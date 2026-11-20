//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.easing
{
    public class Back 
    {


        public static function easeOut(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number=1.70158):Number
        {
            return ((_arg_3 * ((((_arg_1 = ((_arg_1 / _arg_4) - 1)) * _arg_1) * (((_arg_5 + 1) * _arg_1) + _arg_5)) + 1)) + _arg_2);
        }

        public static function easeIn(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number=1.70158):Number
        {
            return ((((_arg_3 * (_arg_1 = (_arg_1 / _arg_4))) * _arg_1) * (((_arg_5 + 1) * _arg_1) - _arg_5)) + _arg_2);
        }

        public static function easeInOut(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number=1.70158):Number
        {
            if ((_arg_1 = (_arg_1 / (_arg_4 * 0.5))) < 1)
            {
                return (((_arg_3 * 0.5) * ((_arg_1 * _arg_1) * ((((_arg_5 = (_arg_5 * 1.525)) + 1) * _arg_1) - _arg_5))) + _arg_2);
            };
            return (((_arg_3 / 2) * ((((_arg_1 = (_arg_1 - 2)) * _arg_1) * ((((_arg_5 = (_arg_5 * 1.525)) + 1) * _arg_1) + _arg_5)) + 2)) + _arg_2);
        }


    }
}//package com.greensock.easing
