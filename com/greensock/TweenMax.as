//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import com.greensock.plugins.TweenPlugin;
    import com.greensock.plugins.AutoAlphaPlugin;
    import com.greensock.plugins.EndArrayPlugin;
    import com.greensock.plugins.FramePlugin;
    import com.greensock.plugins.RemoveTintPlugin;
    import com.greensock.plugins.TintPlugin;
    import com.greensock.plugins.VisiblePlugin;
    import com.greensock.plugins.VolumePlugin;
    import com.greensock.plugins.BevelFilterPlugin;
    import com.greensock.plugins.BezierPlugin;
    import com.greensock.plugins.BezierThroughPlugin;
    import com.greensock.plugins.BlurFilterPlugin;
    import com.greensock.plugins.ColorMatrixFilterPlugin;
    import com.greensock.plugins.ColorTransformPlugin;
    import com.greensock.plugins.DropShadowFilterPlugin;
    import com.greensock.plugins.FrameLabelPlugin;
    import com.greensock.plugins.GlowFilterPlugin;
    import com.greensock.plugins.HexColorsPlugin;
    import com.greensock.plugins.RoundPropsPlugin;
    import com.greensock.plugins.ShortRotationPlugin;
    import com.greensock.events.TweenEvent;
    import com.greensock.core.TweenCore;
    import com.greensock.core.SimpleTimeline;
    import flash.utils.getTimer;
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;
    import flash.utils.Dictionary;
    import flash.events.Event;
    import com.greensock.core.PropTween;
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import com.greensock.core.*;
    import com.greensock.plugins.*;

    public class TweenMax extends TweenLite implements IEventDispatcher 
    {

        public static const version:Number = 11.37;
        private static var _overwriteMode:int = ((OverwriteManager.enabled) ? OverwriteManager.mode : OverwriteManager.init(2));
        public static var killTweensOf:Function = TweenLite.killTweensOf;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;

        protected var _cyclesComplete:uint = 0;
        protected var _dispatcher:EventDispatcher;
        protected var _hasUpdateListener:Boolean;
        protected var _easeType:uint;
        protected var _repeatDelay:Number = 0;
        public var yoyo:Boolean;
        protected var _easePower:uint;
        protected var _repeat:int = 0;

        {
            TweenPlugin.activate([AutoAlphaPlugin, EndArrayPlugin, FramePlugin, RemoveTintPlugin, TintPlugin, VisiblePlugin, VolumePlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, FrameLabelPlugin, GlowFilterPlugin, HexColorsPlugin, RoundPropsPlugin, ShortRotationPlugin, {}]);
        }

        public function TweenMax(_arg_1:Object, _arg_2:Number, _arg_3:Object)
        {
            super(_arg_1, _arg_2, _arg_3);
            if (TweenLite.version < 11.2)
            {
                throw (new Error("TweenMax error! Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com."));
            };
            this.yoyo = Boolean(this.vars.yoyo);
            _repeat = ((this.vars.repeat) ? int(this.vars.repeat) : 0);
            _repeatDelay = ((this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0);
            this.cacheIsDirty = true;
            if (((((((this.vars.onCompleteListener) || (this.vars.onInitListener)) || (this.vars.onUpdateListener)) || (this.vars.onStartListener)) || (this.vars.onRepeatListener)) || (this.vars.onReverseCompleteListener)))
            {
                initDispatcher();
                if (((_arg_2 == 0) && (_delay == 0)))
                {
                    _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
                    _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                };
            };
            if (((this.vars.timeScale) && (!(this.target is TweenCore))))
            {
                this.cachedTimeScale = this.vars.timeScale;
            };
        }

        public static function set globalTimeScale(_arg_1:Number):void
        {
            if (_arg_1 == 0)
            {
                _arg_1 = 0.0001;
            };
            if (TweenLite.rootTimeline == null)
            {
                TweenLite.to({}, 0, {});
            };
            var _local_2:SimpleTimeline = TweenLite.rootTimeline;
            var _local_3:Number = (getTimer() * 0.001);
            _local_2.cachedStartTime = (_local_3 - (((_local_3 - _local_2.cachedStartTime) * _local_2.cachedTimeScale) / _arg_1));
            _local_2 = TweenLite.rootFramesTimeline;
            _local_3 = TweenLite.rootFrame;
            _local_2.cachedStartTime = (_local_3 - (((_local_3 - _local_2.cachedStartTime) * _local_2.cachedTimeScale) / _arg_1));
            TweenLite.rootFramesTimeline.cachedTimeScale = (TweenLite.rootTimeline.cachedTimeScale = _arg_1);
        }

        public static function fromTo(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:Object):TweenMax
        {
            _arg_4.startAt = _arg_3;
            if (_arg_3.immediateRender)
            {
                _arg_4.immediateRender = true;
            };
            return (new TweenMax(_arg_1, _arg_2, _arg_4));
        }

        public static function allFromTo(_arg_1:Array, _arg_2:Number, _arg_3:Object, _arg_4:Object, _arg_5:Number=0, _arg_6:Function=null, _arg_7:Array=null):Array
        {
            _arg_4.startAt = _arg_3;
            if (_arg_3.immediateRender)
            {
                _arg_4.immediateRender = true;
            };
            return (allTo(_arg_1, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7));
        }

        public static function pauseAll(_arg_1:Boolean=true, _arg_2:Boolean=true):void
        {
            changePause(true, _arg_1, _arg_2);
        }

        public static function getTweensOf(_arg_1:Object):Array
        {
            var _local_4:int;
            var _local_5:uint;
            var _local_2:Array = masterList[_arg_1];
            var _local_3:Array = [];
            if (_local_2)
            {
                _local_4 = _local_2.length;
                _local_5 = 0;
                while (--_local_4 > -1)
                {
                    if (!_local_2[_local_4].gc)
                    {
                        var _local_6:* = _local_5++;
                        _local_3[_local_6] = _local_2[_local_4];
                    };
                };
            };
            return (_local_3);
        }

        public static function get globalTimeScale():Number
        {
            return ((TweenLite.rootTimeline == null) ? 1 : TweenLite.rootTimeline.cachedTimeScale);
        }

        public static function killChildTweensOf(_arg_1:DisplayObjectContainer, _arg_2:Boolean=false):void
        {
            var _local_4:Object;
            var _local_5:DisplayObjectContainer;
            var _local_3:Array = getAllTweens();
            var _local_6:int = _local_3.length;
            while (--_local_6 > -1)
            {
                _local_4 = _local_3[_local_6].target;
                if ((_local_4 is DisplayObject))
                {
                    _local_5 = _local_4.parent;
                    while (_local_5)
                    {
                        if (_local_5 == _arg_1)
                        {
                            if (_arg_2)
                            {
                                _local_3[_local_6].complete(false);
                            }
                            else
                            {
                                _local_3[_local_6].setEnabled(false, false);
                            };
                        };
                        _local_5 = _local_5.parent;
                    };
                };
            };
        }

        public static function delayedCall(_arg_1:Number, _arg_2:Function, _arg_3:Array=null, _arg_4:Boolean=false):TweenMax
        {
            return (new TweenMax(_arg_2, 0, {
                "delay":_arg_1,
                "onComplete":_arg_2,
                "onCompleteParams":_arg_3,
                "immediateRender":false,
                "useFrames":_arg_4,
                "overwrite":0
            }));
        }

        public static function isTweening(_arg_1:Object):Boolean
        {
            var _local_4:TweenLite;
            var _local_2:Array = getTweensOf(_arg_1);
            var _local_3:int = _local_2.length;
            while (--_local_3 > -1)
            {
                _local_4 = _local_2[_local_3];
                if (((_local_4.active) || ((_local_4.cachedStartTime == _local_4.timeline.cachedTime) && (_local_4.timeline.active))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function killAll(_arg_1:Boolean=false, _arg_2:Boolean=true, _arg_3:Boolean=true):void
        {
            var _local_5:Boolean;
            var _local_4:Array = getAllTweens();
            var _local_6:int = _local_4.length;
            while (--_local_6 > -1)
            {
                _local_5 = (_local_4[_local_6].target == _local_4[_local_6].vars.onComplete);
                if (((_local_5 == _arg_3) || (!(_local_5 == _arg_2))))
                {
                    if (_arg_1)
                    {
                        _local_4[_local_6].complete(false);
                    }
                    else
                    {
                        _local_4[_local_6].setEnabled(false, false);
                    };
                };
            };
        }

        private static function changePause(_arg_1:Boolean, _arg_2:Boolean=true, _arg_3:Boolean=false):void
        {
            var _local_5:Boolean;
            var _local_4:Array = getAllTweens();
            var _local_6:int = _local_4.length;
            while (--_local_6 > -1)
            {
                _local_5 = (TweenLite(_local_4[_local_6]).target == TweenLite(_local_4[_local_6]).vars.onComplete);
                if (((_local_5 == _arg_3) || (!(_local_5 == _arg_2))))
                {
                    TweenCore(_local_4[_local_6]).paused = _arg_1;
                };
            };
        }

        public static function from(_arg_1:Object, _arg_2:Number, _arg_3:Object):TweenMax
        {
            _arg_3.runBackwards = true;
            if (!("immediateRender" in _arg_3))
            {
                _arg_3.immediateRender = true;
            };
            return (new TweenMax(_arg_1, _arg_2, _arg_3));
        }

        public static function allFrom(_arg_1:Array, _arg_2:Number, _arg_3:Object, _arg_4:Number=0, _arg_5:Function=null, _arg_6:Array=null):Array
        {
            _arg_3.runBackwards = true;
            if (!("immediateRender" in _arg_3))
            {
                _arg_3.immediateRender = true;
            };
            return (allTo(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }

        public static function getAllTweens():Array
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_1:Dictionary = masterList;
            var _local_2:uint;
            var _local_3:Array = [];
            for each (_local_4 in _local_1)
            {
                _local_5 = _local_4.length;
                while (--_local_5 > -1)
                {
                    if (!TweenLite(_local_4[_local_5]).gc)
                    {
                        var _local_8:* = _local_2++;
                        _local_3[_local_8] = _local_4[_local_5];
                    };
                };
            };
            return (_local_3);
        }

        public static function resumeAll(_arg_1:Boolean=true, _arg_2:Boolean=true):void
        {
            changePause(false, _arg_1, _arg_2);
        }

        public static function to(_arg_1:Object, _arg_2:Number, _arg_3:Object):TweenMax
        {
            return (new TweenMax(_arg_1, _arg_2, _arg_3));
        }

        public static function allTo(targets:Array, duration:Number, vars:Object, stagger:Number=0, onCompleteAll:Function=null, onCompleteAllParams:Array=null):Array
        {
            var i:int;
            var varsDup:Object;
            var p:String;
            var onCompleteProxy:Function;
            var onCompleteParamsProxy:Array;
            var l:uint = targets.length;
            var a:Array = [];
            var curDelay:Number = (("delay" in vars) ? Number(vars.delay) : 0);
            onCompleteProxy = vars.onComplete;
            onCompleteParamsProxy = vars.onCompleteParams;
            var lastIndex:int = ((stagger <= 0) ? 0 : (l - 1));
            i = 0;
            while (i < l)
            {
                varsDup = {};
                for (p in vars)
                {
                    varsDup[p] = vars[p];
                };
                varsDup.delay = curDelay;
                if (((i == lastIndex) && (!(onCompleteAll == null))))
                {
                    varsDup.onComplete = function ():void
                    {
                        if (onCompleteProxy != null)
                        {
                            onCompleteProxy.apply(null, onCompleteParamsProxy);
                        };
                        onCompleteAll.apply(null, onCompleteAllParams);
                    };
                };
                a[a.length] = new TweenMax(targets[i], duration, varsDup);
                curDelay = (curDelay + stagger);
                i = (i + 1);
            };
            return (a);
        }


        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return ((_dispatcher == null) ? false : _dispatcher.dispatchEvent(_arg_1));
        }

        public function set timeScale(_arg_1:Number):void
        {
            if (_arg_1 == 0)
            {
                _arg_1 = 0.0001;
            };
            var _local_2:Number = (((_pauseTime) || (_pauseTime == 0)) ? _pauseTime : this.timeline.cachedTotalTime);
            this.cachedStartTime = (_local_2 - (((_local_2 - this.cachedStartTime) * this.cachedTimeScale) / _arg_1));
            this.cachedTimeScale = _arg_1;
            setDirtyCache(false);
        }

        override public function renderTime(_arg_1:Number, _arg_2:Boolean=false, _arg_3:Boolean=false):void
        {
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_8:Boolean;
            var _local_10:Number;
            var _local_11:int;
            var _local_12:int;
            var _local_13:Number;
            var _local_4:Number = ((this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration);
            var _local_5:Number = this.cachedTime;
            if (_arg_1 >= _local_4)
            {
                this.cachedTotalTime = _local_4;
                this.cachedTime = this.cachedDuration;
                this.ratio = 1;
                _local_6 = true;
                if (this.cachedDuration == 0)
                {
                    if ((((_arg_1 == 0) || (_rawPrevTime < 0)) && (!(_rawPrevTime == _arg_1))))
                    {
                        _arg_3 = true;
                    };
                    _rawPrevTime = _arg_1;
                };
            }
            else
            {
                if (_arg_1 <= 0)
                {
                    if (_arg_1 < 0)
                    {
                        this.active = false;
                        if (this.cachedDuration == 0)
                        {
                            if (_rawPrevTime > 0)
                            {
                                _arg_3 = true;
                                _local_6 = true;
                            };
                            _rawPrevTime = _arg_1;
                        };
                    };
                    this.cachedTotalTime = (this.cachedTime = (this.ratio = 0));
                    if (((this.cachedReversed) && (!(_local_5 == 0))))
                    {
                        _local_6 = true;
                    };
                }
                else
                {
                    this.cachedTotalTime = (this.cachedTime = _arg_1);
                    _local_8 = true;
                };
            };
            if (_repeat != 0)
            {
                _local_10 = (this.cachedDuration + _repeatDelay);
                if (_local_6)
                {
                    if (((this.yoyo) && (_repeat % 2)))
                    {
                        this.cachedTime = (this.ratio = 0);
                    };
                }
                else
                {
                    if (_arg_1 > 0)
                    {
                        _local_11 = _cyclesComplete;
                        _cyclesComplete = int((this.cachedTotalTime / _local_10));
                        if (_cyclesComplete == (this.cachedTotalTime / _local_10))
                        {
                            _cyclesComplete--;
                        };
                        if (_local_11 != _cyclesComplete)
                        {
                            _local_7 = true;
                        };
                        this.cachedTime = (((this.cachedTotalTime / _local_10) - _cyclesComplete) * _local_10);
                        if (((this.yoyo) && (_cyclesComplete % 2)))
                        {
                            this.cachedTime = (this.cachedDuration - this.cachedTime);
                        }
                        else
                        {
                            if (this.cachedTime >= this.cachedDuration)
                            {
                                this.cachedTime = this.cachedDuration;
                                this.ratio = 1;
                                _local_8 = false;
                            };
                        };
                        if (this.cachedTime <= 0)
                        {
                            this.cachedTime = (this.ratio = 0);
                            _local_8 = false;
                        };
                    };
                };
            };
            if (((_local_5 == this.cachedTime) && (!(_arg_3))))
            {
                return;
            };
            if (!this.initted)
            {
                init();
            };
            if (((!(this.active)) && (!(this.cachedPaused))))
            {
                this.active = true;
            };
            if (_local_8)
            {
                if (_easeType)
                {
                    _local_12 = _easePower;
                    _local_13 = (this.cachedTime / this.cachedDuration);
                    if (_easeType == 2)
                    {
                        this.ratio = (_local_13 = (1 - _local_13));
                        while (--_local_12 > -1)
                        {
                            this.ratio = (_local_13 * this.ratio);
                        };
                        this.ratio = (1 - this.ratio);
                    }
                    else
                    {
                        if (_easeType == 1)
                        {
                            this.ratio = _local_13;
                            while (--_local_12 > -1)
                            {
                                this.ratio = (_local_13 * this.ratio);
                            };
                        }
                        else
                        {
                            if (_local_13 < 0.5)
                            {
                                this.ratio = (_local_13 = (_local_13 * 2));
                                while (--_local_12 > -1)
                                {
                                    this.ratio = (_local_13 * this.ratio);
                                };
                                this.ratio = (this.ratio * 0.5);
                            }
                            else
                            {
                                this.ratio = (_local_13 = ((1 - _local_13) * 2));
                                while (--_local_12 > -1)
                                {
                                    this.ratio = (_local_13 * this.ratio);
                                };
                                this.ratio = (1 - (0.5 * this.ratio));
                            };
                        };
                    };
                }
                else
                {
                    this.ratio = _ease(this.cachedTime, 0, 1, this.cachedDuration);
                };
            };
            if ((((_local_5 == 0) && (!(this.cachedTotalTime == 0))) && (!(_arg_2))))
            {
                if (this.vars.onStart)
                {
                    this.vars.onStart.apply(null, this.vars.onStartParams);
                };
                if (_dispatcher)
                {
                    _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
                };
            };
            var _local_9:PropTween = this.cachedPT1;
            while (_local_9)
            {
                _local_9.target[_local_9.property] = (_local_9.start + (this.ratio * _local_9.change));
                _local_9 = _local_9.nextNode;
            };
            if (((_hasUpdate) && (!(_arg_2))))
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (((_hasUpdateListener) && (!(_arg_2))))
            {
                _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            };
            if (_local_6)
            {
                if (((_hasPlugins) && (this.cachedPT1)))
                {
                    onPluginEvent("onComplete", this);
                };
                complete(true, _arg_2);
            }
            else
            {
                if (((_local_7) && (!(_arg_2))))
                {
                    if (this.vars.onRepeat)
                    {
                        this.vars.onRepeat.apply(null, this.vars.onRepeatParams);
                    };
                    if (_dispatcher)
                    {
                        _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
                    };
                };
            };
        }

        override public function set totalDuration(_arg_1:Number):void
        {
            if (_repeat == -1)
            {
                return;
            };
            this.duration = ((_arg_1 - (_repeat * _repeatDelay)) / (_repeat + 1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            if (_dispatcher == null)
            {
                initDispatcher();
            };
            if (_arg_1 == TweenEvent.UPDATE)
            {
                _hasUpdateListener = true;
            };
            _dispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        protected function insertPropTween(_arg_1:Object, _arg_2:String, _arg_3:Number, _arg_4:*, _arg_5:String, _arg_6:Boolean, _arg_7:PropTween):PropTween
        {
            var _local_9:Array;
            var _local_10:int;
            var _local_8:PropTween = new PropTween(_arg_1, _arg_2, _arg_3, ((typeof(_arg_4) == "number") ? (_arg_4 - _arg_3) : Number(_arg_4)), _arg_5, _arg_6, _arg_7);
            if (((_arg_6) && (_arg_5 == "_MULTIPLE_")))
            {
                _local_9 = _arg_1.overwriteProps;
                _local_10 = _local_9.length;
                while (--_local_10 > -1)
                {
                    this.propTweenLookup[_local_9[_local_10]] = _local_8;
                };
            }
            else
            {
                this.propTweenLookup[_arg_5] = _local_8;
            };
            return (_local_8);
        }

        override protected function init():void
        {
            var _local_1:TweenMax;
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            var _local_5:Array;
            var _local_6:Object;
            var _local_7:PropTween;
            var _local_8:PropTween;
            var _local_9:int;
            if (this.vars.startAt)
            {
                this.vars.startAt.overwrite = 0;
                this.vars.startAt.immediateRender = true;
                _local_1 = new TweenMax(this.target, 0, this.vars.startAt);
            };
            if (_dispatcher)
            {
                _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.INIT));
            };
            super.init();
            if ((_ease in fastEaseLookup))
            {
                _easeType = fastEaseLookup[_ease][0];
                _easePower = fastEaseLookup[_ease][1];
            };
            if (((!(this.vars.roundProps == null)) && ("roundProps" in TweenLite.plugins)))
            {
                _local_5 = this.vars.roundProps;
                _local_9 = _local_5.length;
                while (--_local_9 > -1)
                {
                    _local_3 = _local_5[_local_9];
                    _local_8 = this.cachedPT1;
                    while (_local_8)
                    {
                        if (_local_8.name == _local_3)
                        {
                            if (_local_8.isPlugin)
                            {
                                _local_8.target.round = true;
                            }
                            else
                            {
                                if (_local_6 == null)
                                {
                                    _local_6 = new TweenLite.plugins.roundProps();
                                    _local_6.add(_local_8.target, _local_3, _local_8.start, _local_8.change);
                                    _hasPlugins = true;
                                    this.cachedPT1 = (_local_7 = insertPropTween(_local_6, "changeFactor", 0, 1, "_MULTIPLE_", true, this.cachedPT1));
                                }
                                else
                                {
                                    _local_6.add(_local_8.target, _local_3, _local_8.start, _local_8.change);
                                };
                                this.removePropTween(_local_8);
                                this.propTweenLookup[_local_3] = _local_7;
                            };
                        }
                        else
                        {
                            if ((((_local_8.isPlugin) && (_local_8.name == "_MULTIPLE_")) && (!(_local_8.target.round))))
                            {
                                _local_4 = ((" " + _local_8.target.overwriteProps.join(" ")) + " ");
                                if (_local_4.indexOf(((" " + _local_3) + " ")) != -1)
                                {
                                    _local_8.target.round = true;
                                };
                            };
                        };
                        _local_8 = _local_8.nextNode;
                    };
                };
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            if (_dispatcher)
            {
                _dispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
            };
        }

        public function setDestination(_arg_1:String, _arg_2:*, _arg_3:Boolean=true):void
        {
            var _local_4:Object = {};
            _local_4[_arg_1] = _arg_2;
            updateTo(_local_4, (!(_arg_3)));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return ((_dispatcher == null) ? false : _dispatcher.willTrigger(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return ((_dispatcher == null) ? false : _dispatcher.hasEventListener(_arg_1));
        }

        protected function initDispatcher():void
        {
            if (_dispatcher == null)
            {
                _dispatcher = new EventDispatcher(this);
            };
            if ((this.vars.onInitListener is Function))
            {
                _dispatcher.addEventListener(TweenEvent.INIT, this.vars.onInitListener, false, 0, true);
            };
            if ((this.vars.onStartListener is Function))
            {
                _dispatcher.addEventListener(TweenEvent.START, this.vars.onStartListener, false, 0, true);
            };
            if ((this.vars.onUpdateListener is Function))
            {
                _dispatcher.addEventListener(TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                _hasUpdateListener = true;
            };
            if ((this.vars.onCompleteListener is Function))
            {
                _dispatcher.addEventListener(TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
            };
            if ((this.vars.onRepeatListener is Function))
            {
                _dispatcher.addEventListener(TweenEvent.REPEAT, this.vars.onRepeatListener, false, 0, true);
            };
            if ((this.vars.onReverseCompleteListener is Function))
            {
                _dispatcher.addEventListener(TweenEvent.REVERSE_COMPLETE, this.vars.onReverseCompleteListener, false, 0, true);
            };
        }

        public function set currentProgress(_arg_1:Number):void
        {
            if (_cyclesComplete == 0)
            {
                setTotalTime((this.duration * _arg_1), false);
            }
            else
            {
                setTotalTime(((this.duration * _arg_1) + (_cyclesComplete * this.cachedDuration)), false);
            };
        }

        public function get totalProgress():Number
        {
            return (this.cachedTotalTime / this.totalDuration);
        }

        public function set totalProgress(_arg_1:Number):void
        {
            setTotalTime((this.totalDuration * _arg_1), false);
        }

        protected function removePropTween(_arg_1:PropTween):Boolean
        {
            if (_arg_1.nextNode)
            {
                _arg_1.nextNode.prevNode = _arg_1.prevNode;
            };
            if (_arg_1.prevNode)
            {
                _arg_1.prevNode.nextNode = _arg_1.nextNode;
            }
            else
            {
                if (this.cachedPT1 == _arg_1)
                {
                    this.cachedPT1 = _arg_1.nextNode;
                };
            };
            if (((_arg_1.isPlugin) && (_arg_1.target.onDisable)))
            {
                _arg_1.target.onDisable();
                if (_arg_1.target.activeDisable)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function get currentProgress():Number
        {
            return (this.cachedTime / this.duration);
        }

        public function get repeat():int
        {
            return (_repeat);
        }

        public function updateTo(_arg_1:Object, _arg_2:Boolean=false):void
        {
            var _local_4:String;
            var _local_5:Number;
            var _local_6:PropTween;
            var _local_7:Number;
            var _local_3:Number = this.ratio;
            if ((((_arg_2) && (!(this.timeline == null))) && (this.cachedStartTime < this.timeline.cachedTime)))
            {
                this.cachedStartTime = this.timeline.cachedTime;
                this.setDirtyCache(false);
                if (this.gc)
                {
                    this.setEnabled(true, false);
                }
                else
                {
                    this.timeline.addChild(this);
                };
            };
            for (_local_4 in _arg_1)
            {
                this.vars[_local_4] = _arg_1[_local_4];
            };
            if (this.initted)
            {
                this.initted = false;
                if (!_arg_2)
                {
                    init();
                    if ((((!(_arg_2)) && (this.cachedTime > 0)) && (this.cachedTime < this.cachedDuration)))
                    {
                        _local_5 = (1 / (1 - _local_3));
                        _local_6 = this.cachedPT1;
                        while (_local_6)
                        {
                            _local_7 = (_local_6.start + _local_6.change);
                            _local_6.change = (_local_6.change * _local_5);
                            _local_6.start = (_local_7 - _local_6.change);
                            _local_6 = _local_6.nextNode;
                        };
                    };
                };
            };
        }

        override public function set currentTime(_arg_1:Number):void
        {
            if (_cyclesComplete != 0)
            {
                if (((this.yoyo) && ((_cyclesComplete % 2) == 1)))
                {
                    _arg_1 = ((this.duration - _arg_1) + (_cyclesComplete * (this.cachedDuration + _repeatDelay)));
                }
                else
                {
                    _arg_1 = (_arg_1 + (_cyclesComplete * (this.duration + _repeatDelay)));
                };
            };
            setTotalTime(_arg_1, false);
        }

        public function get repeatDelay():Number
        {
            return (_repeatDelay);
        }

        public function killProperties(_arg_1:Array):void
        {
            var _local_2:Object = {};
            var _local_3:int = _arg_1.length;
            while (--_local_3 > -1)
            {
                _local_2[_arg_1[_local_3]] = true;
            };
            killVars(_local_2);
        }

        public function set repeatDelay(_arg_1:Number):void
        {
            _repeatDelay = _arg_1;
            setDirtyCache(true);
        }

        public function set repeat(_arg_1:int):void
        {
            _repeat = _arg_1;
            setDirtyCache(true);
        }

        override public function complete(_arg_1:Boolean=false, _arg_2:Boolean=false):void
        {
            super.complete(_arg_1, _arg_2);
            if (((!(_arg_2)) && (_dispatcher)))
            {
                if (((this.cachedTotalTime == this.cachedTotalDuration) && (!(this.cachedReversed))))
                {
                    _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                }
                else
                {
                    if (((this.cachedReversed) && (this.cachedTotalTime == 0)))
                    {
                        _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REVERSE_COMPLETE));
                    };
                };
            };
        }

        override public function invalidate():void
        {
            this.yoyo = Boolean((this.vars.yoyo == true));
            _repeat = ((this.vars.repeat) ? Number(this.vars.repeat) : 0);
            _repeatDelay = ((this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0);
            _hasUpdateListener = false;
            if ((((!(this.vars.onCompleteListener == null)) || (!(this.vars.onUpdateListener == null))) || (!(this.vars.onStartListener == null))))
            {
                initDispatcher();
            };
            setDirtyCache(true);
            super.invalidate();
        }

        public function get timeScale():Number
        {
            return (this.cachedTimeScale);
        }

        override public function get totalDuration():Number
        {
            if (this.cacheIsDirty)
            {
                this.cachedTotalDuration = ((_repeat == -1) ? 999999999999 : ((this.cachedDuration * (_repeat + 1)) + (_repeatDelay * _repeat)));
                this.cacheIsDirty = false;
            };
            return (this.cachedTotalDuration);
        }


    }
}//package com.greensock
