//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.cuepoints
{
    public class CuePoint 
    {

        private var CLASS_NAME:String = "com.disney.mpf.media.model.cuepoint.CuePoint";
        private var _timecode:Number;
        private var _id:String;

        public function CuePoint(_arg_1:String, _arg_2:Number)
        {
            this._id = _arg_1;
            this._timecode = _arg_2;
        }

        public function destroy():void
        {
            delete this[this];
        }

        public function get timeCode():Number
        {
            return (this._timecode);
        }

        public function set timeCode(_arg_1:Number):void
        {
            this._timecode = _arg_1;
        }

        public function get id():String
        {
            return (this._id);
        }


    }
}//package com.disney.mpf.media.cuepoints
