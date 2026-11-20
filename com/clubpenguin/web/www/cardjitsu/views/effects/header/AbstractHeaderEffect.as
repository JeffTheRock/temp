//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.effects.header
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.views.IAnimatingObject;
    import org.osflash.signals.Signal;

    public class AbstractHeaderEffect extends Sprite implements IAnimatingObject 
    {

        protected static const MAIN_VIEW_WIDTH:int = 1600;
        protected static const TRANSITION_OUT_TIME_COMPLETE:Number = 1.5;

        public var transitionInComplete:Signal = new Signal();
        public var transitionOutComplete:Signal = new Signal();


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
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.effects.header
