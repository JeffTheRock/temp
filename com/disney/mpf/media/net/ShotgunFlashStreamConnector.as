//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import __AS3__.vec.Vector;
    import flash.utils.Timer;
    import flash.net.NetConnection;
    import flash.events.TimerEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.AsyncErrorEvent;
    import com.disney.utils.logging.LogManager;
    import com.disney.mpf.errors.events.MPFErrorEvent;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.media.decorator.MediaObject;
    import com.disney.mpf.media.utils.ProtocolTypes;
    import com.disney.mpf.media.model.IMedia;
    import flash.net.DynamicStream;
    import flash.net.NetStream;
    import com.disney.mpf.media.utils.MediaFormats;
    import com.disney.mpf.media.net.events.ConnectionEvent;
    import __AS3__.vec.*;

    public class ShotgunFlashStreamConnector extends AbstractFlashStreamConnector implements IDynamicStreamConnector 
    {

        public static const DEFAULT_PORTS:String = "1935,80,443";
        public static const DEFAULT_PROTOCOLS_FOR_RTMP:String = (DEFAULT_PROTOCOLS + ",rtmps");
        public static const DEFAULT_PROTOCOLS_FOR_RTMPE:String = "rtmpe,rtmpte";
        public static const DEFAULT_PROTOCOLS_ALL:String = ((DEFAULT_PROTOCOLS_FOR_RTMP + ",") + DEFAULT_PROTOCOLS_FOR_RTMPE);
        public static const DEFAULT_PROTOCOLS:String = "rtmp,rtmpt";
        protected static const DEFAULT_TIMEOUT:Number = 10000;
        public static var connectionTimeout:Number = DEFAULT_TIMEOUT;//10000
        protected static var _ports:Vector.<String> = new Vector.<String>();
        protected static var _protocols:Vector.<String> = new Vector.<String>();

        protected var _timer:Timer;
        protected var _connectionSuccess:Boolean = false;
        protected var _fails:int;
        protected var _netConnections:Vector.<NetConnection>;

        public function ShotgunFlashStreamConnector()
        {
            this._fails = 0;
            this._netConnections = new Vector.<NetConnection>();
            this._timer = new Timer(connectionTimeout);
            this._timer.addEventListener(TimerEvent.TIMER, this.onConnectionTimeout, false, 0, true);
            if (((!(ports)) || (ports.length == 0)))
            {
                ports = DEFAULT_PORTS;
            };
            if (((!(protocols)) || (protocols.length == 0)))
            {
                protocols = DEFAULT_PROTOCOLS;
            };
        }

        public static function set ports(_arg_1:String):void
        {
            var _local_3:String;
            var _local_2:Array = _arg_1.split(",");
            _ports.splice(0, _ports.length);
            for each (_local_3 in _local_2)
            {
                _ports.push(_local_3);
            };
        }

        public static function get ports():String
        {
            return (_ports.join(","));
        }

        public static function set protocols(_arg_1:String):void
        {
            var _local_3:String;
            var _local_2:Array = _arg_1.split(",");
            _protocols.splice(0, _protocols.length);
            for each (_local_3 in _local_2)
            {
                _protocols.push(_local_3);
            };
        }

        public static function get protocols():String
        {
            return (_protocols.join(","));
        }


        protected function createNC():NetConnection
        {
            var _local_1:NetConnection = new NetConnection();
            _local_1.client = this;
            _local_1.addEventListener(NetStatusEvent.NET_STATUS, this.onConnect, false, 0, true);
            _local_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onNetSecurityError, false, 0, true);
            _local_1.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError, false, 0, true);
            return (_local_1);
        }

        override public function destroy():void
        {
            _media = null;
            this.destroyUnusedNetConnections();
            this.close();
            super.destroy();
        }

        protected function setActiveNetConnection(_arg_1:NetConnection):void
        {
            this._connectionSuccess = true;
            _arg_1.removeEventListener(NetStatusEvent.NET_STATUS, this.onConnect);
            _arg_1.addEventListener(NetStatusEvent.NET_STATUS, this.ncMonitor, false, 0, true);
            this._netConnections.splice(this._netConnections.indexOf(_arg_1), 1);
            if (this._timer.running)
            {
                this._timer.reset();
            };
            this.destroyUnusedNetConnections();
        }

        protected function onConnectionTimeout(_arg_1:TimerEvent):void
        {
            LogManager.getInstance().log("[ShotgunFlashStreamConnector] ShotgunFlashStreamConnector timed out before successful connection", LogManager.ERROR);
            dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NET_CONNECTION_TIMEOUT, "ShotgunFlashStreamConnector timed out before successful connection"));
            dispatchConnectionFailure();
            this.destroyUnusedNetConnections();
        }

        override public function updateConnection(_arg_1:IMedia=null):void
        {
            var _local_3:NetConnection;
            if (_arg_1)
            {
                _media = _arg_1;
            };
            this._fails = 0;
            _ucState = true;
            var _local_2:URL = ((MediaObject(_media).protocol == ProtocolTypes.STREAMING) ? new URL(_media.url) : null);
            this.destroyUnusedNetConnections();
            if (_local_2)
            {
                this.connectShotgunConnections(_local_2);
            }
            else
            {
                _local_3 = this.createNC();
                _local_3.connect(null);
                this.initializeUpdateConnectionSuccess(_local_3);
            };
        }

        protected function destroyUnusedNetConnections():void
        {
            var _local_3:NetConnection;
            var _local_1:int = this._netConnections.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = this._netConnections.pop();
                _local_3.removeEventListener(NetStatusEvent.NET_STATUS, this.onConnect);
                _local_3.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onNetSecurityError);
                _local_3.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
                _local_3.close();
                _local_2++;
            };
            if (this._timer.running)
            {
                this._timer.reset();
            };
        }

        protected function onNetSecurityError(_arg_1:SecurityErrorEvent):void
        {
            LogManager.getInstance().log((("[ShotgunFlashStreamConnector] SecurityErrorEvent code[" + _arg_1.text) + "]"));
            dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NET_CONNECTION_SECURITY_ERROR, (("[ShotgunFlashStreamConnector] SecurityErrorEvent code[" + _arg_1.text) + "]")));
        }

        protected function onConnect(_arg_1:NetStatusEvent):void
        {
            var _local_2:NetConnection = NetConnection(_arg_1.target);
            switch (_arg_1.info.code)
            {
                case "NetConnection.Connect.Success":
                    if (((!(_nc)) && (!(_ucState))))
                    {
                        this.initializeConnection(_local_2);
                    }
                    else
                    {
                        if (((_ucState) && (!(_ncUpdate))))
                        {
                            this.initializeUpdateConnectionSuccess(_local_2);
                        }
                        else
                        {
                            this.destroyUnusedNetConnections();
                        };
                    };
                    break;
                case "NetConnection.Connect.Failed":
                case "NetConnection.Connect.Rejected":
                case "NetConnection.Connect.Closed":
                default:
                    this._fails++;
                    if (this._fails >= this._netConnections.length)
                    {
                        if (!this._connectionSuccess)
                        {
                            if (_ucState)
                            {
                                this.dispatchErrorEvent(_arg_1.info.code, NetConnection(_arg_1.target).uri);
                                dispatchConnectionUpdateFailure();
                            }
                            else
                            {
                                this.dispatchErrorEvent(_arg_1.info.code, NetConnection(_arg_1.target).uri);
                                dispatchConnectionFailure();
                            };
                        };
                        this.destroyUnusedNetConnections();
                    };
            };
            LogManager.getInstance().log(((("[ShotgunFlashStreamConnector] NetStatusEvent code[" + _arg_1.info.code) + "] - ") + _local_2.uri));
        }

        protected function ncMonitor(_arg_1:NetStatusEvent):void
        {
            switch (_arg_1.info.code)
            {
                case "NetConnection.Connect.Failed":
                case "NetConnection.Connect.Rejected":
                case "NetConnection.Connect.Closed":
                    this.dispatchErrorEvent(_arg_1.info.code, NetConnection(_arg_1.target).uri);
                    dispatchConnectionFailure();
                    this.close();
                    return;
            };
        }

        protected function initializeConnection(_arg_1:NetConnection):void
        {
            _nc = _arg_1;
            this.setActiveNetConnection(_nc);
            this.newNetStream();
            dispatchConnectionSuccess();
        }

        protected function getConnectionURLs(_arg_1:URL):Vector.<URL>
        {
            var _local_4:String;
            var _local_5:String;
            var _local_2:Vector.<URL> = new Vector.<URL>();
            var _local_3:String = ((_arg_1.query != null) ? _arg_1.query.source : null);
            if (_arg_1.protocol)
            {
                if (_protocols.indexOf(_arg_1.protocol) == -1)
                {
                    _protocols.push(_arg_1.protocol);
                };
                _local_2.push(this.buildConnectionURL(_arg_1.protocol, _arg_1.host, _arg_1.port, _arg_1.path, _local_3));
            };
            for each (_local_4 in _ports)
            {
                for each (_local_5 in _protocols)
                {
                    _local_2.push(this.buildConnectionURL(_local_5, _arg_1.host, _local_4, _arg_1.path, _local_3));
                };
            };
            return (_local_2);
        }

        protected function dispatchErrorEvent(_arg_1:String, _arg_2:String):void
        {
            switch (_arg_1)
            {
                case "NetConnection.Connect.Failed":
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NET_CONNECTION_FAILED, ((_arg_2 + ":") + _arg_1)));
                    return;
                case "NetConnection.Connect.Rejected":
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NET_CONNECTION_REJECTED, ((_arg_2 + ":") + _arg_1)));
                    return;
                case "NetConnection.Connect.Closed":
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NET_CONNECTION_CLOSED, ((_arg_2 + ":") + _arg_1)));
                    return;
            };
        }

        public function get ds():DynamicStream
        {
            return ((_ns) ? (_ns as DynamicStream) : null);
        }

        protected function newNetStream():void
        {
            this.closeNetStream();
            _ns = this.createNetStream(_nc);
        }

        override public function updateConnectionComplete():void
        {
            if (_nc)
            {
                _nc.removeEventListener(NetStatusEvent.NET_STATUS, this.ncMonitor);
                if (_nc.connected)
                {
                    _nc.close();
                };
            };
            _ncUpdate.removeEventListener(NetStatusEvent.NET_STATUS, this.ncMonitor);
            _nc = _ncUpdate;
            _nc.addEventListener(NetStatusEvent.NET_STATUS, this.ncMonitor);
            _ncUpdate = null;
            if (_ns)
            {
                _ns.close();
            };
            _ns = _nsUpdate;
            _nsUpdate = null;
            _ucState = false;
        }

        protected function createNetStream(_arg_1:NetConnection):NetStream
        {
            var _local_2:NetStream;
            switch (_media.format.toLowerCase())
            {
                case MediaFormats.FLV:
                    _local_2 = new NetStream(_arg_1);
                    break;
                case MediaFormats.MBR:
                    _local_2 = new DynamicStream(_arg_1);
                    break;
                default:
                    LogManager.getInstance().log("[ShotgunFlashStreamConnector] ShotgunFlashStreamConnector only supports FLV and MBR formats", LogManager.ERROR);
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.UNSUPPORTED_FORMAT, "ShotgunFlashStreamConnector only supports FLV and MBR formats"));
            };
            return (_local_2);
        }

        protected function buildConnectionURL(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String):URL
        {
            var _local_6:String = (((!(_arg_5 == null)) && (_arg_5.length > 1)) ? ((_arg_4 + "?") + _arg_5) : _arg_4);
            var _local_7:String = (((!(_arg_3 == null)) && (_arg_3.length > 1)) ? (":" + _arg_3) : "");
            var _local_8:URL = new URL((((((_arg_1 + "://") + _arg_2) + _local_7) + "/") + _local_6));
            return (_local_8);
        }

        protected function initializeUpdateConnectionSuccess(_arg_1:NetConnection):void
        {
            _ncUpdate = _arg_1;
            this.setActiveNetConnection(_ncUpdate);
            this.updateNetStream();
            dispatchConnectionUpdateSuccess();
        }

        override public function connect(_arg_1:IMedia):void
        {
            var _local_4:NetConnection;
            var _local_2:Boolean;
            _media = _arg_1;
            this._fails = 0;
            _ucState = false;
            var _local_3:URL = ((MediaObject(_media).protocol == ProtocolTypes.STREAMING) ? new URL(_media.url) : null);
            this.destroyUnusedNetConnections();
            if (_nc)
            {
                if ((((_local_3) && (_nc.connected)) && (_local_3.source == _nc.uri)))
                {
                    _local_2 = true;
                    this.newNetStream();
                    _nc.addEventListener(NetStatusEvent.NET_STATUS, this.ncMonitor, false, 0, true);
                    dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_SUCCESS));
                };
            };
            if (!_local_2)
            {
                this.close();
                if (_local_3)
                {
                    this.connectShotgunConnections(_local_3);
                }
                else
                {
                    _local_4 = this.createNC();
                    _local_4.connect(null);
                    this.initializeConnection(_local_4);
                };
            };
        }

        protected function onAsyncError(_arg_1:AsyncErrorEvent):void
        {
            LogManager.getInstance().log((("[ShotgunFlashStreamConnector] AsyncErrorEvent code[" + _arg_1.text) + "]"));
            dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.NET_CONNECTION_ASYNC_ERROR, (("[ShotgunFlashStreamConnector] AsyncErrorEvent code[" + _arg_1.text) + "]")));
        }

        override public function closeNetStream():void
        {
            if (_ns)
            {
                _ns.close();
                _ns = null;
            };
            if (((_nsUpdate) && (!(_ucState))))
            {
                _nsUpdate.close();
                _nsUpdate = null;
            };
        }

        protected function connectShotgunConnections(_arg_1:URL):void
        {
            var _local_3:URL;
            var _local_4:NetConnection;
            var _local_2:Vector.<URL> = this.getConnectionURLs(_arg_1);
            for each (_local_3 in _local_2)
            {
                _local_4 = this.createNC();
                this._netConnections.push(_local_4);
                _local_4.connect(_local_3.source);
            };
            this._timer.start();
        }

        protected function updateNetStream():void
        {
            _nsUpdate = this.createNetStream(_ncUpdate);
        }

        override public function close():void
        {
            this._connectionSuccess = false;
            this.closeNetStream();
            if (_nc)
            {
                _nc.removeEventListener(NetStatusEvent.NET_STATUS, this.ncMonitor);
                _nc.removeEventListener(NetStatusEvent.NET_STATUS, this.onConnect);
                _nc.close();
                _nc = null;
            };
            if (_ncUpdate)
            {
                _ncUpdate.removeEventListener(NetStatusEvent.NET_STATUS, this.ncMonitor);
                _ncUpdate.removeEventListener(NetStatusEvent.NET_STATUS, this.onConnect);
                _ncUpdate.close();
                _ncUpdate = null;
            };
        }


    }
}//package com.disney.mpf.media.net
