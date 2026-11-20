//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.context
{
    import org.robotlegs.mvcs.SignalContext;
    import org.osflash.signals.Signal;
    import flash.display.DisplayObjectContainer;
    import com.clubpenguin.web.www.cardjitsu.services.DataLoaderService;
    import com.clubpenguin.web.www.cardjitsu.services.TrackingService;
    import com.clubpenguin.web.www.cardjitsu.services.SWFAddressService;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.commands.InitConfigCommand;
    import com.clubpenguin.web.www.cardjitsu.signals.InitTrackingServiceSignal;
    import com.clubpenguin.web.www.cardjitsu.commands.InitTrackingServiceCommand;
    import com.clubpenguin.web.www.cardjitsu.signals.InitSWFAddressSignal;
    import com.clubpenguin.web.www.cardjitsu.commands.InitSWFAddressCommand;
    import com.clubpenguin.web.www.cardjitsu.signals.MainNavigationClickedSignal;
    import com.clubpenguin.web.www.cardjitsu.commands.MainNavigationClickedCommand;
    import com.clubpenguin.web.www.cardjitsu.views.environment.background.SkyView;
    import com.clubpenguin.web.www.cardjitsu.mediators.SkyMediator;
    import com.clubpenguin.web.www.cardjitsu.views.environment.foreground.GroundView;
    import com.clubpenguin.web.www.cardjitsu.mediators.GroundMediator;
    import com.clubpenguin.web.www.cardjitsu.views.content.ContentFrameView;
    import com.clubpenguin.web.www.cardjitsu.mediators.ContentFrameMediator;
    import com.clubpenguin.web.www.cardjitsu.views.environment.midground.EnvironmentView;
    import com.clubpenguin.web.www.cardjitsu.mediators.EnvironmentMediator;
    import com.clubpenguin.web.www.cardjitsu.views.effects.ambient.AmbientEffectsView;
    import com.clubpenguin.web.www.cardjitsu.mediators.AmbientEffectsMediator;
    import com.clubpenguin.web.www.cardjitsu.views.LogoView;
    import com.clubpenguin.web.www.cardjitsu.mediators.LogoMediator;
    import com.clubpenguin.web.www.cardjitsu.views.ui.MainNavigation;
    import com.clubpenguin.web.www.cardjitsu.mediators.MainNavigationMediator;
    import com.clubpenguin.web.www.cardjitsu.views.ui.AmuletView;
    import com.clubpenguin.web.www.cardjitsu.mediators.AmuletMediator;
    import com.clubpenguin.web.www.cardjitsu.views.characters.left.LeftCharacterView;
    import com.clubpenguin.web.www.cardjitsu.mediators.LeftCharacterMediator;
    import com.clubpenguin.web.www.cardjitsu.views.characters.right.RightCharacterView;
    import com.clubpenguin.web.www.cardjitsu.mediators.RightCharacterMediator;
    import com.clubpenguin.web.www.cardjitsu.views.effects.header.HeaderEffectsView;
    import com.clubpenguin.web.www.cardjitsu.mediators.HeaderEffectsMediator;
    import com.clubpenguin.web.www.cardjitsu.mediators.MainMediator;

    public class MainContext extends SignalContext 
    {

        private var initConfigSignal:Signal = new Signal();

        public function MainContext(_arg_1:DisplayObjectContainer)
        {
            super(_arg_1);
        }

        override public function startup():void
        {
            injector.mapClass(DataLoaderService, DataLoaderService);
            injector.mapSingleton(TrackingService);
            injector.mapSingleton(SWFAddressService);
            injector.mapSingleton(MainModel);
            signalCommandMap.mapSignal(this.initConfigSignal, InitConfigCommand, true);
            signalCommandMap.mapSignalClass(InitTrackingServiceSignal, InitTrackingServiceCommand, true);
            signalCommandMap.mapSignalClass(InitSWFAddressSignal, InitSWFAddressCommand, true);
            signalCommandMap.mapSignalClass(MainNavigationClickedSignal, MainNavigationClickedCommand);
            mediatorMap.mapView(SkyView, SkyMediator);
            mediatorMap.mapView(GroundView, GroundMediator);
            mediatorMap.mapView(ContentFrameView, ContentFrameMediator);
            mediatorMap.mapView(EnvironmentView, EnvironmentMediator);
            mediatorMap.mapView(AmbientEffectsView, AmbientEffectsMediator);
            mediatorMap.mapView(LogoView, LogoMediator);
            mediatorMap.mapView(MainNavigation, MainNavigationMediator);
            mediatorMap.mapView(AmuletView, AmuletMediator);
            mediatorMap.mapView(LeftCharacterView, LeftCharacterMediator);
            mediatorMap.mapView(RightCharacterView, RightCharacterMediator);
            mediatorMap.mapView(HeaderEffectsView, HeaderEffectsMediator);
            mediatorMap.mapView(Main, MainMediator);
            mediatorMap.createMediator(contextView);
            this.initConfigSignal.dispatch();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.context
