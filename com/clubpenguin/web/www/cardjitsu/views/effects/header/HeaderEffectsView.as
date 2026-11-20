//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.effects.header
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;

    public class HeaderEffectsView extends Sprite 
    {

        public var transitionOutComplete:Signal = new Signal();
        private var _graphic:AbstractHeaderEffect;


        public function init(_arg_1:AbstractHeaderEffect):void
        {
            this._graphic = _arg_1;
            addChild(this._graphic);
            this._graphic.init();
        }

        public function transitionIn():void
        {
            this._graphic.transitionIn();
        }

        public function transitionOut():void
        {
            this._graphic.transitionOutComplete.addOnce(this.onTransitionOutComplete);
            this._graphic.transitionOut();
        }

        private function onTransitionOutComplete():void
        {
            this._graphic.destroy();
            removeChild(this._graphic);
            this._graphic = null;
            this.transitionOutComplete.dispatch();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.effects.header
