//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers
{
    import flash.events.IEventDispatcher;
    import flash.events.Event;

    public interface ITracker extends IEventDispatcher 
    {

        function get enabled():Boolean;
        function set enabled(_arg_1:Boolean):void;
        function track(_arg_1:Event):void;
        function destroy():void;

    }
}//package com.disney.mpf.metrics.trackers
