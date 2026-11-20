//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.ui
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import com.clubpenguin.web.www.cardjitsu.assets.global.Amulet;
    import com.greensock.TweenMax;
    import com.greensock.easing.Back;
    import com.greensock.easing.Sine;
    import flash.events.MouseEvent;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;

    public class AmuletView extends Sprite 
    {

        public var clicked:Signal = new Signal(String);
        private var _amulet:Amulet;
        private var _navigationArray:Array;
        private var _selectedIndex:int;


        public function init():void
        {
            this.initAmulet();
        }

        private function initAmulet():void
        {
            this._amulet = new Amulet();
            this._amulet.fire.mouseChildren = false;
            this._amulet.water.mouseChildren = false;
            this._amulet.fire.activeState.alpha = 0;
            this._amulet.water.activeState.alpha = 0;
            this._amulet.fire.activeState.visible = false;
            this._amulet.water.activeState.visible = false;
            addChild(this._amulet);
            rotation = 180;
            y = -600;
            this._navigationArray = [this._amulet.fire, this._amulet.water];
        }

        public function transitionIn():void
        {
            TweenMax.to(this, 0.8, {
                "rotation":0,
                "ease":Back.easeOut
            });
            TweenMax.to(this, 0.4, {
                "y":-100,
                "ease":Back.easeOut
            });
        }

        private function onRollOver(_arg_1:MouseEvent):void
        {
            TweenMax.to(_arg_1.target.activeState, 0.5, {
                "autoAlpha":1,
                "ease":Sine.easeOut
            });
        }

        private function onRollOut(_arg_1:MouseEvent):void
        {
            TweenMax.to(_arg_1.target.activeState, 0.5, {
                "autoAlpha":0,
                "ease":Sine.easeOut
            });
        }

        private function onMouseClick(_arg_1:MouseEvent):void
        {
            var _local_2:String = _arg_1.target.name;
            this.clicked.dispatch(_local_2);
        }

        public function toggleSelected(_arg_1:String):void
        {
            var _local_2:int = this._navigationArray.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                TweenMax.to(this._navigationArray[_local_3].activeState, 0.5, {
                    "autoAlpha":0,
                    "ease":Sine.easeOut
                });
                _local_3++;
            };
            switch (_arg_1)
            {
                case StateVO.FIRE:
                    this._selectedIndex = 0;
                    break;
                case StateVO.WATER:
                    this._selectedIndex = 1;
                    break;
                default:
                    this._selectedIndex = 2;
            };
            if (_arg_1 != StateVO.STANDARD)
            {
                this._navigationArray[this._selectedIndex].removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
                this._navigationArray[this._selectedIndex].removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
                this._navigationArray[this._selectedIndex].removeEventListener(MouseEvent.CLICK, this.onMouseClick);
                this._navigationArray[this._selectedIndex].buttonMode = false;
                TweenMax.to(this._navigationArray[this._selectedIndex].activeState, 0.5, {
                    "autoAlpha":1,
                    "ease":Sine.easeOut
                });
            };
            this.enable();
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


    }
}//package com.clubpenguin.web.www.cardjitsu.views.ui
