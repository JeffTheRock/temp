//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.services
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import flash.system.Security;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.net.URLRequest;

    public class TrackingService extends Actor 
    {

        public var loadComplete:Signal;
        private var _trackerObj:Object;

        public function TrackingService()
        {
            Security.allowDomain("*");
            this.loadComplete = new Signal();
        }

        public function init():void
        {
            var _local_1:Loader = new Loader();
            _local_1.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadCompleteHandler);
            var _local_2:LoaderContext = new LoaderContext();
            _local_2.applicationDomain = ApplicationDomain.currentDomain;
            var _local_3:URLRequest = new URLRequest("http://disney.go.com/stat/flash/analyticReportingAS3.swf");
            _local_1.load(_local_3, _local_2);
        }

        private function loadCompleteHandler(_arg_1:Event):void
        {
            var _local_2:Class = (_arg_1.target.applicationDomain.getDefinition("com.disney.WebAnalytics.WebAnalyticsManager") as Class);
            this._trackerObj = new (_local_2)();
            this.loadComplete.dispatch();
        }

        public function submitPageView(_arg_1:String, _arg_2:String):void
        {
            var _local_3:Object;
            if (((_arg_2) && (this._trackerObj)))
            {
                _local_3 = {};
                _local_3.account = "wdgdolclp|";
                _local_3.trackType = "pageView";
                _local_3.site = "clp";
                _local_3.property = "clp";
                _local_3.category = "dgame";
                _local_3.siteSection = ("cardjitsu:" + _arg_1);
                _local_3.pageName = _arg_2;
                this._trackerObj.submitTracking(_local_3);
            }
            else
            {
                trace("TrackingManager: submitPageView Failed");
            };
        }

        public function submitLinkClick(_arg_1:String):void
        {
            var _local_2:Object;
            if (((_arg_1) && (this._trackerObj)))
            {
                _local_2 = {};
                _local_2.account = "wdgdolclp|";
                _local_2.trackType = "linkTrack";
                _local_2.site = "clp";
                _local_2.property = "clp";
                _local_2.category = "dgame";
                _local_2.siteSection = "play:create";
                _local_2.linkId = _arg_1;
                this._trackerObj.submitTracking(_local_2);
            }
            else
            {
                trace("TrackingManager: submitLinkClick Failed");
            };
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.services
