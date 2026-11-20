//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.views.characters.right.RightCharacterView;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.characters.AbstractCharacter;
    import com.clubpenguin.web.www.cardjitsu.views.characters.right.RightCharacterStandard;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.clubpenguin.web.www.cardjitsu.views.characters.right.RightCharacterFire;
    import com.clubpenguin.web.www.cardjitsu.views.characters.right.RightCharacterWater;
    import com.greensock.TweenMax;

    public class RightCharacterMediator extends Mediator 
    {

        [Inject]
        public var view:RightCharacterView;
        [Inject]
        public var mainModel:MainModel;
        private var _isInitialLoad:Boolean = true;
        private var _graphic:AbstractCharacter;


        override public function onRegister():void
        {
            this.mainModel.stateChangedSignal.add(this.onStateChanged);
            this.view.transitionOutComplete.add(this.onTransitionOutComplete);
        }

        private function onStateChanged(_arg_1:StateVO):void
        {
            switch (_arg_1.mainState)
            {
                case StateVO.STANDARD:
                    this._graphic = new RightCharacterStandard();
                    break;
                case StateVO.FIRE:
                    this._graphic = new RightCharacterFire();
                    break;
                case StateVO.WATER:
                    this._graphic = new RightCharacterWater();
                    break;
            };
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.view.init(this._graphic);
                TweenMax.delayedCall(4.1, this.view.transitionIn);
            }
            else
            {
                TweenMax.delayedCall(0, this.view.transitionOut);
            };
        }

        private function onTransitionOutComplete():void
        {
            this.view.init(this._graphic);
            TweenMax.delayedCall(1.6, this.view.transitionIn);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
