//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net.events
{
    import flash.net.NetStream;

    public class FlashConnectionEvent extends ConnectionEvent 
    {

        public static var CONNECTION_FAILURE:String = ConnectionEvent.CONNECTION_FAILURE;
        public static var CONNECTION_SUCCESS:String = ConnectionEvent.CONNECTION_SUCCESS;
        public static var CONNECTION_UPDATE_FAILURE:String = ConnectionEvent.CONNECTION_UPDATE_FAILURE;
        public static var CONNECTION_UPDATE_SUCCESS:String = ConnectionEvent.CONNECTION_UPDATE_SUCCESS;

        private var _ns:NetStream;

        public function FlashConnectionEvent(_arg_1:String, _arg_2:NetStream=null)
        {
            super(_arg_1);
            this._ns = _arg_2;
        }

        public function set ns(_arg_1:NetStream):void
        {
            this._ns = _arg_1;
        }

        public function get ns():NetStream
        {
            return (this._ns);
        }


    }
}//package com.disney.mpf.media.net.events
