//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.characters.right
{
    import com.clubpenguin.web.www.cardjitsu.views.characters.AbstractCharacter;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.RightCharacterGraphicStandard;
    import flash.filters.BlurFilter;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import com.greensock.easing.Sine;

    public class RightCharacterStandard extends AbstractCharacter 
    {


        override public function init():void
        {
            _graphic = new RightCharacterGraphicStandard();
            _graphic.cacheAsBitmap = true;
            addChild(_graphic);
            x = (MAIN_VIEW_WIDTH + width);
            y = 0;
            filters = [new BlurFilter(30, 0)];
            visible = false;
        }

        override public function transitionIn():void
        {
            TweenMax.to(this, 0, {"visible":true});
            TweenMax.to(this, 0.3, {
                "x":(MAIN_VIEW_WIDTH - 525),
                "y":250,
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
                "x":(MAIN_VIEW_WIDTH + 50),
                "ease":Sine.easeOut,
                "onComplete":destroy
            });
            TweenMax.delayedCall(TRANSITION_OUT_TIME_COMPLETE, transitionOutComplete.dispatch);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.characters.right
