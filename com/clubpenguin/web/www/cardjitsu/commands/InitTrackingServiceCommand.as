//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.services.TrackingService;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;

    public class InitTrackingServiceCommand extends SignalCommand 
    {

        [Inject]
        public var trackingService:TrackingService;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            this.trackingService.loadComplete.addOnce(this.onComplete);
            this.trackingService.trackingURL = this.mainModel.trackingURL;
            this.trackingService.init();
        }

        private function onComplete():void
        {
            this.mainModel.trackingServiceLoaded();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.commands
