//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.effects.header
{
    import com.clubpenguin.web.www.cardjitsu.assets.fire.HeaderFlames;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;

    public class HeaderEffectFire extends AbstractHeaderEffect 
    {

        private var _headerEffectGraphic:HeaderFlames;


        override public function init():void
        {
            this._headerEffectGraphic = new HeaderFlames();
            this._headerEffectGraphic.left.scaleX = (this._headerEffectGraphic.left.scaleY = 0);
            this._headerEffectGraphic.right.scaleX = (this._headerEffectGraphic.right.scaleY = 0);
            this._headerEffectGraphic.left.rotation = -90;
            this._headerEffectGraphic.right.rotation = -90;
            this._headerEffectGraphic.left.x = 300;
            this._headerEffectGraphic.right.x = -300;
            y = 20;
            addChild(this._headerEffectGraphic);
        }

        override public function transitionIn():void
        {
            TweenMax.to(this._headerEffectGraphic.left, 0.6, {
                "x":180,
                "scaleX":1,
                "scaleY":1,
                "rotation":0,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._headerEffectGraphic.right, 0.6, {
                "x":-150,
                "scaleX":1,
                "scaleY":1,
                "rotation":0,
                "ease":Quart.easeOut
            });
        }

        override public function transitionOut():void
        {
            TweenMax.to(this._headerEffectGraphic.left, 0.6, {
                "x":300,
                "scaleX":0,
                "scaleY":0,
                "rotation":-90,
                "ease":Quart.easeIn
            });
            TweenMax.to(this._headerEffectGraphic.right, 0.6, {
                "x":300,
                "scaleX":0,
                "scaleY":0,
                "rotation":-90,
                "ease":Quart.easeIn
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
