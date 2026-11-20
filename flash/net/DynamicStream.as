//Created by Action Script Viewer - https://www.buraks.com/asv
package flash.net
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.NetStatusEvent;
    import flash.utils.getTimer;

    public class DynamicStream extends NetStream 
    {

        public static var FMS_BURST_MULTIPLIER:Number = 1.2;
        public static const VERSION:String = "1.1.0.6";

        public const STATE_BUFFERING:String = "buffering";
        private const DEBUG:Boolean = false;
        private const BUFFER_FILLED:Number = 1;
        private const PREFERRED_BUFFERLENGTH:Number = 8;
        public const STATE_PLAYING:String = "playing";
        private const BUFFER_BUFFERING:Number = 2;
        private const LIVE_ERROR_CORRECTION_LIMIT:int = 2;
        public const STATE_PAUSED:String = "paused";
        private const STARTUP_BUFFERLENGTH:Number = 2;
        public const STATE_STOPPED:String = "stopped";
        private const MAIN_TIMER_INTERVAL:Number = 0.15;
        private const DROPPED_FRAMES_PERCENTAGE_CAP:Number = 0.35;
        private const DROPPED_FRAMES_TIMER_INTERVAL:uint = 300;

        public var PREFERRED_BUFFERLENGTH_LIVE:Number = 10;
        private var mainTimer:Timer;
        private var _previousMaxBandwidth:Number = 0;
        private var _maxRate:Number = 0;
        private var _liveStream:Boolean;
        private var dsPlayIndex:int = 0;
        private var qosTimer:Timer;
        private var _curStreamID:int = 0;
        private var _startBufferLength:Number;
        private var _aggressiveModeBufferLength:Number;
        private var _droppedFramesLockDelay:int;
        private var _droppedFramesLockRate:int;
        private var _nc:NetConnection;
        private var droppedFramesTimer:Timer;
        private var _liveBWErrorCount:int = 0;
        private var _preferredBufferLength:Number;
        private var _maxBandwidth:Number = 0;
        private var _curBufferTime:uint = 0;
        private var _switchMode:Boolean = false;
        public var DELAY_LIVE_QOS_CHECK_COUNT:int = 10;
        private var _lastMaxBandwidthSO:SharedObject;
        private var _switchQOSTimerDelay:Number;
        private var dsPlayList:Array;
        private var _bufferMode:int = 0;
        private var bandwidthlimit:int = -1;
        private var _reachedBufferTime:Boolean = false;
        private var dsPlayListLen:int;
        private var _manualSwitchMode:Boolean;
        private var _previousDroppedFramesTime:uint = 0;
        private var _prevStreamID:int = 0;
        private var _previousDroppedFrames:uint = 0;
        public var DROPPED_FRAMES_LOCK_LIMIT:uint = 8;
        private var dsPlayState:String;
        public var EMPTY_BUFFERLENGTH:Number = 1;

        public function DynamicStream(_arg_1:NetConnection)
        {
            super(_arg_1);
            this._nc = _arg_1;
            this.dsPlayList = new Array();
            this._preferredBufferLength = this.PREFERRED_BUFFERLENGTH;
            this._switchQOSTimerDelay = (this.PREFERRED_BUFFERLENGTH / 2.5);
            this._startBufferLength = this.STARTUP_BUFFERLENGTH;
            this._aggressiveModeBufferLength = (this.PREFERRED_BUFFERLENGTH / 2);
            this._maxRate = 0;
            this._manualSwitchMode = false;
            this._droppedFramesLockRate = int.MAX_VALUE;
            this._liveStream = false;
            this._maxBandwidth = 0;
            this._lastMaxBandwidthSO = SharedObject.getLocal("AdobeDynamicStream", "/", false);
            this._maxBandwidth = this._lastMaxBandwidthSO.data.maxBandwidth;
            this._curBufferTime = this._startBufferLength;
            this.mainTimer = new Timer((this.MAIN_TIMER_INTERVAL * 1000), 0);
            this.mainTimer.addEventListener(TimerEvent.TIMER, this.monitorQOS);
            this.qosTimer = new Timer((this._switchQOSTimerDelay * 1000), 0);
            this.qosTimer.addEventListener(TimerEvent.TIMER, this.getQOSAndSwitch);
            this.droppedFramesTimer = new Timer((this.DROPPED_FRAMES_TIMER_INTERVAL * 1000), 0);
            this.droppedFramesTimer.addEventListener(TimerEvent.TIMER, this.releaseDFLock);
            this.addEventListener(NetStatusEvent.NET_STATUS, this.onNSStatus);
            this._nc.addEventListener(NetStatusEvent.NET_STATUS, this.onNSStatus);
            this._switchMode = false;
        }

        private function init():void
        {
            if (this.info == null)
            {
                return;
            };
            this.debug("initializing ...");
            this._previousDroppedFrames = this.info.droppedFrames;
            this._previousDroppedFramesTime = getTimer();
            this._bufferMode = this.BUFFER_BUFFERING;
            this._reachedBufferTime = false;
        }

        private function SwitchUpOnMaxBandwidth():void
        {
            if (this.info == null)
            {
                return;
            };
            if (this._manualSwitchMode)
            {
                if (this._curBufferTime != this._preferredBufferLength)
                {
                    this._curBufferTime = this._preferredBufferLength;
                    this.debug(("setting buffer time to " + this._curBufferTime));
                    this.bufferTime = this._curBufferTime;
                };
                return;
            };
            var _local_1:int = getTimer();
            var _local_2:int = this.info.droppedFrames;
            var _local_3:int;
            var _local_4:int = (this.dsPlayList[this.dsPlayIndex].streamCount - 1);
            while (_local_4 >= 0)
            {
                if (this._maxBandwidth > this.dsPlayList[this.dsPlayIndex].streams[_local_4].rate)
                {
                    _local_3 = _local_4;
                    break;
                };
                _local_4--;
            };
            if (_local_3 < this._curStreamID)
            {
                _local_3 = this._curStreamID;
            }
            else
            {
                if (_local_3 > this._curStreamID)
                {
                    if (this.bufferLength < this._curBufferTime)
                    {
                        _local_3 = this._curStreamID;
                    };
                };
            };
            if (_local_3 > (this.dsPlayList[this.dsPlayIndex].streamCount - 1))
            {
                _local_3 = (this.dsPlayList[this.dsPlayIndex].streamCount - 1);
            };
            if (_local_3 > 0)
            {
                if (this.dsPlayList[this.dsPlayIndex].streams[_local_3].rate >= this._droppedFramesLockRate)
                {
                    return;
                };
            };
            if (this._curStreamID != _local_3)
            {
                this.switchStream(_local_3);
            };
            if (this._curBufferTime != this._preferredBufferLength)
            {
                this._curBufferTime = this._preferredBufferLength;
                this.debug(("setting buffer time to " + this._curBufferTime));
                this.bufferTime = this._curBufferTime;
            };
        }

        private function getMaxBandwidth():void
        {
            var _local_1:Number;
            if (this.info == null)
            {
                this.mainTimer.stop();
                return;
            };
            if (this.bandwidthlimit > -1)
            {
                _local_1 = ((this.info.maxBytesPerSecond * 8) / 0x0400);
                if (this.bandwidthlimit > _local_1)
                {
                    this._maxBandwidth = _local_1;
                }
                else
                {
                    this._maxBandwidth = this.bandwidthlimit;
                };
            }
            else
            {
                this._maxBandwidth = ((this.info.maxBytesPerSecond * 8) / 0x0400);
            };
        }

        public function get droppedFramesLockDelay():Number
        {
            return (this._droppedFramesLockDelay);
        }

        override public function play(... _args):void
        {
            var _local_2:DynamicStreamItem;
            if ((_args[0] is DynamicStreamItem))
            {
                this.startPlay(_args[0]);
            }
            else
            {
                if (_args[0] == false)
                {
                    super.play(false);
                }
                else
                {
                    _local_2 = new DynamicStreamItem();
                    _local_2.addStream(String(_args[0]), 0);
                    if (!isNaN(_args[1]))
                    {
                        _local_2.start = _args[1];
                    };
                    if (!isNaN(_args[2]))
                    {
                        _local_2.len = _args[2];
                    };
                    if (_args[3] == false)
                    {
                        _local_2.reset = _args[3];
                    };
                    this.startPlay(_local_2);
                };
            };
        }

        public function onMetaData(_arg_1:Object):void
        {
            this.debug("onMetaData called");
        }

        private function debug(_arg_1:String):void
        {
            if (this.DEBUG)
            {
                trace(_arg_1);
            };
        }

        public function switchToStreamName(_arg_1:String):void
        {
            if (_arg_1.indexOf(":") != -1)
            {
                _arg_1 = _arg_1.split(":")[1];
            };
            var _local_2:int = -1;
            var _local_3:int;
            while (_local_3 < this.dsPlayList[this.dsPlayIndex].streams.length)
            {
                if (this.dsPlayList[this.dsPlayIndex].streams[_local_3]["name"].indexOf(_arg_1) > 0)
                {
                    _local_2 = _local_3;
                    break;
                };
                _local_3++;
            };
            if (((this._manualSwitchMode) && (_local_2 >= 0)))
            {
                this.switchStream(_local_2);
            };
        }

        public function manualSwitchMode(_arg_1:Boolean):void
        {
            this._manualSwitchMode = _arg_1;
        }

        public function set aggressiveModeBufferLength(_arg_1:Number):void
        {
            this._aggressiveModeBufferLength = _arg_1;
        }

        private function monitorQOS(_arg_1:TimerEvent):void
        {
            var _local_2:Number = this.time;
            if (this.time == 0)
            {
                return;
            };
            if (this._bufferMode == this.BUFFER_BUFFERING)
            {
                return;
            };
            if (this.bufferLength >= this._preferredBufferLength)
            {
                this._reachedBufferTime = true;
            };
            this.getMaxBandwidth();
        }

        public function set droppedFramesLockDelay(_arg_1:Number):void
        {
            this.droppedFramesTimer.delay = (_arg_1 * 1000);
            this._droppedFramesLockDelay = _arg_1;
        }

        public function get preferredBufferLength():Number
        {
            return (this._preferredBufferLength);
        }

        private function playAppend(_arg_1:Number, _arg_2:Number, _arg_3:Boolean):void
        {
            var _local_4:NetStreamPlayOptions = new NetStreamPlayOptions();
            _local_4.streamName = this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].name;
            _local_4.start = _arg_1;
            _local_4.len = _arg_2;
            _local_4.transition = ((_arg_3) ? NetStreamPlayTransitions.RESET : NetStreamPlayTransitions.APPEND);
            super.play2(_local_4);
        }

        override public function play2(_arg_1:NetStreamPlayOptions):void
        {
            throw (new Error("The play2() method has been disabled for this class.  Please create a separate NetStream object to use play2()."));
        }

        public function get switchQOSTimerDelay():Number
        {
            return (this._switchQOSTimerDelay);
        }

        public function get currentStreamName():String
        {
            return (this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].name);
        }

        public function onPlayStatus(_arg_1:Object):void
        {
            this.debug(("onPlayStatus called with " + _arg_1.code));
            switch (_arg_1.code)
            {
                case "NetStream.Play.TransitionComplete":
                    this.debug(("transitioned to " + _arg_1.details));
                    return;
                case "NetStream.Play.Complete":
                    return;
                case "NetStream.Play.Failed":
                    this._curStreamID = this._prevStreamID;
                    this._switchMode = false;
                    return;
            };
        }

        private function checkLiveQOSAndSwitch():void
        {
            var _local_2:int;
            var _local_3:int;
            this.debug(((((((("max bw: " + this._maxBandwidth) + " cur bitrate: ") + this.currentStreamBitRate) + " buffer: ") + this.bufferLength) + "\tfps: ") + this.currentFPS));
            if (this.qosTimer.currentCount <= this.DELAY_LIVE_QOS_CHECK_COUNT)
            {
                return;
            };
            if (((this._maxBandwidth < this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate) && (this._liveBWErrorCount < this.LIVE_ERROR_CORRECTION_LIMIT)))
            {
                this._maxBandwidth = this._previousMaxBandwidth;
                this._liveBWErrorCount++;
            }
            else
            {
                this._liveBWErrorCount = 0;
                this._previousMaxBandwidth = this._maxBandwidth;
            };
            var _local_1:int = getTimer();
            if ((((this.bufferLength < (this._preferredBufferLength / 2)) || ((this._maxBandwidth < this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate) && (!(this._maxBandwidth == 0)))) || ((this.currentFPS > 0) && ((((this.info.droppedFrames - this._previousDroppedFrames) * 1000) / (_local_1 - this._previousDroppedFramesTime)) > (this.currentFPS * this.DROPPED_FRAMES_PERCENTAGE_CAP)))))
            {
                _local_2 = 0;
                if (this.bufferLength < (this._preferredBufferLength / 2))
                {
                    if (this.bufferLength < (this.preferredBufferLength / 2))
                    {
                        _local_2 = (this._curStreamID - 1);
                    }
                    else
                    {
                        if (this.bufferLength <= (this.preferredBufferLength / 3))
                        {
                            _local_2 = 0;
                        };
                    };
                    if (_local_2 < 0)
                    {
                        _local_2 = 0;
                    };
                    this.debug("Switching down because of buffer");
                }
                else
                {
                    if (this._maxBandwidth < this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate)
                    {
                        _local_3 = (this.dsPlayList[this.dsPlayIndex].streamCount - 1);
                        while (_local_3 >= 0)
                        {
                            if (this._maxBandwidth > this.dsPlayList[this.dsPlayIndex].streams[_local_3].rate)
                            {
                                _local_2 = _local_3;
                                break;
                            };
                            _local_3--;
                        };
                        if (_local_2 < this._curStreamID)
                        {
                            if (this._maxBandwidth < this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate)
                            {
                                this.debug((int(this._maxBandwidth) + " - Switching down because of maxBitrate lower than current stream bitrate"));
                            }
                            else
                            {
                                if (this.bufferLength < (this._preferredBufferLength / 2))
                                {
                                    this.debug("Switching down because of buffer");
                                };
                            };
                        };
                    }
                    else
                    {
                        this.debug(((((("Switching down because of dropped fps " + (((this.info.droppedFrames - this._previousDroppedFrames) * 1000) / (_local_1 - this._previousDroppedFramesTime))) + " is greather than ") + this.DROPPED_FRAMES_PERCENTAGE_CAP) + " of fps: ") + (this.currentFPS * this.DROPPED_FRAMES_PERCENTAGE_CAP)));
                        this._droppedFramesLockRate = this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate;
                        if (((this.droppedFramesTimer.currentCount < this.DROPPED_FRAMES_LOCK_LIMIT) && (!(this.droppedFramesTimer.running))))
                        {
                            this.droppedFramesTimer.start();
                            this.debug(((("Activating lock to prevent switching to " + this._droppedFramesLockRate) + " | Offense Number ") + this.droppedFramesTimer.currentCount));
                        };
                        _local_2 = (this._curStreamID - 1);
                    };
                };
                if (_local_2 > 0)
                {
                    if (this.dsPlayList[this.dsPlayIndex].streams[_local_2].rate >= this._droppedFramesLockRate)
                    {
                        this.debug(((("next rate: " + this.dsPlayList[this.dsPlayIndex].streams[_local_2].rate) + " lock rate: ") + this._droppedFramesLockRate));
                        return;
                    };
                };
                if (this._curStreamID != _local_2)
                {
                    this.switchStream(_local_2);
                };
                this._previousDroppedFrames = this.info.droppedFrames;
                this._previousDroppedFramesTime = getTimer();
            }
            else
            {
                this.SwitchUpOnMaxBandwidth();
            };
        }

        public function setBandwidthLimit(_arg_1:Number):void
        {
            this.bandwidthlimit = _arg_1;
        }

        private function releaseDFLock(_arg_1:TimerEvent):void
        {
            this.debug("Releasing dropped frames lock and setting the rate back to MAX_VALUE");
            this._droppedFramesLockRate = int.MAX_VALUE;
            this.droppedFramesTimer.stop();
        }

        private function checkVodQOSAndSwitch():void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            this.debug(((((((("max bw: " + this._maxBandwidth) + " cur bitrate: ") + this.currentStreamBitRate) + " buffer: ") + this.bufferLength) + "fps: ") + this.currentFPS));
            this._lastMaxBandwidthSO.data.maxBandwidth = this._maxBandwidth;
            var _local_1:Number = (((this.info.droppedFrames - this._previousDroppedFrames) * 1000) / (_local_2 - this._previousDroppedFramesTime));
            _local_2 = getTimer();
            if ((((this.bufferLength < this._preferredBufferLength) || ((this._maxBandwidth < this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate) && (!(this._maxBandwidth == 0)))) || ((this.currentFPS > 0) && ((_local_1 / (_local_1 + this.currentFPS)) > this.DROPPED_FRAMES_PERCENTAGE_CAP))))
            {
                _local_3 = 0;
                if (((this.bufferLength < this._preferredBufferLength) || (this._maxBandwidth < this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate)))
                {
                    _local_4 = (this.dsPlayList[this.dsPlayIndex].streamCount - 1);
                    while (_local_4 >= 0)
                    {
                        if (this._maxBandwidth > this.dsPlayList[this.dsPlayIndex].streams[_local_4].rate)
                        {
                            _local_3 = _local_4;
                            break;
                        };
                        _local_4--;
                    };
                    if (_local_3 < this._curStreamID)
                    {
                        if (this._maxBandwidth < this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate)
                        {
                            this.debug("Switching down because of maxBitrate lower than current stream bitrate");
                        }
                        else
                        {
                            if (this.bufferLength < this._curBufferTime)
                            {
                                this.debug("Switching down because of buffer");
                            };
                        };
                    };
                    if (((this.bufferLength > this._curBufferTime) && (!(this._curBufferTime == this._preferredBufferLength))))
                    {
                        this._curBufferTime = this._preferredBufferLength;
                        this.debug(("setting buffer time to " + this._curBufferTime));
                        this.bufferTime = this._curBufferTime;
                    };
                }
                else
                {
                    this.debug(((((("Switching down because of dropped fps " + (((this.info.droppedFrames - this._previousDroppedFrames) * 1000) / (_local_2 - this._previousDroppedFramesTime))) + " is greather than ") + this.DROPPED_FRAMES_PERCENTAGE_CAP) + " of fps: ") + (this.currentFPS * this.DROPPED_FRAMES_PERCENTAGE_CAP)));
                    this._droppedFramesLockRate = this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate;
                    if (((this.droppedFramesTimer.currentCount < this.DROPPED_FRAMES_LOCK_LIMIT) && (!(this.droppedFramesTimer.running))))
                    {
                        this.droppedFramesTimer.start();
                        this.debug(((("Activating lock to prevent switching to " + this._droppedFramesLockRate) + " | Offense Number ") + this.droppedFramesTimer.currentCount));
                    };
                    _local_3 = (this._curStreamID - 1);
                };
                if (((this.bufferLength < this._aggressiveModeBufferLength) && (this._reachedBufferTime)))
                {
                    this.debug("switching to the aggressive mode");
                    _local_3 = 0;
                    this.qosTimer.delay = ((this._switchQOSTimerDelay * 1000) / 2);
                };
                if (_local_3 > 0)
                {
                    if (this.dsPlayList[this.dsPlayIndex].streams[_local_3].rate >= this._droppedFramesLockRate)
                    {
                        return;
                    };
                };
                if (this._curStreamID != _local_3)
                {
                    this.switchStream(_local_3);
                };
                this._previousDroppedFrames = this.info.droppedFrames;
                this._previousDroppedFramesTime = getTimer();
            }
            else
            {
                this.SwitchUpOnMaxBandwidth();
                if (this.qosTimer.delay != (this._switchQOSTimerDelay * 1000))
                {
                    this.qosTimer.delay = (this._switchQOSTimerDelay * 1000);
                };
            };
        }

        public function set startBufferLength(_arg_1:Number):void
        {
            this._startBufferLength = _arg_1;
        }

        public function get maxBandwidth():Number
        {
            return (this._maxBandwidth);
        }

        public function startPlay(_arg_1:DynamicStreamItem):void
        {
            var _local_2:int;
            var _local_3:int;
            _arg_1.streamCount = (((_arg_1.streamCount > 0) && (_arg_1.streamCount <= _arg_1.streams.length)) ? _arg_1.streamCount : _arg_1.streams.length);
            this.dsPlayList.push(_arg_1);
            this.dsPlayListLen = this.dsPlayList.length;
            this._curStreamID = 0;
            this._prevStreamID = 0;
            if (_arg_1.startRate > 0)
            {
                _local_2 = (this.dsPlayList[this.dsPlayIndex].streams.length - 1);
                while (_local_2 >= 0)
                {
                    if (_arg_1.startRate >= this.dsPlayList[this.dsPlayIndex].streams[_local_2].rate)
                    {
                        this._curStreamID = _local_2;
                        break;
                    };
                    _local_2--;
                };
            }
            else
            {
                _local_3 = (this.dsPlayList[this.dsPlayIndex].streams.length - 1);
                while (((_local_3 >= 0) && (this._maxBandwidth > 0)))
                {
                    if (this._maxBandwidth > this.dsPlayList[this.dsPlayIndex].streams[_local_3].rate)
                    {
                        this._curStreamID = _local_3;
                        break;
                    };
                    _local_3--;
                };
            };
            if (_arg_1.start == -1)
            {
                this._liveStream = true;
                this._liveBWErrorCount = 0;
                this._previousMaxBandwidth = this._maxBandwidth;
                this._preferredBufferLength = this.PREFERRED_BUFFERLENGTH_LIVE;
                this.debug(("preferred buffer length " + this._preferredBufferLength));
                if (this._switchQOSTimerDelay == (this.PREFERRED_BUFFERLENGTH / 2.5))
                {
                    this.switchQOSTimerDelay = Math.max((this._preferredBufferLength / 5), 2);
                };
                this._curBufferTime = this._preferredBufferLength;
            }
            else
            {
                this._curBufferTime = this._startBufferLength;
                this._liveStream = false;
            };
            if (_arg_1.reset == false)
            {
                this.playAppend(_arg_1.start, _arg_1.len, false);
            }
            else
            {
                this.bufferTime = this._curBufferTime;
                this.playAppend(_arg_1.start, _arg_1.len, true);
            };
            if (!this._liveStream)
            {
                this._maxRate = Math.max(this._maxRate, ((_arg_1.streams[(_arg_1.streamCount - 1)].rate * 0x0400) / 8));
                this._nc.call("setBandwidthLimit", null, (this._maxRate * FMS_BURST_MULTIPLIER), (this._maxRate * FMS_BURST_MULTIPLIER));
            };
        }

        public function switchToStreamRate(_arg_1:int):void
        {
            var _local_4:int;
            var _local_2:int = -1;
            var _local_3:int;
            while (_local_3 < this.dsPlayList[this.dsPlayIndex].streams.length)
            {
                if (this.dsPlayList[this.dsPlayIndex].streams[_local_3].rate == _arg_1)
                {
                    _local_2 = _local_3;
                    break;
                };
                _local_3++;
            };
            if (_local_2 < 0)
            {
                _local_4 = (this.dsPlayList[this.dsPlayIndex].streams.length - 1);
                while (_local_4 >= 0)
                {
                    if (_arg_1 > this.dsPlayList[this.dsPlayIndex].streams[_local_4].rate)
                    {
                        _local_2 = _local_4;
                        break;
                    };
                    _local_4--;
                };
            };
            if (((this._manualSwitchMode) && (_local_2 >= 0)))
            {
                this.switchStream(_local_2);
            };
        }

        public function getStreamItemAt(_arg_1:int=-1):DynamicStreamItem
        {
            if (((_arg_1 > -1) && (_arg_1 < this.dsPlayList.length)))
            {
                return (this.dsPlayList[_arg_1]);
            };
            return (this.dsPlayList[this.dsPlayIndex]);
        }

        private function getQOSAndSwitch(_arg_1:TimerEvent):void
        {
            if (this.info == null)
            {
                this.qosTimer.stop();
                return;
            };
            if (this._manualSwitchMode)
            {
                return;
            };
            if (this._liveStream)
            {
                this.checkLiveQOSAndSwitch();
            }
            else
            {
                this.checkVodQOSAndSwitch();
            };
            this._lastMaxBandwidthSO.data.maxBandwidth = this._maxBandwidth;
        }

        public function get startBufferLength():Number
        {
            return (this._startBufferLength);
        }

        private function switchStream(_arg_1:Number=0):void
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (_arg_1 > (this.dsPlayList[this.dsPlayIndex].streams.length - 1))
            {
                _arg_1 = (this.dsPlayList[this.dsPlayIndex].streams.length - 1);
            };
            if (_arg_1 == this._curStreamID)
            {
                return;
            };
            if (this._switchMode == true)
            {
                return;
            };
            this._prevStreamID = this._curStreamID;
            this._curStreamID = _arg_1;
            this.debug(((("Switch Mode: " + this._switchMode) + " - sending switch to server to bit rate: ") + this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate));
            var _local_2:NetStreamPlayOptions = new NetStreamPlayOptions();
            _local_2.streamName = this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].name;
            _local_2.transition = NetStreamPlayTransitions.SWITCH;
            _local_2.start = this.dsPlayList[this.dsPlayIndex].start;
            _local_2.len = this.dsPlayList[this.dsPlayIndex].len;
            super.play2(_local_2);
            this._switchMode = true;
        }

        public function set switchQOSTimerDelay(_arg_1:Number):void
        {
            this.qosTimer.delay = (_arg_1 * 1000);
            this._switchQOSTimerDelay = _arg_1;
        }

        public function get aggressiveModeBufferLength():Number
        {
            return (this._aggressiveModeBufferLength);
        }

        public function set preferredBufferLength(_arg_1:Number):void
        {
            this._preferredBufferLength = _arg_1;
            if (this._liveStream)
            {
                this.switchQOSTimerDelay = Math.max((this._preferredBufferLength / 5), 1);
                this._curBufferTime = this._preferredBufferLength;
                this.bufferTime = this._curBufferTime;
                this._aggressiveModeBufferLength = (this._preferredBufferLength / 2);
            }
            else
            {
                this.switchQOSTimerDelay = Math.max((this._preferredBufferLength / 2.5), 1);
            };
        }

        public function switchUp():void
        {
            if (this._manualSwitchMode)
            {
                this.switchStream((this._curStreamID + 1));
            };
        }

        public function get currentStreamBitRate():Number
        {
            return (this.dsPlayList[this.dsPlayIndex].streams[this._curStreamID].rate);
        }

        public function switchDown():void
        {
            if (this._manualSwitchMode)
            {
                this.switchStream((this._curStreamID - 1));
            };
        }

        private function onNSStatus(_arg_1:NetStatusEvent):void
        {
            this.debug(("ns status: " + _arg_1.info.code));
            switch (_arg_1.info.code)
            {
                case "NetStream.Play.Stop":
                    this.debug("no more QOS check");
                    this.dsPlayState = this.STATE_STOPPED;
                    this.mainTimer.stop();
                    this.qosTimer.stop();
                    return;
                case "NetStream.Play.Start":
                    this.init();
                    this.mainTimer.start();
                    this.dsPlayState = this.STATE_PLAYING;
                    return;
                case "NetStream.Buffer.Full":
                    this.getMaxBandwidth();
                    this.SwitchUpOnMaxBandwidth();
                    this._bufferMode = this.BUFFER_FILLED;
                    this.qosTimer.start();
                    return;
                case "NetStream.Buffer.Empty":
                    if (!this._manualSwitchMode)
                    {
                        this._curStreamID = 0;
                    };
                    if (!this._liveStream)
                    {
                        this._curBufferTime = this.EMPTY_BUFFERLENGTH;
                        this.bufferTime = this._curBufferTime;
                    };
                    if (!this._manualSwitchMode)
                    {
                        this.switchStream();
                    };
                    this.qosTimer.stop();
                    this.init();
                    return;
                case "NetStream.Seek.Notify":
                    if (!this._liveStream)
                    {
                        this._curBufferTime = this._startBufferLength;
                        this.bufferTime = this._curBufferTime;
                    };
                    this._bufferMode = this.BUFFER_BUFFERING;
                    this._reachedBufferTime = false;
                    return;
                case "NetStream.Pause.Notify":
                    if (this.qosTimer.running)
                    {
                        this.qosTimer.stop();
                    };
                    if (this.mainTimer.running)
                    {
                        this.mainTimer.stop();
                    };
                    this.dsPlayState = this.STATE_PAUSED;
                    return;
                case "NetStream.Unpause.Notify":
                    if (!this.qosTimer.running)
                    {
                        this.qosTimer.start();
                    };
                    if (!this.mainTimer.running)
                    {
                        this.mainTimer.start();
                    };
                    this.dsPlayState = this.STATE_PLAYING;
                    return;
                case "NetStream.Play.Transition":
                    this.debug(("transition successful for " + _arg_1.info.details));
                    this._switchMode = false;
                    return;
                case "NetStream.Play.StreamNotFound":
                    this._curStreamID = this._prevStreamID;
                    this._switchMode = false;
                    return;
                case "NetConnection.Connect.Closed":
                    this._switchMode = false;
                    this.mainTimer.stop();
                    this.qosTimer.stop();
                    return;
            };
        }

        override public function close():void
        {
            super.close();
            this.dsPlayList = new Array();
            this._preferredBufferLength = this.PREFERRED_BUFFERLENGTH;
            this._switchQOSTimerDelay = (this.PREFERRED_BUFFERLENGTH / 2.5);
            this._startBufferLength = this.STARTUP_BUFFERLENGTH;
            this._aggressiveModeBufferLength = (this.PREFERRED_BUFFERLENGTH / 2);
            this._maxRate = 0;
            this._manualSwitchMode = false;
            this._droppedFramesLockRate = int.MAX_VALUE;
            this._liveStream = false;
            this._maxBandwidth = 0;
            this._maxBandwidth = this._lastMaxBandwidthSO.data.maxBandwidth;
            this._curBufferTime = this._startBufferLength;
            this.mainTimer.reset();
            this.qosTimer.reset();
            this.droppedFramesTimer.reset();
            this._switchMode = false;
        }


    }
}//package flash.net
