//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.services
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import com.omniture.ActionSource;
    import flash.system.Security;
    import flash.system.LoaderContext;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.net.URLRequest;

    public class TrackingService extends Actor 
    {

        public var loadComplete:Signal;
        private var _trackerObj:Object;
        private var _actionsource:ActionSource;
        private var _trackingURL:String;

        public function TrackingService()
        {
            Security.allowDomain("*");
            this.loadComplete = new Signal();
        }

        public function set trackingURL(param1:String):void
        {
            this._trackingURL = param1;
        }

        public function init():void
        {
            var _loc2_:LoaderContext;
            var _loc1_:Loader = new Loader();
            _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadCompleteHandler);
            if (Security.sandboxType == Security.REMOTE)
            {
                _loc2_ = new LoaderContext(true, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
                _loc2_.securityDomain = SecurityDomain.currentDomain;
                _loc1_.load(new URLRequest("analyticReportingAS3.swf"), _loc2_);
            }
            else
            {
                _loc1_.load(new URLRequest("analyticReportingAS3.swf"));
            };
        }

        private function loadCompleteHandler(param1:Event):void
        {
            var _loc2_:Class = (param1.target.applicationDomain.getDefinition("com.disney.WebAnalytics.WebAnalyticsManager") as Class);
            this._trackerObj = new (_loc2_)();
            this._actionsource = this._trackerObj.getOmniASInstance();
            this.loadComplete.dispatch();
        }

        public function submitPageView(param1:String, param2:String):void
        {
            var _loc3_:Object;
            if (((Boolean(param1)) && (Boolean(this._trackerObj))))
            {
                _loc3_ = {};
                _loc3_.account = "clubpenguin";
                _loc3_.trackType = "pageView";
                _loc3_.site = "clp";
                _loc3_.property = "clp";
                _loc3_.category = "dgame";
                _loc3_.siteSection = param1;
                _loc3_.pageName = param2;
            }
            else
            {
                trace("TrackingManager: submitPageView Failed");
            };
        }

        public function submitLinkClick(param1:String, param2:String):void
        {
            var _loc3_:Object;
            if (((Boolean(param2)) && (Boolean(this._trackerObj))))
            {
                _loc3_ = {};
                _loc3_.account = "clubpenguin";
                _loc3_.trackType = "linkTrack";
                _loc3_.site = "clp";
                _loc3_.property = "clp";
                _loc3_.category = "dgame";
                _loc3_.siteSection = param1;
                _loc3_.linkId = param2;
                this._trackerObj.submitTracking(_loc3_);
            }
            else
            {
                trace("TrackingManager: submitLinkClick Failed");
            };
        }

        public function get actionsource():ActionSource
        {
            return (this._actionsource);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.services
