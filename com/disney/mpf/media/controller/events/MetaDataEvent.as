//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller.events
{
    import flash.events.Event;
    import com.disney.mpf.media.controller.utils.MetaDataInfo;

    public class MetaDataEvent extends Event 
    {

        private static const CLASS_NAME:String = "com.disney.mpf.media.controller.events.MetaDataEvent";
        public static const META:String = (CLASS_NAME + ".META");

        private var _cancelable:Boolean;
        private var _bubbles:Boolean;
        private var _type:String;
        private var _metadata:MetaDataInfo;

        public function MetaDataEvent(_arg_1:String, _arg_2:MetaDataInfo, _arg_3:Boolean=true, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._type = _arg_1;
            this._bubbles = _arg_3;
            this._cancelable = _arg_4;
            this._metadata = _arg_2;
        }

        override public function clone():Event
        {
            return (new MetaDataEvent(this._type, this._metadata, this._bubbles, this._cancelable));
        }

        public function get metaDataInfo():MetaDataInfo
        {
            return (this._metadata);
        }


    }
}//package com.disney.mpf.media.controller.events
