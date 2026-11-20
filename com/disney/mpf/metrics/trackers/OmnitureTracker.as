//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers
{
    import com.disney.mpf.extensions.IMPFExtension;
    import com.disney.mpf.metrics.trackers.model.IOmnitureStringPropertyParser;
    import flash.events.Event;
    import com.disney.mpf.metrics.trackers.model.IOmnitureNumberPropertyParser;
    import com.disney.mpf.extensions.IVersionChecker;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.extensions.VersionChecker;
    import com.disney.mpf.metrics.trackers.model.DefaultOmnitureIdParser;
    import com.disney.mpf.metrics.trackers.model.DefaultOmnitureNameParser;
    import com.disney.mpf.metrics.trackers.model.DefaultOmnitureCurrentPositionParser;
    import com.disney.mpf.metrics.trackers.model.DefaultOmnitureDurationParser;
    import com.disney.mpf.metrics.trackers.model.OmnitureMediaModule;
    import com.disney.mpf.metrics.trackers.model.DefaultOmnitureMediaMonitor;
    import com.disney.mpf.MPF;
    import com.disney.mpf.metrics.trackers.model.OmnitureModel;
    import flash.events.ErrorEvent;
    import com.disney.mpf.errors.events.MPFErrorEvent;
    import com.disney.mpf.metrics.trackers.model.ITrackerModel;
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import com.disney.mpf.metrics.events.ContentTrackingEvent;

    public class OmnitureTracker extends AbstractTracker implements IMPFExtension 
    {

        public static const NAME:String = "MPF Omniture Tracking Extension";
        public static const VERSION:String = "2.0.0.36";
        public static const DESCRIPTION:String = ((NAME + " ") + VERSION);
        public static const MIN_MPF_VERSION:String = "3.2.0.0";
        public static const MIN_FLASH_PLAYER_VERSION:String = "9.0.0.0";

        protected var _isVideoComplete:Boolean;
        protected var _mediaNameParser:IOmnitureStringPropertyParser;
        protected var _mediaName:String;
        protected var _eventToBeTracked:Event;
        protected var _mediaDurationParser:IOmnitureNumberPropertyParser;
        protected var _mediaDuration:Number;
        protected var _mediaIdParser:IOmnitureStringPropertyParser;
        protected var _versionChecker:IVersionChecker;
        protected var _mediaId:String;
        protected var _mediaPositionParser:IOmnitureNumberPropertyParser;
        protected var _mediaPosition:Number;

        public function OmnitureTracker(_arg_1:OmnitureModel)
        {
            if (_arg_1 != null)
            {
                this.model = _arg_1;
            }
            else
            {
                throw (new MPFError('The "model" constructor parameter may not be null.', MPFErrorCodes.INVALID_TRACKING_CONFIGURATION));
            };
            this._versionChecker = new VersionChecker(this, VERSION, MIN_MPF_VERSION, MIN_FLASH_PLAYER_VERSION, true);
            this._mediaIdParser = new DefaultOmnitureIdParser();
            this._mediaNameParser = new DefaultOmnitureNameParser();
            this._mediaPositionParser = new DefaultOmnitureCurrentPositionParser();
            this._mediaDurationParser = new DefaultOmnitureDurationParser();
            this.s.Media.trackWhilePlaying = true;
            this.s.Media.trackMilestones = OmnitureMediaModule.MPF_DEFAULT_MILESTONES;
            this.s.Media.monitor = new DefaultOmnitureMediaMonitor(this);
            this.s.propSet(4, ((((("MPF:MPFVersion=" + MPF.VERSION) + "|OmnitureExtensionVersion=") + OmnitureTracker.VERSION) + "|ActionSourceVersion=") + this.s.version));
        }

        protected function handleMPFWarn(_arg_1:ErrorEvent):void
        {
            dispatchEvent(_arg_1);
        }

        protected function get s():OmnitureModel
        {
            return (this.model as OmnitureModel);
        }

        public function set mediaIdParser(_arg_1:IOmnitureStringPropertyParser):void
        {
            this._mediaIdParser = _arg_1;
        }

        protected function handleMPFError(_arg_1:ErrorEvent):void
        {
            dispatchEvent(_arg_1);
        }

        public function set mediaNameParser(_arg_1:IOmnitureStringPropertyParser):void
        {
            this._mediaNameParser = _arg_1;
        }

        public function get isVideoComplete():Boolean
        {
            return (this._isVideoComplete);
        }

        public function get mediaNameParser():IOmnitureStringPropertyParser
        {
            return (this._mediaNameParser);
        }

        override public function set model(_arg_1:ITrackerModel):void
        {
            if (_model)
            {
                OmnitureModel(_model).removeEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
                OmnitureModel(_model).removeEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
            };
            _model = _arg_1;
            if (_model)
            {
                OmnitureModel(_model).addEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
                OmnitureModel(_model).addEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
            };
        }

        public function trackStart(_arg_1:Event):void
        {
            this._isVideoComplete = false;
            this.updateModel(_arg_1);
            this.s.Media.open(this.mediaName, Math.round(this._mediaDurationParser.parse(_arg_1)), this.s.Media.playerName);
        }

        override public function track(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case ControllerEvent.START:
                    this.trackStart(_arg_1);
                    return;
                case ControllerEvent.PLAY:
                    this.trackPlay(_arg_1);
                    return;
                case ControllerEvent.PAUSE:
                    this.trackPause(_arg_1);
                    return;
                case ControllerEvent.SEEK_PENDING:
                    this.trackPause(_arg_1);
                    return;
                case ControllerEvent.STOP:
                    this.trackStop(_arg_1);
                    return;
                case ContentTrackingEvent.FORCE_COMPLETION:
                case ControllerEvent.COMPLETE:
                    this.trackComplete(_arg_1);
                    return;
            };
        }

        public function trackComplete(_arg_1:Event):void
        {
            this._isVideoComplete = true;
            this.updateModel(_arg_1);
            this.s.Media.stop(this.mediaName, Math.round(this._mediaPositionParser.parse(_arg_1)));
            this.s.Media.close(this.mediaName);
        }

        public function get mediaIdParser():IOmnitureStringPropertyParser
        {
            return (this._mediaIdParser);
        }

        public function trackPlay(_arg_1:Event):void
        {
            this.updateModel(_arg_1);
            this.s.Media.play(this.mediaName, Math.round(this._mediaPositionParser.parse(_arg_1)));
        }

        override public function get model():ITrackerModel
        {
            return (_model);
        }

        public function trackPause(_arg_1:Event):void
        {
            this.updateModel(_arg_1);
            this.s.Media.stop(this.mediaName, Math.round(this._mediaPositionParser.parse(_arg_1)));
        }

        public function get mediaPositionParser():IOmnitureNumberPropertyParser
        {
            return (this._mediaPositionParser);
        }

        protected function updateModel(_arg_1:Event):void
        {
            this._eventToBeTracked = _arg_1;
            this.s.propSet(3, this.mediaId);
            this.s.eVarSet(2, this.mediaId);
            this.s.update(_arg_1);
        }

        public function get mediaName():String
        {
            return (this._mediaNameParser.parse(this._eventToBeTracked));
        }

        public function set mediaDurationParser(_arg_1:IOmnitureNumberPropertyParser):void
        {
            this._mediaDurationParser = _arg_1;
        }

        public function get mediaId():String
        {
            return (this._mediaIdParser.parse(this._eventToBeTracked));
        }

        public function get mediaDurationParser():IOmnitureNumberPropertyParser
        {
            return (this._mediaDurationParser);
        }

        public function set mediaPositionParser(_arg_1:IOmnitureNumberPropertyParser):void
        {
            this._mediaPositionParser = _arg_1;
        }

        public function trackStop(_arg_1:Event):void
        {
            this.updateModel(_arg_1);
            this.s.Media.stop(this.mediaName, Math.round(this._mediaPositionParser.parse(_arg_1)));
            this.s.Media.close(this.mediaName);
        }

        public function get versionChecker():IVersionChecker
        {
            return (this._versionChecker);
        }


    }
}//package com.disney.mpf.metrics.trackers
