//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.characters
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.views.IAnimatingObject;
    import org.osflash.signals.Signal;

    public class AbstractCharacter extends Sprite implements IAnimatingObject 
    {

        protected static const MAIN_VIEW_WIDTH:int = 1600;
        protected static const TRANSITION_OUT_TIME_COMPLETE:Number = 1.5;

        public var transitionInComplete:Signal = new Signal();
        public var transitionOutComplete:Signal = new Signal();
        protected var _graphic:Sprite;


        public function init():void
        {
        }

        public function transitionIn():void
        {
        }

        public function transitionOut():void
        {
        }

        public function destroy():void
        {
            removeChild(this._graphic);
            this._graphic = null;
            visible = false;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.characters
