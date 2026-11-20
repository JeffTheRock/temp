//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import com.greensock.TweenLite;
    import flash.display.*;
    import com.greensock.*;

    public class VisiblePlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _initVal:Boolean;
        protected var _visible:Boolean;
        protected var _tween:TweenLite;

        public function VisiblePlugin()
        {
            this.propName = "visible";
            this.overwriteProps = ["visible"];
        }

        override public function onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            _target = _arg_1;
            _tween = _arg_3;
            _initVal = _target.visible;
            _visible = Boolean(_arg_2);
            return (true);
        }

        override public function set changeFactor(_arg_1:Number):void
        {
            if (((_arg_1 == 1) && ((_tween.cachedDuration == _tween.cachedTime) || (_tween.cachedTime == 0))))
            {
                _target.visible = _visible;
            }
            else
            {
                _target.visible = _initVal;
            };
        }


    }
}//package com.greensock.plugins
