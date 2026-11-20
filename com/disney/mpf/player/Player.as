//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.player
{
    import flash.display.Sprite;
    import com.disney.mpf.media.model.Playlist;
    import com.disney.mpf.media.controller.IController;
    import flash.utils.Timer;
    import com.disney.mpf.media.model.IMedia;
    import com.disney.mpf.player.Player;
    import flash.ui.ContextMenuItem;
    import com.disney.mpf.MPF;
    import flash.ui.ContextMenu;
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import com.disney.mpf.media.controller.utils.ControllerStates;
    import com.disney.mpf.media.controller.video.IVideoController;
    import flash.events.TimerEvent;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.media.utils.MediaTypes;
    import com.disney.utils.logging.LogManager;
    import com.disney.mpf.errors.events.MPFErrorEvent;
    import com.disney.mpf.media.controller.ILiveDVRController;
    import com.disney.mpf.media.model.IAsset;
    import com.disney.mpf.media.controller.IExternalMediaController;

    public class Player extends Sprite 
    {

        public static const ASPECT_RATIO_ANCHOR_WIDTH:String = "WIDTH";
        public static const ASPECT_RATIO_ANCHOR_HEIGHT:String = "HEIGHT";
        public static const WIDE_SCREEN:String = "16:9";
        public static const STANDARD_SCREEN:String = "4:3";
        private static var _playerCount:int = 0;

        private var _autoAdvance:Boolean = true;
        private var _currentActiveMediaId:String;
        private var _maxWidth:Number = -1;
        private var _isMuted:Boolean;
        private var _maxHeight:Number = -1;
        protected var _playlist:Playlist;
        protected var _controller:IController = null;
        private var _playerVolume:Number = 0.95;
        private var _height:Number;
        private var _maintainAspectRatio:Boolean = false;
        private var _playerVisible:Boolean = true;
        private var _maintainAspectRatioAnchor:String = "HEIGHT";
        private var _loopPlaylist:Boolean = false;
        private var _myTimer:Timer;
        private var _id:String;
        private var _width:Number;
        private var _pauseOnStart:Boolean;
        protected var _startTime:Number;
        protected var _mediaId:String;
        protected var _media:IMedia;

        public function Player(_arg_1:String=null)
        {
            this._id = ((_arg_1 != null) ? _arg_1 : ("id_" + Player._playerCount++));
            var _local_2:ContextMenuItem = new ContextMenuItem("Powered by Disney's Media Player Framework");
            var _local_3:ContextMenuItem = new ContextMenuItem(((MPF.NAME + " v") + MPF.VERSION), false, false);
            if (!this.contextMenu)
            {
                this.contextMenu = new ContextMenu();
            };
            this.contextMenu.customItems.push(_local_2);
            this.contextMenu.customItems.push(_local_3);
            this.contextMenu.hideBuiltInItems();
        }

        public function stop():void
        {
            removeEventListener(ControllerEvent.LOADED, this.playOnLoad);
            if (this.state !== ControllerStates.STOPPED)
            {
                this._controller.stop();
            };
        }

        public function get maintainAspectRatio():Boolean
        {
            if ((this._controller is IVideoController))
            {
                return (IVideoController(this._controller).maintainAspectRatio);
            };
            return (this._maintainAspectRatio);
        }

        private function init():void
        {
            this.initController(IMedia(this._playlist.iterator().first()));
            this._currentActiveMediaId = IMedia(this._playlist.iterator().first()).id;
        }

        private function loadOnInit(_arg_1:ControllerEvent):void
        {
            removeEventListener(ControllerEvent.INITIALIZED, this.loadOnInit);
            var _local_2:Timer = new Timer(0);
            _local_2.addEventListener(TimerEvent.TIMER, this.onLoadTimer);
            _local_2.start();
        }

        public function set maintainAspectRatio(_arg_1:Boolean):void
        {
            this._maintainAspectRatio = _arg_1;
            if (((this._controller) && (this._controller is IVideoController)))
            {
                IVideoController(this._controller).maintainAspectRatio = _arg_1;
            };
        }

        public function get volume():Number
        {
            return (this._playerVolume);
        }

        public function get id():String
        {
            return (this._id);
        }

        override public function get height():Number
        {
            if ((this._controller is IVideoController))
            {
                return (IVideoController(this._controller).height);
            };
            return (this._height);
        }

        public function get position():Number
        {
            if (this._controller)
            {
                return (this._controller.position);
            };
            return (0);
        }

        private function onPauseTimer(_arg_1:TimerEvent):void
        {
            Timer(_arg_1.target).removeEventListener(TimerEvent.TIMER, this.onPauseTimer);
            Timer(_arg_1.target).stop();
            this._pauseOnStart = false;
            this.pause();
        }

        public function play(mediaId:String=null, startTime:Number=undefined):void
        {
            if (this._pauseOnStart)
            {
                removeEventListener(ControllerEvent.START, this.pauseOnStart);
                this._pauseOnStart = false;
            };
            if (this._controller)
            {
                if (mediaId == null)
                {
                    mediaId = this._controller.media.id;
                };
                this._currentActiveMediaId = mediaId;
                if (((!(mediaId == this._controller.media.id)) || ((this.state < ControllerStates.LOADED) || (this.state >= ControllerStates.STOPPED))))
                {
                    removeEventListener(ControllerEvent.LOADED, this.playOnLoad);
                    addEventListener(ControllerEvent.LOADED, this.playOnLoad);
                    this._startTime = startTime;
                    this._mediaId = mediaId;
                    if (((!(mediaId == this._controller.media.id)) || (!(this.state == ControllerStates.LOADING))))
                    {
                        this.load(mediaId);
                    };
                }
                else
                {
                    try
                    {
                        this.volume = this._playerVolume;
                        this._controller.play(startTime);
                    }
                    catch(e:Error)
                    {
                        throw (new MPFError("Play call on controller failed", MPFErrorCodes.PLAYER_CALL_FAILED));
                    };
                };
            }
            else
            {
                throw (new MPFError("MPF Error: Player media or playlist must be set prior to calling play method.", MPFErrorCodes.CANNOT_LOAD_UNTIL_MEDIA_ASSIGNED));
            };
        }

        public function set id(_arg_1:String):void
        {
            name = _arg_1;
            this._id = _arg_1;
        }

        public function get type():String
        {
            return (this._media.format);
        }

        private function removeController():void
        {
            if (this._controller)
            {
                this._controller.destroy();
            };
            this._controller = null;
        }

        public function set volume(_arg_1:Number):void
        {
            this._playerVolume = _arg_1;
            if (((this._controller) && (this.state > ControllerStates.LOADING)))
            {
                if (!this._isMuted)
                {
                    this._controller.volume = this._playerVolume;
                }
                else
                {
                    this._controller.volume = 0;
                };
            };
        }

        public function playNext():void
        {
            var _local_1:IMedia;
            addEventListener(ControllerEvent.START, this.onPlayNext);
            this.stop();
            if (this._playlist.iterator().hasNext())
            {
                _local_1 = IMedia(this._playlist.iterator().next());
                this.play(_local_1.id);
            }
            else
            {
                if (this._loopPlaylist)
                {
                    _local_1 = IMedia(this._playlist.iterator().first());
                    this.play(_local_1.id);
                };
            };
        }

        public function playPrevious():void
        {
            var _local_1:IMedia;
            addEventListener(ControllerEvent.START, this.onPlayPrevious);
            this.stop();
            if (this._playlist.iterator().hasPrevious())
            {
                _local_1 = IMedia(this._playlist.iterator().previous());
                this.play(_local_1.id);
            }
            else
            {
                if (this._loopPlaylist)
                {
                    _local_1 = IMedia(this._playlist.iterator().last());
                    this.play(_local_1.id);
                };
            };
        }

        private function onPlayNext(_arg_1:ControllerEvent):void
        {
            removeEventListener(ControllerEvent.START, this.onPlayNext);
            _arg_1.target.dispatchEvent(new ControllerEvent(ControllerEvent.NEXT, _arg_1.info));
        }

        override public function set height(_arg_1:Number):void
        {
            var _local_2:Array;
            this._height = _arg_1;
            if ((this._controller is IVideoController))
            {
                IVideoController(this._controller).height = _arg_1;
                if (this._maintainAspectRatio)
                {
                    if (IVideoController(this._controller).realAspectRatio() != null)
                    {
                        _local_2 = IVideoController(this._controller).realAspectRatio().split(":");
                        IVideoController(this._controller).width = ((this._height * _local_2[0]) / _local_2[1]);
                    };
                };
            };
            if (this._height > this.maxHeight)
            {
                this.maxHeight = this._height;
            };
        }

        public function set maxHeight(_arg_1:Number):void
        {
            this._maxHeight = _arg_1;
            if ((this._controller is IVideoController))
            {
                IVideoController(this._controller).maxHeight = _arg_1;
            };
        }

        private function onPlayTimer(_arg_1:TimerEvent):void
        {
            Timer(_arg_1.target).removeEventListener(TimerEvent.TIMER, this.onPlayTimer);
            Timer(_arg_1.target).stop();
            this.volume = this._playerVolume;
            this._controller.play(this._startTime);
            this._mediaId = null;
            this._startTime = NaN;
        }

        private function updateControllerProperties():void
        {
            if ((this._controller is IVideoController))
            {
                IVideoController(this._controller).width = this._width;
                IVideoController(this._controller).height = this._height;
                IVideoController(this._controller).maxWidth = this._maxWidth;
                IVideoController(this._controller).maxHeight = this._maxHeight;
                IVideoController(this._controller).maintainAspectRatio = this._maintainAspectRatio;
                IVideoController(this._controller).maintainAspectRatioAnchor = this._maintainAspectRatioAnchor;
                IVideoController(this._controller).visible = this._playerVisible;
            };
        }

        public function get isMuted():Boolean
        {
            return (this._isMuted);
        }

        public function set loopPlaylist(_arg_1:Boolean):void
        {
            this._loopPlaylist = _arg_1;
        }

        private function removeEventListeners():void
        {
            removeEventListener(ControllerEvent.START, this.startHandler);
            removeEventListener(ControllerEvent.PAUSE, this.pauseHandler);
            removeEventListener(ControllerEvent.COMPLETE, this.completeHandler);
        }

        override public function get visible():Boolean
        {
            return (this._playerVisible);
        }

        override public function get x():Number
        {
            return (super.x);
        }

        override public function get y():Number
        {
            return (super.y);
        }

        public function set type(_arg_1:String):void
        {
            var _local_2:IMedia = MediaTypes.getMediaType(_arg_1);
            this._controller = _local_2.createController();
            this.removeEventListeners();
            this.addEventListeners();
            addChild(Sprite(this._controller));
            _local_2.format = _arg_1;
            this.initController(this._controller.media);
        }

        private function onLoadPrevious(_arg_1:ControllerEvent):void
        {
            removeEventListener(ControllerEvent.START, this.onLoadPrevious);
            _arg_1.target.dispatchEvent(new ControllerEvent(ControllerEvent.PREVIOUS, _arg_1.info));
        }

        public function seek(_arg_1:Number):void
        {
            if ((((!(this._controller)) || (this.state < ControllerStates.LOADED)) || (this.state > ControllerStates.SEEKING)))
            {
                LogManager.getInstance().log("[Player] Warning: Seek() may not be called until media is LOADED", LogManager.WARN);
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.WARN, MPFErrorCodes.CANNOT_SEEK_UNTIL_LOADED, "Warning: Seek() may not be called until media is LOADED"));
            }
            else
            {
                this._controller.seek(_arg_1);
            };
        }

        private function pauseHandler(_arg_1:ControllerEvent):void
        {
        }

        public function set maxWidth(_arg_1:Number):void
        {
            this._maxWidth = _arg_1;
            if ((this._controller is IVideoController))
            {
                IVideoController(this._controller).maxWidth = _arg_1;
            };
        }

        private function startHandler(_arg_1:ControllerEvent):void
        {
            if (this.media == IMedia(this._playlist.getMediaItemByIndex(0)))
            {
                dispatchEvent(new ControllerEvent(ControllerEvent.PLAYLIST_START, null));
            };
        }

        public function get state():uint
        {
            if (this._controller)
            {
                return (this._controller.state);
            };
            return (0);
        }

        override public function set width(_arg_1:Number):void
        {
            var _local_2:Array;
            this._width = _arg_1;
            if ((this._controller is IVideoController))
            {
                IVideoController(this._controller).width = _arg_1;
                if (this._maintainAspectRatio)
                {
                    if (IVideoController(this._controller).realAspectRatio() != null)
                    {
                        _local_2 = IVideoController(this._controller).realAspectRatio().split(":");
                        IVideoController(this._controller).height = ((this._width * _local_2[1]) / _local_2[0]);
                    };
                };
            };
            if (this._width > this.maxWidth)
            {
                this.maxWidth = this._width;
            };
        }

        public function get loopPlaylist():Boolean
        {
            return (this._loopPlaylist);
        }

        public function get controller():IController
        {
            return (this._controller);
        }

        public function seekToLive():void
        {
            if ((((!(this._controller)) || (this.state < ControllerStates.LOADED)) || (this.state > ControllerStates.SEEKING)))
            {
                LogManager.getInstance().log("[Player] Warning: Seek() may not be called until media is LOADED", LogManager.WARN);
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.WARN, MPFErrorCodes.CANNOT_SEEK_UNTIL_LOADED, "Warning: Seek() may not be called until media is LOADED"));
            }
            else
            {
                if ((this._controller is ILiveDVRController))
                {
                    ILiveDVRController(this._controller).seekToLive();
                }
                else
                {
                    LogManager.getInstance().log("[Player] ERROR: Seek() may not be called until media is LOADED", LogManager.WARN);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.UNSUPPORTED_METHOD_FOR_CONTROLLER_TYPE, "ERROR: seekToLive() may only be called on ILiveDVRControllers."));
                };
            };
        }

        public function set autoAdvance(_arg_1:Boolean):void
        {
            this._autoAdvance = _arg_1;
        }

        public function set playlist(_arg_1:Playlist):void
        {
            if (this._controller)
            {
                this.stop();
            };
            this._playlist = _arg_1;
            this._media = IMedia(this._playlist.iterator().first());
            this.initController(this._media);
        }

        public function get maxHeight():Number
        {
            if ((this._controller is IVideoController))
            {
                return (IVideoController(this._controller).maxHeight);
            };
            return (this._maxHeight);
        }

        public function get isPlaying():Boolean
        {
            if (this._controller)
            {
                return (this.state == ControllerStates.PLAYING);
            };
            return (false);
        }

        protected function initMedia(_arg_1:IMedia):void
        {
            this._controller.media = _arg_1;
            this._controller.init();
        }

        private function playOnLoad(_arg_1:ControllerEvent):void
        {
            removeEventListener(ControllerEvent.LOADED, this.playOnLoad);
            var _local_2:Timer = new Timer(0);
            _local_2.addEventListener(TimerEvent.TIMER, this.onPlayTimer);
            _local_2.start();
        }

        public function set isMuted(_arg_1:Boolean):void
        {
            this._isMuted = _arg_1;
            if (((this._controller) && (this.state > ControllerStates.LOADING)))
            {
                if (this._isMuted)
                {
                    this._controller.volume = 0;
                }
                else
                {
                    this._controller.volume = this._playerVolume;
                };
            };
        }

        override public function get width():Number
        {
            if ((this._controller is IVideoController))
            {
                return (IVideoController(this._controller).width);
            };
            return (this._width);
        }

        public function set media(_arg_1:IAsset):void
        {
            this._media = IMedia(_arg_1);
            this._playlist = new Playlist(this._media.id);
            this._playlist.addItem(_arg_1);
            this.initController(this._media);
        }

        public function set maintainAspectRatioAnchor(_arg_1:String):void
        {
            this._maintainAspectRatioAnchor = _arg_1;
            if ((this._controller is IVideoController))
            {
                IVideoController(this._controller).maintainAspectRatioAnchor = _arg_1;
            };
        }

        private function addEventListeners():void
        {
            addEventListener(ControllerEvent.START, this.startHandler);
            addEventListener(ControllerEvent.PAUSE, this.pauseHandler);
            addEventListener(ControllerEvent.COMPLETE, this.completeHandler);
        }

        private function onPlayPrevious(_arg_1:ControllerEvent):void
        {
            removeEventListener(ControllerEvent.START, this.onPlayPrevious);
            _arg_1.target.dispatchEvent(new ControllerEvent(ControllerEvent.PREVIOUS, _arg_1.info));
        }

        public function get playlist():Playlist
        {
            return (this._playlist);
        }

        public function get autoAdvance():Boolean
        {
            return (this._autoAdvance);
        }

        private function completeHandler(_arg_1:ControllerEvent):void
        {
            var _local_2:Timer = new Timer(0);
            _local_2.addEventListener(TimerEvent.TIMER, this.onCompleteTimer);
            _local_2.start();
        }

        public function get maxWidth():Number
        {
            if ((this._controller is IVideoController))
            {
                return (IVideoController(this._controller).maxWidth);
            };
            return (this._maxWidth);
        }

        protected function initController(_arg_1:IMedia):void
        {
            if (this._controller)
            {
                if (this._controller.media.format != _arg_1.format)
                {
                    LogManager.getInstance().log(((((("[Player] Removing old controller [type: " + this._controller.media.format) + "]") + " and creating new one [type: ") + _arg_1.format) + "]"));
                    removeChild(Sprite(this._controller));
                    this.removeController();
                    this.removeEventListeners();
                    this._controller = _arg_1.createController();
                    this.updateControllerProperties();
                    this.addEventListeners();
                    addChild(Sprite(this._controller));
                }
                else
                {
                    LogManager.getInstance().log((("[Player] Reusing controller [type: " + this._controller.media.format) + "]"));
                };
            }
            else
            {
                LogManager.getInstance().log((("[Player] Creating new controller [type: " + _arg_1.format) + "]"));
                this._controller = _arg_1.createController();
                this.updateControllerProperties();
                this.addEventListeners();
                addChild(Sprite(this._controller));
            };
            this._media = _arg_1;
            this.initMedia(this._media);
        }

        public function get maintainAspectRatioAnchor():String
        {
            if ((this._controller is IVideoController))
            {
                return (IVideoController(this._controller).maintainAspectRatioAnchor);
            };
            return (this._maintainAspectRatioAnchor);
        }

        public function get media():IAsset
        {
            return (IAsset(this._media));
        }

        public function load(mediaId:String=null):void
        {
            if (this._controller)
            {
                if (mediaId == null)
                {
                    mediaId = this._controller.media.id;
                };
                if (((this.state == ControllerStates.INITIALIZING) || (this.state == ControllerStates.SWITCH)))
                {
                    removeEventListener(ControllerEvent.INITIALIZED, this.loadOnInit);
                    addEventListener(ControllerEvent.INITIALIZED, this.loadOnInit);
                }
                else
                {
                    if (this.state == ControllerStates.INITIALIZED)
                    {
                        try
                        {
                            this._controller.load();
                        }
                        catch(e:Error)
                        {
                            throw (new MPFError("Load call on controller failed", MPFErrorCodes.PLAYER_CALL_FAILED));
                        };
                    }
                    else
                    {
                        removeEventListener(ControllerEvent.INITIALIZED, this.loadOnInit);
                        addEventListener(ControllerEvent.INITIALIZED, this.loadOnInit);
                        this.initController(IMedia(this._playlist.getMediaItemById(mediaId, true)));
                    };
                };
            }
            else
            {
                throw (new MPFError("Player media or playlist must be set prior to calling load method.", MPFErrorCodes.CANNOT_LOAD_UNTIL_MEDIA_ASSIGNED));
            };
        }

        private function onLoadTimer(_arg_1:TimerEvent):void
        {
            Timer(_arg_1.target).removeEventListener(TimerEvent.TIMER, this.onLoadTimer);
            Timer(_arg_1.target).stop();
            this._controller.load();
            this._mediaId = null;
        }

        override public function set visible(_arg_1:Boolean):void
        {
            this._playerVisible = _arg_1;
            super.visible = this._playerVisible;
            if (this._controller)
            {
                Sprite(this._controller).visible = this._playerVisible;
            };
        }

        private function onCompleteTimer(_arg_1:TimerEvent):void
        {
            var _local_2:IMedia;
            Timer(_arg_1.target).removeEventListener(TimerEvent.TIMER, this.onCompleteTimer);
            Timer(_arg_1.target).stop();
            if (((this._playlist.length > 0) && (this._media == IMedia(this._playlist.getMediaItemByIndex((this._playlist.length - 1))))))
            {
                dispatchEvent(new ControllerEvent(ControllerEvent.PLAYLIST_COMPLETE, null));
            };
            if (this._autoAdvance)
            {
                if (this._pauseOnStart)
                {
                    removeEventListener(ControllerEvent.START, this.pauseOnStart);
                    this._pauseOnStart = false;
                    return;
                };
                addEventListener(ControllerEvent.START, this.onPlayNext);
                if (this._playlist.iterator().hasNext())
                {
                    _local_2 = IMedia(this._playlist.iterator().next());
                    this.play(_local_2.id);
                }
                else
                {
                    if (this._loopPlaylist)
                    {
                        _local_2 = IMedia(this._playlist.iterator().first());
                        this.play(_local_2.id);
                    };
                };
            };
        }

        override public function set x(_arg_1:Number):void
        {
            super.x = _arg_1;
            if ((this._controller is IExternalMediaController))
            {
                IExternalMediaController(this._controller).moveExternalMediaLocation("x");
            };
        }

        override public function set y(_arg_1:Number):void
        {
            super.y = _arg_1;
            if ((this._controller is IExternalMediaController))
            {
                IExternalMediaController(this._controller).moveExternalMediaLocation("y");
            };
        }

        private function pauseOnStart(_arg_1:ControllerEvent):void
        {
            removeEventListener(ControllerEvent.START, this.pauseOnStart);
            var _local_2:Timer = new Timer(0);
            _local_2.addEventListener(TimerEvent.TIMER, this.onPauseTimer);
            _local_2.start();
        }

        public function pause():void
        {
            if (((this.state < ControllerStates.PAUSED) || (this.state >= ControllerStates.STOPPED)))
            {
                this._pauseOnStart = true;
                addEventListener(ControllerEvent.START, this.pauseOnStart);
            }
            else
            {
                if (this.state > ControllerStates.PAUSED)
                {
                    this._controller.pause();
                };
            };
        }

        private function onLoadNext(_arg_1:ControllerEvent):void
        {
            removeEventListener(ControllerEvent.START, this.onLoadNext);
            _arg_1.target.dispatchEvent(new ControllerEvent(ControllerEvent.NEXT, _arg_1.info));
        }

        public function loadNext():void
        {
            var _local_1:IMedia;
            addEventListener(ControllerEvent.START, this.onLoadNext);
            this.stop();
            if (this._playlist.iterator().hasNext())
            {
                _local_1 = IMedia(this._playlist.iterator().next());
                this.load(_local_1.id);
            }
            else
            {
                if (this._loopPlaylist)
                {
                    _local_1 = IMedia(this._playlist.iterator().first());
                    this.load(_local_1.id);
                };
            };
        }

        public function destroy():void
        {
            this.removeController();
            this.removeEventListeners();
            if (this._playlist != null)
            {
                this._playlist.destroy();
            };
            if (this._media != null)
            {
                this._media.destroy();
            };
            delete this[this];
        }

        public function loadPrevious():void
        {
            var _local_1:IMedia;
            addEventListener(ControllerEvent.START, this.onLoadPrevious);
            this.stop();
            if (this._playlist.iterator().hasPrevious())
            {
                _local_1 = IMedia(this._playlist.iterator().previous());
                this.load(_local_1.id);
            }
            else
            {
                if (this._loopPlaylist)
                {
                    _local_1 = IMedia(this._playlist.iterator().last());
                    this.load(_local_1.id);
                };
            };
        }


    }
}//package com.disney.mpf.player
