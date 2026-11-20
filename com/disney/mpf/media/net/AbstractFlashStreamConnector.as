//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import flash.net.NetStream;
    import flash.net.NetConnection;
    import com.disney.mpf.media.model.IMedia;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.utils.logging.LogManager;
    import com.disney.mpf.media.net.events.FlashConnectionEvent;

    public class AbstractFlashStreamConnector extends AbstractStreamConnector implements IFlashStreamConnector, IUpdateableStreamConnector 
    {

        protected var _nsUpdate:NetStream;
        protected var _nc:NetConnection;
        protected var _format:String;
        protected var _ucState:Boolean = false;
        protected var _media:IMedia;
        protected var _ns:NetStream;
        protected var _ncUpdate:NetConnection;


        override public function destroy():void
        {
            this._nc = null;
            this._ns = null;
            this._format = null;
        }

        public function updateConnection(_arg_1:IMedia=null):void
        {
            throw (new MPFError("[AbstractFlashStreamConnector] 'updateConnection' method must be overridden in derived class.", MPFErrorCodes.ABSTRACT_METHOD_OVERRIDE));
        }

        public function get ns():NetStream
        {
            return (this._ns);
        }

        public function onBWDone():void
        {
            LogManager.getInstance().log("[AbstractFlashStreamConnector] onBWDone()");
        }

        protected function get ncUpdate():NetConnection
        {
            return (this._ncUpdate);
        }

        public function updateConnectionComplete():void
        {
            throw (new MPFError("[AbstractFlashStreamConnector] 'updateConnectionComplete' method must be overridden in derived class.", MPFErrorCodes.ABSTRACT_METHOD_OVERRIDE));
        }

        public function dispatchConnectionUpdateSuccess():void
        {
            dispatchEvent(new FlashConnectionEvent(FlashConnectionEvent.CONNECTION_UPDATE_SUCCESS, this.nsUpdate));
        }

        protected function get nsUpdate():NetStream
        {
            return (this._nsUpdate);
        }

        public function dispatchConnectionUpdateFailure():void
        {
            dispatchEvent(new FlashConnectionEvent(FlashConnectionEvent.CONNECTION_UPDATE_FAILURE, this.nsUpdate));
        }

        override public function dispatchConnectionSuccess():void
        {
            dispatchEvent(new FlashConnectionEvent(FlashConnectionEvent.CONNECTION_SUCCESS, this.ns));
        }

        public function closeNetStream():void
        {
            throw (new MPFError("[AbstractFlashStreamConnector] 'closeNetStream' method must be overridden in derived class.", MPFErrorCodes.ABSTRACT_METHOD_OVERRIDE));
        }

        public function get nc():NetConnection
        {
            return (this._nc);
        }

        override public function dispatchConnectionFailure():void
        {
            dispatchEvent(new FlashConnectionEvent(FlashConnectionEvent.CONNECTION_FAILURE, this.ns));
        }


    }
}//package com.disney.mpf.media.net
