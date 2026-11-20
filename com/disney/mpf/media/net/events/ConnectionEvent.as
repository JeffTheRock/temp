//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net.events
{
    import flash.events.Event;

    public class ConnectionEvent extends Event 
    {

        public static var CONNECTION_FAILURE:String = "connectionFailure";
        public static var CONNECTION_SUCCESS:String = "connectionSuccess";
        public static var CONNECTION_UPDATE_FAILURE:String = "connectionUpdateFailure";
        public static var CONNECTION_UPDATE_SUCCESS:String = "connectionUpdateSuccess";

        private var _type:String;

        public function ConnectionEvent(_arg_1:String)
        {
            this._type = _arg_1;
            super(_arg_1, false, true);
        }

        override public function clone():Event
        {
            return (new ConnectionEvent(this._type));
        }


    }
}//package com.disney.mpf.media.net.events
