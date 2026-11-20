//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.views.ui.MainNavigation;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.signals.MainNavigationClickedSignal;
    import com.greensock.TweenLite;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;

    public class MainNavigationMediator extends Mediator 
    {

        [Inject]
        public var view:MainNavigation;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var mainNavigationClickedSignal:MainNavigationClickedSignal;
        private var _isInitialLoad:Boolean = true;


        override public function onRegister():void
        {
            this.mainModel.stateChangedSignal.add(this.onStateChanged);
        }

        private function onStateChanged(_arg_1:StateVO):void
        {
            if (this._isInitialLoad)
            {
                this.view.init();
                this.view.clicked.add(this.onMainNavigationClicked);
                this._isInitialLoad = false;
            }
            else
            {
                TweenLite.delayedCall(0, this.view.disable);
            };
            this.view.toggleSelected(_arg_1.mainState);
            TweenLite.delayedCall(3, this.view.enable);
        }

        private function onMainNavigationClicked(_arg_1:String):void
        {
            this.mainNavigationClickedSignal.dispatch(_arg_1);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
