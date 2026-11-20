//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers.model
{
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import flash.events.Event;

    public class DefaultOmnitureNameParser implements IOmnitureStringPropertyParser 
    {


        public function parse(event:Event):String
        {
            var e:ControllerEvent;
            var returnValue:String;
            if ((event is ControllerEvent))
            {
                e = (event as ControllerEvent);
                returnValue = "";
                try
                {
                    if (e.info.media.name)
                    {
                        returnValue = e.info.media.name;
                    }
                    else
                    {
                        returnValue = e.info.media.id;
                    };
                    return (returnValue);
                }
                catch(e:Error)
                {
                };
            };
            return (null);
        }


    }
}//package com.disney.mpf.metrics.trackers.model
