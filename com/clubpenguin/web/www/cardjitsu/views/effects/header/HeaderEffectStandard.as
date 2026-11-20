//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.effects.header
{
    import com.greensock.TweenMax;

    public class HeaderEffectStandard extends AbstractHeaderEffect 
    {


        override public function init():void
        {
        }

        override public function transitionIn():void
        {
            transitionInComplete.dispatch();
        }

        override public function transitionOut():void
        {
            TweenMax.delayedCall(TRANSITION_OUT_TIME_COMPLETE, transitionOutComplete.dispatch);
        }

        override public function destroy():void
        {
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.effects.header
