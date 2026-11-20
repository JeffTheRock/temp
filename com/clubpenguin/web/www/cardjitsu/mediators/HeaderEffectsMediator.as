//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.views.effects.header.HeaderEffectsView;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.effects.header.AbstractHeaderEffect;
    import com.clubpenguin.web.www.cardjitsu.views.effects.header.HeaderEffectStandard;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.clubpenguin.web.www.cardjitsu.views.effects.header.HeaderEffectFire;
    import com.clubpenguin.web.www.cardjitsu.views.effects.header.HeaderEffectWater;
    import com.greensock.TweenMax;

    public class HeaderEffectsMediator extends Mediator 
    {

        [Inject]
        public var view:HeaderEffectsView;
        [Inject]
        public var mainModel:MainModel;
        private var _isInitialLoad:Boolean = true;
        private var _graphic:AbstractHeaderEffect;


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
                    this._graphic = new HeaderEffectStandard();
                    break;
                case StateVO.FIRE:
                    this._graphic = new HeaderEffectFire();
                    break;
                case StateVO.WATER:
                    this._graphic = new HeaderEffectWater();
                    break;
            };
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.view.init(this._graphic);
                TweenMax.delayedCall(4.3, this.view.transitionIn);
            }
            else
            {
                TweenMax.delayedCall(0.5, this.view.transitionOut);
            };
        }

        private function onTransitionOutComplete():void
        {
            this.view.init(this._graphic);
            TweenMax.delayedCall(1.5, this.view.transitionIn);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
