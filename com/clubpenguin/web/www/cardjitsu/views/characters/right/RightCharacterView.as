//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.characters.right
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import com.clubpenguin.web.www.cardjitsu.views.characters.AbstractCharacter;

    public class RightCharacterView extends Sprite 
    {

        public var transitionOutComplete:Signal = new Signal();
        private var _graphic:AbstractCharacter;


        public function init(_arg_1:AbstractCharacter):void
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
            removeChild(this._graphic);
            this._graphic = null;
            this.transitionOutComplete.dispatch();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.characters.right
