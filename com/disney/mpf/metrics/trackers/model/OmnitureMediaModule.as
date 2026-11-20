//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers.model
{
    import flash.events.EventDispatcher;
    import com.omniture.ActionSource;
    import com.disney.mpf.metrics.trackers.utils.OmnitureStringUtils;
    import com.disney.mpf.errors.events.MPFErrorEvent;
    import com.disney.mpf.errors.MPFErrorCodes;
    import flash.events.Event;

    public class OmnitureMediaModule extends EventDispatcher 
    {

        public static const MPF_TRACKEVENTS:String = "event1,event11";
        public static const MPF_TRACKVARS:String = "events,eVar2,prop3,prop4";
        public static const MPF_DEFAULT_MILESTONES:String = "";

        protected var _s:ActionSource;
        protected var _trackEvents:String;
        protected var _trackSeconds:Number;
        protected var _trackVars:String;
        protected var _monitor:IOmnitureMediaMonitor;
        protected var _trackWhilePlaying:Boolean;
        protected var _playerName:String;
        protected var _trackMilestones:String;

        public function OmnitureMediaModule(_arg_1:ActionSource)
        {
            this._s = _arg_1;
        }

        public function trackVarRemove(_arg_1:String):void
        {
            this._trackVars = OmnitureStringUtils.removeFromString(_arg_1, this._trackVars);
            this._s.Media.trackVars = this._trackVars;
        }

        protected function verifyParams():void
        {
            if (!this._s)
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "ActionSource reference does not exist in OmnitureModel."));
            };
            if (((!(this._s.Media.playerName)) || (this._s.Media.playerName == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The playerName property on the OmnitureModel.Media instance is invalid or not set."));
            };
            if (((!(this._s.Media.trackVars)) || (this._s.Media.trackVars == "")))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "The trackVars property on the OmnitureModel.Media instance is invalid or not set."));
            };
            if ((((this._s.Media.trackMilestones) && (!(this._s.Media.trackMilestones == ""))) && ((this._s.Media.trackSeconds) && (this._s.Media.trackSeconds < 1))))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "Both trackMilestones and trackSeconds are set. Only one of these methods can be used."));
            };
        }

        public function stop(_arg_1:String, _arg_2:Number):void
        {
            this._s.Media.stop(_arg_1, _arg_2);
        }

        public function get trackEventsList():String
        {
            return (this._trackEvents);
        }

        public function track(_arg_1:String):void
        {
            this._s.Media.track(_arg_1);
        }

        public function get playerName():String
        {
            return (this._playerName);
        }

        public function update(_arg_1:Event):void
        {
            this._s.Media.playerName = this._playerName;
            this._s.Media.trackEvents = this._trackEvents;
            this._s.Media.trackVars = this._trackVars;
            this._s.Media.trackMilestones = this._trackMilestones;
            this._s.Media.trackSeconds = this._trackSeconds;
            this._s.Media.trackWhilePlaying = this._trackWhilePlaying;
            this._s.Media.monitor = this._monitor.onOmnitureEvent;
            this.verifyParams();
        }

        public function set trackWhilePlaying(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this._trackWhilePlaying = _arg_1;
                this._s.Media.trackWhilePlaying = _arg_1;
            }
            else
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.INVALID_TRACKING_CONFIGURATION, "TrackWhilePlaying must be set to true for MPF use."));
            };
        }

        public function open(_arg_1:String, _arg_2:Number, _arg_3:String):void
        {
            this._s.Media.open(_arg_1, _arg_2, _arg_3);
        }

        public function get trackVarsList():String
        {
            return (this._trackVars);
        }

        public function trackEventAdd(_arg_1:String):void
        {
            this._trackEvents = OmnitureStringUtils.addToString(_arg_1, this._trackEvents);
            this._s.Media.trackEvents = this._trackEvents;
        }

        public function get monitor():IOmnitureMediaMonitor
        {
            return (this._monitor);
        }

        public function set trackMilestones(_arg_1:String):void
        {
            this._trackMilestones = _arg_1;
            this._trackSeconds = 0;
            this._s.Media.trackMilestones = _arg_1;
            this._s.Media.trackSeconds = 0;
        }

        public function set playerName(_arg_1:String):void
        {
            this._playerName = _arg_1;
            this._s.Media.playerName = this._playerName;
        }

        public function trackEventsRemoveAll():void
        {
            this._trackEvents = "";
            this._s.Media.trackEvents = "";
        }

        public function get trackSeconds():Number
        {
            return (this._trackSeconds);
        }

        public function trackVarAdd(_arg_1:String):void
        {
            this._trackVars = OmnitureStringUtils.addToString(_arg_1, this._trackVars);
            this._s.Media.trackVars = this._trackVars;
        }

        public function trackVarsRemoveAll():void
        {
            this._trackVars = "";
            this._s.Media.trackVars = "";
        }

        public function get trackMilestones():String
        {
            return (this._trackMilestones);
        }

        public function set monitor(_arg_1:IOmnitureMediaMonitor):void
        {
            this._monitor = _arg_1;
            this._s.Media.monitor = this._monitor.onOmnitureEvent;
        }

        public function set trackSeconds(_arg_1:Number):void
        {
            this._trackSeconds = _arg_1;
            this._trackMilestones = "";
            this._s.Media.trackSeconds = _arg_1;
            this._s.Media.trackMilestones = "";
        }

        public function close(_arg_1:String):void
        {
            this._s.Media.close(_arg_1);
        }

        public function trackEventRemove(_arg_1:String):void
        {
            this._trackEvents = OmnitureStringUtils.removeFromString(_arg_1, this._trackEvents);
            this._s.Media.trackEvents = this._trackEvents;
        }

        public function play(_arg_1:String, _arg_2:Number):void
        {
            this._s.Media.play(_arg_1, _arg_2);
        }

        public function get trackWhilePlaying():Boolean
        {
            return (this._trackWhilePlaying);
        }


    }
}//package com.disney.mpf.metrics.trackers.model
