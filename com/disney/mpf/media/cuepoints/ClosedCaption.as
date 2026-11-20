//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.cuepoints
{
    import com.disney.mpf.media.cuepoints.lang.Language;

    public class ClosedCaption extends CuePoint 
    {

        private var CLASS_NAME:String = "com.disney.mpf.media.model.cuepoint.ClosedCaption";
        private var _caption:String;
        private var _subTitles:Object;

        public function ClosedCaption(_arg_1:String, _arg_2:Number, _arg_3:String)
        {
            super(_arg_1, _arg_2);
            this._caption = _arg_3;
            this._subTitles = new Object();
        }

        public function set subtitle(_arg_1:Language):void
        {
            this._subTitles[_arg_1.id] = _arg_1;
        }

        public function get caption():String
        {
            return (this._caption);
        }

        public function set caption(_arg_1:String):void
        {
            this._caption = _arg_1;
        }

        public function getSubtitleById(_arg_1:String):Language
        {
            return (this._subTitles[_arg_1]);
        }


    }
}//package com.disney.mpf.media.cuepoints
