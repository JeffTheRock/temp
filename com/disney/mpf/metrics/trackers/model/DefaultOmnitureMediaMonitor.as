//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers.model
{
    import com.disney.mpf.metrics.trackers.OmnitureTracker;
    import com.omniture.ActionSource;

    public class DefaultOmnitureMediaMonitor implements IOmnitureMediaMonitor 
    {

        private var _tracker:OmnitureTracker;
        private var _model:OmnitureModel;

        public function DefaultOmnitureMediaMonitor(_arg_1:OmnitureTracker)
        {
            this._tracker = _arg_1;
            this._model = (this._tracker.model as OmnitureModel);
        }

        public function onOmnitureEvent(_arg_1:ActionSource, _arg_2:*):void
        {
            var _local_3:* = "";
            var _local_4:* = "";
            switch (_arg_2.event)
            {
                case "OPEN":
                    _local_3 = "event11";
                    _local_4 = "event1";
                    break;
                case "CLOSE":
                    _local_3 = "event1";
                    if (this._tracker.isVideoComplete)
                    {
                        _local_4 = "event11";
                    };
                    break;
            };
            if (((_arg_2.event == "OPEN") || (_arg_2.event == "CLOSE")))
            {
                this._model.eventAdd(_local_4);
                this._model.eventRemove(_local_3);
                this._model.Media.track(_arg_2.name);
                this._model.eventRemove("event1,event11");
            };
        }


    }
}//package com.disney.mpf.metrics.trackers.model
