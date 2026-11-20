//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import com.greensock.TweenMax;
    import com.greensock.easing.Linear;

    public class LogoView extends Sprite 
    {

        private static const transitionTime:Number = 0.5;

        public var transitionOutComplete:Signal = new Signal();
        private var _graphic:Sprite;


        public function init(_arg_1:Sprite):void
        {
            this._graphic = _arg_1;
            addChildAt(this._graphic, 0);
        }

        public function transitionIn():void
        {
            TweenMax.to(this, transitionTime, {
                "autoAlpha":1,
                "ease":Linear.easeOut
            });
        }

        public function transitionOut():void
        {
            TweenMax.to(this, transitionTime, {
                "autoAlpha":0,
                "ease":Linear.easeOut,
                "onComplete":this.transitionOutComplete.dispatch
            });
        }

        public function destroy():void
        {
            removeChild(this._graphic);
            this._graphic = null;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views
