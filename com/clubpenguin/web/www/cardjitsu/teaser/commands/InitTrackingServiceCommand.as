//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.TrackingService;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel;

    public class InitTrackingServiceCommand extends SignalCommand 
    {

        [Inject]
        public var trackingService:TrackingService;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            this.trackingService.loadComplete.addOnce(this.onComplete);
            this.trackingService.init();
        }

        private function onComplete():void
        {
            this.mainModel.trackingServiceLoaded();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.commands
