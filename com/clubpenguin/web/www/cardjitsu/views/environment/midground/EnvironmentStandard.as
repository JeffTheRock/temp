//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.environment.midground
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.CloudsLeftStandard;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.MountainsLeftStandard;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.CloudsRightStandard;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.MountainsRightStandard;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import com.greensock.easing.Back;

    public class EnvironmentStandard extends AbstractEnvironment 
    {

        private var _mountainsLeft:Sprite;
        private var _mountainsRight:Sprite;
        private var _cloudsLeft:Sprite;
        private var _cloudsRight:Sprite;


        override public function init():void
        {
            this.initMountains();
        }

        private function initMountains():void
        {
            this._cloudsLeft = new CloudsLeftStandard();
            this._cloudsLeft.y = 700;
            addChild(this._cloudsLeft);
            this._mountainsLeft = new MountainsLeftStandard();
            this._mountainsLeft.y = 605;
            this._mountainsLeft.getChildByName("one").y = 0;
            this._mountainsLeft.getChildByName("two").y = 0;
            this._mountainsLeft.getChildByName("dojo").y = 0;
            this._mountainsLeft.getChildByName("two").cacheAsBitmap = true;
            this._mountainsLeft.getChildByName("dojo").cacheAsBitmap = true;
            addChild(this._mountainsLeft);
            this._cloudsRight = new CloudsRightStandard();
            this._cloudsRight.x = (MAIN_VIEW_WIDTH - 365);
            this._cloudsRight.y = 700;
            addChild(this._cloudsRight);
            this._mountainsRight = new MountainsRightStandard();
            this._mountainsRight.x = (MAIN_VIEW_WIDTH - 365);
            this._mountainsRight.y = 605;
            this._mountainsRight.getChildByName("one").y = 0;
            this._mountainsRight.getChildByName("two").y = 0;
            this._mountainsRight.getChildByName("three").y = 0;
            this._mountainsRight.getChildByName("ninja").y = 0;
            this._mountainsRight.getChildByName("ninja").alpha = 0.5;
            this._mountainsRight.getChildByName("two").cacheAsBitmap = true;
            this._mountainsRight.getChildByName("ninja").cacheAsBitmap = true;
            addChild(this._mountainsRight);
            this._mountainsLeft.visible = false;
            this._mountainsRight.visible = false;
            this._cloudsLeft.visible = false;
            this._cloudsRight.visible = false;
        }

        override public function transitionIn():void
        {
            TweenMax.to(this._mountainsLeft, 0, {
                "delay":0,
                "visible":true
            });
            TweenMax.to(this._mountainsLeft.getChildByName("dojo"), 0.7, {
                "delay":0,
                "y":-250,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("one"), 0.5, {
                "delay":0.3,
                "y":-245,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("two"), 0.5, {
                "delay":0.45,
                "y":-250,
                "ease":Back.easeOut
            });
            TweenMax.to(this._cloudsLeft, 0, {
                "delay":0.55,
                "visible":true
            });
            TweenMax.to(this._cloudsLeft, 0.5, {
                "delay":0.6,
                "y":340,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsRight, 0, {
                "delay":0,
                "visible":true
            });
            TweenMax.to(this._mountainsRight.getChildByName("one"), 0.5, {
                "delay":0,
                "y":-140,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("two"), 0.5, {
                "delay":0.15,
                "y":-180,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("three"), 0.5, {
                "delay":0.3,
                "y":-200,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("ninja"), 0.5, {
                "delay":0.45,
                "y":-92.5,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._cloudsRight, 0, {
                "delay":0.4,
                "visible":true
            });
            TweenMax.to(this._cloudsRight, 0.5, {
                "delay":0.45,
                "y":420,
                "ease":Quart.easeOut
            });
        }

        override public function transitionOut():void
        {
            TweenMax.to(this._cloudsLeft, 0.5, {
                "delay":0,
                "y":700,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._cloudsLeft]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("two"), 0.5, {
                "delay":0.15,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("two")]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("one"), 0.5, {
                "delay":0.3,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("one")]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("dojo"), 0.7, {
                "delay":0.15,
                "y":0,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("dojo")]
            });
            TweenMax.to(this._cloudsRight, 0.5, {
                "delay":0,
                "y":700,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._cloudsRight]
            });
            TweenMax.to(this._mountainsRight.getChildByName("ninja"), 0.5, {
                "delay":0,
                "y":0,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("ninja")]
            });
            TweenMax.to(this._mountainsRight.getChildByName("three"), 0.5, {
                "delay":0.15,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("three")]
            });
            TweenMax.to(this._mountainsRight.getChildByName("two"), 0.5, {
                "delay":0.3,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("two")]
            });
            TweenMax.to(this._mountainsRight.getChildByName("one"), 0.5, {
                "delay":0.45,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("one")]
            });
            TweenMax.delayedCall(TRANSITION_OUT_TIME_COMPLETE, transitionOutComplete.dispatch);
        }

        override public function destroy():void
        {
            removeChild(this._mountainsLeft);
            this._mountainsLeft = null;
            removeChild(this._mountainsRight);
            this._mountainsRight = null;
            removeChild(this._cloudsLeft);
            this._cloudsLeft = null;
            removeChild(this._cloudsRight);
            this._cloudsRight = null;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.environment.midground
