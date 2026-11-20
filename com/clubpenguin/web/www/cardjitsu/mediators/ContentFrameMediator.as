//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.views.content.ContentFrameView;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.greensock.TweenMax;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;

    public class ContentFrameMediator extends Mediator 
    {

        [Inject]
        public var view:ContentFrameView;
        [Inject]
        public var mainModel:MainModel;
        private var _isInitialLoad:Boolean = true;


        override public function onRegister():void
        {
            this.view.transitionOutComplete.add(this.onTransitionOutComplete);
            this.view.actionsource = this.mainModel.actionsource;
            this.view.init();
            this.mainModel.stateChangedSignal.add(this.onStateChanged);
            this.view.mainContentAreaButtonClicked.addOnce(this.onButtonClicked);
        }

        private function onButtonClicked(_arg_1:String):void
        {
            this.mainModel.trackLink(_arg_1);
        }

        private function onStateChanged(_arg_1:StateVO):void
        {
            this.view.currentState = _arg_1.mainState;
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.view.initMainContent();
                this.view.initCalloutPanel(this.mainModel.calloutVOArray);
                this.view.initVideoPlayer();
                TweenMax.delayedCall(2.4, this.view.transitionInHeaderGraphic);
                TweenMax.delayedCall(4.3, this.view.transitionInMainContent);
                TweenMax.delayedCall(4.3, this.view.transitionInSeparator);
                TweenMax.delayedCall(4.3, this.view.transitionInCalloutContent);
                TweenMax.delayedCall(4.8, this.view.transitionInVideoPlayer);
            }
            else
            {
                TweenMax.delayedCall(0.7, this.view.transitionOutHeaderGraphic);
                TweenMax.delayedCall(0, this.view.transitionOutMainContent);
                TweenMax.delayedCall(0, this.view.transitionOutSeparator);
                TweenMax.delayedCall(0, this.view.transitionOutCalloutContent);
                TweenMax.delayedCall(0, this.view.transitionOutVideoPlayer);
            };
        }

        private function onTransitionOutComplete():void
        {
            this.view.destroyMainContent();
            this.view.initMainContent();
            this.view.destroyVideoPlayer();
            this.view.initVideoPlayer();
            TweenMax.delayedCall(0.5, this.view.transitionInHeaderGraphic);
            TweenMax.delayedCall(1.9, this.view.transitionInSeparator);
            TweenMax.delayedCall(1.9, this.view.transitionInMainContent);
            TweenMax.delayedCall(2, this.view.transitionInCalloutContent);
            TweenMax.delayedCall(2.5, this.view.transitionInVideoPlayer);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
