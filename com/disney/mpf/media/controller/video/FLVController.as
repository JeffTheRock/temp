//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller.video
{
    import com.disney.mpf.media.controller.ILiveDVRController;
    import com.disney.mpf.media.controller.IUpdateableController;
    import com.disney.mpf.media.model.IMedia;
    import flash.net.NetStream;
    import flash.media.Video;
    import com.disney.mpf.media.net.IFlashStreamConnector;
    import flash.utils.Timer;
    import com.disney.mpf.media.net.ShotgunFlashStreamConnector;
    import flash.events.NetStatusEvent;
    import flash.events.TimerEvent;
    import com.disney.mpf.media.net.events.ConnectionEvent;
    import com.disney.mpf.errors.events.MPFErrorEvent;
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import com.disney.mpf.media.controller.utils.ControllerStates;
    import com.disney.mpf.media.decorator.MediaObject;
    import com.disney.utils.logging.LogManager;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.media.model.StreamItemEntry;
    import com.disney.mpf.media.utils.ProtocolTypes;
    import flash.events.Event;
    import com.disney.mpf.media.model.info.IMediaInfo;
    import com.disney.mpf.media.net.IUpdateableStreamConnector;
    import flash.media.SoundTransform;
    import com.disney.mpf.media.utils.DeliveryModes;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.media.controller.events.MetaDataEvent;
    import com.disney.mpf.media.model.info.meta.FLVMetaInfo;
    import com.disney.mpf.media.controller.utils.MetaDataInfo;
    import com.disney.mpf.media.net.events.FlashConnectionEvent;
    import com.disney.mpf.media.model.info.qos.FLVQOSData;
    import com.disney.mpf.player.events.*;

    public class FLVController extends VideoController implements ILiveDVRController, IUpdateableController 
    {

        public static var dvrDurationAutoIncrement:Number = 900;
        private static var _timesCreated:uint = 0;

        protected var _mediaUpdate:IMedia;
        private var _availableDVRDuration:Number = 0;
        private var _availableDVRDurationACTUAL:Number = 0;
        private var _resumeTime:Number;
        protected var _volume:Number;
        private var _height:Number;
        protected var _nsUpdate:NetStream;
        private var _isNetConnectionLost:Boolean;
        protected var _isSeeking:Boolean = false;
        protected var _ucState:Boolean = false;
        protected var _videoUpdate:Video;
        protected var _ns:NetStream;
        protected var _fsc:IFlashStreamConnector;
        protected var _video:Video;
        protected var _returnToState:int;
        private var _downloadProgressTimer:Timer;
        protected var _metaDataObject:Object;
        protected var _videoPrevious:Video;
        private var _resumeState:int;
        protected var _startPlayerAfterSeek:Boolean;
        private var _dvrConnectTime:Number = 0;
        protected var _playOnUpdate:Boolean;
        protected var _seekTime:Number;
        private var _width:Number;
        private var _streamName:String;
        protected var FlashStreamConnectorClass:Class = ShotgunFlashStreamConnector;
        protected var _updateTime:Number = 0;
        protected var _netStreamStopped:Boolean = false;

        public function FLVController()
        {
            this.setupController();
        }

        override public function destroy():void
        {
            if (this._ns)
            {
                this._ns.removeEventListener(NetStatusEvent.NET_STATUS, this.flvCheck);
            };
            if (((this._downloadProgressTimer) && (this._downloadProgressTimer.running == true)))
            {
                this._downloadProgressTimer.removeEventListener(TimerEvent.TIMER, this.onDownloadProgressTimer);
                this._downloadProgressTimer.stop();
                this._downloadProgressTimer = null;
            };
            if (this._fsc)
            {
                this._fsc.removeEventListener(ConnectionEvent.CONNECTION_SUCCESS, this.onConnect);
                this._fsc.removeEventListener(ConnectionEvent.CONNECTION_FAILURE, this.onConnectFail);
                this._fsc.removeEventListener(ConnectionEvent.CONNECTION_UPDATE_SUCCESS, this.onConnectUpdate);
                this._fsc.removeEventListener(ConnectionEvent.CONNECTION_UPDATE_FAILURE, this.onConnectUpdateFail);
                this._fsc.removeEventListener(MPFErrorEvent.ERROR, this.onFSCError);
                this._fsc.removeEventListener(MPFErrorEvent.WARN, this.onFSCError);
                this._fsc.destroy();
            };
            if (this._video)
            {
                this._video.clear();
                removeChild(this._video);
                this._video = null;
            };
            super.destroy();
        }

        override public function stop():void
        {
            try
            {
                dispatchEvent(new ControllerEvent(ControllerEvent.STOP_PENDING, this.populateData()));
            }
            catch(e:Error)
            {
            };
            this._resumeState = 0;
            this._resumeTime = 0;
            try
            {
                this._fsc.closeNetStream();
            }
            catch(e:Error)
            {
            };
            try
            {
                super.stop();
            }
            catch(e:Error)
            {
            };
            try
            {
                this.clearPlayer();
            }
            catch(e:Error)
            {
            };
        }

        protected function onConnect(_arg_1:ConnectionEvent):void
        {
            this._ns = this._fsc.ns;
            this.initMetaData(this._ns);
            super.init();
        }

        override public function init():void
        {
            var fscCustomClass:Class;
            _controllerStates.state = ControllerStates.INITIALIZING;
            dispatchEvent(new ControllerEvent(ControllerEvent.INITIALIZING, this.populateData()));
            _startPlayerOnLoad = false;
            if (MediaObject(media).connectorType)
            {
                LogManager.getInstance().log("[FLVController] Using a custom IFlashStreamConnector class for this media item.");
                fscCustomClass = MediaObject(media).connectorType;
            };
            try
            {
                if (((fscCustomClass) && (!(this._fsc is fscCustomClass))))
                {
                    if (this._fsc)
                    {
                        this._fsc.destroy();
                    };
                    this._fsc = null;
                    this._fsc = new (fscCustomClass)();
                }
                else
                {
                    if (!this._fsc)
                    {
                        this._fsc = new this.FlashStreamConnectorClass();
                    };
                };
                this._fsc.addEventListener(ConnectionEvent.CONNECTION_SUCCESS, this.onConnect);
                this._fsc.addEventListener(ConnectionEvent.CONNECTION_FAILURE, this.onConnectFail);
                this._fsc.addEventListener(ConnectionEvent.CONNECTION_UPDATE_SUCCESS, this.onConnectUpdate);
                this._fsc.addEventListener(ConnectionEvent.CONNECTION_UPDATE_FAILURE, this.onConnectUpdateFail);
                this._fsc.addEventListener(MPFErrorEvent.ERROR, this.onFSCError);
                this._fsc.addEventListener(MPFErrorEvent.WARN, this.onFSCError);
            }
            catch(e:Error)
            {
                LogManager.getInstance().log("[FLVController] Custom FlashStreamConnector class specified in MediaObject must implement IFlashStreamConnector.", LogManager.ERROR);
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.CONNECTOR_TYPE_INVALID, "[FLVController] Custom FlashStreamConnector class must implement IFlashStreamConnector."));
                stop();
                return;
            };
            switch (MediaObject(media).protocol)
            {
                case ProtocolTypes.STREAMING:
                    this._streamName = StreamItemEntry(MediaObject(media).streamItem.streams[0]).stream;
                    this.createNetConnection(media);
                    return;
                case ProtocolTypes.PROGRESSIVE:
                    this._streamName = media.url;
                    this.createNetConnection(media);
                    return;
            };
        }

        override protected function updateProgress(_arg_1:Event):void
        {
            if (((((!(media == null)) && (_updateProgressCount == _updateProgressSample)) && (this.position == _previousPosition)) && ((0 <= this.position) && (this.position < 1.25))))
            {
                if (MediaObject(media).protocol == ProtocolTypes.PROGRESSIVE)
                {
                    this._ns.seek(this.position);
                };
                this._ns.resume();
            };
            super.updateProgress(_arg_1);
        }

        override public function get volume():Number
        {
            if (this._ns)
            {
                try
                {
                    return (this._ns.soundTransform.volume);
                }
                catch(e:Error)
                {
                    return (_volume);
                };
            };
            return (this._volume);
        }

        private function onLoadStatusEvent(_arg_1:NetStatusEvent):void
        {
            switch (_arg_1.info.code)
            {
                case "NetStream.Play.Start":
                    this._netStreamStopped = false;
                    LogManager.getInstance().log(("[FLVController] onLoadStatusEvent() " + _arg_1.info.code));
                    return;
                default:
                    this.flvCheck(_arg_1);
            };
        }

        override public function realAspectRatio():String
        {
            var _local_1:Number = _realAspectRatio;
            if (Math.abs((VideoController.WIDE_SCREEN_RATIO - _local_1)) < VideoController.aspectRatioTolerance)
            {
                return (VideoController.WIDE_SCREEN);
            };
            if (Math.abs((VideoController.NORMAL_SCREEN_RATIO - _local_1)) < VideoController.aspectRatioTolerance)
            {
                return (VideoController.STANDARD_SCREEN);
            };
            if (((!(_realAspectRatio == 0)) && (!(isNaN(_realAspectRatio)))))
            {
                return ((Math.round((100 * _realAspectRatio)) / 100) + ":1");
            };
            return (null);
        }

        override public function get height():Number
        {
            if (this._video.height > 0)
            {
                return (this._video.height);
            };
            return (this._height);
        }

        override public function get position():Number
        {
            if (this._ns == null)
            {
                return (0);
            };
            return (this._ns.time);
        }

        override public function play(_arg_1:Number=undefined):void
        {
            var _local_2:IMediaInfo;
            if ((((this._isNetConnectionLost == true) && (this._resumeState == ControllerStates.PAUSED)) || ((this._isNetConnectionLost == true) && (this._resumeState == ControllerStates.PLAYING))))
            {
                this._isNetConnectionLost = false;
                this.play(this._resumeTime);
                this._resumeTime = 0;
                this._resumeState = 0;
                return;
            };
            if (((state == ControllerStates.PLAYING) && (!(_arg_1))))
            {
                return;
            };
            _startPlayerOnLoad = true;
            if (_arg_1)
            {
                _startTime = _arg_1;
            }
            else
            {
                _startTime = undefined;
            };
            if (MediaObject(media).protocol == ProtocolTypes.PROGRESSIVE)
            {
                _local_2 = this.populateData();
                if ((((!(this._returnToState == ControllerStates.SEEKING)) && (!(state == ControllerStates.PAUSED))) && (_local_2.percentLoaded == 1)))
                {
                    this._ns.play(media.url);
                }
                else
                {
                    this._ns.resume();
                };
                super.play(_startTime);
            }
            else
            {
                this._ns.resume();
            };
            this._returnToState = ControllerStates.PLAYING;
            if (_startTime)
            {
                this.seek(_startTime);
            };
        }

        protected function finishUpdate():void
        {
            this._nsUpdate.removeEventListener(NetStatusEvent.NET_STATUS, this.flvUpdatePreCheck);
            addChild(this._videoUpdate);
            if (this._video)
            {
                this._videoPrevious = this._video;
            };
            this._video = this._videoUpdate;
            this._fsc.closeNetStream();
            this._ns = this._nsUpdate;
            this._ns.addEventListener(NetStatusEvent.NET_STATUS, this.flvCheck);
            this._nsUpdate = null;
            this._videoUpdate = null;
            this._updateTime = undefined;
            if (this._playOnUpdate)
            {
                this._ns.resume();
            };
            this._ucState = false;
            IUpdateableStreamConnector(this._fsc).updateConnectionComplete();
            dispatchEvent(new ControllerEvent(ControllerEvent.UPDATE_SUCCESS, this.populateData()));
        }

        override public function set volume(level:Number):void
        {
            var transform:SoundTransform;
            this._volume = level;
            if (this._ns)
            {
                try
                {
                    transform = this._ns.soundTransform;
                    transform.volume = this._volume;
                    this._ns.soundTransform = transform;
                }
                catch(e:Error)
                {
                };
            };
        }

        public function get bufferTime():Number
        {
            return (this._ns.bufferTime);
        }

        private function updateDVRDuration():void
        {
            var _local_1:Number;
            if (this._dvrConnectTime > 0)
            {
                _local_1 = ((this._metaDataObject.duration > 0) ? this._metaDataObject.duration : 0);
                this._availableDVRDurationACTUAL = ((_local_1 + (new Date().time / 1000)) - this._dvrConnectTime);
                this._availableDVRDuration = (this._availableDVRDurationACTUAL - (this._ns.bufferTime + 0.5));
            }
            else
            {
                this._availableDVRDurationACTUAL = 0;
                this._availableDVRDuration = 0;
            };
            if (duration <= this._availableDVRDurationACTUAL)
            {
                duration = ((Math.floor((this._availableDVRDurationACTUAL / dvrDurationAutoIncrement)) + 1) * dvrDurationAutoIncrement);
            };
        }

        override public function set height(_arg_1:Number):void
        {
            this._height = _arg_1;
            this._video.height = _arg_1;
            _currentAspectRatio = (this.width / this.height);
        }

        private function onSeekHandler(_arg_1:int):void
        {
            this._returnToState = _arg_1;
            var _local_2:Timer = new Timer(0);
            _local_2.addEventListener(TimerEvent.TIMER, this.onSeekTimer, false, 0, true);
            _local_2.start();
        }

        private function startDownloadProgress():void
        {
            dispatchEvent(new ControllerEvent(ControllerEvent.DOWNLOAD_START, this.populateData()));
            this._downloadProgressTimer = new Timer(25);
            this._downloadProgressTimer.addEventListener(TimerEvent.TIMER, this.onDownloadProgressTimer);
            this._downloadProgressTimer.start();
            if (((media.deliveryMode > DeliveryModes.VOD) && (media.deliveryMode < DeliveryModes.LIVE_NODVR)))
            {
                this.addEventListener(ControllerEvent.COMPLETE, this.LiveDVRCompleteHandler);
            };
        }

        override public function currentAspectRatio():String
        {
            var _local_1:Number = _currentAspectRatio;
            if (_local_1 == 0)
            {
                _local_1 = _realAspectRatio;
            };
            if (Math.abs((VideoController.WIDE_SCREEN_RATIO - _local_1)) < VideoController.aspectRatioTolerance)
            {
                return (VideoController.WIDE_SCREEN);
            };
            if (Math.abs((VideoController.NORMAL_SCREEN_RATIO - _local_1)) < VideoController.aspectRatioTolerance)
            {
                return (VideoController.STANDARD_SCREEN);
            };
            if (((!(_currentAspectRatio == 0)) && (!(isNaN(_currentAspectRatio)))))
            {
                return ((Math.round((100 * _currentAspectRatio)) / 100) + ":1");
            };
            return (null);
        }

        protected function onFSCError(_arg_1:MPFErrorEvent):void
        {
            _arg_1.stopImmediatePropagation();
            dispatchEvent(_arg_1.clone());
        }

        override public function seek(_arg_1:Number):void
        {
            dispatchEvent(new ControllerEvent(ControllerEvent.SEEK_PENDING, this.populateData()));
            this._seekTime = _arg_1;
            this._returnToState = super.state;
            if (((this._seekTime < 0) || (this._seekTime > this.duration)))
            {
                throw (new MPFError(((("Seek out of bounds: seek to " + _arg_1) + ", duration is ") + this.duration), MPFErrorCodes.SEEK_OUTOFBOUNDS));
            };
            if (media.deliveryMode == DeliveryModes.LIVE_DVR)
            {
                this._ns.seek(Math.min(this._seekTime, this.getAvailableDVRDuration()));
            }
            else
            {
                this._ns.seek(this._seekTime);
            };
        }

        private function onFirstMetaData(_arg_1:MetaDataEvent):void
        {
            removeEventListener(MetaDataEvent.META, this.onFirstMetaData);
            this.bufferTime = MediaObject(media).bufferTime;
            this._ns.removeEventListener(NetStatusEvent.NET_STATUS, this.onLoadStatusEvent);
            this._ns.pause();
            this._ns.addEventListener(NetStatusEvent.NET_STATUS, this.flvCheck);
            super.state = ControllerStates.LOADED;
            dispatchEvent(new ControllerEvent(ControllerEvent.LOADED, this.populateData()));
        }

        private function initMetaData(ns:NetStream):void
        {
            var superScope:VideoController;
            var thisScope:FLVController;
            superScope = this;
            thisScope = this;
            var netClient:Object = new Object();
            netClient.onMetaData = function (_arg_1:Object):void
            {
                var _local_4:Number;
                if (((_videoPrevious) && (thisScope.contains(_videoPrevious))))
                {
                    thisScope.removeChild(_videoPrevious);
                    _videoPrevious = null;
                };
                _metaDataObject = _arg_1;
                if (superScope.duration == 0)
                {
                    superScope.duration = _arg_1.duration;
                };
                if (media.deliveryMode == DeliveryModes.LIVE_DVR)
                {
                    trackDVRDuration(((_arg_1.duration) ? _arg_1.duration : 0));
                };
                _metaInfo = new FLVMetaInfo(_arg_1);
                var _local_2:IMediaInfo = superScope.populateData();
                _local_2.meta = _metaInfo;
                _local_2.bytesTotal = ns.bytesTotal;
                var _local_3:MetaDataInfo = new MetaDataInfo();
                _local_3.controller = thisScope;
                _local_3.creationDate = _arg_1.creationdate;
                _local_3.duration = Number(_arg_1.duration);
                _local_3.height = Number(_arg_1.height);
                _local_3.width = Number(_arg_1.width);
                _local_3.encodedWith = _arg_1.Encoded_With;
                _local_3.canSeekToEnd = Boolean(_arg_1.canSeekToEnd);
                _local_3.framerate = Number(_arg_1.framerate);
                _local_3.audioCodecId = _arg_1.audiocodecid;
                _local_3.audioDataRate = Number(_arg_1.audiodatarate);
                _local_3.videoCodecId = _arg_1.videocodecid;
                _local_3.videoDataRate = Number(_arg_1.videodatarate);
                _realAspectRatio = (_local_2.meta.width / _local_2.meta.height);
                _currentAspectRatio = (width / height);
                if (((_maintainAspectRatio) && ((!(_currentAspectRatio === _realAspectRatio)) || ((!(_maxWidth == _width)) || (!(_maxHeight == _height))))))
                {
                    if (_maintainAspectRatioAnchor == VideoController.WIDTH)
                    {
                        _local_4 = Math.max(width, maxWidth);
                    }
                    else
                    {
                        _local_4 = Math.max(height, maxHeight);
                    };
                    if (Math.abs((VideoController.WIDE_SCREEN_RATIO - _realAspectRatio)) < VideoController.aspectRatioTolerance)
                    {
                        changeAspectRatio(VideoController.WIDE_SCREEN, _maintainAspectRatioAnchor, _local_4);
                    }
                    else
                    {
                        if (Math.abs((VideoController.NORMAL_SCREEN_RATIO - _realAspectRatio)) < VideoController.aspectRatioTolerance)
                        {
                            changeAspectRatio(VideoController.STANDARD_SCREEN, _maintainAspectRatioAnchor, _local_4);
                        }
                        else
                        {
                            changeAspectRatio(((_local_2.meta.width.toString() + ":") + _local_2.meta.height.toString()), _maintainAspectRatioAnchor, _local_4);
                        };
                    };
                };
                dispatchEvent(new MetaDataEvent(MetaDataEvent.META, _local_3));
            };
            ns.client = netClient;
        }

        public function updateConnection(_arg_1:Number=0, _arg_2:Boolean=true):void
        {
            if (this._ucState)
            {
                return;
            };
            this._ucState = true;
            if ((this._fsc is IUpdateableStreamConnector))
            {
                if (((!(isNaN(_arg_1))) && (_arg_1 > 0)))
                {
                    this._updateTime = _arg_1;
                };
                this._playOnUpdate = _arg_2;
                IUpdateableStreamConnector(this._fsc).updateConnection(media);
            }
            else
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.UPDATE_CONNECTION_NOT_SUPPORTED_BY_STREAM_CONNECTOR, "[FLVController] The current FlashStreamConnector class does not implement IUpdateableStreamConnector."));
            };
        }

        private function trackDVRDuration(_arg_1:Number):void
        {
            if (_arg_1 > this._availableDVRDurationACTUAL)
            {
                this._availableDVRDurationACTUAL = _arg_1;
                this._dvrConnectTime = (new Date().time / 1000);
            };
        }

        override public function set width(_arg_1:Number):void
        {
            this._width = _arg_1;
            this._video.width = _arg_1;
            _currentAspectRatio = (this.width / this.height);
        }

        protected function clearPlayer():void
        {
            if (((this._downloadProgressTimer) && (this._downloadProgressTimer.running == true)))
            {
                this._downloadProgressTimer.removeEventListener(TimerEvent.TIMER, this.onDownloadProgressTimer);
                this._downloadProgressTimer.stop();
                this._downloadProgressTimer = null;
            };
            this._metaDataObject = null;
            this._metaDataObject = new Object();
            this._availableDVRDuration = 0;
            this._availableDVRDurationACTUAL = 0;
            this._dvrConnectTime = 0;
            if (this._ns != null)
            {
                this._ns.removeEventListener(NetStatusEvent.NET_STATUS, this.flvCheck);
            };
            if (this._nsUpdate != null)
            {
                this._nsUpdate.removeEventListener(NetStatusEvent.NET_STATUS, this.flvUpdatePreCheck);
            };
            if (this._video != null)
            {
                this._video.clear();
            };
            if (this._videoUpdate)
            {
                this._videoUpdate.clear();
            };
            this._videoUpdate = null;
            if (this._videoPrevious)
            {
                this._videoPrevious.clear();
            };
            try
            {
                removeChild(this._videoPrevious);
            }
            catch(e:Error)
            {
            };
            this._videoPrevious = null;
        }

        protected function flvUpdatePreCheck(_arg_1:NetStatusEvent):void
        {
            switch (_arg_1.info.code)
            {
                case "NetStream.Play.Start":
                    if (((!(this._playOnUpdate)) || ((MediaObject(media).protocol == ProtocolTypes.STREAMING) && (media.deliveryMode <= DeliveryModes.LIVE_DVR))))
                    {
                        this._nsUpdate.pause();
                        if (MediaObject(media).protocol == ProtocolTypes.STREAMING)
                        {
                            this._nsUpdate.seek(this._updateTime);
                        };
                        if (!this._playOnUpdate)
                        {
                            this.finishUpdate();
                        };
                    }
                    else
                    {
                        this.finishUpdate();
                    };
                    return;
                case "NetStream.Buffer.Full":
                    return;
                case "NetStream.Seek.Notify":
                    this.finishUpdate();
                    return;
            };
        }

        public function seekToLive():void
        {
            if (((media.deliveryMode > DeliveryModes.VOD) && (media.deliveryMode < DeliveryModes.LIVE_NODVR)))
            {
                this.seek(this.getAvailableDVRDuration());
            }
            else
            {
                throw (new MPFError(("Seek out of bounds: Duration is " + this.duration), MPFErrorCodes.SEEK_OUTOFBOUNDS));
            };
        }

        public function set bufferTime(_arg_1:Number):void
        {
            if (duration)
            {
                this._ns.bufferTime = Math.min(_arg_1, (duration - 0.1));
            }
            else
            {
                this._ns.bufferTime = _arg_1;
            };
        }

        protected function flvCheck(_arg_1:NetStatusEvent):void
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_2:String = media.url;
            if (ProtocolTypes.STREAMING)
            {
                _local_2 = ((("FMS:" + media.url) + " | Stream:") + this._streamName);
            };
            LogManager.getInstance().log(("[FLVController] NetStatusEvent: " + _local_2));
            LogManager.getInstance().log(("[FLVController] NetStatusEvent: " + _arg_1.info.code));
            switch (_arg_1.info.code)
            {
                case "NetStream.Buffer.Empty":
                    dispatchEvent(new ControllerEvent(ControllerEvent.BUFFER_EMPTY, this.populateData()));
                    if (this._netStreamStopped)
                    {
                        _local_5 = Math.max((duration - 10), (0.985 * duration));
                        _local_6 = Math.min(_local_5, Math.round(_local_5));
                        if (((super.state == ControllerStates.PLAYING) && ((this.position >= _local_5) || (this.position >= _local_6))))
                        {
                            super.state = ControllerStates.ENDED;
                        }
                        else
                        {
                            if (super.state != ControllerStates.ENDED)
                            {
                                this.stop();
                            };
                        };
                    };
                    return;
                case "NetStream.Buffer.Full":
                    if (this._isSeeking)
                    {
                        this._isSeeking = false;
                        this.onSeekHandler(this._returnToState);
                    }
                    else
                    {
                        this._netStreamStopped = false;
                        dispatchEvent(new ControllerEvent(ControllerEvent.BUFFER_FULL, this.populateData()));
                        if ((((super.state > ControllerStates.LOADING) && (!(super.state == ControllerStates.PLAYING))) && ((!(super.state == ControllerStates.PAUSED)) || (media.deliveryMode > DeliveryModes.LIVE_DVR))))
                        {
                            if (_startPlayerOnLoad)
                            {
                                _startPlayerOnLoad = false;
                                if (MediaObject(media).protocol == ProtocolTypes.PROGRESSIVE)
                                {
                                    this._ns.resume();
                                };
                                super.play(_startTime);
                            };
                        };
                    };
                    return;
                case "NetStream.Buffer.Flush":
                    dispatchEvent(new ControllerEvent(ControllerEvent.BUFFER_FLUSH, this.populateData()));
                    return;
                case "NetStream.Failed":
                    LogManager.getInstance().log(("[FLVController] NetStream Failed: " + _local_2), LogManager.ERROR);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NETSTREAM_FAILED, _arg_1.info.code));
                    return;
                case "NetStream.Play.Start":
                    this._netStreamStopped = false;
                    if ((((!(super.state == ControllerStates.PLAYING)) && (!(super.state == ControllerStates.PAUSED))) && (media.deliveryMode < DeliveryModes.LIVE_DVR)))
                    {
                        LogManager.getInstance().log((("[FLVController] NetStream.Play.Start: " + "media.deliveryMode:") + media.deliveryMode.toString()));
                        if (_startPlayerOnLoad)
                        {
                            _startPlayerOnLoad = false;
                            super.play(_startTime);
                        };
                    };
                    return;
                case "NetStream.Play.Stop":
                    this._netStreamStopped = true;
                    _local_3 = Math.max((duration - 10), (0.985 * duration));
                    _local_4 = Math.min(_local_3, Math.round(_local_3));
                    if (super.state == ControllerStates.STOPPED)
                    {
                        this._fsc.closeNetStream();
                    }
                    else
                    {
                        if ((((MediaObject(media).protocol == ProtocolTypes.PROGRESSIVE) && (super.state == ControllerStates.PLAYING)) && ((this.position >= _local_3) || (this.position >= _local_4))))
                        {
                            super.state = ControllerStates.ENDED;
                        };
                    };
                    return;
                case "NetStream.Play.Failed":
                    LogManager.getInstance().log(("[FLVController] NetStream Play Failed: " + _local_2), LogManager.ERROR);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NETSTREAM_PLAY_FAILED, _arg_1.info.code));
                    return;
                case "NetStream.Play.StreamNotFound":
                    LogManager.getInstance().log(("[FLVController] Media stream not found: " + _local_2), LogManager.ERROR);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.MEDIA_NOT_FOUND, _arg_1.info.code));
                    return;
                case "NetStream.Play.Reset":
                    return;
                case "NetStream.Play.PublishNotify":
                    LogManager.getInstance().log(("[FLVController] Live Stream Publish Notify: " + _local_2));
                    dispatchEvent(new ControllerEvent(ControllerEvent.LIVE_PUBLISH, this.populateData()));
                    return;
                case "NetStream.Play.UnpublishNotify":
                    LogManager.getInstance().log(("[FLVController] Live Stream Unpublish Notify: " + _local_2));
                    dispatchEvent(new ControllerEvent(ControllerEvent.LIVE_UNPUBLISH, this.populateData()));
                    return;
                case "NetStream.Play.InsufficientBW":
                    LogManager.getInstance().log(("[FLVController] Insufficient Bandwidth: " + _local_2), LogManager.WARN);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.WARN, MPFErrorCodes.NETSTREAM_PLAY_INSUFFICIENTBW, _arg_1.info.code));
                    return;
                case "NetStream.Play.FileStructureInvalid":
                    LogManager.getInstance().log(("[FLVController] Media stream not found: " + _local_2), LogManager.ERROR);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.MEDIA_NOT_FOUND, _arg_1.info.code));
                    LogManager.getInstance().log(("[FLVController] File structure invalid: " + _local_2), LogManager.ERROR);
                    this.clearPlayer();
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.FILE_STRUCTURE_INVALID, _arg_1.info.code));
                    return;
                case "NetStream.Play.NoSupportedTrackFound":
                    LogManager.getInstance().log(("[FLVController] No supported track found: " + _local_2), LogManager.ERROR);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NO_SUPPORTED_TRACK_FOUND, _arg_1.info.code));
                    return;
                case "NetStream.Play.Transition":
                    LogManager.getInstance().log(("[FLVController] NetStream.Play.Transition - Bitrate Changed: " + _local_2));
                    dispatchEvent(new ControllerEvent(ControllerEvent.ON_BITRATE_CHANGE_REQUESTED, this.populateData()));
                    return;
                case "NetStream.Pause.Notify":
                    if ((((super.state < ControllerStates.LOADED) && (!(super.state == ControllerStates.PAUSED))) && (super.state < ControllerStates.STOPPED)))
                    {
                        _startPlayerOnLoad = false;
                        super.pause();
                    };
                    return;
                case "NetStream.Unpause.Notify":
                    this._netStreamStopped = false;
                    if ((((!(super.state == ControllerStates.PLAYING)) && (super.state == ControllerStates.PAUSED)) && (media.deliveryMode < DeliveryModes.LIVE_NODVR)))
                    {
                        if (_startPlayerOnLoad)
                        {
                            _startPlayerOnLoad = false;
                            super.play(_startTime);
                        };
                    };
                    return;
                case "NetStream.Seek.Failed":
                    LogManager.getInstance().log(("[FLVController] NetStream Seek Failed: " + _local_2), LogManager.ERROR);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NETSTREAM_SEEK_FAILED, _arg_1.info.code));
                    this.onSeekHandler(this._returnToState);
                    return;
                case "NetStream.Seek.InvalidTime":
                    if (((this.position < duration) && (this._seekTime > 0)))
                    {
                        this._seekTime = (this._seekTime - 1);
                        this.seek(Math.max(this._seekTime, 0));
                    }
                    else
                    {
                        LogManager.getInstance().log(("[FLVController] NetStream Seek Invalid Time: " + _local_2), LogManager.ERROR);
                        dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NETSTREAM_SEEK_INVALIDTIME, _arg_1.info.code));
                        this.pause();
                    };
                    return;
                case "NetStream.Seek.Notify":
                    if (((MediaObject(media).protocol == ProtocolTypes.PROGRESSIVE) || (!(this.state === ControllerStates.PLAYING))))
                    {
                        this.onSeekHandler(this._returnToState);
                    }
                    else
                    {
                        this._isSeeking = true;
                    };
                    return;
            };
        }

        protected function onConnectUpdate(_arg_1:FlashConnectionEvent):void
        {
            this._ns.removeEventListener(NetStatusEvent.NET_STATUS, this.flvCheck);
            this._nsUpdate = _arg_1.ns;
            this._videoUpdate = new Video(this._video.width, this._video.height);
            this._videoUpdate.smoothing = true;
            this._videoUpdate.attachNetStream(this._nsUpdate);
            this._nsUpdate.addEventListener(NetStatusEvent.NET_STATUS, this.flvUpdatePreCheck);
            this.initMetaData(this._nsUpdate);
            this._nsUpdate.play(this._streamName);
            this._nsUpdate.soundTransform = new SoundTransform(this._volume);
        }

        private function LiveDVRCompleteHandler(_arg_1:ControllerEvent):void
        {
            this.downloadComplete();
        }

        protected function createNetConnection(_arg_1:IMedia):void
        {
            this._fsc.connect(_arg_1);
        }

        private function getAvailableDVRDuration():Number
        {
            if (this._dvrConnectTime > 0)
            {
                return ((this._availableDVRDuration >= 0) ? this._availableDVRDuration : 0);
            };
            return (0);
        }

        override public function populateData():IMediaInfo
        {
            var qosData:FLVQOSData;
            var info:IMediaInfo = super.populateData();
            try
            {
                info.bytesLoaded = this._ns.bytesLoaded;
                info.bytesTotal = this._ns.bytesTotal;
                if (((MediaObject(media).protocol == ProtocolTypes.STREAMING) && (state >= ControllerStates.LOADED)))
                {
                    info.percentLoaded = 1;
                }
                else
                {
                    if (MediaObject(media).protocol == ProtocolTypes.PROGRESSIVE)
                    {
                        info.percentLoaded = (this._ns.bytesLoaded / this._ns.bytesTotal);
                    };
                };
                info.bufferLength = this._ns.bufferLength;
                info.meta = _metaInfo;
                info.bitRate = _metaInfo.videoDataRate;
                if (media.deliveryMode < DeliveryModes.LIVE_DVR)
                {
                    info.availableDuration = (duration * info.percentLoaded);
                }
                else
                {
                    if (media.deliveryMode != DeliveryModes.LIVE_NODVR)
                    {
                        info.availableDuration = this.getAvailableDVRDuration();
                    };
                };
                qosData = new FLVQOSData(this._ns);
                info.qosData = qosData;
            }
            catch(e:Error)
            {
            };
            return (info);
        }

        protected function onConnectFail(_arg_1:ConnectionEvent):void
        {
            var _local_2:Number = this.position;
            var _local_3:int = this.state;
            this.stop();
            this._resumeState = _local_3;
            this._resumeTime = _local_2;
            this._isNetConnectionLost = true;
            this._fsc.close();
            dispatchEvent(new ControllerEvent(ControllerEvent.STALLED, this.populateData()));
        }

        override public function get width():Number
        {
            if (this._video.width > 0)
            {
                return (this._video.width);
            };
            return (this._width);
        }

        private function onSeekTimer(_arg_1:TimerEvent):void
        {
            _arg_1.target.removeEventListener(TimerEvent.TIMER, this.onSeekTimer);
            super.seek(this._seekTime);
            var _local_2:int = this._returnToState;
            this._returnToState = ControllerStates.SEEKING;
            switch (_local_2)
            {
                case ControllerStates.LOADED:
                    if (!_startPlayerOnLoad)
                    {
                        this.pause();
                    }
                    else
                    {
                        this.play();
                    };
                    return;
                case ControllerStates.PAUSED:
                    this.pause();
                    return;
                case ControllerStates.PLAYING:
                    if (MediaObject(media).protocol == ProtocolTypes.STREAMING)
                    {
                        super.play();
                    }
                    else
                    {
                        this.play();
                    };
                    return;
            };
        }

        private function onDownloadProgressTimer(event:TimerEvent):void
        {
            var info:IMediaInfo;
            try
            {
                info = this.populateData();
                if (!isNaN(info.percentLoaded))
                {
                    dispatchEvent(new ControllerEvent(ControllerEvent.DOWNLOAD_PROGRESS, info));
                };
                switch (MediaObject(media).protocol)
                {
                    case ProtocolTypes.STREAMING:
                        if (media.deliveryMode != DeliveryModes.LIVE_DVR)
                        {
                            if (state >= ControllerStates.LOADED)
                            {
                                this.downloadComplete();
                            };
                        }
                        else
                        {
                            this.updateDVRDuration();
                        };
                        break;
                    case ProtocolTypes.PROGRESSIVE:
                    default:
                        if (this._ns.bytesLoaded == this._ns.bytesTotal)
                        {
                            if (((this._metaDataObject) && (this._metaDataObject.duration > 0)))
                            {
                                this.downloadComplete();
                            };
                        };
                };
            }
            catch(e:Error)
            {
                Timer(event.target).removeEventListener(TimerEvent.TIMER, onDownloadProgressTimer);
                Timer(event.target).stop();
            };
        }

        private function downloadComplete():void
        {
            var infoComplete:IMediaInfo;
            try
            {
                infoComplete = this.populateData();
                infoComplete.percentLoaded = 1;
                this._downloadProgressTimer.removeEventListener(TimerEvent.TIMER, this.onDownloadProgressTimer);
                this._downloadProgressTimer.stop();
                dispatchEvent(new ControllerEvent(ControllerEvent.DOWNLOAD_COMPLETE, infoComplete));
            }
            catch(e:Error)
            {
            };
        }

        override public function load():void
        {
            _startPlayerOnLoad = false;
            super.load();
            this.clearPlayer();
            this._ns.bufferTime = 1;
            this.volume = this._volume;
            this._video.attachNetStream(this._ns);
            addEventListener(MetaDataEvent.META, this.onFirstMetaData);
            this._ns.addEventListener(NetStatusEvent.NET_STATUS, this.onLoadStatusEvent);
            var _local_1:SoundTransform = this._ns.soundTransform;
            _local_1.volume = 0;
            this._ns.soundTransform = _local_1;
            if (((MediaObject(media).protocol == ProtocolTypes.STREAMING) && (media.deliveryMode <= DeliveryModes.LIVE_DVR)))
            {
                this._ns.play(this._streamName, 0);
            }
            else
            {
                this._ns.play(this._streamName);
            };
            this.startDownloadProgress();
        }

        protected function onConnectUpdateFail(_arg_1:FlashConnectionEvent):void
        {
            this._ucState = false;
            dispatchEvent(new ControllerEvent(ControllerEvent.UPDATE_FAILURE, this.populateData()));
        }

        override public function pause():void
        {
            dispatchEvent(new ControllerEvent(ControllerEvent.PAUSE_PENDING, this.populateData()));
            this._returnToState = ControllerStates.PAUSED;
            this._ns.pause();
            super.pause();
        }

        protected function setupController():void
        {
            _timesCreated++;
            this._streamName = new String();
            this._video = new Video();
            this._video.smoothing = true;
            addChild(this._video);
            super.clip = this._video;
        }


    }
}//package com.disney.mpf.media.controller.video
