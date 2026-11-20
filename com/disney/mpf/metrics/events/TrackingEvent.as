//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.events
{
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class TrackingEvent extends MouseEvent 
    {

        private static const CLASS_NAME:String = "com.disney.mpf.metrics.events.TrackingEvent";
        public static const IMPRESSION:String = (CLASS_NAME + ".trackingImpression");
        public static const VIDEO_START:String = (CLASS_NAME + ".trackingVideoStart");
        public static const VIDEO_FIRST_QUARTILE:String = (CLASS_NAME + ".trackingVideoFirstQuartile");
        public static const VIDEO_MIDPOINT:String = (CLASS_NAME + ".trackingVideoMidpoint");
        public static const VIDEO_THIRD_QUARTILE:String = (CLASS_NAME + ".trackingVideoThirdQuartile");
        public static const COMPLETION:String = (CLASS_NAME + ".trackingComplete");
        public static const CLICK_THROUGH:String = (CLASS_NAME + ".trackingClickThrough");
        public static const PAUSE:String = (CLASS_NAME + ".trackingPause");
        public static const RESUME:String = (CLASS_NAME + ".trackingResume");
        public static const REWIND:String = (CLASS_NAME + ".trackingRewind");
        public static const EXPAND:String = (CLASS_NAME + ".trackingExpand");
        public static const CONTRACT:String = (CLASS_NAME + ".trackingContract");
        public static const VOLUME_CHANGE:String = (CLASS_NAME + ".trackingVolumeChange");
        public static const AUDIO_MUTE:String = (CLASS_NAME + ".trackingAudioMute");
        public static const AUDIO_UNMUTE:String = (CLASS_NAME + ".trackingAudioUnMute");
        public static const USER_VIDEO_START:String = (CLASS_NAME + ".tracking_userVidStart");
        public static const AUTO_VIDEO_START:String = (CLASS_NAME + ".tracking_autoVidStart");
        public static const UI_VIDEO_START:String = (CLASS_NAME + ".tracking_uiVidStart");
        public static const CUSTOM_EVENT:String = (CLASS_NAME + ".tracking_customEvent");

        private var _interactionTime:Date;
        private var _value:Number;
        private var _currentPosition:Number;
        private var _type:String;
        private var _bubbles:Boolean;
        private var _engagementCode:String;
        private var _localX:Number;
        private var _localY:Number;
        private var _cancelable:Boolean;
        private var _trackingUrl:String;
        private var _duration:Number;
        private var _description:String;

        public function TrackingEvent(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:Date=undefined, _arg_5:String=null, _arg_6:Number=undefined, _arg_7:Number=undefined, _arg_8:Number=undefined, _arg_9:Number=undefined, _arg_10:Number=undefined, _arg_11:Boolean=true, _arg_12:Boolean=true)
        {
            super(_arg_1, _arg_11, _arg_12, _arg_9, _arg_10);
            this._description = _arg_5;
            this._type = _arg_1;
            this._trackingUrl = _arg_2;
            this._engagementCode = _arg_3;
            this._currentPosition = _arg_6;
            this._duration = _arg_7;
            this._interactionTime = _arg_4;
            this._value = _arg_8;
            this._bubbles = _arg_11;
            this._cancelable = _arg_12;
        }

        public function set currentPosition(_arg_1:Number):void
        {
            this._currentPosition = _arg_1;
        }

        public function get engagementCode():String
        {
            return (this._engagementCode);
        }

        public function get currentPosition():Number
        {
            return (this._currentPosition);
        }

        public function get duration():Number
        {
            return (this._duration);
        }

        override public function clone():Event
        {
            return (new TrackingEvent(this._type, this._trackingUrl, this._engagementCode, this._interactionTime, this._description, this._currentPosition, this._duration, this._value, localX, localY, this._bubbles, this._cancelable));
        }

        public function set engagementCode(_arg_1:String):void
        {
            this._engagementCode = _arg_1;
        }

        public function set value(_arg_1:Number):void
        {
            this._value = _arg_1;
        }

        public function set duration(_arg_1:Number):void
        {
            this._duration = _arg_1;
        }

        public function set trackingUrl(_arg_1:String):void
        {
            this._trackingUrl = _arg_1;
        }

        public function get value():Number
        {
            return (this._value);
        }

        public function get trackingUrl():String
        {
            return (this._trackingUrl);
        }

        public function get description():String
        {
            return (this._description);
        }

        public function set interactionTime(_arg_1:Date):void
        {
            this._interactionTime = _arg_1;
        }

        public function get interactionTime():Date
        {
            return (this._interactionTime);
        }


    }
}//package com.disney.mpf.metrics.events
