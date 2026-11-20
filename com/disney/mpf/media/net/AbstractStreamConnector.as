//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import flash.events.EventDispatcher;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.media.model.IMedia;
    import com.disney.mpf.media.net.events.ConnectionEvent;

    public class AbstractStreamConnector extends EventDispatcher implements IStreamConnector 
    {


        public function connect(_arg_1:IMedia):void
        {
            throw (new MPFError("[AbstractStreamConnector] 'connect' method should be overridden in derived class.", MPFErrorCodes.ABSTRACT_METHOD_OVERRIDE));
        }

        public function dispatchConnectionFailure():void
        {
            dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_FAILURE));
        }

        public function close():void
        {
            throw (new MPFError("[AbstractStreamConnector] 'close' method should be overridden in derived class.", MPFErrorCodes.ABSTRACT_METHOD_OVERRIDE));
        }

        public function destroy():void
        {
            throw (new MPFError("[AbstractStreamConnector] 'destroy' method should be overridden in derived class.", MPFErrorCodes.ABSTRACT_METHOD_OVERRIDE));
        }

        public function dispatchConnectionSuccess():void
        {
            dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_SUCCESS));
        }


    }
}//package com.disney.mpf.media.net
