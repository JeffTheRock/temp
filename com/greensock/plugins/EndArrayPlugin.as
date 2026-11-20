//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import com.greensock.TweenLite;
    import flash.display.*;
    import com.greensock.*;

    public class EndArrayPlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _a:Array;
        protected var _info:Array = [];

        public function EndArrayPlugin()
        {
            this.propName = "endArray";
            this.overwriteProps = ["endArray"];
        }

        public function init(_arg_1:Array, _arg_2:Array):void
        {
            _a = _arg_1;
            var _local_3:int = _arg_2.length;
            while (_local_3--)
            {
                if (((!(_arg_1[_local_3] == _arg_2[_local_3])) && (!(_arg_1[_local_3] == null))))
                {
                    _info[_info.length] = new ArrayTweenInfo(_local_3, _a[_local_3], (_arg_2[_local_3] - _a[_local_3]));
                };
            };
        }

        override public function onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            if (((!(_arg_1 is Array)) || (!(_arg_2 is Array))))
            {
                return (false);
            };
            init((_arg_1 as Array), _arg_2);
            return (true);
        }

        override public function set changeFactor(_arg_1:Number):void
        {
            var _local_3:ArrayTweenInfo;
            var _local_4:Number;
            var _local_2:int = _info.length;
            if (this.round)
            {
                while (_local_2--)
                {
                    _local_3 = _info[_local_2];
                    _local_4 = (_local_3.start + (_local_3.change * _arg_1));
                    _a[_local_3.index] = ((_local_4 > 0) ? int((_local_4 + 0.5)) : int((_local_4 - 0.5)));
                };
            }
            else
            {
                while (_local_2--)
                {
                    _local_3 = _info[_local_2];
                    _a[_local_3.index] = (_local_3.start + (_local_3.change * _arg_1));
                };
            };
        }


    }
}//package com.greensock.plugins

class ArrayTweenInfo 
{

    public var change:Number;
    public var start:Number;
    public var index:uint;

    public function ArrayTweenInfo(_arg_1:uint, _arg_2:Number, _arg_3:Number)
    {
        this.index = _arg_1;
        this.start = _arg_2;
        this.change = _arg_3;
    }

}

