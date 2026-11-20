//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model
{
    public class StreamItem 
    {

        private var _defaultBitrate:Number = -1;
        private var _emptyBufferLength:Number;
        private var _preferredBufferLength:Number;
        private var _streams:Array;

        public function StreamItem(_arg_1:String=null, _arg_2:Number=-1, _arg_3:Boolean=false)
        {
            this._streams = new Array();
            if (_arg_1)
            {
                this.addStream(_arg_1, _arg_2, _arg_3);
            };
        }

        public function addStream(_arg_1:String, _arg_2:Number=-1, _arg_3:Boolean=false):void
        {
            var _local_4:StreamItemEntry = new StreamItemEntry(_arg_1, _arg_2);
            this._streams.push(_local_4);
            this._streams.sortOn("bitrate", Array.NUMERIC);
            if (_arg_3)
            {
                this.defaultBitrate = _arg_2;
            };
        }

        public function set maxBufferLength(_arg_1:Number):void
        {
            this._preferredBufferLength = _arg_1;
        }

        public function set defaultBitrate(_arg_1:Number):void
        {
            var _local_2:uint;
            var _local_3:uint = this.streams.length;
            this._defaultBitrate = _arg_1;
        }

        public function get maxBufferLength():Number
        {
            return (this._preferredBufferLength);
        }

        public function get defaultBitrate():Number
        {
            return (this._defaultBitrate);
        }

        public function get minBufferLength():Number
        {
            return (this._emptyBufferLength);
        }

        public function get streams():Array
        {
            return (this._streams);
        }

        public function set minBufferLength(_arg_1:Number):void
        {
            this._emptyBufferLength = _arg_1;
        }


    }
}//package com.disney.mpf.media.model
