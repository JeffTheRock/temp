//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.cuepoints.events
{
    import flash.events.Event;
    import com.disney.mpf.media.cuepoints.ClosedCaption;

    public class ClosedCaptionEvent extends Event 
    {

        private static const CLASS_NAME:String = "com.disney.mpf.media.cuepoints.events.ClosedCaptionEvent";
        public static const TRIGGER:String = (CLASS_NAME + ".TRIGGER");

        private var _caption:ClosedCaption;

        public function ClosedCaptionEvent(_arg_1:String, _arg_2:ClosedCaption, _arg_3:Boolean=true, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._caption = _arg_2;
        }

        public function get caption():ClosedCaption
        {
            return (this._caption);
        }


    }
}//package com.disney.mpf.media.cuepoints.events
