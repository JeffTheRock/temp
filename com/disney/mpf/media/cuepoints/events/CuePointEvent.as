//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.cuepoints.events
{
    import flash.events.Event;
    import com.disney.mpf.media.cuepoints.CuePoint;

    public class CuePointEvent extends Event 
    {

        private static const CLASS_NAME:String = "com.disney.mpf.media.cuepoints.events.CuePointEvent";
        public static const TRIGGER:String = (CLASS_NAME + ".TRIGGER");

        private var _cuepoint:CuePoint;

        public function CuePointEvent(_arg_1:String, _arg_2:CuePoint, _arg_3:Boolean=true, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._cuepoint = _arg_2;
        }

        public function get cuePoint():CuePoint
        {
            return (this._cuepoint);
        }


    }
}//package com.disney.mpf.media.cuepoints.events
