//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.events
{
    import com.disney.mpf.media.controller.events.ControllerEvent;

    public class EventList 
    {

        public static const CONTENT_EVENTS:EventList = new EventList(ControllerEvent.INITIALIZING, ControllerEvent.INITIALIZED, ControllerEvent.LOADING, ControllerEvent.LOADED, ControllerEvent.NEXT, ControllerEvent.PREVIOUS, ControllerEvent.ON_BITRATE_CHANGED, ControllerEvent.ON_BITRATE_CHANGE_REQUESTED, ControllerEvent.PLAY_STATE_CHANGED, ControllerEvent.STALLED, ControllerEvent.WAITING, ControllerEvent.START, ControllerEvent.PAUSE, ControllerEvent.PAUSE_PENDING, ControllerEvent.STOP, ControllerEvent.STOP_PENDING, ControllerEvent.COMPLETE, ControllerEvent.PLAY, ControllerEvent.PLAY_PENDING, ControllerEvent.SEEK, ControllerEvent.SEEK_PENDING, ControllerEvent.MUTE, ControllerEvent.UNMUTE, ControllerEvent.VOLUME_CHANGE, ControllerEvent.PROGRESS_UPDATE);
        public static const AD_EVENTS:EventList = new EventList(TrackingEvent.IMPRESSION, TrackingEvent.VIDEO_FIRST_QUARTILE, TrackingEvent.VIDEO_THIRD_QUARTILE, TrackingEvent.VIDEO_MIDPOINT, TrackingEvent.COMPLETION, TrackingEvent.CLICK_THROUGH, TrackingEvent.PAUSE, TrackingEvent.RESUME, TrackingEvent.REWIND, TrackingEvent.AUDIO_MUTE, TrackingEvent.AUDIO_UNMUTE, TrackingEvent.VOLUME_CHANGE, TrackingEvent.EXPAND, TrackingEvent.CONTRACT);
        public static const AD_AND_CONTENT_EVENTS:EventList = new EventList(AD_EVENTS.events, CONTENT_EVENTS.events);

        private var _events:Array;

        public function EventList(... _args)
        {
            var _local_2:*;
            super();
            this._events = new Array();
            for each (_local_2 in _args)
            {
                if ((_local_2 is String))
                {
                    this.addEventString(_local_2);
                }
                else
                {
                    if ((_local_2 is Array))
                    {
                        this.addEventArray(_local_2);
                    }
                    else
                    {
                        if ((_local_2 is EventList))
                        {
                            this.addEventList(_local_2);
                        };
                    };
                };
            };
        }

        private function addEventArray(_arg_1:Array):void
        {
            var _local_2:String;
            for each (_local_2 in _arg_1)
            {
                this.addEventString(_local_2);
            };
        }

        public function get events():Array
        {
            return (this._events);
        }

        private function addEventString(_arg_1:String):void
        {
            this._events.push(_arg_1);
        }

        private function addEventList(_arg_1:EventList):void
        {
            this.addEventArray(_arg_1.events);
        }


    }
}//package com.disney.mpf.metrics.events
