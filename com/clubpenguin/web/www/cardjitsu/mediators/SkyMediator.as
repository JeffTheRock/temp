//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.environment.background.SkyView;
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.SkyGraphicStandard;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.clubpenguin.web.www.cardjitsu.assets.fire.SkyGraphicFire;
    import com.clubpenguin.web.www.cardjitsu.assets.water.SkyGraphicWater;
    import com.greensock.TweenMax;

    public class SkyMediator extends Mediator 
    {

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var view:SkyView;
        private var _isInitialLoad:Boolean = true;


        override public function onRegister():void
        {
            this.mainModel.stateChangedSignal.add(this.onStateChanged);
        }

        private function onStateChanged(_arg_1:StateVO):void
        {
            var _local_2:Sprite;
            switch (_arg_1.mainState)
            {
                case StateVO.STANDARD:
                    _local_2 = new SkyGraphicStandard();
                    break;
                case StateVO.FIRE:
                    _local_2 = new SkyGraphicFire();
                    break;
                case StateVO.WATER:
                    _local_2 = new SkyGraphicWater();
                    break;
            };
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.view.init(_local_2);
            }
            else
            {
                this.view.update(_local_2);
                TweenMax.delayedCall(1.3, this.view.transition);
            };
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
