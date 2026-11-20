//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.ui
{
    import flash.display.Sprite;
    import org.osflash.signals.natives.NativeSignal;
    import org.osflash.signals.Signal;
    import flash.display.MovieClip;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.MainNavigationGraphicStandard;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.MainNavigationGraphicFire;
    import com.clubpenguin.web.www.cardjitsu.assets.water.MainNavigationGraphicWater;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import flash.events.MouseEvent;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;

    public class MainNavigation extends Sprite 
    {

        private var mouseOver:NativeSignal;
        private var mouseOut:NativeSignal;
        private var mouseClick:NativeSignal;
        public var clicked:Signal = new Signal(String);
        private var _standard:MovieClip;
        private var _fire:MovieClip;
        private var _water:MovieClip;
        private var _navigationArray:Array = [];
        private var _selectedIndex:int;


        public function init():void
        {
            this.initGraphics();
        }

        private function initGraphics():void
        {
            this._standard = new MainNavigationGraphicStandard();
            this._fire = new MainNavigationGraphicFire();
            this._water = new MainNavigationGraphicWater();
            this._standard.mouseChildren = false;
            this._fire.mouseChildren = false;
            this._water.mouseChildren = false;
            this._standard.name = "";
            this._fire.name = "fire";
            this._water.name = "water";
            addChild(this._standard);
            this._standard.frame.height = 50;
            this._standard.navigationMask.height = 35;
            this._standard.iconArea.y = 25;
            this._fire.x = 85;
            this._fire.frame.height = 50;
            this._fire.navigationMask.height = 35;
            this._fire.iconArea.y = 25;
            addChild(this._fire);
            this._water.x = 170;
            this._water.frame.height = 50;
            this._water.navigationMask.height = 35;
            this._water.iconArea.y = 25;
            addChild(this._water);
            this._navigationArray = [this._standard, this._fire, this._water];
        }

        public function toggleSelected(_arg_1:String):void
        {
            var _local_2:int = this._navigationArray.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                TweenMax.to(this._navigationArray[_local_3].frame, 0.4, {
                    "height":50,
                    "ease":Quart.easeOut
                });
                TweenMax.to(this._navigationArray[_local_3].navigationMask, 0.4, {
                    "height":35,
                    "ease":Quart.easeOut
                });
                TweenMax.to(this._navigationArray[_local_3].iconArea, 0.4, {
                    "y":25,
                    "ease":Quart.easeOut
                });
                this._navigationArray[_local_3].addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
                this._navigationArray[_local_3].addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
                this._navigationArray[_local_3].addEventListener(MouseEvent.CLICK, this.onMouseClick);
                this._navigationArray[_local_3].buttonMode = true;
                _local_3++;
            };
            switch (_arg_1)
            {
                case StateVO.STANDARD:
                    this._selectedIndex = 0;
                    break;
                case StateVO.FIRE:
                    this._selectedIndex = 1;
                    break;
                case StateVO.WATER:
                    this._selectedIndex = 2;
                    break;
            };
            this._navigationArray[this._selectedIndex].removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this._navigationArray[this._selectedIndex].removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this._navigationArray[this._selectedIndex].removeEventListener(MouseEvent.CLICK, this.onMouseClick);
            this._navigationArray[this._selectedIndex].buttonMode = false;
            TweenMax.to(this._navigationArray[this._selectedIndex].frame, 0.4, {
                "height":70,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._navigationArray[this._selectedIndex].navigationMask, 0.4, {
                "height":55,
                "ease":Quart.easeOut
            });
            TweenMax.to(this._navigationArray[this._selectedIndex].iconArea, 0.4, {
                "y":10,
                "ease":Quart.easeOut
            });
        }

        public function enable():void
        {
            var _local_1:int = this._navigationArray.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                if (this._navigationArray[_local_2] != this._navigationArray[this._selectedIndex])
                {
                    this._navigationArray[_local_2].addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
                    this._navigationArray[_local_2].addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
                    this._navigationArray[_local_2].addEventListener(MouseEvent.CLICK, this.onMouseClick);
                    this._navigationArray[_local_2].buttonMode = true;
                };
                _local_2++;
            };
        }

        public function disable():void
        {
            var _local_1:int = this._navigationArray.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                this._navigationArray[_local_2].removeEventListener(MouseEvent.CLICK, this.onMouseClick);
                _local_2++;
            };
        }

        private function onRollOver(_arg_1:MouseEvent):void
        {
            TweenMax.to(_arg_1.target.frame, 0.4, {
                "height":70,
                "ease":Quart.easeOut
            });
            TweenMax.to(_arg_1.target.navigationMask, 0.4, {
                "height":55,
                "ease":Quart.easeOut
            });
            TweenMax.to(_arg_1.target.iconArea, 0.4, {
                "y":10,
                "ease":Quart.easeOut
            });
        }

        private function onRollOut(_arg_1:MouseEvent):void
        {
            TweenMax.to(_arg_1.target.frame, 0.4, {
                "height":50,
                "ease":Quart.easeOut
            });
            TweenMax.to(_arg_1.target.navigationMask, 0.4, {
                "height":35,
                "ease":Quart.easeOut
            });
            TweenMax.to(_arg_1.target.iconArea, 0.4, {
                "y":25,
                "ease":Quart.easeOut
            });
        }

        private function onMouseClick(_arg_1:MouseEvent):void
        {
            this.clicked.dispatch(_arg_1.target.name);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.ui
