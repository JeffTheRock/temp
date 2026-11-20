//Created by Action Script Viewer - https://www.buraks.com/asv
package com.omniture
{
    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.net.sendToURL;
    import flash.utils.setInterval;
    import flash.external.ExternalInterface;
    import flash.net.SharedObject;
    import flash.net.ObjectEncoding;
    import flash.system.Capabilities;
    import flash.utils.clearInterval;
    import flash.events.Event;
    import flash.utils.getQualifiedClassName;

    public dynamic class ActionSource extends Sprite 
    {

        public var ssl:Boolean;
        public var account:String;
        public var _movie:Object;
        private var delayTrackingInterval:Number;
        public var movieID:String;
        private var _moduleMediaVariables:Object;
        public var pageURL:String;
        public var otherVariables:Object;
        private var requestNum:Number;
        public var dc:String;
        public var visitorNamespace:String;
        public var mobile:Boolean;
        public var flashVersion:Number;
        public var trackingServerBase:String;
        public var version:String;
        public var trackingServer:String;
        public var ClickMap:ActionSource_Module_ClickMap;
        public var autoTrack:Boolean;
        private var bufferTrackQueue:Array;
        public var trackingServerSecure:String;
        private var flashRoot:Object;
        private var accountConfigList:Array;
        public var lastRequest:String;
        public var trackClickMap:Boolean;
        public var charSet:String;
        private var _configURL:String;
        public var delayTracking:Number;
        private var configXML:ActionSource_XML;
        private var accountVarList:Array;
        private var trackOnLoadInterval:Number;
        public var pageName:String;
        private var _root:Object;
        private var requiredVarList:Array;
        private var delayTrackingStage:Number;
        public var requestList:Array;
        public var Media:ActionSource_Module_Media;
        private var externalVariables:Object;

        public var flashASVersion:Number = 3;
        private var flashLivePreview:Boolean = false;
        public var trackLocal:Boolean = true;
        public var debugTracking:Boolean = false;
        private var _useExternalVariables:Boolean = false;
        private var _trackOnLoad:Boolean = false;
        private var onLoadTracked:Boolean = false;
        private var bufferTrackInterval:Number = 0;
        private var trackCalled:Boolean = false;

        public function ActionSource()
        {
            var _local_1:Object;
            var _local_2:Number;
            var _local_3:String;
            var _local_4:Array;
            super();
            _local_1 = this;
            _local_1.version = "FAS-2.8";
            _local_3 = getVersion();
            _local_4 = _local_3.split(" ");
            _local_1.flashVersion = parseInt(_local_4[1].substr(0, 1));
            _local_1.initPre();
            _local_1.requestNum = 0;
            _local_1.requestList = new Array();
            _local_1.lastRequest = "";
            _local_1.requiredVarList = ["dynamicVariablePrefix", "visitorID", "vmk", "visitorMigrationKey", "visitorMigrationServer", "visitorMigrationServerSecure", "charSet", "visitorNamespace", "cookieDomainPeriods", "cookieLifetime", "pageName", "pageURL", "referrer", "currencyCode"];
            _local_1.accountVarList = ["purchaseID", "variableProvider", "channel", "server", "pageType", "transactionID", "campaign", "state", "zip", "events", "products", "tnt"];
            _local_2 = (_local_1.requiredVarList.length - 1);
            while (_local_2 >= 0)
            {
                _local_1.accountVarList.unshift(_local_1.requiredVarList[_local_2]);
                _local_2--;
            };
            _local_2 = 1;
            while (_local_2 <= 50)
            {
                _local_1.accountVarList.push(("prop" + _local_2));
                _local_1.accountVarList.push(("eVar" + _local_2));
                _local_1.accountVarList.push(("hier" + _local_2));
                _local_1.accountVarList.push(("list" + _local_2));
                _local_2++;
            };
            _local_1.accountVarList.push("pe");
            _local_1.accountVarList.push("pev1");
            _local_1.accountVarList.push("pev2");
            _local_1.accountVarList.push("pev3");
            _local_1.requiredVarList.push("pe");
            _local_1.requiredVarList.push("pev1");
            _local_1.requiredVarList.push("pev2");
            _local_1.requiredVarList.push("pev3");
            _local_1.accountConfigList = ["account", "configURL", "linkObject", "linkURL", "linkName", "linkType", "trackDownloadLinks", "trackExternalLinks", "trackClickMap", "linkLeaveQueryString", "linkTrackVars", "linkTrackEvents", "trackingServer", "trackingServerSecure", "dc", "movieID", "autoTrack", "delayTracking", "trackLocal", "debugTracking"];
            _local_1.modulesInit();
            _local_1.setupInterval(_local_1, "setVariableCallHandler", 1000, null);
            _local_1.initPost();
        }

        public function clearVars():*
        {
            var _local_1:Object;
            var _local_2:Number;
            var _local_3:String;
            _local_1 = this;
            _local_2 = 0;
            while (_local_2 < accountVarList.length)
            {
                _local_3 = _local_1.accountVarList[_local_2];
                if (((((((((((((_local_3.substr(0, 4) == "prop") || (_local_3.substr(0, 4) == "eVar")) || (_local_3.substr(0, 4) == "hier")) || (_local_3.substr(0, 4) == "list")) || (_local_3 == "channel")) || (_local_3 == "events")) || (_local_3 == "purchaseID")) || (_local_3 == "transactionID")) || (_local_3 == "products")) || (_local_3 == "state")) || (_local_3 == "zip")) || (_local_3 == "campaign")))
                {
                    _local_1[_local_3] = undefined;
                };
                _local_2++;
            };
        }

        private function updateExternalVariables():*
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:Array;
            var _local_4:Number;
            var _local_5:Array;
            var _local_6:String;
            var _local_7:Object;
            var _local_8:String;
            var _local_9:String;
            var _local_10:Object;
            _local_1 = this;
            _local_6 = "";
            _local_1.externalVariables = new Object();
            _local_2 = _local_1.getMovieClipURL(_local_1);
            if (_local_1.isSet(_local_2))
            {
                _local_3 = _local_2.split("?");
                _local_6 = (_local_6 + ("&" + _local_3[1]));
            };
            if (_local_1.isSet(_local_1, "parent"))
            {
                _local_2 = _local_1.getMovieClipURL(_local_1.parent);
                if (_local_1.isSet(_local_2))
                {
                    _local_3 = _local_2.split("?");
                    _local_6 = (_local_6 + ("&" + _local_3[1]));
                };
            }
            else
            {
                if (_local_1.isSet(_local_1, "_parent"))
                {
                    _local_2 = _local_1.getMovieClipURL(_local_1._parent);
                    if (_local_1.isSet(_local_2))
                    {
                        _local_3 = _local_2.split("?");
                        _local_6 = (_local_6 + ("&" + _local_3[1]));
                    };
                };
            };
            if (_local_1.isSet(_local_1.movie))
            {
                _local_2 = _local_1.getMovieClipURL(_local_1.movie);
                if (_local_1.isSet(_local_2))
                {
                    _local_3 = _local_2.split("?");
                    _local_6 = (_local_6 + ("&" + _local_3[1]));
                };
            };
            if (_local_1.isSet(_local_6))
            {
                _local_3 = _local_6.split("&");
                _local_4 = 0;
                while (_local_4 < _local_3.length)
                {
                    _local_5 = _local_3[_local_4].split("=");
                    _local_8 = _local_5[0];
                    if (((_local_8.substr(0, 2) == "s_") || (_local_8.substr(0, 2) == "s.")))
                    {
                        _local_8 = _local_8.substr(2);
                        _local_9 = unescape(_local_5[1]);
                        _local_1.externalVariables[_local_8] = _local_9;
                    };
                    _local_4++;
                };
            };
            if (_local_1.isSet(_local_1.movie))
            {
                _local_7 = _local_1.movie;
                if (_local_1.flashASVersion >= 3)
                {
                    if (((_local_1.isSet(_local_1.movie, "loaderInfo")) && (_local_1.isSet(_local_1.movie.loaderInfo, "parameters"))))
                    {
                        _local_7 = _local_1.movie.loaderInfo.parameters;
                    };
                };
                for (_local_8 in _local_7)
                {
                    if ((((_local_8.substr(0, 2) == "s_") || (_local_8.substr(0, 2) == "s.")) && ((typeof(_local_7[_local_8]) == "string") || (typeof(_local_7[_local_8]) == "boolean"))))
                    {
                        _local_9 = _local_7[_local_8];
                        _local_8 = _local_8.substr(2);
                        _local_1.externalVariables[_local_8] = _local_9;
                    };
                };
            };
            if (_local_1.isSet(_local_1.useExternalVariables))
            {
                _local_1.variableOverridesApply(_local_1.externalVariables);
            };
        }

        private function flushRequestList():*
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:Array;
            var _local_4:Number;
            _local_1 = this;
            while (_local_1.requestNum < _local_1.requestList.length)
            {
                if (_local_1.isSet(_local_1.debugTracking))
                {
                    _local_2 = ("ActionSource Debug: " + _local_1.requestList[_local_1.requestNum]);
                    _local_3 = _local_1.requestList[_local_1.requestNum].split("&");
                    _local_4 = 0;
                    while (_local_4 < _local_3.length)
                    {
                        _local_2 = (_local_2 + ("\n\t" + unescape(_local_3[_local_4])));
                        _local_4++;
                    };
                    _local_1.logDebug(_local_2);
                };
                _local_1.requestURL(_local_1.requestList[_local_1.requestNum]);
                _local_1.lastRequest = _local_1.requestList[_local_1.requestNum];
                _local_1.requestNum++;
            };
        }

        private function bufferRequest(_arg_1:String, _arg_2:String, _arg_3:String):*
        {
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:Object;
            var _local_7:Number;
            var _local_8:Number;
            _local_4 = this;
            _local_5 = _local_4.getBufferedRequests();
            if (_local_4.isSet(_local_5))
            {
                if (!_local_4.isSet(_local_5.data))
                {
                    _local_5.data = new Object();
                };
                if (!_local_4.isSet(_local_5.data.list))
                {
                    _local_5.data.list = new Array();
                };
                _local_8 = -1;
                _local_7 = 0;
                while (_local_7 < _local_5.data.list.length)
                {
                    if (_local_5.data.list[_local_7].id == _arg_2)
                    {
                        _local_5.data.list[_local_7].request = _arg_3;
                        _arg_3 = "";
                    }
                    else
                    {
                        if (!_local_4.isSet(_local_5.data.list[_local_7].id))
                        {
                            _local_8 = _local_7;
                        };
                    };
                    _local_7++;
                };
                if (_local_4.isSet(_arg_3))
                {
                    _local_6 = new Object();
                    _local_6.account = _arg_1;
                    _local_6.id = _arg_2;
                    _local_6.request = _arg_3;
                    if (_local_8 >= 0)
                    {
                        _local_5.data.list[_local_8] = _local_6;
                    }
                    else
                    {
                        _local_5.data.list.push(_local_6);
                    };
                };
                _local_5.flush();
            };
        }

        private function variableOverridesBuild(_arg_1:Object, _arg_2:Boolean):*
        {
            var _local_3:Object;
            var _local_4:Number;
            var _local_5:String;
            _local_3 = this;
            _local_4 = 0;
            while (_local_4 < _local_3.accountVarList.length)
            {
                _local_5 = _local_3.accountVarList[_local_4];
                if (!_local_3.isSet(_arg_1[_local_5]))
                {
                    _arg_1[_local_5] = _local_3[_local_5];
                    if (((!(_arg_2)) && (!(_local_3.isSet(_arg_1[_local_5])))))
                    {
                        _arg_1[("!" + _local_5)] = 1;
                    };
                };
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < _local_3.accountConfigList.length)
            {
                _local_5 = _local_3.accountConfigList[_local_4];
                if (!_local_3.isSet(_arg_1[_local_5]))
                {
                    _arg_1[_local_5] = _local_3[_local_5];
                    if (((!(_arg_2)) && (!(_local_3.isSet(_arg_1[_local_5])))))
                    {
                        _arg_1[("!" + _local_5)] = 1;
                    };
                };
                _local_4++;
            };
        }

        public function set useExternalVariables(_arg_1:Boolean):*
        {
            this._useExternalVariables = _arg_1;
            if (this.isSet(this._useExternalVariables))
            {
                this.updateExternalVariables();
            };
        }

        private function requestURL(_arg_1:*):*
        {
            var _local_2:URLRequest;
            _local_2 = new URLRequest(_arg_1);
            sendToURL(_local_2);
        }

        public function setupInterval(_arg_1:Object, _arg_2:String, _arg_3:Number, _arg_4:*):*
        {
            if (_arg_4 != null)
            {
                return (setInterval(_arg_1[_arg_2], _arg_3, _arg_4));
            };
            return (setInterval(_arg_1[_arg_2], _arg_3));
        }

        private function _trackLink(_arg_1:*, _arg_2:String, _arg_3:String, _arg_4:Object):*
        {
            var _local_5:Object;
            var _local_6:String;
            _local_5 = this;
            if (((_local_5.isSet(_arg_1)) && (typeof(_arg_1) == "string")))
            {
                _local_6 = _arg_1;
                _arg_1 = new Object();
                _arg_1.url = _local_6;
            };
            _local_5.linkObject = _arg_1;
            _local_5.linkType = _arg_2;
            _local_5.linkName = _arg_3;
            _local_5.track(_arg_4);
        }

        public function set movie(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:String;
            _local_2 = this;
            _local_2._movie = _arg_1;
            if (!_local_2.flashLivePreview)
            {
                _local_3 = _local_2.getMovieURL();
                _local_2.ssl = (_local_3.toLowerCase().substr(0, 6) == "https:");
                if (_local_2.isSet(_local_2._movie))
                {
                    if (_local_2.flashASVersion < 3)
                    {
                        _local_2._movie.s_s = this;
                    };
                    _local_2.updateExternalVariables();
                    _local_2.modulesUpdate();
                };
            };
        }

        private function queryStringLinkTracking():String
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:String;
            var _local_8:String;
            var _local_9:Number;
            _local_1 = this;
            _local_2 = _local_1.linkType;
            _local_3 = _local_1.linkURL;
            _local_4 = _local_1.linkName;
            _local_8 = "";
            if (((!(_local_1.isSet(_local_3))) && (_local_1.isSet(_local_1.linkObject))))
            {
                if (_local_1.isSet(_local_1.linkObject, "url"))
                {
                    _local_3 = _local_1.linkObject.url;
                }
                else
                {
                    if (_local_1.isSet(_local_1.linkObject, "URL"))
                    {
                        _local_3 = _local_1.linkObject.URL;
                    }
                    else
                    {
                        if (_local_1.isSet(_local_1.linkObject, "href"))
                        {
                            _local_3 = _local_1.linkObject.href;
                        }
                        else
                        {
                            if (_local_1.isSet(_local_1.linkObject, "HREF"))
                            {
                                _local_3 = _local_1.linkObject.HREF;
                            }
                            else
                            {
                                if (_local_1.isSet(_local_1.linkObject, "htmlText"))
                                {
                                    _local_5 = _local_1.linkObject.htmlText.toLowerCase().indexOf("href=");
                                    if (_local_5 >= 0)
                                    {
                                        _local_5 = (_local_5 + 5);
                                        _local_7 = _local_1.linkObject.htmlText.substr(_local_5, 1);
                                        if (((_local_7 == '"') || (_local_7 == "'")))
                                        {
                                            _local_5++;
                                            _local_6 = _local_1.linkObject.htmlText.toLowerCase().indexOf(_local_7, _local_5);
                                            if (_local_6 >= 0)
                                            {
                                                if (--_local_6 > _local_5)
                                                {
                                                    _local_3 = _local_1.linkObject.htmlText.substr(_local_5, ((_local_6 - _local_5) + 1));
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (((_local_1.isSet(_local_2)) && ((_local_1.isSet(_local_3)) || (_local_1.isSet(_local_4)))))
            {
                _local_2 = _local_2.toLowerCase();
                if (((!(_local_2 == "d")) && (!(_local_2 == "e"))))
                {
                    _local_2 = "o";
                };
                if (((_local_1.isSet(_local_3)) && (!(_local_1.isSet(_local_1.linkLeaveQueryString)))))
                {
                    _local_9 = _local_3.indexOf("?");
                    if (_local_9 >= 0)
                    {
                        _local_3 = _local_3.substr(0, _local_9);
                    };
                };
                _local_8 = (_local_8 + ("&pe=lnk_" + escape(_local_2)));
                _local_8 = (_local_8 + ((_local_1.isSet(_local_3)) ? ("&pev1=" + escape(_local_3)) : ""));
                _local_8 = (_local_8 + ((_local_1.isSet(_local_4)) ? ("&pev2=" + escape(_local_4)) : ""));
            };
            return (_local_8);
        }

        private function _track(_arg_1:Object, _arg_2:String):*
        {
            var _local_3:Object;
            var _local_4:Boolean;
            var _local_5:Object;
            var _local_6:Date;
            var _local_7:Number;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_11:Number;
            var _local_12:String;
            _local_3 = this;
            _local_6 = new Date();
            _local_7 = Math.floor((Math.random() * 10000000000000));
            _local_8 = (("s" + (Math.floor((_local_6.getTime() / 10800000)) % 10)) + _local_7);
            _local_9 = ((((((((((((((("" + _local_6.getDate()) + "/") + _local_6.getMonth()) + "/") + _local_6.getFullYear()) + " ") + _local_6.getHours()) + ":") + _local_6.getMinutes()) + ":") + _local_6.getSeconds()) + " ") + _local_6.getDay()) + " ") + _local_6.getTimezoneOffset());
            _local_10 = ("t=" + escape(_local_9));
            if (_local_3.isSet(_local_3.flashLivePreview))
            {
                return;
            };
            if (_local_3.isSet(_local_3.otherVariables))
            {
                _local_11 = 0;
                while (_local_11 < _local_3.accountVarList.length)
                {
                    _local_12 = _local_3.accountVarList[_local_11];
                    if (_local_3.isSet(_local_3.otherVariables[_local_12]))
                    {
                        _local_3[_local_12] = _local_3.otherVariables[_local_12];
                    };
                    _local_11++;
                };
                _local_11 = 0;
                while (_local_11 < _local_3.accountConfigList.length)
                {
                    _local_12 = _local_3.accountConfigList[_local_11];
                    if (_local_3.isSet(_local_3.otherVariables[_local_12]))
                    {
                        _local_3[_local_12] = _local_3.otherVariables[_local_12];
                    };
                    _local_11++;
                };
            };
            _local_4 = _local_3.bufferTrack(_arg_1, _arg_2);
            if (!_local_4)
            {
                if (_local_3.isSet(_arg_1))
                {
                    _local_5 = new Object();
                    _local_3.variableOverridesBuild(_local_5, false);
                    _local_3.variableOverridesApply(_arg_1);
                };
                if (((_local_3.isSet(_local_3.usePlugins)) && (_local_3.isSet(_local_3.doPlugins))))
                {
                    _local_3.doPlugins(_local_3);
                };
                if (_local_3.isSet(_local_3.account))
                {
                    if (!_local_3.isSet(_local_3.pageURL))
                    {
                        _local_3.pageURL = _local_3.getMovieURL();
                    };
                    if (((!(_local_3.isSet(_local_3.referrer))) && (!(_local_3.isSet(_local_3._1_referrer)))))
                    {
                        _local_3.referrer = _local_3.getMovieReferrer();
                        _local_3._1_referrer = 1;
                    };
                    _local_10 = (_local_10 + _local_3.queryStringAccountVariables());
                    _local_10 = (_local_10 + _local_3.queryStringLinkTracking());
                    _local_10 = (_local_10 + _local_3.queryStringClickMap());
                    _local_10 = (_local_10 + _local_3.queryStringTechnology());
                    _local_3.makeRequest(_local_8, _local_10, "", _arg_2);
                };
                if (_local_3.isSet(_arg_1))
                {
                    _local_3.variableOverridesApply(_local_5);
                };
            };
            _local_3.referrer = undefined;
            _local_3.pe = undefined;
            _local_3.pev1 = undefined;
            _local_3.pev2 = undefined;
            _local_3.pev3 = undefined;
            _local_3.linkObject = undefined;
            _local_3.linkURL = undefined;
            _local_3.linkName = undefined;
            _local_3.linkType = undefined;
            _local_3.objectID = undefined;
            if (((!(_local_4)) && (_local_3.isSet(_local_3.account))))
            {
                if (((!(_local_3.isSet(_arg_2))) && (!(_local_3.isSet(_local_3.trackCalled)))))
                {
                    _local_3.trackCalled = true;
                    _local_3.flushBufferedRequests();
                };
            };
        }

        public function get trackOnLoad():Boolean
        {
            return (this._trackOnLoad);
        }

        private function callJavaScript(script:String):*
        {
            var s:Object;
            var e:Object;
            s = this;
            try
            {
                if ((((s.isSet(ExternalInterface)) && (s.isSet(ExternalInterface.available))) && (s.isSet(ExternalInterface.call))))
                {
                    return (ExternalInterface.call(script));
                };
            }
            catch(e)
            {
            };
            return (null);
        }

        private function getSharedObject(key:String):*
        {
            var o:Object;
            var encoding:Number;
            var tryNum:Number;
            var e:Object;
            o = null;
            tryNum = 0;
            while (((!(this.isSet(o))) && (tryNum < 2)))
            {
                try
                {
                    encoding = SharedObject.defaultObjectEncoding;
                    SharedObject.defaultObjectEncoding = ObjectEncoding.AMF0;
                    o = SharedObject.getLocal(key, "/");
                    SharedObject.defaultObjectEncoding = encoding;
                    o.objectEncoding = ObjectEncoding.AMF0;
                }
                catch(e)
                {
                };
                tryNum++;
            };
            return (o);
        }

        private function getVersion():String
        {
            return (Capabilities.version);
        }

        private function makeRequest(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):*
        {
            var _local_5:Object;
            var _local_6:*;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_11:String;
            var _local_12:Number;
            _local_5 = this;
            _local_6 = _local_5.getMovieURL();
            _local_7 = _local_5.trackingServer;
            _local_8 = _local_5.trackingServerBase;
            _local_9 = _local_5.dc;
            _local_10 = "sc.";
            if (!_local_5.isSet(_arg_3))
            {
                if (_local_5.isSet(_local_7))
                {
                    if (((_local_5.isSet(_local_5.trackingServerSecure)) && (_local_5.isSet(_local_5.ssl))))
                    {
                        _local_7 = _local_5.trackingServerSecure;
                    };
                }
                else
                {
                    _local_11 = _local_5.visitorNamespace;
                    if (!_local_5.isSet(_local_11))
                    {
                        _local_11 = _local_5.account;
                        _local_12 = _local_11.indexOf(",");
                        if (_local_12 >= 0)
                        {
                            _local_11 = _local_11.substr(0, _local_12);
                        };
                        _local_11 = _local_11.split("_").join("-");
                    };
                    if (!_local_5.isSet(_local_8))
                    {
                        _local_8 = "2o7.net";
                    };
                    if (_local_5.isSet(_local_9))
                    {
                        _local_9 = _local_9.toLowerCase();
                    }
                    else
                    {
                        _local_9 = "d1";
                    };
                    if (_local_8 == "2o7.net")
                    {
                        if (_local_9 == "d1")
                        {
                            _local_9 = "112";
                        }
                        else
                        {
                            if (_local_9 == "d2")
                            {
                                _local_9 = "122";
                            };
                        };
                        _local_10 = "";
                    };
                    _local_7 = (((((_local_11 + ".") + _local_9) + ".") + _local_10) + _local_8);
                };
                if (_local_5.isSet(_local_5.ssl))
                {
                    _arg_3 = "https://";
                }
                else
                {
                    _arg_3 = "http://";
                };
                _arg_3 = (_arg_3 + (((((((((((((_local_7 + "/b/ss/") + _local_5.account) + "/") + ((_local_5.mobile) ? "5.0" : "0")) + "/") + _local_5.version) + "-AS") + _local_5.flashASVersion) + "/") + _arg_1) + "?AQB=1&ndh=1&") + _arg_2) + "&AQE=1"));
                if (_local_5.isSet(_arg_4))
                {
                    _local_5.bufferRequest(_local_5.account, _arg_4, _arg_3);
                    return;
                };
            };
            if (((_local_5.isSet(_local_5.ssl)) && (_arg_3.toLowerCase().substr(0, 5) == "http:")))
            {
                _arg_3 = ("https:" + _arg_3.substr(5));
            };
            if (((((_local_5.isSet(_local_5.trackLocal)) || (_local_5.flashVersion < 8)) || (!(_local_5.isSet(_local_6)))) || (_local_6.toLowerCase().substr(0, 4) == "http")))
            {
                _local_5.requestList.push(_arg_3);
                if (((!(_local_5.isSet(_local_5.delayTracking))) || ((_local_5.isSet(_local_5.delayTrackingStage)) && (_local_5.delayTrackingStage == 2))))
                {
                    _local_5.flushRequestList();
                }
                else
                {
                    if (((_local_5.isSet(_local_5.delayTracking)) && (!(_local_5.isSet(_local_5.delayTrackingStage)))))
                    {
                        _local_5.delayTrackingStage = 1;
                        _local_5.delayTrackingInterval = _local_5.setupInterval(_local_5, "delayTrackingDone", _local_5.delayTracking, null);
                    };
                };
            };
        }

        public function replace(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            if (this.isSet(_arg_1))
            {
                if (_arg_1.indexOf(_arg_2) >= 0)
                {
                    return (_arg_1.split(_arg_2).join(_arg_3));
                };
            };
            return (_arg_1);
        }

        public function get configURL():String
        {
            return (this._configURL);
        }

        private function queryStringClickMap():String
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:String;
            var _local_4:Number;
            var _local_5:String;
            var _local_6:Number;
            var _local_7:String;
            _local_1 = this;
            _local_2 = "";
            _local_3 = _local_1.pageName;
            _local_4 = 1;
            _local_5 = _local_1.objectID;
            _local_6 = 1;
            _local_7 = "FLASH";
            if ((((!(_local_1.isSet(_local_5))) && (_local_1.isSet(_local_1.linkObject))) && ((_local_1.isSet(_local_1.linkObject, "name")) || (_local_1.isSet(_local_1.linkObject, "_name")))))
            {
                _local_5 = _local_1.ClickMap.getObjectID(_local_1.linkObject);
            };
            if (!_local_1.isSet(_local_3))
            {
                _local_3 = _local_1.pageURL;
                _local_4 = 0;
            };
            if (((((_local_1.isSet(_local_1.trackClickMap)) && (_local_1.isSet(_local_3))) && (_local_1.isSet(_local_5))) && (_local_1.isSet(_local_7))))
            {
                _local_2 = (_local_2 + ("&pid=" + escape(_local_3)));
                _local_2 = (_local_2 + ((_local_1.isSet(_local_4)) ? ("&pidt=" + escape(("" + _local_4))) : ""));
                _local_2 = (_local_2 + ("&oid=" + escape(_local_5.substr(0, 100))));
                _local_2 = (_local_2 + ((_local_1.isSet(_local_6)) ? ("&oidt=" + escape(("" + _local_6))) : ""));
                _local_2 = (_local_2 + ("&ot=" + escape(_local_7)));
            };
            return (_local_2);
        }

        private function bufferTrackCheck():*
        {
            var _local_1:Object;
            var _local_2:Number;
            var _local_3:Object;
            _local_1 = this;
            if (((((!(_local_1.isSet(_local_1.bufferTrackQueue))) || (_local_1.bufferTrackQueue.length <= 0)) || (!(_local_1.isSet(_local_1.configXML)))) || (_local_1.isSet(_local_1.configXML.loaded))))
            {
                clearInterval(_local_1.bufferTrackInterval);
                _local_1.bufferTrackInterval = 0;
                if (_local_1.isSet(_local_1.bufferTrackQueue))
                {
                    _local_2 = 0;
                    while (_local_2 < _local_1.bufferTrackQueue.length)
                    {
                        _local_3 = _local_1.bufferTrackQueue[_local_2];
                        if (_local_1.isSet(_local_3))
                        {
                            _local_1.variableOverridesApply(_local_3.setVariables);
                            _local_1.track(_local_3.variableOverrides, _local_3.bufferedRequestID);
                        };
                        _local_2++;
                    };
                };
                _local_1.bufferTrackQueue = undefined;
            };
        }

        private function queryStringTechnology():String
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:Object;
            _local_1 = this;
            _local_2 = "";
            _local_3 = Capabilities;
            if ((((_local_1.isSet(_local_3)) && (_local_1.isSet(_local_3.screenResolutionX))) && (_local_1.isSet(_local_3.screenResolutionY))))
            {
                _local_2 = (_local_2 + ((("&s=" + _local_3.screenResolutionX) + "x") + _local_3.screenResolutionY));
            };
            return (_local_2);
        }

        public function isSet(val:*, mbr:String=null):Boolean
        {
            var e:Object;
            try
            {
                if (mbr != null)
                {
                    val = val[mbr];
                };
                return ((((((!(val == null)) && (!(val == undefined))) && (!(("" + val) == "NaN"))) && (!(val == false))) && (!(val == ""))) && (!(val == 0)));
            }
            catch(e)
            {
            };
            return (false);
        }

        public function flushBufferedRequests():*
        {
            var _local_1:*;
            _local_1 = this;
            if (_local_1.isSet(_local_1.account))
            {
                _local_1._flushBufferedRequests(_local_1.account);
            };
        }

        public function setInterface(inter:Object):*
        {
            var s:Object;
            var subInter:Object;
            var interReady:Function;
            s = this;
            if (s.isSet(inter))
            {
                if (s.isSet(inter, "root"))
                {
                    s.movie = inter.root;
                }
                else
                {
                    if (s.isSet(inter, "_root"))
                    {
                        s.movie = inter._root;
                    }
                    else
                    {
                        if (((s.isSet(inter, "getModule")) && (s.isSet(inter, "addEventListener"))))
                        {
                            subInter = inter.getModule("experience");
                            if (((s.isSet(subInter)) && (s.isSet(subInter, "getStage"))))
                            {
                                inter = subInter.getStage();
                                if (s.isSet(inter))
                                {
                                    s.movie = inter;
                                };
                            }
                            else
                            {
                                interReady = function (_arg_1:Object):*
                                {
                                    s.setInterface(inter);
                                };
                                inter.addEventListener("complete", subInter);
                            };
                        }
                        else
                        {
                            s.movie = inter;
                        };
                    };
                };
            };
        }

        private function bufferTrack(_arg_1:Object, _arg_2:String):*
        {
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:Object;
            _local_3 = this;
            if (((_local_3.isSet(_local_3.configXML)) && (!(_local_3.isSet(_local_3.configXML.loaded)))))
            {
                if (!_local_3.isSet(_local_3.bufferTrackQueue))
                {
                    _local_3.bufferTrackQueue = new Array();
                };
                _local_5 = new Object();
                _local_5.setVariables = new Object();
                _local_3.variableOverridesBuild(_local_5.setVariables, true);
                if (_local_3.isSet(_arg_1))
                {
                    _local_5.variableOverrides = new Object();
                    for (_local_4 in _arg_1)
                    {
                        _local_5.variableOverrides[_local_4] = _arg_1[_local_4];
                    };
                };
                _local_5.bufferedRequestID = _arg_2;
                _local_3.bufferTrackQueue.push(_local_5);
                if (!_local_3.isSet(_local_3.bufferTrackInterval))
                {
                    _local_3.bufferTrackInterval = _local_3.setupInterval(_local_3, "bufferTrackCheck", 100, null);
                };
                return (true);
            };
            return (false);
        }

        private function queryStringAccountVariables():String
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:String;
            var _local_6:String;
            var _local_7:*;
            var _local_8:String;
            var _local_9:String;
            var _local_10:*;
            var _local_11:*;
            var _local_12:*;
            _local_1 = this;
            _local_2 = "";
            _local_10 = "";
            _local_11 = "";
            _local_12 = "";
            if (((_local_1.isSet(_local_1.pe)) || (_local_1.isSet(_local_1.linkType))))
            {
                _local_10 = _local_1.linkTrackVars;
                _local_11 = _local_1.linkTrackEvents;
                if (_local_1.isSet(_local_1.pe))
                {
                    _local_12 = (_local_1.pe.substr(0, 1).toUpperCase() + _local_1.pe.substr(1));
                    if (_local_1.isSet(_local_1[_local_12]))
                    {
                        _local_10 = _local_1[_local_12].trackVars;
                        _local_11 = _local_1[_local_12].trackEvents;
                    };
                };
            };
            if (_local_1.isSet(_local_10))
            {
                _local_10 = (((("," + _local_10) + ",") + _local_1.requiredVarList.join(",")) + ",");
            };
            if (_local_1.isSet(_local_11))
            {
                _local_11 = (("," + _local_11) + ",");
            };
            _local_3 = 0;
            while (_local_3 < _local_1.accountVarList.length)
            {
                _local_5 = _local_1.accountVarList[_local_3];
                _local_6 = _local_1[_local_5];
                _local_8 = _local_5.substr(0, 4);
                _local_9 = _local_5.substr(4);
                if (((_local_1.isSet(_local_6)) && ((!(_local_1.isSet(_local_10))) || (_local_10.indexOf((("," + _local_5) + ",")) >= 0))))
                {
                    switch (_local_5)
                    {
                        case "dynamicVariablePrefix":
                            _local_5 = "D";
                            break;
                        case "visitorID":
                            _local_5 = "vid";
                            break;
                        case "pageURL":
                            _local_5 = "g";
                            break;
                        case "referrer":
                            _local_5 = "r";
                            break;
                        case "vmk":
                        case "visitorMigrationKey":
                            _local_5 = "vmt";
                            break;
                        case "visitorMigrationServer":
                            _local_5 = "vmf";
                            if (((_local_1.isSet(_local_1.ssl)) && (_local_1.isSet(_local_1.visitorMigrationServerSecure))))
                            {
                                _local_6 = "";
                            };
                            break;
                        case "visitorMigrationServerSecure":
                            _local_5 = "vmf";
                            if (((!(_local_1.isSet(_local_1.ssl))) && (_local_1.isSet(_local_1.visitorMigrationServer))))
                            {
                                _local_6 = "";
                            };
                            break;
                        case "charSet":
                            _local_5 = "ce";
                            break;
                        case "visitorNamespace":
                            _local_5 = "ns";
                            break;
                        case "cookieDomainPeriods":
                            _local_5 = "cdp";
                            break;
                        case "cookieLifetime":
                            _local_5 = "cl";
                            break;
                        case "currencyCode":
                            _local_5 = "cc";
                            break;
                        case "channel":
                            _local_5 = "ch";
                            break;
                        case "transactionID":
                            _local_5 = "xact";
                            break;
                        case "campaign":
                            _local_5 = "v0";
                            break;
                        case "events":
                            if (_local_1.isSet(_local_11))
                            {
                                _local_7 = _local_6.split(",");
                                _local_6 = "";
                                _local_4 = 0;
                                while (_local_4 < _local_7.length)
                                {
                                    if (_local_11.indexOf((("," + _local_7[_local_4]) + ",")) >= 0)
                                    {
                                        _local_6 = (_local_6 + (((_local_1.isSet(_local_6)) ? "," : "") + _local_7[_local_4]));
                                    };
                                    _local_4++;
                                };
                            };
                            break;
                        default:
                            if (_local_1.isNumber(_local_9))
                            {
                                if (_local_8 == "prop")
                                {
                                    _local_5 = ("c" + _local_9);
                                }
                                else
                                {
                                    if (_local_8 == "eVar")
                                    {
                                        _local_5 = ("v" + _local_9);
                                    }
                                    else
                                    {
                                        if (_local_8 == "list")
                                        {
                                            _local_5 = ("l" + _local_9);
                                        }
                                        else
                                        {
                                            if (_local_8 == "hier")
                                            {
                                                _local_5 = ("h" + _local_9);
                                                _local_6 = _local_6.substr(0, 0xFF);
                                            };
                                        };
                                    };
                                };
                            };
                    };
                    if (_local_1.isSet(_local_6))
                    {
                        _local_2 = (_local_2 + ((("&" + escape(_local_5)) + "=") + ((_local_5.substr(0, 3) != "pev") ? escape(_local_6) : _local_6)));
                    };
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function isNumber(_arg_1:*):Boolean
        {
            return (!(isNaN(parseInt(_arg_1))));
        }

        private function doTrackOnLoad():*
        {
            var _local_1:Object;
            _local_1 = this;
            if (((!(_local_1.isSet(_local_1.account))) || (!(_local_1.isSet(_local_1.movie)))))
            {
                return;
            };
            clearInterval(_local_1.trackOnLoadInterval);
            if (((_local_1._trackOnLoad) && (!(_local_1.onLoadTracked))))
            {
                _local_1.onLoadTracked = true;
                _local_1.track();
            };
        }

        public function flushBufferedRequest(_arg_1:String, _arg_2:String):*
        {
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:Number;
            var _local_7:String;
            _local_3 = this;
            _local_4 = _local_3.getBufferedRequests();
            if ((((_local_3.isSet(_local_4)) && (_local_3.isSet(_local_4.data))) && (_local_3.isSet(_local_4.data.list))))
            {
                _local_6 = 0;
                while (_local_6 < _local_4.data.list.length)
                {
                    _local_5 = _local_4.data.list[_local_6];
                    if (((_local_5.account == _arg_1) && (_local_5.id == _arg_2)))
                    {
                        _local_7 = _local_4.data.list[_local_6].request;
                        _local_4.data.list[_local_6].account = "";
                        _local_4.data.list[_local_6].id = "";
                        _local_4.data.list[_local_6].request = "";
                        _local_4.flush();
                        _local_3.makeRequest("", "", _local_7, "");
                    };
                    _local_6++;
                };
            };
        }

        public function set trackOnLoad(_arg_1:Boolean):*
        {
            this._trackOnLoad = _arg_1;
            if (this._trackOnLoad)
            {
                this.trackOnLoadInterval = this.setupInterval(this, "doTrackOnLoad", 100, null);
            };
        }

        public function variableOverridesApply(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:Number;
            var _local_4:String;
            var _local_5:Array;
            _local_2 = this;
            _local_3 = 0;
            while (_local_3 < _local_2.accountVarList.length)
            {
                _local_4 = _local_2.accountVarList[_local_3];
                if (((_local_2.isSet(_arg_1[_local_4])) || (_local_2.isSet(_arg_1[("!" + _local_4)]))))
                {
                    _local_2[_local_4] = _arg_1[_local_4];
                };
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < _local_2.accountConfigList.length)
            {
                _local_4 = _local_2.accountConfigList[_local_3];
                if (((_local_2.isSet(_arg_1[_local_4])) || (_local_2.isSet(_arg_1[("!" + _local_4)]))))
                {
                    if ((((((((_local_4 == "trackDownloadLinks") || (_local_4 == "trackExternalLinks")) || (_local_4 == "trackClickMap")) || (_local_4 == "linkLeaveQueryString")) || (_local_4 == "autoTrack")) || (_local_4 == "trackLocal")) || (_local_4 == "debugTracking")))
                    {
                        if (typeof(_arg_1[_local_4]) == "string")
                        {
                            if (_arg_1[_local_4].toLowerCase() == "true")
                            {
                                _arg_1[_local_4] = true;
                            }
                            else
                            {
                                _arg_1[_local_4] = false;
                            };
                        }
                        else
                        {
                            _arg_1[_local_4] = _local_2.isSet(_arg_1[_local_4]);
                        };
                    }
                    else
                    {
                        if (_local_4 == "delayTracking")
                        {
                            if (typeof(_arg_1[_local_4]) == "string")
                            {
                                _arg_1[_local_4] = parseInt(_arg_1[_local_4]);
                            }
                            else
                            {
                                if (typeof(_arg_1[_local_4]) != "number")
                                {
                                    _arg_1[_local_4] = 0;
                                };
                            };
                        };
                    };
                    _local_2[_local_4] = _arg_1[_local_4];
                };
                _local_3++;
            };
            for (_local_4 in _arg_1)
            {
                if (_local_4.indexOf(".") >= 0)
                {
                    _local_5 = _local_4.split(".");
                    if (_local_5.length == 2)
                    {
                        if (((!(_local_2.isSet(_arg_1[_local_5[0]]))) || (!(typeof(_arg_1[_local_5[0]]) == "object"))))
                        {
                            _arg_1[_local_5[0]] = new Object();
                        };
                        _arg_1[_local_4][_local_5[1]] = _arg_1[_local_4];
                        _local_4 = _local_5[0];
                    }
                    else
                    {
                        _local_4 = "";
                    };
                };
            };
            for (_local_4 in _arg_1)
            {
                if (typeof(_arg_1[_local_4]) == "object")
                {
                    if (_local_4 == "config")
                    {
                        _local_2.variableOverridesApply(_arg_1[_local_4]);
                    }
                    else
                    {
                        if (((((_local_4.substr(0, 1) == _local_4.substr(0, 1).toUpperCase()) && (_local_2.isSet(_local_2[_local_4]))) && ("boolean")) && (_local_2.isSet(_local_2[_local_4].variableOverridesApply))))
                        {
                            _local_2[_local_4].variableOverridesApply(_arg_1[_local_4]);
                        };
                    };
                };
            };
        }

        public function get useExternalVariables():Boolean
        {
            return (this._useExternalVariables);
        }

        public function set moduleMediaVariables(_arg_1:Object):*
        {
            this._moduleMediaVariables = _arg_1;
            this.modulesUpdate();
        }

        private function setVariableCallHandler():*
        {
            var _local_1:Object;
            var _local_2:Object;
            var _local_3:String;
            var _local_4:String;
            var _local_5:Array;
            var _local_6:Number;
            var _local_7:Array;
            var _local_8:Object;
            var _local_9:Number;
            _local_1 = this;
            for (_local_3 in _local_1)
            {
                if (_local_3.substr(0, 5) == "_svc_")
                {
                    _local_5 = _local_3.split("_");
                    if (((_local_1.isSet(_local_5)) && (_local_5.length >= 4)))
                    {
                        if (((_local_5[3] == "dot") && (_local_5.length > 4)))
                        {
                            _local_5[2] = (_local_5[2] + ("_dot_" + _local_5[4]));
                            _local_6 = 5;
                            while (_local_6 < _local_5.length)
                            {
                                _local_5[(_local_6 - 2)] = _local_5[_local_6];
                                _local_6++;
                            };
                        };
                        _local_8 = null;
                        if (_local_1.isSet(_local_7))
                        {
                            _local_9 = 0;
                            while (_local_9 < _local_7.length)
                            {
                                if (_local_7[_local_9].methodName == _local_5[2])
                                {
                                    _local_8 = _local_7[_local_9];
                                };
                                _local_9++;
                            };
                        };
                        if (!_local_1.isSet(_local_8))
                        {
                            _local_7 = new Array();
                            _local_8 = new Object();
                            _local_8.methodName = _local_5[2];
                            _local_7[0] = _local_8;
                        };
                        if (_local_5[3] == "call")
                        {
                            if (_local_1.isSet(_local_1[_local_3]))
                            {
                                _local_8.call = true;
                            };
                            _local_1[_local_3] = null;
                        }
                        else
                        {
                            if ((((_local_5[3] == "param") && (_local_5.length > 4)) && (_local_1.isSet(_local_5[4]))))
                            {
                                if (!_local_1.isSet(_local_8.paramList))
                                {
                                    _local_8.paramList = new Array();
                                };
                                _local_8.paramList[_local_5[4]] = _local_1[_local_3];
                            };
                        };
                    };
                };
            };
            if (((_local_1.isSet(_local_7)) && (_local_7.length > 0)))
            {
                _local_9 = 0;
                while (_local_9 < _local_7.length)
                {
                    _local_8 = _local_7[_local_9];
                    if (((_local_1.isSet(_local_8.methodName)) && (_local_1.isSet(_local_8.call))))
                    {
                        _local_5 = _local_8.methodName.split("_dot_");
                        if (_local_5.length > 1)
                        {
                            _local_2 = _local_1[_local_5[0]];
                            _local_4 = _local_5[1];
                        }
                        else
                        {
                            _local_2 = _local_1;
                            _local_4 = _local_8.methodName;
                        };
                        if (_local_1.isSet(_local_2[_local_4]))
                        {
                            if (((_local_1.isSet(_local_8.paramList)) && (_local_8.paramList.length > 0)))
                            {
                                if (_local_8.paramList.length == 1)
                                {
                                    _local_1[("_svc_result_" + _local_8.methodName)] = _local_2[_local_4](_local_8.paramList[0]);
                                }
                                else
                                {
                                    if (_local_8.paramList.length == 2)
                                    {
                                        _local_1[("_svc_result_" + _local_8.methodName)] = _local_2[_local_4](_local_8.paramList[0], _local_8.paramList[1]);
                                    }
                                    else
                                    {
                                        if (_local_8.paramList.length == 3)
                                        {
                                            _local_1[("_svc_result_" + _local_8.methodName)] = _local_2[_local_4](_local_8.paramList[0], _local_8.paramList[1], _local_8.paramList[2]);
                                        };
                                    };
                                };
                            }
                            else
                            {
                                _local_1[(("_svc_" + _local_8.methodName) + "_result")] = _local_2[_local_4]();
                            };
                        };
                    };
                    _local_9++;
                };
            };
        }

        private function getMovieClipURL(_arg_1:Object):String
        {
            var _local_2:Object;
            _local_2 = this;
            if (_local_2.isSet(_arg_1))
            {
                if ((((_local_2.flashASVersion > 2) && (_local_2.isSet(_arg_1, "loaderInfo"))) && (_local_2.isSet(_arg_1.loaderInfo, "loaderURL"))))
                {
                    return (_arg_1.loaderInfo.loaderURL);
                };
                if (_local_2.isSet(_arg_1, "_url"))
                {
                    return (_arg_1._url);
                };
            };
            return ("");
        }

        public function get movie():Object
        {
            return (this._movie);
        }

        private function getBufferedRequests():*
        {
            var s:Object;
            var bufferedRequests:Object;
            s = this;
            if (!s.isSet(s.disableBufferedRequests))
            {
                bufferedRequests = s.getSharedObject("s_br");
            };
            if (!s.isSet(bufferedRequests))
            {
                bufferedRequests = s.bufferedRequests;
                if (!s.isSet(bufferedRequests))
                {
                    s.bufferedRequests = new Object();
                    s.bufferedRequests.flush = function ():*
                    {
                    };
                    bufferedRequests = s.bufferedRequests;
                };
            };
            return (bufferedRequests);
        }

        private function modulesInit():*
        {
            var _local_1:Object;
            _local_1 = this;
            _local_1.ClickMap = new ActionSource_Module_ClickMap(_local_1);
            _local_1.Media = new ActionSource_Module_Media(_local_1);
            _local_1.modulesUpdate();
        }

        private function modulesUpdate():*
        {
            var _local_1:Object;
            var _local_2:String;
            _local_1 = this;
            if (_local_1.isSet(_local_1.Media))
            {
                if (_local_1.isSet(_local_1._moduleMediaVariables))
                {
                    for (_local_2 in _local_1._moduleMediaVariables)
                    {
                        if (_local_1.isSet(_local_1._moduleMediaVariables[_local_2]))
                        {
                            if (((_local_2 == "trackWhilePlaying") || (_local_2 == "autoTrack")))
                            {
                                if (("" + _local_1._moduleMediaVariables[_local_2]).toLowerCase() == "true")
                                {
                                    _local_1._moduleMediaVariables[_local_2] = true;
                                }
                                else
                                {
                                    _local_1._moduleMediaVariables[_local_2] = false;
                                };
                            };
                            _local_1.Media[_local_2] = _local_1._moduleMediaVariables[_local_2];
                        };
                    };
                };
                _local_1.Media.autoTrack = _local_1.Media.autoTrack;
            };
        }

        public function track(_arg_1:Object=null, _arg_2:String=""):*
        {
            this._track(_arg_1, _arg_2);
        }

        public function logDebug(_arg_1:String):*
        {
            trace(_arg_1);
            this.callJavaScript((('function s_logDebug(){var e;try{console.log("' + this.replace(this.replace(_arg_1, "\n", "\\n"), '"', '\\"')) + '");}catch(e){}}'));
        }

        private function initPre():*
        {
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        public function get moduleMediaVariables():Object
        {
            return (this._moduleMediaVariables);
        }

        public function getMovieURL():String
        {
            var _local_1:Object;
            var _local_2:String;
            _local_1 = this;
            _local_2 = _local_1.callJavaScript("function s_ActionSource_wl(){return window.location.href;}");
            if (_local_1.isSet(_local_2))
            {
                return (_local_2);
            };
            if (_local_1.isSet(_local_1.movie))
            {
                return (_local_1.getMovieClipURL(_local_1.movie));
            };
            return ("");
        }

        public function set configURL(_arg_1:String):*
        {
            var _local_2:Object;
            _local_2 = this;
            if (_arg_1 != _local_2._configURL)
            {
                _local_2._configURL = _arg_1;
                if (_local_2.isSet(_local_2._configURL))
                {
                    if (!_local_2.isSet(_local_2.configXML))
                    {
                        _local_2.configXML = new ActionSource_XML(_local_2);
                        _local_2.configXML.onDataReady = "variableOverridesApply";
                    };
                    _local_2.configXML.url = _local_2._configURL;
                };
            };
        }

        private function onAddedToStage(_arg_1:Event):*
        {
            if (((parent == null) || (!(getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent"))))
            {
                this.visible = false;
                this.movie = root;
            }
            else
            {
                this.flashLivePreview = true;
            };
        }

        private function getMovieReferrer():String
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.callJavaScript((((((((((((((((((((((((("" + "function s_ActionSource_r(){") + "\tvar ") + "\t\tr = '',") + "\t\tw = window,") + "\t\te,") + "\t\tp,") + "\t\tl,") + "\t\te;") + "\tif ((w) && (w.document)) {") + "\t\tr = w.document.referrer;") + "\t\ttry {") + "\t\t\tp = w.parent;") + "\t\t\tl = w.location;") + "\t\t\twhile ((p) && (p.location) && (l) && (''+p.location != ''+l) && (w.location) && (''+p.location != ''+w.location) && (p.location.host == l.host)) {") + "\t\t\t\tw = p;") + "\t\t\t\tp = w.parent;") + "\t\t\t}") + "\t\t} catch (e) {}") + "\t\tif ((w) && (w.document)) {") + "\t\t\tr = w.document.referrer;") + "\t\t}") + "\t}") + "\treturn r;") + "}")));
        }

        private function initPost():*
        {
        }

        public function trackLink(_arg_1:*, _arg_2:String, _arg_3:String, _arg_4:Object=null):*
        {
            this._trackLink(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private function _flushBufferedRequests(_arg_1:String):*
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:Number;
            _local_2 = this;
            _local_3 = _local_2.getBufferedRequests();
            if ((((_local_2.isSet(_local_3)) && (_local_2.isSet(_local_3.data))) && (_local_2.isSet(_local_3.data.list))))
            {
                _local_5 = 0;
                while (_local_5 < _local_3.data.list.length)
                {
                    _local_4 = _local_3.data.list[_local_5];
                    if (_local_4.account == _arg_1)
                    {
                        _local_2.flushBufferedRequest(_arg_1, _local_4.id);
                    };
                    _local_5++;
                };
            };
        }

        private function delayTrackingDone():*
        {
            var _local_1:Object;
            _local_1 = this;
            clearInterval(_local_1.delayTrackingInterval);
            _local_1.delayTrackingStage = 2;
            _local_1.flushRequestList();
        }


    }
}//package com.omniture
