//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import com.greensock.TweenLite;
    import com.greensock.core.PropTween;
    import com.greensock.*;
    import com.greensock.core.*;

    public class TweenPlugin 
    {

        public static const VERSION:Number = 1.31;
        public static const API:Number = 1;

        public var activeDisable:Boolean;
        protected var _changeFactor:Number = 0;
        protected var _tweens:Array = [];
        public var onDisable:Function;
        public var propName:String;
        public var round:Boolean;
        public var onEnable:Function;
        public var priority:int = 0;
        public var overwriteProps:Array;
        public var onComplete:Function;


        public static function activate(_arg_1:Array):Boolean
        {
            var _local_3:Object;
            TweenLite.onPluginEvent = TweenPlugin.onTweenEvent;
            var _local_2:int = _arg_1.length;
            while (_local_2--)
            {
                if (_arg_1[_local_2].hasOwnProperty("API"))
                {
                    _local_3 = new ((_arg_1[_local_2] as Class))();
                    TweenLite.plugins[_local_3.propName] = _arg_1[_local_2];
                };
            };
            return (true);
        }

        private static function onTweenEvent(_arg_1:String, _arg_2:TweenLite):Boolean
        {
            var _local_4:Boolean;
            var _local_5:Array;
            var _local_6:int;
            var _local_3:PropTween = _arg_2.cachedPT1;
            if (_arg_1 == "onInit")
            {
                _local_5 = [];
                while (_local_3)
                {
                    _local_5[_local_5.length] = _local_3;
                    _local_3 = _local_3.nextNode;
                };
                _local_5.sortOn("priority", (Array.NUMERIC | Array.DESCENDING));
                _local_6 = _local_5.length;
                while (_local_6--)
                {
                    PropTween(_local_5[_local_6]).nextNode = _local_5[(_local_6 + 1)];
                    PropTween(_local_5[_local_6]).prevNode = _local_5[(_local_6 - 1)];
                };
                _arg_2.cachedPT1 = _local_5[0];
            }
            else
            {
                while (_local_3)
                {
                    if (((_local_3.isPlugin) && (_local_3.target[_arg_1])))
                    {
                        if (_local_3.target.activeDisable)
                        {
                            _local_4 = true;
                        };
                        var _local_7:* = _local_3.target;
                        (_local_7[_arg_1]());
                    };
                    _local_3 = _local_3.nextNode;
                };
            };
            return (_local_4);
        }


        protected function updateTweens(_arg_1:Number):void
        {
            var _local_3:PropTween;
            var _local_4:Number;
            var _local_2:int = _tweens.length;
            if (this.round)
            {
                while (_local_2--)
                {
                    _local_3 = _tweens[_local_2];
                    _local_4 = (_local_3.start + (_local_3.change * _arg_1));
                    _local_3.target[_local_3.property] = ((_local_4 > 0) ? int((_local_4 + 0.5)) : int((_local_4 - 0.5)));
                };
            }
            else
            {
                while (_local_2--)
                {
                    _local_3 = _tweens[_local_2];
                    _local_3.target[_local_3.property] = (_local_3.start + (_local_3.change * _arg_1));
                };
            };
        }

        protected function addTween(_arg_1:Object, _arg_2:String, _arg_3:Number, _arg_4:*, _arg_5:String=null):void
        {
            var _local_6:Number;
            if (_arg_4 != null)
            {
                _local_6 = ((typeof(_arg_4) == "number") ? (Number(_arg_4) - _arg_3) : Number(_arg_4));
                if (_local_6 != 0)
                {
                    _tweens[_tweens.length] = new PropTween(_arg_1, _arg_2, _arg_3, _local_6, ((_arg_5) || (_arg_2)), false);
                };
            };
        }

        public function get changeFactor():Number
        {
            return (_changeFactor);
        }

        public function onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            addTween(_arg_1, this.propName, _arg_1[this.propName], _arg_2, this.propName);
            return (true);
        }

        public function killProps(_arg_1:Object):void
        {
            var _local_2:int = this.overwriteProps.length;
            while (_local_2--)
            {
                if ((this.overwriteProps[_local_2] in _arg_1))
                {
                    this.overwriteProps.splice(_local_2, 1);
                };
            };
            _local_2 = _tweens.length;
            while (_local_2--)
            {
                if ((PropTween(_tweens[_local_2]).name in _arg_1))
                {
                    _tweens.splice(_local_2, 1);
                };
            };
        }

        public function set changeFactor(_arg_1:Number):void
        {
            updateTweens(_arg_1);
            _changeFactor = _arg_1;
        }


    }
}//package com.greensock.plugins
