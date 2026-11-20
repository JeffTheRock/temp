//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.characters.left
{
    import com.clubpenguin.web.www.cardjitsu.views.characters.AbstractCharacter;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.LeftCharacterGraphicStandard;
    import flash.filters.BlurFilter;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import com.greensock.easing.Sine;

    public class LeftCharacterStandard extends AbstractCharacter 
    {


        override public function init():void
        {
            _graphic = new LeftCharacterGraphicStandard();
            _graphic.cacheAsBitmap = true;
            addChild(_graphic);
            x = -(width);
            y = 1050;
            filters = [new BlurFilter(30, 0)];
            visible = false;
        }

        override public function transitionIn():void
        {
            TweenMax.to(this, 0, {"visible":true});
            TweenMax.to(this, 0.3, {
                "x":620,
                "y":615,
                "ease":Quart.easeOut
            });
            TweenMax.to(this, 0.1, {
                "delay":0.2,
                "blurFilter":{"blurX":0}
            });
        }

        override public function transitionOut():void
        {
            filters = [new BlurFilter(30, 0)];
            TweenMax.to(this, 0.3, {
                "x":-50,
                "ease":Sine.easeOut,
                "onComplete":destroy
            });
            TweenMax.delayedCall(TRANSITION_OUT_TIME_COMPLETE, transitionOutComplete.dispatch);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.characters.left
