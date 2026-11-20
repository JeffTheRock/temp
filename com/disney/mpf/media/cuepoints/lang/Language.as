//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.cuepoints.lang
{
    public class Language 
    {

        private const CLASS_NAME:String = "com.disney.mpf.media.cuepoints.lang.Language";

        private var _id:String;
        private var _text:String;
        private var _encoding:String;

        public function Language(_arg_1:String, _arg_2:String, _arg_3:String)
        {
            this._id = _arg_1;
            this._encoding = _arg_3;
            this._text = _arg_2;
        }

        public function set text(_arg_1:String):void
        {
            this._text = _arg_1;
        }

        public function get text():String
        {
            return (this._text);
        }

        public function get encoding():String
        {
            return (this._encoding);
        }

        public function get id():String
        {
            return (this._id);
        }


    }
}//package com.disney.mpf.media.cuepoints.lang
