//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.environment.midground
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.views.IAnimatingObject;
    import org.osflash.signals.Signal;
    import flash.display.DisplayObject;

    public class AbstractEnvironment extends Sprite implements IAnimatingObject 
    {

        protected static const MAIN_VIEW_WIDTH:int = 1600;
        protected static const TRANSITION_OUT_TIME_COMPLETE:Number = 1.3;

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

        protected function makeObjectInvisible(_arg_1:DisplayObject):void
        {
            _arg_1.visible = false;
            _arg_1 = null;
        }

        public function destroy():void
        {
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.environment.midground
