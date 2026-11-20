//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model
{
    public class StreamItemEntry 
    {

        private var _bitrate:int;
        private var _stream:String;

        public function StreamItemEntry(_arg_1:String, _arg_2:Number=-1)
        {
            this.stream = _arg_1;
            this.bitrate = _arg_2;
        }

        public function get stream():String
        {
            return (this._stream);
        }

        public function set stream(_arg_1:String):void
        {
            this._stream = _arg_1;
        }

        public function set bitrate(_arg_1:int):void
        {
            this._bitrate = _arg_1;
        }

        public function get bitrate():int
        {
            return (this._bitrate);
        }


    }
}//package com.disney.mpf.media.model
