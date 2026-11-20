//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller.utils
{
    public class ControllerStates 
    {

        public static const INITIALIZING:uint = 0;
        public static const INITIALIZED:uint = 1;
        public static const LOADING:uint = 2;
        public static const LOADED:uint = 3;
        public static const BUFFERING:uint = 4;
        public static const PAUSED:uint = 5;
        public static const PLAYING:uint = 6;
        public static const SEEKING:uint = 7;
        public static const STOPPED:uint = 8;
        public static const COMPLETE:uint = 9;
        public static const ENDED:uint = 10;
        public static const SWITCH:uint = 11;

        private var _state:uint;


        public function get state():uint
        {
            return (this._state);
        }

        public function set state(_arg_1:uint):void
        {
            this._state = _arg_1;
        }


    }
}//package com.disney.mpf.media.controller.utils
