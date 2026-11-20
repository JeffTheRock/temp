//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model.info.qos
{
    public class AbstractQOSData 
    {

        private var _time:Number;

        public function AbstractQOSData()
        {
            this._time = new Date().time;
        }

        public function get timeStamp():Number
        {
            return (this._time);
        }


    }
}//package com.disney.mpf.media.model.info.qos
