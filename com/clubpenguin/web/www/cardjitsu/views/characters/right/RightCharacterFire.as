//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.characters.right
{
    import com.clubpenguin.web.www.cardjitsu.views.characters.AbstractCharacter;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.RightCharacterGraphicFire;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import flash.filters.BlurFilter;
    import com.greensock.easing.Sine;

    public class RightCharacterFire extends AbstractCharacter 
    {


        override public function init():void
        {
            _graphic = new RightCharacterGraphicFire();
            _graphic.cacheAsBitmap = true;
            addChild(_graphic);
            x = (MAIN_VIEW_WIDTH + width);
            y = 0;
            scaleX = (scaleY = 1.1);
        }

        override public function transitionIn():void
        {
            TweenMax.to(this, 0, {"visible":true});
            TweenMax.to(this, 0.3, {
                "x":(MAIN_VIEW_WIDTH - 430),
                "y":280,
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
            TweenMax.to(this, 0.4, {
                "x":(MAIN_VIEW_WIDTH + 50),
                "ease":Sine.easeOut,
                "onComplete":destroy
            });
            TweenMax.delayedCall(TRANSITION_OUT_TIME_COMPLETE, transitionOutComplete.dispatch);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.characters.right
