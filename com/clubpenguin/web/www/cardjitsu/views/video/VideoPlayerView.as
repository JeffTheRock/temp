//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.video
{
    import flash.display.Sprite;
    import org.osflash.signals.natives.NativeSignal;
    import com.disney.mpf.player.Player;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoPlayButton;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoMuteButton;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoProgressBar;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.omniture.ActionSource;
    import com.disney.mpf.metrics.trackers.OmnitureTracker;
    import com.disney.mpf.metrics.trackers.model.OmnitureModel;
    import com.clubpenguin.web.www.cardjitsu.models.vo.VideoVO;
    import com.disney.mpf.media.utils.MediaTypes;
    import com.disney.mpf.media.utils.MediaFormats;
    import com.disney.mpf.media.model.FLVMediaType;
    import flash.display.Shape;
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import com.disney.mpf.media.model.Playlist;
    import com.disney.mpf.media.decorator.MediaObject;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoPreloaderAnimationGraphic;
    import flash.text.TextFormat;
    import com.clubpenguin.web.libs.fonts.BurbankBigRegularBold;
    import flash.text.TextFormatAlign;
    import flash.text.AntiAliasType;
    import flash.text.TextFieldAutoSize;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoPlayProgressBarFire;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoScrubberFire;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoPlayProgressBarWater;
    import com.clubpenguin.web.www.cardjitsu.assets.global.VideoScrubberWater;
    import flash.events.MouseEvent;
    import com.disney.mpf.media.controller.utils.ControllerStates;
    import flash.geom.Rectangle;
    import flash.external.ExternalInterface;
    import com.disney.mpf.metrics.TrackingManager;
    import com.disney.mpf.metrics.events.EventList;

    public class VideoPlayerView extends Sprite 
    {

        private static const WATER_THEME:String = "water";
        private static const FIRE_THEME:String = "fire";
        private static var CURRENT_THEME:String;
        private static var CURRENT_LANGUAGE:String;

        private var videoBufferEmpty:NativeSignal;
        private var videoBufferFull:NativeSignal;
        private var videoBufferFlush:NativeSignal;
        private var videoDownloadProgress:NativeSignal;
        private var videoPlayProgress:NativeSignal;
        private var videoPlay:NativeSignal;
        private var videoPause:NativeSignal;
        private var videoStop:NativeSignal;
        private var videoPlayComplete:NativeSignal;
        private var mouseOver:NativeSignal;
        private var mouseOut:NativeSignal;
        private var mouseDown:NativeSignal;
        private var mouseUp:NativeSignal;
        private var mouseMove:NativeSignal;
        private var mouseClick:NativeSignal;
        private var _videoPlayer:Player;
        private var _playButton:VideoPlayButton;
        private var _muteButton:VideoMuteButton;
        private var _progressBarContainer:VideoProgressBar;
        private var _preloaderAnimationGraphic:MovieClip;
        private var _timerTextField:TextField;
        private var _playProgressBar:Sprite;
        private var _videoScrubber:Sprite;
        private var _actionsource:ActionSource;
        private var _omniTracker:OmnitureTracker;
        private var _omniModel:OmnitureModel;
        private var _vo:VideoVO;

        public function VideoPlayerView(_arg_1:VideoVO, _arg_2:ActionSource)
        {
            this._vo = _arg_1;
            this._actionsource = _arg_2;
            CURRENT_LANGUAGE = this._vo.language;
            CURRENT_THEME = this._vo.id.toLowerCase();
        }

        public function init():void
        {
            this.installMPFComponents();
            this.initPlaceHolder();
            this.createPlayer();
            this.initTimer();
            this.initVideoPlayerUI();
            this.initProgressBar();
            this.initOmnitureTracker();
            this.initEmbedCode();
            this.activateUI();
        }

        private function installMPFComponents():void
        {
            MediaTypes.install(MediaFormats.FLV, FLVMediaType);
        }

        private function initPlaceHolder():void
        {
            var _local_1:Shape = new Shape();
            _local_1.graphics.beginFill(0);
            _local_1.graphics.drawRect(0, 0, this._vo.width, this._vo.height);
            _local_1.graphics.endFill();
            addChildAt(_local_1, 0);
        }

        public function createPlayer():void
        {
            this._videoPlayer = new Player();
            this._videoPlayer.width = this._vo.width;
            this._videoPlayer.height = this._vo.height;
            this.videoBufferEmpty = new NativeSignal(this._videoPlayer, ControllerEvent.BUFFER_EMPTY, ControllerEvent);
            this.videoBufferFull = new NativeSignal(this._videoPlayer, ControllerEvent.BUFFER_FULL, ControllerEvent);
            this.videoBufferFlush = new NativeSignal(this._videoPlayer, ControllerEvent.BUFFER_FLUSH, ControllerEvent);
            this.videoDownloadProgress = new NativeSignal(this._videoPlayer, ControllerEvent.DOWNLOAD_PROGRESS, ControllerEvent);
            this.videoPlayProgress = new NativeSignal(this._videoPlayer, ControllerEvent.PROGRESS_UPDATE, ControllerEvent);
            this.videoPlayComplete = new NativeSignal(this._videoPlayer, ControllerEvent.COMPLETE, ControllerEvent);
            this.videoPlay = new NativeSignal(this._videoPlayer, ControllerEvent.PLAY, ControllerEvent);
            this.videoPause = new NativeSignal(this._videoPlayer, ControllerEvent.PAUSE, ControllerEvent);
            this.videoStop = new NativeSignal(this._videoPlayer, ControllerEvent.STOP, ControllerEvent);
            this.videoBufferEmpty.add(this.onBufferEmpty);
            this.videoBufferFull.add(this.onBufferFull);
            this.videoBufferFlush.add(this.onBufferFlush);
            this.videoPlayProgress.add(this.onPlayProgress);
            this.videoDownloadProgress.add(this.onDownloadProgress);
            this.videoPlayComplete.add(this.onPlayComplete);
            this.videoPlay.add(this.onVideoPlay);
            this.videoPause.add(this.onVideoPause);
            this.videoStop.add(this.onVideoStop);
            var _local_1:String = (((("CJ_" + this._vo.id) + "_TRAILER") + "_") + CURRENT_LANGUAGE);
            var _local_2:Playlist = new Playlist("card_jitsu_playlist");
            var _local_3:MediaObject = new MediaObject(_local_1, this._vo.vidSrc, _local_1, MediaFormats.FLV);
            _local_2.addItem(_local_3);
            _local_2.bufferTime = 10;
            this._videoPlayer.playlist = _local_2;
            addChild(this._videoPlayer);
        }

        private function onBufferEmpty(_arg_1:ControllerEvent):void
        {
            trace((this + " Buffer Emtpy"));
        }

        private function onBufferFull(_arg_1:ControllerEvent):void
        {
            trace((this + " Buffer Full"));
        }

        private function onBufferFlush(_arg_1:ControllerEvent):void
        {
            trace((this + " Buffer Flush"));
        }

        private function onDownloadProgress(_arg_1:ControllerEvent):void
        {
            var _local_2:Number = (_arg_1.info.bytesLoaded / _arg_1.info.bytesTotal);
            this._progressBarContainer.loadProgressBar.width = (_local_2 * this._progressBarContainer.backing.width);
        }

        private function onPlayProgress(_arg_1:ControllerEvent):void
        {
            var _local_2:int = this._videoPlayer.controller.duration;
            var _local_3:Number = (this._videoPlayer.position / _local_2);
            var _local_4:Number = (((_local_3 * ((this._progressBarContainer.backing.width - this._videoScrubber.width) - 5)) + this._videoScrubber.width) + 3);
            this._playProgressBar.width = _local_4;
            this._videoScrubber.x = _local_4;
            this._timerTextField.text = ((this.formatTime(this._videoPlayer.position) + " / ") + this.formatTime(_local_2));
        }

        private function formatTime(_arg_1:Number):String
        {
            var _local_2:String;
            var _local_3:String;
            if (_arg_1 > 0)
            {
                _local_2 = String(((_arg_1 * 0.0166) >> 0));
                _local_3 = String(((_arg_1 % 60) >> 0));
                return ((_local_2 + ":") + ((_local_3.length < 2) ? ("0" + _local_3) : _local_3));
            };
            return ("0:00");
        }

        private function onPlayComplete(_arg_1:ControllerEvent):void
        {
            trace((this + " Play Complete"));
            this.onVideoPause(null);
        }

        private function onVideoPlay(_arg_1:ControllerEvent):void
        {
            this._playButton.activeState.visible = true;
            this._playButton.idleState.visible = false;
        }

        private function onVideoPause(_arg_1:ControllerEvent):void
        {
            this._playButton.activeState.visible = false;
            this._playButton.idleState.visible = true;
        }

        private function onVideoStop(_arg_1:ControllerEvent):void
        {
            trace((this + " Video Stopped"));
        }

        private function onVideoMute(_arg_1:ControllerEvent):void
        {
            trace((this + " Video Muted"));
            if (this._videoPlayer.isMuted)
            {
                this._muteButton.activeState.visible = true;
                this._muteButton.idleState.visible = false;
            }
            else
            {
                this._muteButton.activeState.visible = false;
                this._muteButton.idleState.visible = true;
            };
        }

        private function initBufferPreloaderGraphic():void
        {
            this._preloaderAnimationGraphic = new VideoPreloaderAnimationGraphic();
            this._preloaderAnimationGraphic.x = (this._videoPlayer.x + (this._videoPlayer.width * 0.5));
            this._preloaderAnimationGraphic.y = (this._videoPlayer.y + (this._videoPlayer.height * 0.5));
            addChild(this._preloaderAnimationGraphic);
        }

        private function initTimer():void
        {
            this._timerTextField = new TextField();
            this._timerTextField.defaultTextFormat = new TextFormat(new BurbankBigRegularBold().fontName, 14, "0xFFFFFF", true, null, null, null, null, TextFormatAlign.RIGHT);
            this._timerTextField.embedFonts = true;
            this._timerTextField.antiAliasType = AntiAliasType.ADVANCED;
            this._timerTextField.text = "0:00 / 0:00";
            this._timerTextField.x = 460;
            this._timerTextField.y = 441;
            this._timerTextField.autoSize = TextFieldAutoSize.LEFT;
            this._timerTextField.selectable = false;
            addChild(this._timerTextField);
        }

        private function initVideoPlayerUI():void
        {
            this._playButton = new VideoPlayButton();
            this._playButton.x = 0;
            this._playButton.y = 435;
            this._playButton.name = "play";
            this._playButton.mouseChildren = false;
            this._playButton.buttonMode = true;
            this._playButton.activeState.visible = false;
            addChild(this._playButton);
            this._muteButton = new VideoMuteButton();
            this._muteButton.x = 40;
            this._muteButton.y = 435;
            this._muteButton.name = "mute";
            this._muteButton.mouseChildren = false;
            this._muteButton.buttonMode = true;
            this._muteButton.activeState.visible = false;
            addChild(this._muteButton);
        }

        private function initProgressBar():void
        {
            this._progressBarContainer = new VideoProgressBar();
            this._progressBarContainer.x = 85;
            this._progressBarContainer.y = 450;
            switch (this._vo.id.toLowerCase())
            {
                case FIRE_THEME:
                    this._playProgressBar = new VideoPlayProgressBarFire();
                    this._videoScrubber = new VideoScrubberFire();
                    break;
                case WATER_THEME:
                    this._playProgressBar = new VideoPlayProgressBarWater();
                    this._videoScrubber = new VideoScrubberWater();
                    break;
                default:
                    this._playProgressBar = new VideoPlayProgressBarWater();
                    this._videoScrubber = new VideoScrubberWater();
            };
            this._progressBarContainer.addChildAt(this._playProgressBar, (this._progressBarContainer.numChildren - 1));
            this._progressBarContainer.addChildAt(this._videoScrubber, (this._progressBarContainer.numChildren - 1));
            this._progressBarContainer.loadProgressBar.width = 0;
            this._playProgressBar.width = 0;
            this._videoScrubber.x = this._videoScrubber.width;
            addChild(this._progressBarContainer);
        }

        private function initEmbedCode():void
        {
            var _local_1:EmbedCode = new EmbedCode(this._vo);
            _local_1.init();
            _local_1.x = (915 - _local_1.width);
            _local_1.y = 436;
            addChild(_local_1);
        }

        private function activateUI():void
        {
            this.mouseDown = new NativeSignal(this._videoScrubber, MouseEvent.MOUSE_DOWN, MouseEvent);
            this.mouseClick = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
            this._videoScrubber.buttonMode = true;
            this.mouseDown.add(this.onMouseDown);
            this.mouseClick.add(this.onMouseClick);
        }

        private function onMouseClick(_arg_1:MouseEvent):void
        {
            switch (_arg_1.target.name)
            {
                case "play":
                    if (this._videoPlayer.controller.state == ControllerStates.PLAYING)
                    {
                        this._videoPlayer.pause();
                    }
                    else
                    {
                        if ((((this._videoPlayer.controller.state == ControllerStates.PAUSED) || (this._videoPlayer.controller.state == ControllerStates.STOPPED)) || (this._videoPlayer.controller.state == ControllerStates.INITIALIZED)))
                        {
                            this._videoPlayer.play();
                        }
                        else
                        {
                            if (this._videoPlayer.controller.state == ControllerStates.COMPLETE)
                            {
                                this._videoPlayer.seek(0);
                                this._videoPlayer.play();
                            };
                        };
                    };
                    return;
                case "mute":
                    this._videoPlayer.isMuted = (!(this._videoPlayer.isMuted));
                    this._muteButton.idleState.visible = (!(this._muteButton.idleState.visible));
                    this._muteButton.activeState.visible = (!(this._muteButton.activeState.visible));
                    return;
            };
        }

        private function onMouseDown(_arg_1:MouseEvent):void
        {
            this._videoPlayer.pause();
            var _local_2:Rectangle = new Rectangle((this._videoScrubber.width + 2), 0, ((this._progressBarContainer.width - this._videoScrubber.width) - 4), 0);
            this._videoScrubber.startDrag(false, _local_2);
            this.mouseMove = new NativeSignal(stage, MouseEvent.MOUSE_MOVE, MouseEvent);
            this.mouseMove.add(this.onMouseMove);
            this.mouseUp = new NativeSignal(stage, MouseEvent.MOUSE_UP, MouseEvent);
            this.mouseUp.addOnce(this.onMouseUp);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            var _local_2:Number = (((this._videoScrubber.x - this._videoScrubber.width) / this._progressBarContainer.width) * this._videoPlayer.controller.duration);
            this._playProgressBar.width = this._videoScrubber.x;
            this._videoPlayer.seek(_local_2);
        }

        private function onMouseUp(_arg_1:MouseEvent):void
        {
            this._videoScrubber.stopDrag();
            this.mouseMove.remove(this.onMouseMove);
            this._videoPlayer.play();
        }

        private function playVideo():void
        {
            this._videoPlayer.play();
        }

        private function initOmnitureTracker():void
        {
            var _local_1:* = "www.clubpenguin.com/card-jitsu/";
            if (ExternalInterface.available)
            {
                _local_1 = ExternalInterface.call("window.location.href.toString");
            };
            this._omniModel = new OmnitureModel(this._actionsource, "dol", "wdgdolclp", "w88.go.com", "sw88.go.com", "112", (((("CJ_" + this._vo.id) + "_TRAILER") + "_") + CURRENT_LANGUAGE), "dgame", _local_1, "dgame_clp_video_player");
            this._omniModel.trackLocal = true;
            this._omniModel.debugTracking = true;
            this._omniTracker = new OmnitureTracker(this._omniModel);
            TrackingManager.getInstance().businessApplication = this;
            TrackingManager.getInstance().addTracker("Omniture_Tracker", this._omniTracker, EventList.CONTENT_EVENTS);
            this.addChild(this._actionsource);
        }

        public function destroy():void
        {
            this._videoPlayer.stop();
            this._videoPlayer.destroy();
            TrackingManager.getInstance().removeTracker("Omniture_Tracker");
            this.mouseDown.remove(this.onMouseDown);
            this.mouseClick.remove(this.onMouseClick);
            this.videoBufferEmpty.remove(this.onBufferEmpty);
            this.videoBufferFull.remove(this.onBufferFull);
            this.videoBufferFlush.remove(this.onBufferFlush);
            this.videoPlayProgress.remove(this.onPlayProgress);
            this.videoDownloadProgress.remove(this.onDownloadProgress);
            this.videoPlayComplete.remove(this.onPlayComplete);
            this.videoPlay.remove(this.onVideoPlay);
            this.videoPause.remove(this.onVideoPause);
            this.videoStop.remove(this.onVideoStop);
            removeChild(this._videoPlayer);
            this._videoPlayer = null;
            removeChild(this._actionsource);
            this._omniTracker = null;
            this._omniModel = null;
        }

        public function play():void
        {
            this._videoPlayer.play();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.video
