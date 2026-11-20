//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import com.greensock.TweenLite;
    import flash.display.*;
    import com.greensock.*;

    public class AutoAlphaPlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _ignoreVisible:Boolean;

        public function AutoAlphaPlugin()
        {
            this.propName = "autoAlpha";
            this.overwriteProps = ["alpha", "visible"];
        }

        override public function killProps(_arg_1:Object):void
        {
            super.killProps(_arg_1);
            _ignoreVisible = Boolean(("visible" in _arg_1));
        }

        override public function onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            _target = _arg_1;
            addTween(_arg_1, "alpha", _arg_1.alpha, _arg_2, "alpha");
            return (true);
        }

        override public function set changeFactor(_arg_1:Number):void
        {
            updateTweens(_arg_1);
            if (!_ignoreVisible)
            {
                _target.visible = Boolean((!(_target.alpha == 0)));
            };
        }


    }
}//package com.greensock.plugins
