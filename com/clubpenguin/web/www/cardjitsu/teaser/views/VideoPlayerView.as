//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.views
{
    import flash.display.Sprite;
    import org.osflash.signals.natives.NativeSignal;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.PlayButton;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.MuteButton;
    import com.clubpenguin.web.www.cardjitsu.teaser.media.video.VideoStream;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.ProgressBar;
    import flash.display.Shape;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.VideoVO;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.VideoPlayerFrame;
    import flash.events.MouseEvent;

    public class VideoPlayerView extends Sprite 
    {

        private var mouseOver:NativeSignal;
        private var mouseOut:NativeSignal;
        private var mouseDown:NativeSignal;
        private var mouseUp:NativeSignal;
        private var mouseMove:NativeSignal;
        private var mouseClick:NativeSignal;
        private var _playButton:PlayButton;
        private var _muteButton:MuteButton;
        private var _videoPlayerStream:VideoStream;
        private var _progressBar:ProgressBar;
        private var _seekPoint:Number;
        private var _trackWidthPlaceHolder:Shape;
        private var _videoVO:VideoVO;


        public function set data(_arg_1:VideoVO):void
        {
            this._videoVO = _arg_1;
        }

        public function init():void
        {
            this.initFrame();
            this.initVideoPlayerUI();
            this.initPlaceHolder();
            this.initVideoStream();
            this.activateUI();
        }

        private function initFrame():void
        {
            var _local_1:Sprite = new VideoPlayerFrame();
            _local_1.x = (stage.stageWidth * 0.5);
            addChild(_local_1);
        }

        private function initVideoPlayerUI():void
        {
            this._playButton = new PlayButton();
            this._playButton.x = 20;
            this._playButton.y = 374;
            this._playButton.name = "play";
            this._playButton.mouseChildren = false;
            this._playButton.buttonMode = true;
            this._playButton.activeState.visible = false;
            addChild(this._playButton);
            this._muteButton = new MuteButton();
            this._muteButton.x = 60;
            this._muteButton.y = 374;
            this._muteButton.name = "mute";
            this._muteButton.mouseChildren = false;
            this._muteButton.buttonMode = true;
            this._muteButton.activeState.visible = false;
            addChild(this._muteButton);
        }

        private function initPlaceHolder():void
        {
            var _local_1:Shape = new Shape();
            _local_1.graphics.beginFill(0x222222, 1);
            _local_1.graphics.drawRect(0, 0, 460, 350);
            _local_1.graphics.endFill();
            _local_1.x = 30;
            _local_1.y = 15;
            addChildAt(_local_1, 0);
        }

        private function initVideoStream():void
        {
            this._videoPlayerStream = new VideoStream(this._videoVO.videoSrc, this._videoVO.width, this._videoVO.height);
            this._videoPlayerStream.init();
            this._videoPlayerStream.x = 30;
            this._videoPlayerStream.y = 22;
            this._videoPlayerStream.stateChanged.add(this.onStateChanged);
            this._videoPlayerStream.soundEnabled.add(this.onSoundStateChanged);
            addChildAt(this._videoPlayerStream, 1);
        }

        private function onStateChanged(_arg_1:String):void
        {
            trace(((this + " State: ") + _arg_1));
            switch (_arg_1)
            {
                case VideoStream.PLAYING_STATE:
                    this._playButton.activeState.visible = true;
                    this._playButton.idleState.visible = false;
                    return;
                case VideoStream.PAUSED_STATE:
                    this._playButton.activeState.visible = false;
                    this._playButton.idleState.visible = true;
                    return;
                case VideoStream.COMPLETE_STATE:
                    this._playButton.activeState.visible = false;
                    this._playButton.idleState.visible = true;
                    return;
            };
        }

        private function onSoundStateChanged(_arg_1:Boolean):void
        {
            trace(((this + " State: ") + _arg_1));
            switch (_arg_1)
            {
                case true:
                    this._muteButton.activeState.visible = false;
                    this._muteButton.idleState.visible = true;
                    return;
                case false:
                    this._muteButton.activeState.visible = true;
                    this._muteButton.idleState.visible = false;
                    return;
            };
        }

        private function activateUI():void
        {
            this.mouseClick = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
            this.mouseClick.add(this.onMouseClick);
            this._videoPlayerStream.play();
        }

        private function onMouseClick(_arg_1:MouseEvent):void
        {
            switch (_arg_1.target.name)
            {
                case "play":
                    this._videoPlayerStream.togglePlayback();
                    return;
                case "mute":
                    this._videoPlayerStream.toggleSound();
                    return;
            };
        }

        public function destroy():void
        {
            this._videoPlayerStream.destroy();
            removeChild(this._videoPlayerStream);
            this._videoPlayerStream = null;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.views
