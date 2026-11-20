//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.environment.foreground
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import com.greensock.TweenMax;
    import com.greensock.easing.Back;

    public class GroundView extends Sprite 
    {

        private static const transitionTime:Number = 1;

        public var transitionOutComplete:Signal = new Signal();
        private var _graphic:Sprite;


        public function init(_arg_1:Sprite):void
        {
            this._graphic = _arg_1;
            this._graphic.y = 500;
            this._graphic.visible = false;
            addChildAt(this._graphic, 0);
        }

        public function transitionIn():void
        {
            this._graphic.visible = true;
            TweenMax.to(this._graphic, transitionTime, {
                "y":0,
                "ease":Back.easeOut
            });
        }

        public function transitionOut():void
        {
            TweenMax.to(this._graphic, transitionTime, {
                "y":500,
                "ease":Back.easeIn,
                "onComplete":this.transitionOutComplete.dispatch
            });
        }

        public function destroy():void
        {
            removeChild(this._graphic);
            this._graphic = null;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.environment.foreground
