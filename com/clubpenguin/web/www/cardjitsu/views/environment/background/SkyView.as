//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.environment.background
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import com.greensock.TweenMax;
    import com.greensock.easing.Linear;

    public class SkyView extends Sprite 
    {

        private static const transitionTime:Number = 0.8;

        private var _graphic:Sprite;


        public function init(_arg_1:Sprite):void
        {
            addChildAt(_arg_1, 0);
        }

        public function update(_arg_1:Sprite):void
        {
            this._graphic = _arg_1;
        }

        public function transition():void
        {
            var _local_1:DisplayObject = getChildAt(0);
            TweenMax.to(_local_1, transitionTime, {
                "autoAlpha":0,
                "ease":Linear.easeOut,
                "onComplete":this.removeCurrentGraphic,
                "onCompleteParams":[_local_1]
            });
            addChildAt(this._graphic, 0);
        }

        private function removeCurrentGraphic(_arg_1:DisplayObject):void
        {
            removeChild(_arg_1);
            _arg_1 = null;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.environment.background
