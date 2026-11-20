//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.effects.header
{
    import com.clubpenguin.web.www.cardjitsu.assets.water.HeaderEffectsWater;
    import com.greensock.TweenMax;
    import com.greensock.easing.Strong;

    public class HeaderEffectWater extends AbstractHeaderEffect 
    {

        private var _headerEffectGraphic:HeaderEffectsWater;


        override public function init():void
        {
            this._headerEffectGraphic = new HeaderEffectsWater();
            this._headerEffectGraphic.water.scaleX = (this._headerEffectGraphic.water.scaleY = 0);
            this._headerEffectGraphic.water.rotation = -90;
            addChild(this._headerEffectGraphic);
        }

        override public function transitionIn():void
        {
            TweenMax.to(this._headerEffectGraphic.water, 0.6, {
                "scaleX":1,
                "scaleY":1,
                "rotation":2,
                "ease":Strong.easeInOut
            });
        }

        override public function transitionOut():void
        {
            TweenMax.to(this._headerEffectGraphic.water, 0.6, {
                "delay":0,
                "scaleX":0,
                "scaleY":0,
                "rotation":-90,
                "ease":Strong.easeInOut
            });
            TweenMax.delayedCall(TRANSITION_OUT_TIME_COMPLETE, transitionOutComplete.dispatch);
        }

        override public function destroy():void
        {
            removeChild(this._headerEffectGraphic);
            this._headerEffectGraphic = null;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.effects.header
