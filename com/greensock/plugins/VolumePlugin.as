//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import flash.media.SoundTransform;
    import com.greensock.TweenLite;
    import flash.display.*;
    import com.greensock.*;

    public class VolumePlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _st:SoundTransform;

        public function VolumePlugin()
        {
            this.propName = "volume";
            this.overwriteProps = ["volume"];
        }

        override public function onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            if (((isNaN(_arg_2)) || (!(_arg_1.hasOwnProperty("soundTransform")))))
            {
                return (false);
            };
            _target = _arg_1;
            _st = _target.soundTransform;
            addTween(_st, "volume", _st.volume, _arg_2, "volume");
            return (true);
        }

        override public function set changeFactor(_arg_1:Number):void
        {
            updateTweens(_arg_1);
            _target.soundTransform = _st;
        }


    }
}//package com.greensock.plugins
