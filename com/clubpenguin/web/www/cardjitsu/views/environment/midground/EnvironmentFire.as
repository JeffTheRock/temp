//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.environment.midground
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.MountainsLeftFire;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.MountainsRightFire;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.CloudsLeftFire;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.CloudsRightFire;
    import flash.filters.BlurFilter;
    import flash.filters.GlowFilter;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import com.greensock.easing.Back;

    public class EnvironmentFire extends AbstractEnvironment 
    {

        private var _cloudsLeft:Sprite;
        private var _cloudsRight:Sprite;
        private var _mountainsLeft:Sprite;
        private var _mountainsRight:Sprite;


        override public function init():void
        {
            this.initMountains();
        }

        private function initMountains():void
        {
            this._mountainsLeft = new MountainsLeftFire();
            this._mountainsLeft.y = 605;
            this._mountainsLeft.getChildByName("one").y = 200;
            this._mountainsLeft.getChildByName("two").y = 200;
            this._mountainsLeft.getChildByName("three").y = 200;
            this._mountainsLeft.getChildByName("volcano").y = 300;
            this._mountainsLeft.getChildByName("haze").y = 0;
            addChild(this._mountainsLeft);
            this._mountainsRight = new MountainsRightFire();
            this._mountainsRight.x = (MAIN_VIEW_WIDTH - 365);
            this._mountainsRight.y = 605;
            this._mountainsRight.getChildByName("one").y = 200;
            this._mountainsRight.getChildByName("two").y = 200;
            this._mountainsRight.getChildByName("three").y = 200;
            this._mountainsRight.getChildByName("haze").y = 0;
            addChild(this._mountainsRight);
            this._cloudsLeft = new CloudsLeftFire();
            this._cloudsLeft.y = 650;
            addChildAt(this._cloudsLeft, 0);
            this._cloudsRight = new CloudsRightFire();
            this._cloudsRight.x = (MAIN_VIEW_WIDTH - 365);
            this._cloudsRight.y = 650;
            addChildAt(this._cloudsRight, 0);
            this._mountainsLeft.visible = false;
            this._mountainsRight.visible = false;
            this._cloudsLeft.visible = false;
            this._cloudsRight.visible = false;
            var _local_1:BlurFilter = new BlurFilter(100, 100);
            var _local_2:GlowFilter = new GlowFilter(16777011, 0.5, 75, 75, 2, 1);
        }

        override public function transitionIn():void
        {
            TweenMax.to(this._mountainsLeft, 0, {
                "delay":0,
                "visible":true
            });
            TweenMax.to(this._mountainsLeft.getChildByName("haze"), 0.5, {
                "delay":0,
                "y":-290,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("one"), 0.5, {
                "delay":0,
                "y":-130,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("two"), 0.5, {
                "delay":0.15,
                "y":-115,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("three"), 0.5, {
                "delay":0.3,
                "y":-100,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("volcano"), 0.5, {
                "delay":0.45,
                "y":-45,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._cloudsLeft, 0, {
                "delay":0.55,
                "visible":true
            });
            TweenMax.to(this._cloudsLeft, 0.5, {
                "delay":0.6,
                "y":450,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsRight, 0, {
                "delay":0,
                "visible":true
            });
            TweenMax.to(this._mountainsRight.getChildByName("haze"), 0.5, {
                "delay":0,
                "y":-290,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("one"), 0.5, {
                "delay":0.15,
                "y":-170,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("two"), 0.5, {
                "delay":0.3,
                "y":-210,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("three"), 0.5, {
                "delay":0.45,
                "y":-145,
                "ease":Back.easeOut
            });
            TweenMax.to(this._cloudsRight, 0, {
                "delay":0.45,
                "visible":true
            });
            TweenMax.to(this._cloudsRight, 0.5, {
                "delay":0.5,
                "y":400,
                "ease":Quart.easeOut
            });
        }

        override public function transitionOut():void
        {
            TweenMax.to(this._mountainsLeft.getChildByName("haze"), 0.5, {
                "delay":0.5,
                "y":0,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("haze")]
            });
            TweenMax.to(this._cloudsLeft, 0.5, {
                "delay":0,
                "y":700,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._cloudsLeft]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("volcano"), 0.5, {
                "delay":0.1,
                "y":0,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("volcano")]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("three"), 0.5, {
                "delay":0.2,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("three")]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("two"), 0.5, {
                "delay":0.3,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("two")]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("one"), 0.5, {
                "delay":0.4,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("one")]
            });
            TweenMax.to(this._mountainsRight.getChildByName("haze"), 0.5, {
                "delay":0.5,
                "y":0,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("haze")]
            });
            TweenMax.to(this._cloudsRight, 0.5, {
                "delay":0,
                "y":700,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._cloudsRight]
            });
            TweenMax.to(this._mountainsRight.getChildByName("three"), 0.5, {
                "delay":0.1,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("three")]
            });
            TweenMax.to(this._mountainsRight.getChildByName("two"), 0.5, {
                "delay":0.25,
                "y":0,
                "ease":Back.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("two")]
            });
            TweenMax.to(this._mountainsRight.getChildByName("one"), 0.5, {
                "delay":0.4,
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
