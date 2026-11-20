//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.errors.events
{
    import flash.events.ErrorEvent;
    import flash.events.Event;

    public class MPFErrorEvent extends ErrorEvent 
    {

        public static const ERROR:String = "MPF_ERROR";
        public static const WARN:String = "MPF_WARNING";

        private var _code:int;
        private var _message:String;

        public function MPFErrorEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=true, _arg_5:Boolean=true)
        {
            super(_arg_1, _arg_4, _arg_5, _arg_3);
            this._code = _arg_2;
            this._message = _arg_3;
        }

        override public function clone():Event
        {
            return (new MPFErrorEvent(type, this.code, this.message, bubbles, cancelable));
        }

        public function get message():String
        {
            return (this._message);
        }

        public function get code():int
        {
            return (this._code);
        }


    }
}//package com.disney.mpf.errors.events
