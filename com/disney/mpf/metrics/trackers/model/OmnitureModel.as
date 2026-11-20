//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers.model
{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.omniture.ActionSource;
    import com.disney.mpf.errors.events.MPFErrorEvent;
    import flash.events.ErrorEvent;
    import com.disney.mpf.metrics.trackers.utils.OmnitureStringUtils;
    import flash.events.Event;
    import com.disney.mpf.errors.MPFErrorCodes;

    public class OmnitureModel extends EventDispatcher implements ITrackerModel 
    {

        protected var _charset:String;
        protected var _pageName:String;
        protected var _dc:String;
        protected var _pageURL:String;
        protected var _mediaModule:OmnitureMediaModule;
        protected var _events:String = "";
        protected var _eVars:Dictionary;
        protected var _pageType:String;
        protected var _trackingServerSecure:String;
        protected var _visitorNamespace:String;
        protected var _account:String;
        protected var _props:Dictionary;
        protected var _trackingServer:String;
        protected var _s:ActionSource;

        public function OmnitureModel(_arg_1:ActionSource, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:String, _arg_8:String, _arg_9:String, _arg_10:String)
        {
            this._s = _arg_1;
            this._visitorNamespace = _arg_2;
            this._account = _arg_3;
            this._trackingServer = _arg_4;
            this._trackingServerSecure = _arg_5;
            this._dc = _arg_6;
            this._pageName = _arg_7;
            this._pageType = _arg_8;
            this._pageURL = _arg_9;
            this._charset = "UTF-8";
            this._mediaModule = new OmnitureMediaModule(this._s);
            this._mediaModule.playerName = _arg_10;
            this._mediaModule.addEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
            this._mediaModule.addEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
            this._eVars = new Dictionary();
            this._props = new Dictionary();
            this._s.events = this._events;
        }

        public function eVarSet(_arg_1:int, _arg_2:String):void
        {
            this.Media.trackVarAdd(("eVar" + _arg_1));
            this._eVars[("eVar" + _arg_1)] = _arg_2;
            this._s[("eVar" + _arg_1)] = _arg_2;
        }

        protected function handleMPFWarn(_arg_1:ErrorEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }

        public function set trackingServerSecure(_arg_1:String):void
        {
            this._trackingServerSecure = _arg_1;
        }

        public function get version():String
        {
            return (this._s.version);
        }

        public function propSet(_arg_1:int, _arg_2:String):void
        {
            this.Media.trackVarAdd(("prop" + _arg_1));
            this._props[("prop" + _arg_1)] = _arg_2;
            this._s[("prop" + _arg_1)] = _arg_2;
        }

        public function get visitorNamespace():String
        {
            return (this._visitorNamespace);
        }

        public function set visitorNamespace(_arg_1:String):void
        {
            this._visitorNamespace = _arg_1;
        }

        public function eVarRemove(_arg_1:int):void
        {
            this.Media.trackVarRemove(("eVar" + _arg_1));
            delete this._eVars[("eVar" + _arg_1)];
            this._s[("eVar" + _arg_1)] = "";
        }

        public function eventAdd(_arg_1:String):void
        {
            var _local_2:String = OmnitureStringUtils.addToString(_arg_1, this._events);
            this.Media.trackEventAdd(_arg_1);
            if (_local_2.length > 0)
            {
                this.Media.trackVarAdd("events");
            };
            this._events = _local_2;
            this._s.events = this._events;
        }

        public function get debugTracking():Boolean
        {
            return (this._s.debugTracking);
        }

        public function get charSet():String
        {
            return (this._charset);
        }

        public function get account():String
        {
            return (this._account);
        }

        public function get propsList():String
        {
            var _local_1:Array = new Array();
            var _local_2:int = 1;
            while (_local_2 < 51)
            {
                if (this._props[("props" + _local_2)])
                {
                    _local_1.push(this._props[("props" + _local_2)]);
                };
                _local_2++;
            };
            return (_local_1.join(","));
        }

        public function set trackingServer(_arg_1:String):void
        {
            this._trackingServer = _arg_1;
        }

        public function get pageName():String
        {
            return (this._pageName);
        }

        public function eventRemove(_arg_1:String):void
        {
            var _local_2:String = OmnitureStringUtils.removeFromString(_arg_1, this._events);
            this.Media.trackEventRemove(_arg_1);
            if (_local_2.length == 0)
            {
                this.Media.trackVarRemove("events");
            };
            this._events = _local_2;
            this._s.events = this._events;
        }

        public function set pageURL(_arg_1:String):void
        {
            this._pageURL = _arg_1;
        }

        public function get Media():OmnitureMediaModule
        {
            return (this._mediaModule);
        }

        public function set trackLocal(_arg_1:Boolean):void
        {
            this._s.trackLocal = _arg_1;
        }

        public function update(_arg_1:Event):void
        {
            var _local_4:String;
            var _local_5:String;
            this.Media.update(_arg_1);
            this._s.charSet = this._charset;
            this._s.visitorNamespace = this._visitorNamespace;
            this._s.account = this._account;
            this._s.trackingServer = this._trackingServer;
            this._s.trackingServerSecure = this._trackingServerSecure;
            this._s.dc = this._dc;
            this._s.pageName = this._pageName;
            this._s.pageType = this._pageType;
            this._s.pageURL = this._pageURL;
            this._s.events = this._events;
            var _local_2:int = 1;
            while (_local_2 < 51)
            {
                if (((this._s[("prop" + _local_2)]) && (!(this._s[("prop" + _local_2)] == ""))))
                {
                    this._s[("prop" + _local_2)] = "";
                };
                _local_2++;
            };
            var _local_3:int = 1;
            while (_local_3 < 51)
            {
                if (((this._s[("eVar" + _local_3)]) && (!(this._s[("eVar" + _local_3)] == ""))))
                {
                    this._s[("eVar" + _local_3)] = "";
                };
                _local_3++;
            };
            for (_local_4 in this._props)
            {
                this._s[_local_4] = this._props[_local_4];
                this.Media.trackVarAdd(_local_4);
            };
            for (_local_5 in this._eVars)
            {
                this._s[_local_5] = this._eVars[_local_5];
                this.Media.trackVarAdd(_local_5);
            };
            this.verifyParams();
        }

        public function track(_arg_1:Object=null, _arg_2:String=""):*
        {
            return (this._s.track(_arg_1, _arg_2));
        }

        public function eVarsRemoveAll():void
        {
            var _local_1:int = 1;
            while (_local_1 < 51)
            {
                if (this._eVars[("eVar" + _local_1)])
                {
                    this.Media.trackVarRemove(("eVar" + _local_1));
                    delete this._eVars[("eVar" + _local_1)];
                    this._s[("eVar" + _local_1)] = "";
                };
                _local_1++;
            };
        }

        public function propRemove(_arg_1:int):void
        {
            this.Media.trackVarRemove(("prop" + _arg_1));
            delete this._props[("prop" + _arg_1)];
            this._s[("prop" + _arg_1)] = "";
        }

        public function set pageType(_arg_1:String):void
        {
            this._pageType = _arg_1;
        }

        public function set debugTracking(_arg_1:Boolean):void
        {
            this._s.debugTracking = _arg_1;
        }

        public function get eventsList():String
        {
            return (this._events);
        }

        public function set account(_arg_1:String):void
        {
            this._account = _arg_1;
        }

        public function set charSet(_arg_1:String):void
        {
            this._charset = _arg_1;
        }

        public function get pageURL():String
        {
            return (this._pageURL);
        }

        public function get trackingServer():String
        {
            return (this._trackingServer);
        }

        protected function verifyParams():void
        {
            if (!this._s)
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "ActionSource reference does not exist in OmnitureModel."));
            };
            if (((!(this._s.visitorNamespace)) || (this._s.visitorNamespace == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'visitorNamespace' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this._s.account)) || (this._s.account == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'account' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this._s.trackingServer)) || (this._s.trackingServer == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'trackingServer' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this._s.trackingServerSecure)) || (this._s.trackingServerSecure == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'trackingServerSecure' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this._s.dc)) || (this._s.dc == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'dc' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this._s.pageName)) || (this._s.pageName == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.WARN, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'pageName' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this._s.pageType)) || (this._s.pageType == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.WARN, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'pageType' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this._s.pageURL)) || (this._s.pageURL == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.WARN, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The 'pageURL' property on the OmnitureModel instance is invalid."));
            };
            if (((!(this.eventsList == "")) && ((!(this._s.Media.trackEvents)) || (this._s.Media.trackEvents == ""))))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The trackEvents property on the OmnitureModel.Media instance is invalid or not set."));
            };
        }

        public function get trackLocal():Boolean
        {
            return (this._s.trackLocal);
        }

        public function get pageType():String
        {
            return (this._pageType);
        }

        public function eventsRemoveAll():void
        {
            this.eventRemove(this._events);
        }

        public function propsRemoveAll():void
        {
            var _local_1:int = 1;
            while (_local_1 < 51)
            {
                if (this._props[("prop" + _local_1)])
                {
                    this.Media.trackVarRemove(("prop" + _local_1));
                    delete this._props[("prop" + _local_1)];
                    this._s[("prop" + _local_1)] = "";
                };
                _local_1++;
            };
        }

        public function get eVarsList():String
        {
            var _local_1:Array = new Array();
            var _local_2:int = 1;
            while (_local_2 < 51)
            {
                if (this._eVars[("eVar" + _local_2)])
                {
                    _local_1.push(this._eVars[("eVar" + _local_2)]);
                };
                _local_2++;
            };
            return (_local_1.join(","));
        }

        public function get trackingServerSecure():String
        {
            return (this._trackingServerSecure);
        }

        public function set pageName(_arg_1:String):void
        {
            this._pageName = _arg_1;
        }

        protected function handleMPFError(_arg_1:ErrorEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }

        public function set dc(_arg_1:String):void
        {
            this._dc = _arg_1;
        }

        public function get dc():String
        {
            return (this._dc);
        }


    }
}//package com.disney.mpf.metrics.trackers.model
