//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.events
{
    import flash.events.Event;

    public class ContentTrackingEvent extends Event 
    {

        private static const CLASS_NAME:String = "com.disney.mpf.metrics.events.CustomTrackingEvent";
        public static const FORCE_COMPLETION:String = (CLASS_NAME + ".forceCompletion");

        private var _cancelable:Boolean;
        private var _bubbles:Boolean;
        private var _type:String;

        public function ContentTrackingEvent(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=true)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._type = _arg_1;
            this._bubbles = _arg_2;
            this._cancelable = _arg_3;
        }

        override public function clone():Event
        {
            return (new ContentTrackingEvent(this._type, this._bubbles, this._cancelable));
        }


    }
}//package com.disney.mpf.metrics.events
