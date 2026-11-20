//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.environment.midground
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.assets.water.MountainsLeftWater;
    import com.clubpenguin.web.www.cardjitsu.assets.water.MountainsRightWater;
    import com.clubpenguin.web.www.cardjitsu.assets.water.CloudsLeftWater;
    import com.clubpenguin.web.www.cardjitsu.assets.water.CloudsRightWater;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import com.greensock.easing.Back;

    public class EnvironmentWater extends AbstractEnvironment 
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
            this._mountainsLeft = new MountainsLeftWater();
            this._mountainsLeft.y = 605;
            this._mountainsLeft.getChildByName("one").y = 200;
            this._mountainsLeft.getChildByName("two").y = 200;
            this._mountainsLeft.getChildByName("three").y = 200;
            this._mountainsLeft.getChildByName("clouds").y = 200;
            this._mountainsLeft.getChildByName("haze").y = 0;
            addChild(this._mountainsLeft);
            this._mountainsRight = new MountainsRightWater();
            this._mountainsRight.x = (MAIN_VIEW_WIDTH - 365);
            this._mountainsRight.y = 605;
            this._mountainsRight.getChildByName("one").y = 200;
            this._mountainsRight.getChildByName("two").y = 200;
            this._mountainsRight.getChildByName("three").y = 200;
            this._mountainsRight.getChildByName("clouds").y = 200;
            this._mountainsRight.getChildByName("haze").y = 0;
            addChild(this._mountainsRight);
            this._cloudsLeft = new CloudsLeftWater();
            this._cloudsLeft.y = 650;
            addChildAt(this._cloudsLeft, 0);
            this._cloudsRight = new CloudsRightWater();
            this._cloudsRight.x = (MAIN_VIEW_WIDTH - 365);
            this._cloudsRight.y = 650;
            addChildAt(this._cloudsRight, 0);
            this._mountainsLeft.getChildByName("one").cacheAsBitmap = true;
            this._mountainsLeft.getChildByName("two").cacheAsBitmap = true;
            this._mountainsRight.getChildByName("one").cacheAsBitmap = true;
            this._mountainsRight.getChildByName("two").cacheAsBitmap = true;
            this._mountainsLeft.visible = false;
            this._mountainsRight.visible = false;
            this._cloudsLeft.visible = false;
            this._cloudsRight.visible = false;
        }

        override public function transitionIn():void
        {
            TweenMax.to(this._mountainsLeft, 0, {"visible":true});
            TweenMax.to(this._mountainsLeft.getChildByName("haze"), 0.5, {
                "delay":0,
                "y":-220,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("one"), 0.5, {
                "delay":0,
                "y":-190,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("two"), 0.5, {
                "delay":0.3,
                "y":-145,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("three"), 0.9, {
                "delay":0,
                "y":-230,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsLeft.getChildByName("clouds"), 0.5, {
                "delay":0.45,
                "y":-65,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._cloudsLeft, 0, {"visible":true});
            TweenMax.to(this._cloudsLeft, 0.5, {
                "delay":0.45,
                "y":400,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsRight, 0, {"visible":true});
            TweenMax.to(this._mountainsRight.getChildByName("haze"), 0.5, {
                "delay":0,
                "y":-220,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("one"), 0.5, {
                "delay":0,
                "y":-200,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("two"), 0.5, {
                "delay":0.3,
                "y":-170,
                "ease":Back.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("three"), 0.9, {
                "delay":0,
                "y":-220,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._mountainsRight.getChildByName("clouds"), 0.5, {
                "delay":0.45,
                "y":-100,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._cloudsRight, 0, {"visible":true});
            TweenMax.to(this._cloudsRight, 0.5, {
                "delay":0.45,
                "y":415,
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
            TweenMax.to(this._mountainsLeft.getChildByName("clouds"), 0.5, {
                "delay":0.1,
                "y":0,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsLeft.getChildByName("clouds")]
            });
            TweenMax.to(this._mountainsLeft.getChildByName("three"), 0.7, {
                "delay":0.15,
                "y":0,
                "ease":Quart.easeIn,
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
            TweenMax.to(this._mountainsRight.getChildByName("clouds"), 0.5, {
                "delay":0.1,
                "y":0,
                "ease":Quart.easeIn,
                "onComplete":makeObjectInvisible,
                "onCompleteParams":[this._mountainsRight.getChildByName("clouds")]
            });
            TweenMax.to(this._mountainsRight.getChildByName("three"), 0.7, {
                "delay":0.15,
                "y":0,
                "ease":Quart.easeIn,
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
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.environment.midground
