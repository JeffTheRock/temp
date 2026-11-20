//Created by Action Script Viewer - https://www.buraks.com/asv
package com.asual.swfaddress
{
    import flash.utils.Timer;
    import flash.external.ExternalInterface;
    import flash.events.EventDispatcher;
    import flash.errors.IllegalOperationError;
    import flash.events.TimerEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.system.Capabilities;
    import flash.events.Event;

    public class SWFAddress 
    {

        private static var _init:Boolean = false;
        private static var _initChange:Boolean = false;
        private static var _initChanged:Boolean = false;
        private static var _strict:Boolean = true;
        private static var _autoUpdate:Boolean = true;
        private static var _updating:Boolean = false;
        private static var _value:String = "";
        private static var _queue:Array = new Array();
        private static var _queueTimer:Timer = new Timer(10);
        private static var _initTimer:Timer = new Timer(10);
        private static var _availability:Boolean = ExternalInterface.available;
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        public static var onInit:Function;
        public static var onChange:Function;
        private static var _initializer:Boolean = _initialize();

        public function SWFAddress()
        {
            throw (new IllegalOperationError("SWFAddress cannot be instantiated."));
        }

        private static function _initialize():Boolean
        {
            if (_availability)
            {
                try
                {
                    _availability = (ExternalInterface.call('function() { return (typeof SWFAddress != "undefined"); }') as Boolean);
                    ExternalInterface.addCallback("getSWFAddressValue", function ():String
                    {
                        return (_value);
                    });
                    ExternalInterface.addCallback("setSWFAddressValue", _setValue);
                }
                catch(e:Error)
                {
                    _availability = false;
                };
            };
            _queueTimer.addEventListener(TimerEvent.TIMER, _callQueue);
            _initTimer.addEventListener(TimerEvent.TIMER, _check);
            _initTimer.start();
            return (true);
        }

        private static function _check(_arg_1:TimerEvent):void
        {
            if ((((typeof(SWFAddress["onInit"]) == "function") || (_dispatcher.hasEventListener(SWFAddressEvent.INIT))) && (!(_init))))
            {
                _setValueInit(_getValue());
                _init = true;
            };
            if (((((typeof(SWFAddress["onChange"]) == "function") || (_dispatcher.hasEventListener(SWFAddressEvent.CHANGE))) || (typeof(SWFAddress["onExternalChange"]) == "function")) || (_dispatcher.hasEventListener(SWFAddressEvent.EXTERNAL_CHANGE))))
            {
                _initTimer.stop();
                _init = true;
                _setValueInit(_getValue());
            };
        }

        private static function _strictCheck(_arg_1:String, _arg_2:Boolean):String
        {
            if (SWFAddress.getStrict())
            {
                if (_arg_2)
                {
                    if (_arg_1.substr(0, 1) != "/")
                    {
                        _arg_1 = ("/" + _arg_1);
                    };
                }
                else
                {
                    if (_arg_1 == "")
                    {
                        _arg_1 = "/";
                    };
                };
            };
            return (_arg_1);
        }

        private static function _getValue():String
        {
            var _local_1:String;
            var _local_3:Array;
            var _local_2:String;
            if (_availability)
            {
                _local_1 = (ExternalInterface.call("SWFAddress.getValue") as String);
                _local_3 = (ExternalInterface.call("SWFAddress.getIds") as Array);
                if (_local_3 != null)
                {
                    _local_2 = _local_3.toString();
                };
            };
            if ((((_local_2 == null) || (!(_availability))) || (_initChanged)))
            {
                _local_1 = _value;
            }
            else
            {
                if (((_local_1 == "undefined") || (_local_1 == null)))
                {
                    _local_1 = "";
                };
            };
            return (_strictCheck(((_local_1) || ("")), false));
        }

        private static function _setValueInit(_arg_1:String):void
        {
            _value = _arg_1;
            if (!_init)
            {
                _dispatchEvent(SWFAddressEvent.INIT);
            }
            else
            {
                _dispatchEvent(SWFAddressEvent.CHANGE);
                _dispatchEvent(SWFAddressEvent.EXTERNAL_CHANGE);
            };
            _initChange = true;
        }

        private static function _setValue(_arg_1:String, _arg_2:Boolean):void
        {
            if (((_arg_1 == "undefined") || (_arg_1 == null)))
            {
                _arg_1 = "";
            };
            if (((_value == _arg_1) && (_init)))
            {
                return;
            };
            if (!_initChange)
            {
                return;
            };
            _value = _arg_1;
            if (!_init)
            {
                _init = true;
                if (((typeof(SWFAddress["onInit"]) == "function") || (_dispatcher.hasEventListener(SWFAddressEvent.INIT))))
                {
                    _dispatchEvent(SWFAddressEvent.INIT);
                };
            };
            _dispatchEvent(SWFAddressEvent.CHANGE);
            _dispatchEvent(((_arg_2) ? SWFAddressEvent.INTERNAL_CHANGE : SWFAddressEvent.EXTERNAL_CHANGE));
        }

        private static function _dispatchEvent(_arg_1:String):void
        {
            if (_dispatcher.hasEventListener(_arg_1))
            {
                _dispatcher.dispatchEvent(new SWFAddressEvent(_arg_1));
            };
            _arg_1 = (_arg_1.substr(0, 1).toUpperCase() + _arg_1.substring(1));
            if (typeof(SWFAddress[("on" + _arg_1)]) == "function")
            {
                var _local_2:* = SWFAddress;
                (_local_2[("on" + _arg_1)]());
            };
        }

        private static function _callQueue(_arg_1:TimerEvent):void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:Object;
            if (_queue.length != 0)
            {
                _local_2 = "";
                _local_3 = 0;
                while ((_local_4 = _queue[_local_3]))
                {
                    if ((_local_4.param is String))
                    {
                        _local_4.param = (('"' + _local_4.param) + '"');
                    };
                    _local_2 = (_local_2 + (((_local_4.fn + "(") + _local_4.param) + ");"));
                    _local_3++;
                };
                _queue = new Array();
                navigateToURL(new URLRequest((("javascript:" + _local_2) + "void(0);")), "_self");
            }
            else
            {
                _queueTimer.stop();
            };
        }

        private static function _call(_arg_1:String, _arg_2:Object=""):void
        {
            if (_availability)
            {
                if (Capabilities.os.indexOf("Mac") != -1)
                {
                    if (_queue.length == 0)
                    {
                        _queueTimer.start();
                    };
                    _queue.push({
                        "fn":_arg_1,
                        "param":_arg_2
                    });
                }
                else
                {
                    ExternalInterface.call(_arg_1, _arg_2);
                };
            };
        }

        public static function back():void
        {
            _call("SWFAddress.back");
        }

        public static function forward():void
        {
            _call("SWFAddress.forward");
        }

        public static function up():void
        {
            var _local_1:String = SWFAddress.getPath();
            SWFAddress.setValue(_local_1.substr(0, (_local_1.lastIndexOf("/", (_local_1.length - 2)) + ((_local_1.substr((_local_1.length - 1)) == "/") ? 1 : 0))));
        }

        public static function go(_arg_1:int):void
        {
            _call("SWFAddress.go", _arg_1);
        }

        public static function href(_arg_1:String, _arg_2:String="_self"):void
        {
            if (((_availability) && (Capabilities.playerType == "ActiveX")))
            {
                ExternalInterface.call("SWFAddress.href", _arg_1, _arg_2);
                return;
            };
            navigateToURL(new URLRequest(_arg_1), _arg_2);
        }

        public static function popup(_arg_1:String, _arg_2:String="popup", _arg_3:String='""', _arg_4:String=""):void
        {
            if (((_availability) && ((Capabilities.playerType == "ActiveX") || (ExternalInterface.call("asual.util.Browser.isSafari")))))
            {
                ExternalInterface.call("SWFAddress.popup", _arg_1, _arg_2, _arg_3, _arg_4);
                return;
            };
            navigateToURL(new URLRequest((((((((('javascript:popup=window.open("' + _arg_1) + '","') + _arg_2) + '",') + _arg_3) + ");") + _arg_4) + ";void(0);")), "_self");
        }

        public static function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _dispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public static function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _dispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public static function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_dispatcher.dispatchEvent(_arg_1));
        }

        public static function hasEventListener(_arg_1:String):Boolean
        {
            return (_dispatcher.hasEventListener(_arg_1));
        }

        public static function getBaseURL():String
        {
            var _local_1:String;
            if (_availability)
            {
                _local_1 = String(ExternalInterface.call("SWFAddress.getBaseURL"));
            };
            return ((((_local_1 == null) || (_local_1 == "null")) || (!(_availability))) ? "" : _local_1);
        }

        public static function getStrict():Boolean
        {
            var _local_1:String;
            if (_availability)
            {
                _local_1 = (ExternalInterface.call("SWFAddress.getStrict") as String);
            };
            return ((_local_1 == null) ? _strict : (_local_1 == "true"));
        }

        public static function setStrict(_arg_1:Boolean):void
        {
            _call("SWFAddress.setStrict", _arg_1);
            _strict = _arg_1;
        }

        public static function getAutoUpdate():Boolean
        {
            var _local_1:* = "null";
            if (_availability)
            {
                _local_1 = (ExternalInterface.call("SWFAddress.getAutoUpdate") as String);
            };
            return ((_local_1 == null) ? _autoUpdate : (_local_1 == "true"));
        }

        public static function setAutoUpdate(_arg_1:Boolean):void
        {
            _call("SWFAddress.setAutoUpdate", _arg_1);
            _autoUpdate = _arg_1;
        }

        public static function update():void
        {
            _updating = true;
            SWFAddress.setValue(_value);
            _call("SWFAddress.update");
            _updating = false;
        }

        public static function getHistory():Boolean
        {
            return ((_availability) ? (ExternalInterface.call("SWFAddress.getHistory") as Boolean) : false);
        }

        public static function setHistory(_arg_1:Boolean):void
        {
            _call("SWFAddress.setHistory", _arg_1);
        }

        public static function getTracker():String
        {
            return ((_availability) ? (ExternalInterface.call("SWFAddress.getTracker") as String) : "");
        }

        public static function setTracker(_arg_1:String):void
        {
            _call("SWFAddress.setTracker", _arg_1);
        }

        public static function getTitle():String
        {
            var _local_1:String = ((_availability) ? (ExternalInterface.call("SWFAddress.getTitle") as String) : "");
            if (((_local_1 == "undefined") || (_local_1 == null)))
            {
                _local_1 = "";
            };
            return (decodeURI(_local_1));
        }

        public static function setTitle(_arg_1:String):void
        {
            _call("SWFAddress.setTitle", encodeURI(decodeURI(_arg_1)));
        }

        public static function getStatus():String
        {
            var _local_1:String = ((_availability) ? (ExternalInterface.call("SWFAddress.getStatus") as String) : "");
            if (((_local_1 == "undefined") || (_local_1 == null)))
            {
                _local_1 = "";
            };
            return (decodeURI(_local_1));
        }

        public static function setStatus(_arg_1:String):void
        {
            _call("SWFAddress.setStatus", encodeURI(decodeURI(_arg_1)));
        }

        public static function resetStatus():void
        {
            _call("SWFAddress.resetStatus");
        }

        public static function getValue():String
        {
            return (decodeURI(_strictCheck(((_value) || ("")), false)));
        }

        public static function setValue(_arg_1:String):void
        {
            if (((_arg_1 == "undefined") || (_arg_1 == null)))
            {
                _arg_1 = "";
            };
            _arg_1 = encodeURI(decodeURI(_strictCheck(_arg_1, true)));
            if (((_value == _arg_1) && (!(_updating))))
            {
                return;
            };
            _value = _arg_1;
            _call("SWFAddress.setValue", _arg_1);
            if (_init)
            {
                if (((_autoUpdate) || (_updating)))
                {
                    _dispatchEvent(SWFAddressEvent.CHANGE);
                    _dispatchEvent(SWFAddressEvent.INTERNAL_CHANGE);
                };
            }
            else
            {
                _initChanged = true;
            };
        }

        public static function getPath():String
        {
            var _local_1:String = SWFAddress.getValue();
            if (_local_1.indexOf("?") != -1)
            {
                return (_local_1.split("?")[0]);
            };
            if (_local_1.indexOf("#") != -1)
            {
                return (_local_1.split("#")[0]);
            };
            return (_local_1);
        }

        public static function setPath(_arg_1:String):void
        {
            var _local_2:String = SWFAddress.getQueryString();
            SWFAddress.setValue((_arg_1 + ((_local_2) ? ("?" + _local_2) : "")));
        }

        public static function getPathNames():Array
        {
            var _local_1:String = SWFAddress.getPath();
            var _local_2:Array = _local_1.split("/");
            if (((_local_1.substr(0, 1) == "/") || (_local_1.length == 0)))
            {
                _local_2.splice(0, 1);
            };
            if (_local_1.substr((_local_1.length - 1), 1) == "/")
            {
                _local_2.splice((_local_2.length - 1), 1);
            };
            return (_local_2);
        }

        public static function getQueryString():String
        {
            var _local_1:String = SWFAddress.getValue();
            var _local_2:Number = _local_1.indexOf("?");
            if (((!(_local_2 == -1)) && (_local_2 < _local_1.length)))
            {
                return (_local_1.substr((_local_2 + 1)));
            };
            return (null);
        }

        public static function setQueryString(_arg_1:String):void
        {
            SWFAddress.setValue((SWFAddress.getPath() + ((_arg_1) ? ("?" + _arg_1) : "")));
        }

        public static function getParameter(_arg_1:String):Object
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:int;
            var _local_2:String = SWFAddress.getValue();
            var _local_3:Number = _local_2.indexOf("?");
            if (_local_3 != -1)
            {
                _local_2 = _local_2.substr((_local_3 + 1));
                _local_4 = _local_2.split("&");
                _local_6 = new Array();
                _local_7 = 0;
                while (_local_7 < _local_4.length)
                {
                    _local_5 = _local_4[_local_7].split("=");
                    if (_local_5[0] == _arg_1)
                    {
                        _local_6.push(_local_5[1]);
                    };
                    _local_7++;
                };
                if (_local_6.length != 0)
                {
                    return ((_local_6.length != 1) ? _local_6 : _local_6[0]);
                };
            };
            return (null);
        }

        public static function setParameter(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false):void
        {
            var _local_7:String;
            var _local_8:Object;
            var _local_9:Number;
            var _local_4:Array = SWFAddress.getParameterNames();
            var _local_5:Array = [];
            var _local_6:Number = 0;
            while (_local_6 < _local_4.length)
            {
                _local_7 = _local_4[_local_6];
                _local_8 = SWFAddress.getParameter(_local_7);
                if (typeof(_local_8) == "string")
                {
                    _local_8 = [_local_8];
                };
                if (_local_7 == _arg_1)
                {
                    _local_8 = (((_arg_2 === null) || (_arg_2 == "")) ? [] : ((_arg_3) ? _local_8.concat([_arg_2]) : [_arg_2]));
                };
                _local_9 = 0;
                while (_local_9 < _local_8.length)
                {
                    _local_5.push(((_local_7 + "=") + _local_8[_local_9]));
                    _local_9++;
                };
                _local_6++;
            };
            if (_local_4.indexOf(_arg_1) == -1)
            {
                _local_5.push(((_arg_1 + "=") + _arg_2));
            };
            SWFAddress.setQueryString(_local_5.join("&"));
        }

        public static function getParameterNames():Array
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_6:String;
            var _local_1:String = SWFAddress.getValue();
            var _local_2:Number = _local_1.indexOf("?");
            var _local_3:Array = new Array();
            if (_local_2 != -1)
            {
                _local_1 = _local_1.substr((_local_2 + 1));
                if (((!(_local_1 == "")) && (!(_local_1.indexOf("=") == -1))))
                {
                    _local_4 = _local_1.split("&");
                    _local_5 = 0;
                    while (_local_5 < _local_4.length)
                    {
                        _local_6 = _local_4[_local_5].split("=")[0];
                        if (_local_3.indexOf(_local_6) == -1)
                        {
                            _local_3.push(_local_6);
                        };
                        _local_5++;
                    };
                };
            };
            return (_local_3);
        }


    }
}//package com.asual.swfaddress
