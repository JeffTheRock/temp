//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.context
{
    import org.robotlegs.mvcs.SignalContext;
    import org.osflash.signals.Signal;
    import flash.display.DisplayObjectContainer;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.DataLoaderService;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.FontLoaderService;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.TrackingService;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.teaser.commands.InitConfigCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.signals.InitFontsSignal;
    import com.clubpenguin.web.www.cardjitsu.teaser.commands.InitFontsCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.signals.InitTrackingServiceSignal;
    import com.clubpenguin.web.www.cardjitsu.teaser.commands.InitTrackingServiceCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.views.VideoPlayerView;
    import com.clubpenguin.web.www.cardjitsu.teaser.mediators.VideoPlayerMediator;
    import com.clubpenguin.web.www.cardjitsu.teaser.mediators.MainMediator;

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
            injector.mapClass(FontLoaderService, FontLoaderService);
            injector.mapSingleton(TrackingService);
            injector.mapSingleton(MainModel);
            signalCommandMap.mapSignal(this.initConfigSignal, InitConfigCommand, true);
            signalCommandMap.mapSignalClass(InitFontsSignal, InitFontsCommand, true);
            signalCommandMap.mapSignalClass(InitTrackingServiceSignal, InitTrackingServiceCommand, true);
            mediatorMap.mapView(VideoPlayerView, VideoPlayerMediator);
            mediatorMap.mapView(Main, MainMediator);
            mediatorMap.createMediator(contextView);
            this.initConfigSignal.dispatch();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.context
