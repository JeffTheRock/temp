//Created by Action Script Viewer - https://www.buraks.com/asv
package com.omniture
{
    import flash.utils.clearInterval;

    public dynamic class ActionSource_Module_Media 
    {

        public var playerName:String;
        public var trackVars:String;
        private var list:Object;
        private var monitorList:Array;
        private var autoTrackInterval:Number;
        public var trackEvents:String;
        private var s:Object;

        public var trackWhilePlaying:Boolean = false;
        public var trackSeconds:Number = 0;
        public var trackMilestones:String = "";
        private var _autoTrack:Boolean = false;
        private var autoTrackDone:Boolean = false;

        public function ActionSource_Module_Media(_arg_1:Object)
        {
            var _local_2:Object;
            super();
            _local_2 = this;
            _local_2.s = _arg_1;
            _local_2.monitorList = null;
        }

        public function listenerMedia_scrubbing(_arg_1:*):*
        {
            this.listenerMedia.scrubbing(_arg_1);
        }

        public function stop(_arg_1:String, _arg_2:Number):*
        {
            this.event(_arg_1, 2, _arg_2);
        }

        public function listenerBrightcove_seek(_arg_1:*):*
        {
            this.listenerBrightcove.seek(_arg_1);
        }

        public function doAutoTrack():*
        {
            var _local_1:Object;
            _local_1 = this;
            if (((!(_local_1.s.isSet(_local_1.s.account))) || (!(_local_1.s.isSet(_local_1.s.movie)))))
            {
                return;
            };
            clearInterval(_local_1.autoTrackInterval);
            if (((_local_1._autoTrack) && (!(_local_1.autoTrackDone))))
            {
                if (_local_1.attach(_local_1.s.movie))
                {
                    _local_1.autoTrackDone = true;
                }
                else
                {
                    _local_1.autoTrackInterval = _local_1.s.setupInterval(this, "doAutoTrack", 1000, null);
                };
            };
        }

        public function listenerMedia_click(_arg_1:*):*
        {
            this.listenerMedia.click(_arg_1);
        }

        private function event(_arg_1:String, _arg_2:Number, _arg_3:Number):*
        {
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:Date;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:String;
            var _local_10:Array;
            var _local_11:Number;
            var _local_12:String;
            var _local_13:Boolean;
            var _local_14:String;
            var _local_15:String;
            var _local_16:String;
            var _local_17:String;
            var _local_18:String;
            var _local_19:Object;
            _local_4 = this;
            _local_6 = new Date();
            _local_7 = Math.floor((_local_6.getTime() / 1000));
            _local_8 = _local_4.trackSeconds;
            _local_9 = _local_4.trackMilestones;
            _local_12 = "--**--";
            _local_13 = true;
            _local_14 = null;
            _local_15 = _local_4.trackVars;
            _local_16 = _local_4.trackEvents;
            _local_17 = "media";
            _local_19 = new Object();
            _arg_1 = _local_4.cleanName(_arg_1);
            _local_5 = ((((_local_4.s.isSet(_arg_1)) && (_local_4.s.isSet(_local_4.list))) && (_local_4.s.isSet(_local_4.list[_arg_1]))) ? _local_4.list[_arg_1] : null);
            if (_local_4.s.isSet(_local_5))
            {
                _local_19.name = _arg_1;
                _local_19.length = _local_5.length;
                _local_19.playerName = _local_5.playerName;
                if (_local_5.lastTrackOffset < 0)
                {
                    _local_19.event = "OPEN";
                }
                else
                {
                    _local_19.event = ((_arg_2 == 1) ? "PLAY" : ((_arg_2 == 2) ? "STOP" : ((_arg_2 == 3) ? "MONITOR" : "CLOSE")));
                };
                _local_19.openTime = new Date();
                _local_19.openTime.setTime((_local_5.timestamp * 1000));
                if (((_arg_2 > 2) || ((!(_arg_2 == _local_5.lastEventType)) && ((!(_arg_2 == 2)) || (_local_5.lastEventType == 1)))))
                {
                    _local_14 = ("Media." + _arg_1);
                    _local_18 = (((((("" + escape(_local_5.name)) + _local_12) + _local_5.length) + _local_12) + escape(_local_5.playerName)) + _local_12);
                    if (_local_4.s.isSet(_arg_2))
                    {
                        if (((_arg_3 < 0) && (_local_5.lastEventTimestamp > 0)))
                        {
                            _arg_3 = ((_local_7 - _local_5.lastEventTimestamp) + _local_5.lastEventOffset);
                            _arg_3 = ((_arg_3 < _local_5.length) ? _arg_3 : (_local_5.length - 1));
                        };
                        _arg_3 = Math.floor(_arg_3);
                        if (((_arg_2 >= 2) && (_local_5.lastEventOffset < _arg_3)))
                        {
                            _local_5.timePlayed = (_local_5.timePlayed + (_arg_3 - _local_5.lastEventOffset));
                            _local_5.timePlayedSinseTrack = (_local_5.timePlayedSinseTrack + (_arg_3 - _local_5.lastEventOffset));
                        };
                        if (_arg_2 <= 2)
                        {
                            _local_5.session = (_local_5.session + (((_arg_2 == 1) ? "S" : "E") + _arg_3));
                            _local_5.lastEventType = _arg_2;
                        }
                        else
                        {
                            if (_local_5.lastEventType != 1)
                            {
                                _local_4.event(_arg_1, 1, _arg_3);
                            };
                        };
                        _local_5.lastEventTimestamp = _local_7;
                        _local_5.lastEventOffset = _arg_3;
                        _local_18 = (_local_18 + ((((((("" + _local_5.timePlayed) + _local_12) + _local_5.timestamp) + _local_12) + (((_local_4.s.isSet(_local_4.trackWhilePlaying)) && (_local_5.lastTrackOffset >= 0)) ? ("L" + _local_5.lastTrackOffset) : "")) + _local_5.session) + ((_arg_2 != 2) ? (((_local_4.s.isSet(_local_4.trackWhilePlaying)) ? "L" : "E") + _arg_3) : "")));
                        if (_local_4.s.isSet(_local_4.trackWhilePlaying))
                        {
                            _local_14 = null;
                            _local_17 = "m_o";
                            if (_arg_2 != 4)
                            {
                                _local_19.offset = _arg_3;
                                _local_19.percent = (((_local_19.offset + 1) / _local_19.length) * 100);
                                _local_19.percent = ((_local_19.percent > 100) ? 100 : Math.floor(_local_19.percent));
                                _local_19.timePlayed = _local_5.timePlayed;
                                if (_local_4.s.isSet(_local_4.monitor))
                                {
                                    _local_4.monitor(_local_4.s, _local_19);
                                };
                            };
                            if (_local_5.lastTrackOffset < 0)
                            {
                                _local_17 = "m_s";
                            }
                            else
                            {
                                if (_arg_2 == 4)
                                {
                                    _local_17 = "m_i";
                                }
                                else
                                {
                                    _local_13 = false;
                                    _local_15 = (_local_16 = "None");
                                    _local_8 = ((_local_4.s.isSet(_local_8)) ? parseInt(("" + _local_8)) : 0);
                                    _local_10 = ((_local_4.s.isSet(_local_9)) ? _local_9.split(",") : null);
                                    if (((_local_4.s.isSet(_local_8)) && (_local_5.timePlayedSinseTrack >= _local_8)))
                                    {
                                        _local_13 = true;
                                    }
                                    else
                                    {
                                        if (_local_4.s.isSet(_local_10))
                                        {
                                            if (_arg_3 < _local_5.lastTrackOffset)
                                            {
                                                _local_5.lastTrackOffset = _arg_3;
                                            }
                                            else
                                            {
                                                _local_11 = 0;
                                                while (_local_11 < _local_10.length)
                                                {
                                                    _local_8 = ((_local_4.s.isSet(_local_10[_local_11])) ? parseInt(("" + _local_10[_local_11])) : 0);
                                                    if ((((_local_4.s.isSet(_local_8)) && (((_local_5.lastTrackOffset + 1) / _local_5.length) < (_local_8 / 100))) && (((_arg_3 + 1) / _local_5.length) >= (_local_8 / 100))))
                                                    {
                                                        _local_13 = true;
                                                        _local_11 = _local_10.length;
                                                    };
                                                    _local_11++;
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    }
                    else
                    {
                        _local_4.event(_arg_1, 2, -1);
                        if (_local_4.s.isSet(_local_4.trackWhilePlaying))
                        {
                            _local_19.offset = _local_5.lastEventOffset;
                            _local_19.percent = (((_local_19.offset + 1) / _local_19.length) * 100);
                            _local_19.percent = ((_local_19.percent > 100) ? 100 : Math.floor(_local_19.percent));
                            _local_19.timePlayed = _local_5.timePlayed;
                            if (_local_4.s.isSet(_local_4.monitor))
                            {
                                _local_4.monitor(_local_4.s, _local_19);
                            };
                        };
                        _local_4.list[_arg_1] = 0;
                        if (_local_4.s.isSet(_local_5.session))
                        {
                            _local_18 = (_local_18 + (((((("" + _local_5.timePlayed) + _local_12) + _local_5.timestamp) + _local_12) + (((_local_4.s.isSet(_local_4.trackWhilePlaying)) && (_local_5.lastTrackOffset >= 0)) ? ("L" + _local_5.lastTrackOffset) : "")) + _local_5.session));
                            if (_local_4.s.isSet(_local_4.trackWhilePlaying))
                            {
                                _local_15 = (_local_16 = "None");
                                _local_17 = "m_o";
                            }
                            else
                            {
                                _local_13 = false;
                                _local_4.s.flushBufferedRequest(_local_4.s.account, _local_14);
                            };
                        }
                        else
                        {
                            _local_13 = false;
                        };
                        _local_14 = null;
                    };
                    if (_local_13)
                    {
                        _local_4.s.track({
                            "linkTrackVars":_local_15,
                            "linkTrackEvents":_local_16,
                            "pe":_local_17,
                            "pev3":_local_18
                        }, _local_14);
                        if (_local_4.s.isSet(_local_4.trackWhilePlaying))
                        {
                            _local_5.timePlayedSinseTrack = 0;
                            _local_5.lastTrackOffset = _arg_3;
                            _local_5.session = "";
                        };
                    };
                };
            };
        }

        public function listenerMedia_complete(_arg_1:*):*
        {
            this.listenerMedia.complete(_arg_1);
        }

        public function listenerFLVPlayback_complete(_arg_1:*):*
        {
            this.listenerFLVPlayback.complete(_arg_1);
        }

        public function variableOverridesApply(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:String;
            _local_2 = this;
            for (_local_3 in _arg_1)
            {
                if (((_local_3 == "autoTrack") || (_local_3 == "trackWhilePlaying")))
                {
                    if (typeof(_arg_1[_local_3]) == "string")
                    {
                        if (_arg_1[_local_3].toLowerCase() == "true")
                        {
                            _arg_1[_local_3] = true;
                        }
                        else
                        {
                            _arg_1[_local_3] = false;
                        };
                    }
                    else
                    {
                        if (typeof(_arg_1[_local_3]) != "boolean")
                        {
                            _arg_1[_local_3] = false;
                        };
                    };
                }
                else
                {
                    if (_local_3 == "trackSeconds")
                    {
                        if (typeof(_arg_1[_local_3]) == "string")
                        {
                            (_arg_1[_local_3] == parseInt(_arg_1[_local_3]));
                        }
                        else
                        {
                            if (typeof(_arg_1[_local_3]) != "number")
                            {
                                (_arg_1[_local_3] == 0);
                            };
                        };
                    };
                };
                if (((((typeof(_arg_1[_local_3]) == "string") || (typeof(_arg_1[_local_3]) == "number")) || (typeof(_arg_1[_local_3]) == "boolean")) && (((((((_local_3 == "autoTrack") || (_local_3 == "trackWhilePlaying")) || (_local_3 == "trackSeconds")) || (_local_3 == "trackMilestones")) || (_local_3 == "playerName")) || (_local_3 == "trackVars")) || (_local_3 == "trackEvents"))))
                {
                    _local_2[_local_3] = _arg_1[_local_3];
                };
            };
        }

        private function startMonitor(monitor:Object):*
        {
            var m:Object;
            var monitorNum:Number;
            var nextMonitorNum:Number;
            m = this;
            nextMonitorNum = 0;
            if (m.s.isSet(m.monitorList))
            {
                nextMonitorNum = -1;
                monitorNum = 0;
                while (monitorNum < m.monitorList.length)
                {
                    if (m.s.isSet(m.monitorList[monitorNum]))
                    {
                        if (((((m.s.isSet(m.monitorList[monitorNum].node)) && (m.s.isSet(monitor))) && (m.s.isSet(monitor.node))) && (m.monitorList[monitorNum].node == monitor.node)))
                        {
                            return;
                        };
                    }
                    else
                    {
                        if (nextMonitorNum < 0)
                        {
                            nextMonitorNum = monitorNum;
                        };
                    };
                    monitorNum++;
                };
                if (nextMonitorNum < 0)
                {
                    nextMonitorNum = m.monitorList.length;
                };
            }
            else
            {
                m.monitorList = new Array();
            };
            monitor.update = function (_arg_1:Object):*
            {
                if (((((((_arg_1.m == null) || (_arg_1.m == undefined)) || (_arg_1.m.s == null)) || (_arg_1.m.s == undefined)) || (_arg_1.node == null)) || (_arg_1.node == undefined)))
                {
                    clearInterval(_arg_1.interval);
                    _arg_1.m.monitorList[_arg_1.num] = null;
                }
                else
                {
                    _arg_1.monitor();
                };
            };
            monitor.interval = m.s.setupInterval(monitor, "update", 5000, monitor);
            monitor.num = nextMonitorNum;
            m.monitorList[monitor.num] = monitor;
        }

        private function _open(_arg_1:String, _arg_2:Number, _arg_3:String, _arg_4:Object):*
        {
            var _local_5:Object;
            var _local_6:Object;
            var _local_7:Date;
            var _local_8:String;
            var _local_9:String;
            _local_5 = this;
            _local_6 = new Object();
            _local_7 = new Date();
            _local_8 = "";
            _arg_1 = _local_5.cleanName(_arg_1);
            _arg_2 = Math.floor(_arg_2);
            if (!_local_5.s.isSet(_arg_2))
            {
                _arg_2 = 1;
            };
            if (((_local_5.s.isSet(_arg_1)) && (_local_5.s.isSet(_arg_3))))
            {
                if (!_local_5.s.isSet(_local_5.list))
                {
                    _local_5.list = new Object();
                };
                if (_local_5.s.isSet(_local_5.list[_arg_1]))
                {
                    _local_5.close(_arg_1);
                };
                if (_local_5.s.isSet(_arg_4))
                {
                    _local_8 = ("" + _arg_4);
                };
                for (_local_9 in _local_5.list)
                {
                    if (((_local_5.s.isSet(_local_5.list[_local_9])) && (_local_5.list[_local_9].playerID == _local_8)))
                    {
                        _local_5.close(_local_5.list[_local_9].name);
                    };
                };
                _local_6.name = _arg_1;
                _local_6.length = _arg_2;
                _local_6.playerName = _local_5.cleanName(((_local_5.s.isSet(_local_5.playerName)) ? _local_5.playerName : _arg_3));
                _local_6.playerID = _local_8;
                _local_6.timePlayed = 0;
                _local_6.timePlayedSinseTrack = 0;
                _local_6.timestamp = Math.floor((_local_7.getTime() / 1000));
                _local_6.lastEventType = 0;
                _local_6.lastEventTimestamp = _local_6.timestamp;
                _local_6.lastEventOffset = 0;
                _local_6.session = "";
                _local_6.lastTrackOffset = -1;
                _local_5.list[_arg_1] = _local_6;
            };
        }

        private function autoEvent(_arg_1:String, _arg_2:Number, _arg_3:String, _arg_4:Number, _arg_5:Number, _arg_6:Object):*
        {
            var _local_7:Object;
            _local_7 = this;
            _arg_1 = _local_7.cleanName(_arg_1);
            if ((((_local_7.s.isSet(_arg_1)) && (_local_7.s.isSet(_arg_2))) && (_local_7.s.isSet(_arg_3))))
            {
                if (((!(_local_7.s.isSet(_local_7.list))) || (!(_local_7.s.isSet(_local_7.list[_arg_1])))))
                {
                    _local_7.open(_arg_1, _arg_2, _arg_3, _arg_6);
                };
                _local_7.event(_arg_1, _arg_4, _arg_5);
            };
        }

        public function play(name:String, offset:Number):*
        {
            var m:Object;
            var media:Object;
            var monitor:Object;
            m = this;
            m.event(name, 1, offset);
            monitor = new Object();
            monitor.m = m;
            monitor.node = m.cleanName(name);
            monitor.monitor = function ():*
            {
                var _local_1:Object;
                var _local_2:Object;
                var _local_3:Object;
                _local_1 = this.m;
                _local_2 = this.node;
                _local_3 = ((((_local_1.s.isSet(_local_2)) && (_local_1.s.isSet(_local_1.list))) && (_local_1.s.isSet(_local_1.list[_local_2]))) ? _local_1.list[_local_2] : null);
                if (_local_1.s.isSet(_local_3))
                {
                    if (_local_3.lastEventType == 1)
                    {
                        _local_1.event(_local_3.name, 3, -1);
                    };
                }
                else
                {
                    this.node = null;
                };
            };
            m.startMonitor(monitor);
        }

        public function set autoTrack(_arg_1:Boolean):*
        {
            this._autoTrack = _arg_1;
            if (this._autoTrack)
            {
                this.autoTrackInterval = this.s.setupInterval(this, "doAutoTrack", 100, null);
            };
        }

        public function listenerFLVPlayback_stateChange(_arg_1:*):*
        {
            this.listenerFLVPlayback.stateChange(_arg_1);
        }

        public function listenerBrightcove_videoStart(_arg_1:*):*
        {
            this.listenerBrightcove.videoStart(_arg_1);
        }

        public function listenerMedia_change(_arg_1:*):*
        {
            this.listenerMedia.change(_arg_1);
        }

        private function attach(node:Object):Boolean
        {
            var m:Object;
            var member:String;
            var childNum:Number;
            var player:Object;
            var monitor:Object;
            var attached:Boolean;
            var subAttached:Boolean;
            m = this;
            attached = false;
            if (m.s.isSet(node))
            {
                if (((m.s.isSet(node, "getModule")) || (m.s.isSet(node, "showBrightcoveMenu"))))
                {
                    player = node;
                    if (((m.s.flashASVersion > 2) && (m.s.isSet(node, "getModule"))))
                    {
                        player = node.getModule("experience");
                        if ((((m.s.isSet(player)) && (m.s.isSet(player, "getReady"))) && (player.getReady())))
                        {
                            player = node.getModule("videoPlayer");
                        }
                        else
                        {
                            player = undefined;
                        };
                    };
                    if (((s.isSet(player)) && (s.isSet(player, "addEventListener"))))
                    {
                        if (!m.s.isSet(m.listenerBrightcove))
                        {
                            m.listenerBrightcove = new Object();
                            m.listenerBrightcove.m = m;
                            m.listenerBrightcove.playerName = "Brightcove";
                            if (m.s.flashASVersion > 2)
                            {
                                m.listenerBrightcove.playerName = (m.listenerBrightcove.playerName + " 3");
                            }
                            else
                            {
                                m.listenerBrightcove.playerName = (m.listenerBrightcove.playerName + " 2");
                            };
                            m.listenerBrightcove.handleEvent = function (_arg_1:Object, _arg_2:Number, _arg_3:Number):*
                            {
                                var _local_4:Object;
                                var _local_5:String;
                                var _local_6:Number;
                                var _local_7:Object;
                                _local_4 = this.m;
                                if (((_local_4.s.isSet(_local_4.autoTrack)) && (_local_4.s.isSet(_arg_1))))
                                {
                                    if (_local_4.s.flashASVersion > 2)
                                    {
                                        _local_7 = _arg_1.getCurrentVideo();
                                    }
                                    else
                                    {
                                        _local_7 = _arg_1.getCurrentTitle();
                                    };
                                    if (((_local_4.s.isSet(_local_7)) && (_local_4.s.isSet(_local_7.id))))
                                    {
                                        _local_5 = ((this.playerName + ":") + _local_7.id);
                                        _local_6 = (_local_7.length / 1000);
                                        if (_arg_3 < 0)
                                        {
                                            _arg_3 = _arg_1.getVideoPosition();
                                        };
                                        if (!_local_4.s.isSet(_arg_3))
                                        {
                                            _arg_3 = 0;
                                        };
                                        _local_4.autoEvent(_local_5, _local_6, this.playerName, _arg_2, _arg_3, _arg_1);
                                    };
                                };
                            };
                            m.listenerBrightcove.videoProgress = (m.listenerBrightcove.videoStart = (m.listenerBrightcove.progress = (m.listenerBrightcove.play = function (_arg_1:*):*
                            {
                                if (((((this.m.s.isSet(_arg_1)) && (this.m.s.isSet(_arg_1.target))) && (this.m.s.isSet(_arg_1.target.isPlaying))) && (_arg_1.target.isPlaying())))
                                {
                                    this.handleEvent(_arg_1.target, 1, ((typeof(_arg_1.position) == "number") ? _arg_1.position : -1));
                                };
                            })));
                            m.listenerBrightcove.videoStop = (m.listenerBrightcove.startBuffering = (m.listenerBrightcove.pause = (m.listenerBrightcove.buffering = (m.listenerBrightcove.scrubber = (m.listenerBrightcove.seek = function (_arg_1:*):*
                            {
                                if (this.m.s.isSet(_arg_1))
                                {
                                    this.handleEvent(_arg_1.target, 2, -1);
                                };
                            })))));
                            m.listenerBrightcove.videoComplete = (m.listenerBrightcove.mediaComplete = function (_arg_1:*):*
                            {
                                if (this.m.s.isSet(_arg_1))
                                {
                                    this.handleEvent(_arg_1.target, 0, -1);
                                };
                            });
                        };
                        if (m.s.flashASVersion > 2)
                        {
                            player.addEventListener("videoProgress", m.listenerBrightcove_videoProgress);
                            player.addEventListener("videoStart", m.listenerBrightcove_videoStart);
                            player.addEventListener("videoStop", m.listenerBrightcove_videoStop);
                            player.addEventListener("startBuffering", m.listenerBrightcove_startBuffering);
                            player.addEventListener("seek", m.listenerBrightcove_seek);
                            player.addEventListener("videoComplete", m.listenerBrightcove_videoComplete);
                        }
                        else
                        {
                            player.addEventListener("progress", m.listenerBrightcove, "progress");
                            player.addEventListener("play", m.listenerBrightcove, "play");
                            player.addEventListener("pause", m.listenerBrightcove, "pause");
                            player.addEventListener("buffering", m.listenerBrightcove, "buffering");
                            player.addEventListener("scrubber", m.listenerBrightcove, "scrubber");
                            player.addEventListener("seek", m.listenerBrightcove, "seek");
                            player.addEventListener("mediaComplete", m.listenerBrightcove, "mediaComplete");
                        };
                        monitor = new Object();
                        monitor.m = m;
                        monitor.node = player;
                        monitor.monitor = function ():*
                        {
                            var _local_1:Object;
                            var _local_2:Object;
                            _local_1 = this.m;
                            _local_2 = this.node;
                            if (((_local_1.s.isSet(_local_2.isPlaying)) && (_local_2.isPlaying())))
                            {
                                this.m.listenerBrightcove.handleEvent(_local_2, 3, -1);
                            };
                        };
                        m.startMonitor(monitor);
                        attached = true;
                        return (attached);
                    };
                };
                if (((m.s.isSet(node, "addEventListener")) && (m.s.isSet(node, "isFLVCuePointEnabled"))))
                {
                    if (!m.s.isSet(m.listenerFLVPlayback))
                    {
                        m.listenerFLVPlayback = new Object();
                        m.listenerFLVPlayback.m = m;
                        m.listenerFLVPlayback.playerName = "Flash FLVPlayback";
                        m.listenerFLVPlayback.handleEvent = function (_arg_1:Object, _arg_2:Number):*
                        {
                            var _local_3:Object;
                            var _local_4:String;
                            var _local_5:Number;
                            var _local_6:Number;
                            _local_3 = this.m;
                            if (((_local_3.s.isSet(_local_3.autoTrack)) && (_local_3.s.isSet(_arg_1))))
                            {
                                if (_local_3.s.flashASVersion > 2)
                                {
                                    _local_4 = _arg_1.source;
                                }
                                else
                                {
                                    _local_4 = _arg_1.contentPath;
                                };
                                _local_5 = _arg_1.totalTime;
                                _local_6 = _arg_1.playheadTime;
                                _local_3.autoEvent(_local_4, _local_5, this.playerName, _arg_2, _local_6, _arg_1);
                            };
                        };
                        m.listenerFLVPlayback.stateChange = function (_arg_1:*):*
                        {
                            var _local_2:Object;
                            var _local_3:Number;
                            var _local_4:Object;
                            _local_2 = this.m;
                            _local_3 = -1;
                            if (((_local_2.s.isSet(_arg_1)) && (_local_2.s.isSet(_arg_1.target))))
                            {
                                _local_4 = _arg_1.target;
                                if (_local_2.s.isSet(_local_4, "state"))
                                {
                                    if (_local_4.state == "playing")
                                    {
                                        _local_3 = 1;
                                    }
                                    else
                                    {
                                        if ((((((_local_4.state == "stopped") || (_local_4.state == "paused")) || (_local_4.state == "buffering")) || (_local_4.state == "rewinding")) || (_local_4.state == "seeking")))
                                        {
                                            _local_3 = 2;
                                        };
                                    };
                                    if (_local_3 >= 0)
                                    {
                                        this.handleEvent(_arg_1.target, _local_3);
                                    };
                                };
                            };
                        };
                        m.listenerFLVPlayback.complete = function (_arg_1:*):*
                        {
                            if (this.m.s.isSet(_arg_1))
                            {
                                this.handleEvent(_arg_1.target, 0);
                            };
                        };
                    };
                    if (m.s.flashASVersion > 2)
                    {
                        node.addEventListener("complete", m.listenerFLVPlayback_complete);
                        node.addEventListener("stateChange", m.listenerFLVPlayback_stateChange);
                    }
                    else
                    {
                        node.addEventListener("complete", m.listenerFLVPlayback);
                        node.addEventListener("stateChange", m.listenerFLVPlayback);
                    };
                    monitor = new Object();
                    monitor.m = m;
                    monitor.node = node;
                    monitor.monitor = function ():*
                    {
                        var _local_1:Object;
                        var _local_2:Object;
                        _local_1 = this.m;
                        _local_2 = this.node;
                        if (((_local_1.s.isSet(_local_2.state)) && (_local_2.state == "playing")))
                        {
                            this.m.listenerFLVPlayback.handleEvent(_local_2, 3);
                        };
                    };
                    m.startMonitor(monitor);
                    attached = true;
                    return (attached);
                };
                if (((m.s.isSet(node, "addEventListener")) && (m.s.isSet(node, "addCuePoint"))))
                {
                    if (!m.s.isSet(m.listenerMedia))
                    {
                        m.listenerMedia = new Object();
                        m.listenerMedia.m = m;
                        m.listenerMedia.playerName = "Flash Media";
                        m.listenerMedia.handleEvent = function (_arg_1:Object, _arg_2:Number):*
                        {
                            var _local_3:Object;
                            var _local_4:String;
                            var _local_5:Number;
                            var _local_6:Number;
                            _local_3 = this.m;
                            if (((_local_3.s.isSet(_local_3.autoTrack)) && (_local_3.s.isSet(_arg_1))))
                            {
                                _local_4 = _arg_1.contentPath;
                                _local_5 = _arg_1.totalTime;
                                _local_6 = _arg_1.playheadTime;
                                _local_3.autoEvent(_local_4, _local_5, this.playerName, _arg_2, _local_6, _arg_1);
                            };
                        };
                        m.listenerMedia.complete = function (_arg_1:*):*
                        {
                            if (this.m.s.isSet(_arg_1))
                            {
                                this.handleEvent(_arg_1.target, 0);
                            };
                        };
                        m.listenerMedia.click = function (_arg_1:*):*
                        {
                            if (((this.m.s.isSet(_arg_1)) && (this.m.s.isSet(_arg_1.target))))
                            {
                                this.handleEvent(_arg_1.target, ((this.m.s.isSet(_arg_1.target.playing)) ? 1 : 2));
                            };
                        };
                        m.listenerMedia.change = function (_arg_1:*):*
                        {
                            if (((this.m.s.isSet(_arg_1)) && (this.m.s.isSet(_arg_1.target))))
                            {
                                this.handleEvent(_arg_1.target, ((this.m.s.isSet(_arg_1.target.playing)) ? 1 : 2));
                            };
                        };
                        m.listenerMedia.scrubbing = function (_arg_1:*):*
                        {
                            if (this.m.s.isSet(_arg_1))
                            {
                                this.handleEvent(_arg_1.target, 2);
                            };
                        };
                    };
                    if (m.s.flashASVersion > 2)
                    {
                        node.addEventListener("complete", m.listenerMedia_complete);
                        node.addEventListener("click", m.listenerMedia_click);
                        node.addEventListener("change", m.listenerMedia_change);
                        node.addEventListener("scrubbing", m.listenerMedia_scrubbing);
                    }
                    else
                    {
                        node.addEventListener("complete", m.listenerMedia);
                        node.addEventListener("click", m.listenerMedia);
                        node.addEventListener("change", m.listenerMedia);
                        node.addEventListener("scrubbing", m.listenerMedia);
                    };
                    monitor = new Object();
                    monitor.m = m;
                    monitor.node = node;
                    monitor.monitor = function ():*
                    {
                        var _local_1:Object;
                        var _local_2:Object;
                        _local_1 = this.m;
                        _local_2 = this.node;
                        if (_local_1.s.isSet(_local_2.playing))
                        {
                            this.m.listenerMedia.handleEvent(_local_2, 3);
                        };
                    };
                    m.startMonitor(monitor);
                    attached = true;
                    return (attached);
                };
                if (m.s.flashASVersion > 2)
                {
                    if (((m.s.isSet(node, "numChildren")) && (m.s.isSet(node, "getChildAt"))))
                    {
                        childNum = 0;
                        while (childNum < node.numChildren)
                        {
                            subAttached = m.attach(node.getChildAt(childNum));
                            if (m.s.isSet(subAttached))
                            {
                                attached = subAttached;
                            };
                            childNum++;
                        };
                    };
                }
                else
                {
                    for (member in node)
                    {
                        if (((((m.s.isSet(node[member])) && (m.s.isSet(node[member]._name))) && (node[member]._name == member)) && (((("" + node) + ".") + member) == ("" + node[member]))))
                        {
                            subAttached = m.attach(node[member]);
                            if (m.s.isSet(subAttached))
                            {
                                attached = subAttached;
                            };
                        };
                    };
                };
            };
            return (attached);
        }

        public function listenerBrightcove_videoStop(_arg_1:*):*
        {
            this.listenerBrightcove.videoStop(_arg_1);
        }

        public function open(_arg_1:String, _arg_2:Number, _arg_3:String, _arg_4:Object=null):*
        {
            this._open(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function track(_arg_1:String):*
        {
            var _local_2:Object;
            _local_2 = this;
            if (_local_2.s.isSet(_local_2.trackWhilePlaying))
            {
                _local_2.event(_arg_1, 4, -1);
            };
        }

        public function get autoTrack():Boolean
        {
            return (this._autoTrack);
        }

        public function listenerBrightcove_videoProgress(_arg_1:*):*
        {
            this.listenerBrightcove.videoProgress(_arg_1);
        }

        private function cleanName(_arg_1:String):String
        {
            var _local_2:Object;
            _local_2 = this;
            return (_local_2.s.replace(_local_2.s.replace(_local_2.s.replace(_arg_1, "\n", ""), "\r", ""), "--**--", ""));
        }

        public function listenerBrightcove_startBuffering(_arg_1:*):*
        {
            this.listenerBrightcove.startBuffering(_arg_1);
        }

        public function close(_arg_1:String):*
        {
            this.event(_arg_1, 0, -1);
        }

        public function listenerBrightcove_videoComplete(_arg_1:*):*
        {
            this.listenerBrightcove.videoComplete(_arg_1);
        }


    }
}//package com.omniture
