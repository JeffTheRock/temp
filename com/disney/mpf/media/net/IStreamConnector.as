//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import flash.events.IEventDispatcher;
    import com.disney.mpf.media.model.IMedia;

    public interface IStreamConnector extends IEventDispatcher 
    {

        function connect(_arg_1:IMedia):void;
        function dispatchConnectionFailure():void;
        function close():void;
        function destroy():void;
        function dispatchConnectionSuccess():void;

    }
}//package com.disney.mpf.media.net
