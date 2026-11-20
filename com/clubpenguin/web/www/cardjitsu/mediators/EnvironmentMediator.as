//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.views.environment.midground.EnvironmentView;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.environment.midground.AbstractEnvironment;
    import com.clubpenguin.web.www.cardjitsu.views.environment.midground.EnvironmentStandard;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.clubpenguin.web.www.cardjitsu.views.environment.midground.EnvironmentFire;
    import com.clubpenguin.web.www.cardjitsu.views.environment.midground.EnvironmentWater;
    import com.greensock.TweenMax;

    public class EnvironmentMediator extends Mediator 
    {

        [Inject]
        public var view:EnvironmentView;
        [Inject]
        public var mainModel:MainModel;
        private var _isInitialLoad:Boolean = true;
        private var _graphic:AbstractEnvironment;


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
                    this._graphic = new EnvironmentStandard();
                    break;
                case StateVO.FIRE:
                    this._graphic = new EnvironmentFire();
                    break;
                case StateVO.WATER:
                    this._graphic = new EnvironmentWater();
                    break;
            };
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.view.init(this._graphic);
                TweenMax.delayedCall(3.4, this.view.transitionIn);
            }
            else
            {
                TweenMax.delayedCall(0.2, this.view.transitionOut);
            };
        }

        private function onTransitionOutComplete():void
        {
            this.view.init(this._graphic);
            TweenMax.delayedCall(1, this.view.transitionIn);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
