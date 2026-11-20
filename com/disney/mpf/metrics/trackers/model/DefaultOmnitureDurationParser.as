//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers.model
{
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import flash.events.Event;

    public class DefaultOmnitureDurationParser implements IOmnitureNumberPropertyParser 
    {


        public function parse(_arg_1:Event):Number
        {
            if ((_arg_1 is ControllerEvent))
            {
                return (ControllerEvent(_arg_1).info.duration);
            };
            return (NaN);
        }


    }
}//package com.disney.mpf.metrics.trackers.model
