//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.environment.background.SkyView;
    import com.clubpenguin.web.www.cardjitsu.views.environment.midground.EnvironmentView;
    import com.clubpenguin.web.www.cardjitsu.views.environment.foreground.GroundView;
    import com.clubpenguin.web.www.cardjitsu.views.content.ContentFrameView;
    import com.clubpenguin.web.www.cardjitsu.views.ui.MainNavigation;
    import com.clubpenguin.web.www.cardjitsu.views.characters.left.LeftCharacterView;
    import com.clubpenguin.web.www.cardjitsu.views.characters.right.RightCharacterView;
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.assets.preloader.BackgroundGraphicPreloader;
    import com.clubpenguin.web.www.cardjitsu.assets.preloader.ProgressBarGraphic;
    import com.greensock.TweenLite;
    import com.greensock.easing.Back;
    import com.clubpenguin.web.www.cardjitsu.views.effects.ambient.AmbientEffectsView;
    import com.clubpenguin.web.www.cardjitsu.views.effects.header.HeaderEffectsView;
    import com.clubpenguin.web.www.cardjitsu.views.ui.AmuletView;
    import com.clubpenguin.web.www.cardjitsu.views.LogoView;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import net.hires.debug.Stats;
    import org.osflash.signals.natives.NativeSignal;
    import flash.events.Event;
    import flash.external.ExternalInterface;

    public class MainMediator extends Mediator 
    {

        private static const MAIN_WIDTH:int = 1600;
        private static const MAIN_HEIGHT:int = 1050;

        [Inject]
        public var view:Main;
        [Inject]
        public var mainModel:MainModel;
        private var _skyView:SkyView;
        private var _environmentView:EnvironmentView;
        private var _groundView:GroundView;
        private var _mainContentArea:ContentFrameView;
        private var _mainNavigation:MainNavigation;
        private var _leftCharacter:LeftCharacterView;
        private var _rightCharacter:RightCharacterView;
        private var _preloaderContainer:Sprite;
        private var _isInitialLoad:Boolean = true;


        override public function onRegister():void
        {
            this.initPreloaderGraphic();
            this.mainModel.initialLoadComplete.addOnce(this.onInitialLoadComplete);
            this.mainModel.stateChangedSignal.add(this.onStateChanged);
        }

        private function initPreloaderGraphic():void
        {
            this._preloaderContainer = new Sprite();
            var _local_1:Sprite = new BackgroundGraphicPreloader();
            _local_1.x = (MAIN_WIDTH * 0.5);
            _local_1.cacheAsBitmap = true;
            this._preloaderContainer.addChild(_local_1);
            var _local_2:Sprite = new ProgressBarGraphic();
            _local_2.x = ((this._preloaderContainer.width * 0.5) - (_local_2.width * 0.5));
            _local_2.y = ((1000 * 0.5) - (_local_2.height * 0.5));
            this._preloaderContainer.addChild(_local_2);
            this.view.addChild(this._preloaderContainer);
        }

        private function onInitialLoadComplete():void
        {
            this.initSkyView();
            this.initEnvironmentView();
            this.initGroundView();
            this.initAmbientEffectsView();
            this.initLeftCharacter();
            this.initMainContentArea();
            this.initHeaderEffectsView();
            this.initMainNavigation();
            this.initAmuletView();
            this.initLogo();
            this.initRightCharacter();
            this.view.setChildIndex(this._preloaderContainer, (this.view.numChildren - 1));
        }

        private function transitionPreloaderOut():void
        {
            TweenLite.to(this._preloaderContainer, 1.5, {
                "delay":0.5,
                "y":-(this._preloaderContainer.height),
                "ease":Back.easeIn,
                "onComplete":this.destroyPreloaderGraphic
            });
        }

        private function destroyPreloaderGraphic():void
        {
            this.view.removeChild(this._preloaderContainer);
            this._preloaderContainer = null;
        }

        private function initSkyView():void
        {
            this._skyView = new SkyView();
            this._skyView.x = (MAIN_WIDTH * 0.5);
            this.view.addChild(this._skyView);
        }

        private function initEnvironmentView():void
        {
            this._environmentView = new EnvironmentView();
            this.view.addChild(this._environmentView);
        }

        private function initGroundView():void
        {
            this._groundView = new GroundView();
            this._groundView.x = (MAIN_WIDTH * 0.5);
            this._groundView.y = 605;
            this.view.addChild(this._groundView);
        }

        private function initAmbientEffectsView():void
        {
            var _local_1:AmbientEffectsView = new AmbientEffectsView();
            this.view.addChild(_local_1);
            var _local_2:AmbientEffectsView = new AmbientEffectsView();
            _local_2.x = (MAIN_WIDTH - 300);
            this.view.addChild(_local_2);
        }

        private function initLeftCharacter():void
        {
            this._leftCharacter = new LeftCharacterView();
            this.view.addChild(this._leftCharacter);
        }

        private function initMainContentArea():void
        {
            this._mainContentArea = new ContentFrameView(this.mainModel.mainContentDataVOArray);
            this._mainContentArea.x = (((MAIN_WIDTH * 0.5) - (this._mainContentArea.width * 0.5)) - 45);
            this.view.addChild(this._mainContentArea);
        }

        private function initHeaderEffectsView():void
        {
            var _local_1:HeaderEffectsView = new HeaderEffectsView();
            _local_1.x = ((MAIN_WIDTH * 0.5) - 45);
            this.view.addChild(_local_1);
        }

        private function initMainNavigation():void
        {
            this._mainNavigation = new MainNavigation();
            this._mainNavigation.x = 970;
            this._mainNavigation.y = 200;
            this.view.addChild(this._mainNavigation);
        }

        private function initAmuletView():void
        {
            var _local_1:AmuletView = new AmuletView();
            _local_1.x = 610;
            this.view.addChild(_local_1);
        }

        private function initLogo():void
        {
            var _local_1:LogoView = new LogoView();
            _local_1.x = 320;
            _local_1.y = 40;
            this.view.addChild(_local_1);
        }

        private function initRightCharacter():void
        {
            this._rightCharacter = new RightCharacterView();
            this.view.addChild(this._rightCharacter);
        }

        private function onStateChanged(_arg_1:StateVO):void
        {
            if (this._isInitialLoad)
            {
                this._isInitialLoad = false;
                this.transitionPreloaderOut();
            };
            switch (_arg_1.mainState)
            {
                case StateVO.STANDARD:
                    this.view.setChildIndex(this._leftCharacter, (this.view.getChildIndex(this._mainContentArea) + 1));
                    this.view.setChildIndex(this._rightCharacter, (this.view.getChildIndex(this._mainContentArea) + 1));
                    return;
                case StateVO.FIRE:
                    this.view.setChildIndex(this._leftCharacter, (this.view.getChildIndex(this._mainContentArea) - 1));
                    this.view.setChildIndex(this._rightCharacter, (this.view.numChildren - 1));
                    return;
                case StateVO.WATER:
                    this.view.setChildIndex(this._leftCharacter, (this.view.getChildIndex(this._mainContentArea) - 1));
                    this.view.setChildIndex(this._rightCharacter, (this.view.numChildren - 1));
                    return;
            };
        }

        private function initPerformanceMonitor():void
        {
            this.view.addChild(new Stats());
        }

        private function initBrowserResize():void
        {
            var _local_1:NativeSignal = new NativeSignal(this.view.stage, Event.RESIZE, Event);
            _local_1.add(this.onBrowserResize);
            this.onBrowserResize(null);
        }

        private function onBrowserResize(_arg_1:Event):void
        {
			if (this.view.parent != this.view.stage) return;
            var sw:Number = view.stage.stageWidth;
			var sh:Number = view.stage.stageHeight;
			var s:Number  = Math.min(sw / MAIN_WIDTH, sh / MAIN_HEIGHT);
			view.scaleX = view.scaleY = s;
			view.x = Math.round((sw - MAIN_WIDTH * s) / 2);
			view.y = 0;
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
