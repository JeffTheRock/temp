//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import flash.display.MovieClip;
    import com.greensock.TweenLite;

    public class FramePlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _target:MovieClip;
        public var frame:int;

        public function FramePlugin()
        {
            this.propName = "frame";
            this.overwriteProps = ["frame", "frameLabel"];
            this.round = true;
        }

        override public function onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            if (((!(_arg_1 is MovieClip)) || (isNaN(_arg_2))))
            {
                return (false);
            };
            _target = (_arg_1 as MovieClip);
            this.frame = _target.currentFrame;
            addTween(this, "frame", this.frame, _arg_2, "frame");
            return (true);
        }

        override public function set changeFactor(_arg_1:Number):void
        {
            updateTweens(_arg_1);
            _target.gotoAndStop(this.frame);
        }


    }
}//package com.greensock.plugins
