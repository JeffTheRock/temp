//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.characters.left
{
    import com.clubpenguin.web.www.cardjitsu.views.characters.AbstractCharacter;
    import com.clubpenguin.web.www.cardjitsu.assets.water.LeftCharacterGraphicWater;
    import flash.filters.BlurFilter;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import com.greensock.easing.Strong;

    public class LeftCharacterWater extends AbstractCharacter 
    {


        override public function init():void
        {
            _graphic = new LeftCharacterGraphicWater();
            _graphic.cacheAsBitmap = true;
            addChild(_graphic);
            x = -(width);
            y = 465;
            filters = [new BlurFilter(20, 0)];
        }

        override public function transitionIn():void
        {
            TweenMax.to(this, 0, {"visible":true});
            TweenMax.to(this, 0.3, {
                "x":350,
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
                "x":-50,
                "ease":Strong.easeOut,
                "onComplete":destroy
            });
            TweenMax.delayedCall(TRANSITION_OUT_TIME_COMPLETE, transitionOutComplete.dispatch);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.characters.left
