//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.environment.foreground.GroundView;
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.GroundGraphicStandard;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.GroundGraphicFire;
    import com.clubpenguin.web.www.cardjitsu.assets.water.GroundGraphicWater;
    import com.greensock.TweenMax;

    public class GroundMediator extends Mediator 
    {

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var view:GroundView;
        private var _isInitialLoad:Boolean = true;
        private var _graphic:Sprite;


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
                    this._graphic = new GroundGraphicStandard();
                    break;
                case StateVO.FIRE:
                    this._graphic = new GroundGraphicFire();
                    break;
                case StateVO.WATER:
                    this._graphic = new GroundGraphicWater();
                    break;
            };
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.view.init(this._graphic);
                TweenMax.delayedCall(3, this.view.transitionIn);
            }
            else
            {
                TweenMax.delayedCall(0.5, this.view.transitionOut);
            };
        }

        private function onTransitionOutComplete():void
        {
            this.view.destroy();
            this.view.init(this._graphic);
            TweenMax.delayedCall(0.6, this.view.transitionIn);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
