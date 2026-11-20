//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers.utils
{
    public class OmnitureStringUtils 
    {


        public static function addToString(_arg_1:String, _arg_2:String):String
        {
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:Boolean;
            var _local_7:int;
            if (((!(_arg_1 == null)) && (!(_arg_1 == ""))))
            {
                _local_3 = _arg_1.split(",");
                _local_4 = new Array();
                if (((_arg_2) && (!(_arg_2 == ""))))
                {
                    _local_4 = _arg_2.split(",");
                };
                _local_5 = 0;
                while (_local_5 < _local_3.length)
                {
                    _local_6 = true;
                    _local_7 = 0;
                    while (_local_7 < _local_4.length)
                    {
                        if (_local_4[_local_7] == _local_3[_local_5])
                        {
                            _local_6 = false;
                        };
                        _local_7++;
                    };
                    if (_local_6)
                    {
                        _local_4.push(_local_3[_local_5]);
                    };
                    _local_5++;
                };
                _arg_2 = _local_4.join(",");
            };
            return (_arg_2);
        }

        public static function removeFromString(_arg_1:String, _arg_2:String):String
        {
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:Boolean;
            var _local_7:int;
            if (((!(_arg_1 == null)) && (!(_arg_1 == ""))))
            {
                _local_3 = _arg_1.split(",");
                _local_4 = new Array();
                if (((_arg_2) && (!(_arg_2 == ""))))
                {
                    _local_4 = _arg_2.split(",");
                };
                _local_5 = 0;
                while (_local_5 < _local_3.length)
                {
                    _local_6 = false;
                    _local_7 = 0;
                    while (_local_7 < _local_4.length)
                    {
                        if (_local_4[_local_7] == _local_3[_local_5])
                        {
                            _local_6 = true;
                            break;
                        };
                        _local_7++;
                    };
                    if (_local_6)
                    {
                        _local_4.splice(_local_7, 1);
                    };
                    _local_5++;
                };
                _arg_2 = _local_4.join(",");
            };
            return (_arg_2);
        }


    }
}//package com.disney.mpf.metrics.trackers.utils
