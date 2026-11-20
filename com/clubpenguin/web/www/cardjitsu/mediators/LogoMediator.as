//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.LogoView;
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import flash.utils.getDefinitionByName;
    import com.greensock.TweenMax;

    public class LogoMediator extends Mediator 
    {

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var view:LogoView;
        private var _isInitialLoad:Boolean = true;
        private var _graphic:Sprite;


        override public function onRegister():void
        {
            this.mainModel.stateChangedSignal.add(this.onStateChanged);
            this.view.transitionOutComplete.add(this.onTransitionOutComplete);
        }

        private function onStateChanged(_arg_1:StateVO):void
        {
            var _local_2:String;
            switch (_arg_1.mainState)
            {
                case StateVO.STANDARD:
                    if (this.mainModel.currentLanguage != "PT")
                    {
                        _local_2 = "com.clubpenguin.web.www.cardjitsu.assets.standard.LogoGraphicStandardEN";
                    }
                    else
                    {
                        _local_2 = "com.clubpenguin.web.www.cardjitsu.assets.standard.LogoGraphicStandardPT";
                    };
                    break;
                case StateVO.FIRE:
                    _local_2 = ("com.clubpenguin.web.www.cardjitsu.assets.fire.LogoGraphicFire" + this.mainModel.currentLanguage);
                    break;
                case StateVO.WATER:
                    _local_2 = ("com.clubpenguin.web.www.cardjitsu.assets.water.LogoGraphicWater" + this.mainModel.currentLanguage);
                    break;
            };
            var _local_3:Class = (getDefinitionByName(_local_2) as Class);
            this._graphic = new (_local_3)();
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.view.alpha = 0;
                this.view.visible = false;
                this.view.y = 40;
                this.view.init(this._graphic);
                TweenMax.delayedCall(2.8, this.view.transitionIn);
            }
            else
            {
                TweenMax.delayedCall(1, this.view.transitionOut);
            };
        }

        private function onTransitionOutComplete():void
        {
            this.view.destroy();
            this.view.alpha = 0;
            this.view.visible = false;
            this.view.init(this._graphic);
            TweenMax.delayedCall(0, this.view.transitionIn);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
