//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers.model
{
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import flash.events.Event;

    public class DefaultOmnitureIdParser implements IOmnitureStringPropertyParser 
    {


        public function parse(event:Event):String
        {
            var e:ControllerEvent;
            if ((event is ControllerEvent))
            {
                e = (event as ControllerEvent);
                try
                {
                    return ("vid:" + e.info.media.id);
                }
                catch(e:Error)
                {
                };
            };
            return (null);
        }


    }
}//package com.disney.mpf.metrics.trackers.model
