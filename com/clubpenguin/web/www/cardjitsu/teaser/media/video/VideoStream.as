//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.media.video
{
    import flash.media.Video;
    import org.osflash.signals.Signal;
    import flash.media.SoundTransform;
    import flash.net.NetStream;
    import flash.net.NetConnection;
    import flash.events.NetStatusEvent;

    public class VideoStream extends Video 
    {

        public static const PLAYING_STATE:String = "playing";
        public static const PAUSED_STATE:String = "paused";
        public static const SEEKING_STATE:String = "seeking";
        public static const PAUSED_SEEKING_STATE:String = "pausedSeeking";
        public static const COMPLETE_STATE:String = "complete";
        public static const STOPPED_STATE:String = "stopped";

        public var currentState:String = "stopped";
        public var stateChanged:Signal = new Signal(String);
        public var currentTimeSignal:Signal = new Signal(Number);
        public var loadProgressSignal:Signal = new Signal(Number);
        public var playProgressSignal:Signal = new Signal(Number);
        public var soundEnabled:Signal = new Signal(Boolean);
        private var _sndTransform:SoundTransform;
        private var _isSoundEnabled:Boolean = true;
        private var _netStream:NetStream;
        private var _netConnection:NetConnection;
        private var _vidSrc:String;
        private var _bufferFlush:Boolean = false;

        public function VideoStream(_arg_1:String, _arg_2:Number, _arg_3:Number)
        {
            this._vidSrc = _arg_1;
            super(_arg_2, _arg_3);
        }

        public function init():void
        {
            var _local_1:Object = new Object();
            _local_1.onMetaData = this.onMetaData;
            this._sndTransform = new SoundTransform();
            this._netConnection = new NetConnection();
            this._netConnection.connect(null);
            this._netStream = new NetStream(this._netConnection);
            this._netStream.bufferTime = 10;
            this._netStream.client = _local_1;
            this._netStream.soundTransform = this._sndTransform;
            this._netStream.addEventListener(NetStatusEvent.NET_STATUS, this.onNetStatus);
            smoothing = true;
            attachNetStream(this._netStream);
        }

        public function play():void
        {
            this._netStream.play(this._vidSrc);
        }

        private function onNetStatus(_arg_1:NetStatusEvent):void
        {
            trace(((this + " e.info.code: ") + _arg_1.info.code));
            switch (_arg_1.info.code)
            {
                case "NetStream.Play.Start":
                    this.currentState = PLAYING_STATE;
                    this.stateChanged.dispatch(this.currentState);
                    return;
                case "NetStream.Buffer.Empty":
                    return;
                case "NetStream.Buffer.Flush":
                    this._bufferFlush = true;
                    return;
                case "NetStream.Buffer.Full":
                    this._bufferFlush = true;
                    return;
                case "NetStream.Seek.Notify":
                    return;
                case "NetStream.Seek.InvalidTime":
                    this._bufferFlush = false;
                    return;
                case "NetStream.Play.Stop":
                    if (this._bufferFlush)
                    {
                        this.currentState = COMPLETE_STATE;
                        this.stateChanged.dispatch(this.currentState);
                    };
                    return;
            };
        }

        private function onMetaData(_arg_1:Object):void
        {
        }

        public function set volume(_arg_1:Number):void
        {
            this._sndTransform.volume = _arg_1;
            this._netStream.soundTransform = this._sndTransform;
        }

        public function togglePlayback():void
        {
            switch (this.currentState)
            {
                case PLAYING_STATE:
                    this._netStream.pause();
                    this.currentState = PAUSED_STATE;
                    break;
                case PAUSED_STATE:
                    this._netStream.resume();
                    this.currentState = PLAYING_STATE;
                    break;
                case COMPLETE_STATE:
                    this.currentState = PLAYING_STATE;
                    this._netStream.seek(0);
                    this._netStream.resume();
                    break;
            };
            this.stateChanged.dispatch(this.currentState);
        }

        public function toggleSound():void
        {
            if (this._isSoundEnabled)
            {
                this.volume = 0;
                this._isSoundEnabled = false;
                this.soundEnabled.dispatch(this._isSoundEnabled);
            }
            else
            {
                this.volume = 1;
                this._isSoundEnabled = true;
                this.soundEnabled.dispatch(this._isSoundEnabled);
            };
        }

        public function destroy():void
        {
            this._netStream.close();
            this._netStream = null;
            this._netConnection = null;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.media.video
