//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import flash.filters.GlowFilter;
    import com.greensock.TweenLite;
    import flash.display.*;
    import com.greensock.*;
    import flash.filters.*;

    public class GlowFilterPlugin extends FilterPlugin 
    {

        public static const API:Number = 1;
        private static var _propNames:Array = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];

        public function GlowFilterPlugin()
        {
            this.propName = "glowFilter";
            this.overwriteProps = ["glowFilter"];
        }

        override public function onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            _target = _arg_1;
            _type = GlowFilter;
            initFilter(_arg_2, new GlowFilter(0xFFFFFF, 0, 0, 0, ((_arg_2.strength) || (1)), ((_arg_2.quality) || (2)), _arg_2.inner, _arg_2.knockout), _propNames);
            return (true);
        }


    }
}//package com.greensock.plugins
