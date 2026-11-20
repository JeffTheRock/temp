//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller
{
    import flash.display.Sprite;
    import com.disney.mpf.media.cuepoints.CuePointManager;
    import com.disney.mpf.media.controller.utils.ControllerStates;
    import com.disney.mpf.media.model.IMedia;
    import com.disney.mpf.media.controller.events.ControllerEvent;
    import com.disney.mpf.media.cuepoints.CuePoint;
    import com.disney.mpf.media.cuepoints.ClosedCaption;
    import com.disney.mpf.media.cuepoints.events.ClosedCaptionEvent;
    import com.disney.mpf.media.cuepoints.events.CuePointEvent;
    import com.disney.mpf.media.utils.DeliveryModes;
    import flash.events.Event;
    import com.disney.mpf.media.model.info.IMediaInfo;
    import com.disney.mpf.media.decorator.MediaObject;
    import com.disney.utils.logging.LogManager;
    import com.disney.mpf.media.cuepoints.*;
    import com.disney.mpf.media.cuepoints.events.*;

    public class AbstractController extends Sprite implements IController 
    {

        protected var _cuePointManager:CuePointManager;
        protected var _isPlayerStarted:Boolean = false;
        protected var _controllerStates:ControllerStates;
        protected var _previousPosition:Number;
        protected var _startPlayerOnLoad:Boolean = false;
        private var _volume:Number;
        private var _id:Number;
        protected var _updateProgressSample:Number = 90;
        protected var _startTime:Number;
        protected var _updateProgressCount:Number = 0;
        private var _autoPlay:Boolean = true;
        protected var _durationOveride:Boolean = false;
        private var _media:IMedia;
        protected var _duration:Number;

        public function AbstractController()
        {
            this._controllerStates = new ControllerStates();
            this._cuePointManager = null;
            this._id = Math.floor((Math.random() * 10000));
            this._duration = 0;
        }

        public function stop():void
        {
            try
            {
                this.startTrackProgress(false);
            }
            catch(e:Error)
            {
            };
            try
            {
                this._controllerStates.state = ControllerStates.STOPPED;
            }
            catch(e:Error)
            {
            };
            try
            {
                dispatchEvent(new ControllerEvent(ControllerEvent.STOP, this.populateData()));
            }
            catch(e:Error)
            {
            };
        }

        public function init():void
        {
            if (((!(isNaN(this.media.duration))) && (this.media.duration > 0)))
            {
                this._duration = this._media.duration;
                this._durationOveride = true;
            }
            else
            {
                this._duration = 0;
            };
            this._controllerStates.state = ControllerStates.INITIALIZED;
            dispatchEvent(new ControllerEvent(ControllerEvent.INITIALIZED, this.populateData()));
        }

        public function get duration():Number
        {
            return (this._duration);
        }

        protected function updateProgress(_arg_1:Event):void
        {
            var _local_2:CuePoint;
            if ((((!(this._cuePointManager)) && (!(this.media.cuePointCollection == null))) && (this.media.cuePointCollection.allCuePoints.length > 0)))
            {
                this._cuePointManager = new CuePointManager(this._media.cuePointCollection);
            }
            else
            {
                if (this._cuePointManager != null)
                {
                    if ((((this._cuePointManager.hasNext()) && (this._cuePointManager.currentCuePoint)) && (this._cuePointManager.currentCuePoint.timeCode < this.position)))
                    {
                        _local_2 = this._cuePointManager.advanceCuePoint();
                        if ((_local_2 is ClosedCaption))
                        {
                            dispatchEvent(new ClosedCaptionEvent(ClosedCaptionEvent.TRIGGER, ClosedCaption(_local_2)));
                        }
                        else
                        {
                            dispatchEvent(new CuePointEvent(CuePointEvent.TRIGGER, _local_2));
                        };
                    };
                };
            };
            if (((this.duration > 0) || (this.media.deliveryMode >= DeliveryModes.LIVE_DVR)))
            {
                if ((((this.duration > 0) && (this.position >= this.duration)) || (this.state == ControllerStates.ENDED)))
                {
                    this.startTrackProgress(false);
                    this._controllerStates.state = ControllerStates.COMPLETE;
                    dispatchEvent(new ControllerEvent(ControllerEvent.COMPLETE, this.populateData()));
                    return;
                };
                if (this.state == ControllerStates.PAUSED)
                {
                    this.startTrackProgress(false);
                }
                else
                {
                    if (this.state != ControllerStates.PLAYING)
                    {
                        this._controllerStates.state = ControllerStates.PLAYING;
                    };
                };
                if (this.media.deliveryMode < DeliveryModes.LIVE_DVR)
                {
                    if (this._updateProgressCount == this._updateProgressSample)
                    {
                        if (((this.position == this._previousPosition) && ((this.duration - this.position) < 1)))
                        {
                            this.startTrackProgress(false);
                            this._controllerStates.state = ControllerStates.COMPLETE;
                            dispatchEvent(new ControllerEvent(ControllerEvent.COMPLETE, this.populateData()));
                        };
                        this._updateProgressCount = 0;
                    };
                    this._previousPosition = this.position;
                    this._updateProgressCount++;
                };
                dispatchEvent(new ControllerEvent(ControllerEvent.PROGRESS_UPDATE, this.populateData()));
            };
        }

        public function get volume():Number
        {
            return (this._volume);
        }

        public function get id():Number
        {
            return (this._id);
        }

        public function get state():uint
        {
            return (this._controllerStates.state);
        }

        public function set duration(_arg_1:Number):void
        {
            this._duration = _arg_1;
        }

        public function set state(_arg_1:uint):void
        {
            this._controllerStates.state = _arg_1;
        }

        public function play(_arg_1:Number=undefined):void
        {
            this._controllerStates.state = ControllerStates.PLAYING;
            this.startTrackProgress(true);
            if (!this._isPlayerStarted)
            {
                dispatchEvent(new ControllerEvent(ControllerEvent.START, this.populateData()));
                this._isPlayerStarted = true;
            };
            dispatchEvent(new ControllerEvent(ControllerEvent.PLAY, this.populateData()));
            if (_arg_1)
            {
                this.seek(_arg_1);
            };
        }

        public function get position():Number
        {
            return (-1);
        }

        public function populateData():IMediaInfo
        {
            return (null);
        }

        public function set media(_arg_1:IMedia):void
        {
            if ((((this.state < ControllerStates.STOPPED) && (!(this._media == null))) && (this._media is MediaObject)))
            {
                this.stop();
            };
            if (this.state > ControllerStates.INITIALIZING)
            {
                this.state = ControllerStates.SWITCH;
            };
            this._media = _arg_1;
            this._isPlayerStarted = false;
            if (((!(_arg_1.cuePointCollection == null)) && (_arg_1.cuePointCollection.allCuePoints.length > 0)))
            {
                this._cuePointManager = new CuePointManager(this._media.cuePointCollection);
            }
            else
            {
                if (this._cuePointManager != null)
                {
                    this._cuePointManager.destroy();
                    this._cuePointManager = null;
                };
            };
        }

        public function set volume(_arg_1:Number):void
        {
            this._volume = _arg_1;
        }

        public function get cuePointManager():CuePointManager
        {
            return (this._cuePointManager);
        }

        protected function startTrackProgress(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                addEventListener(Event.ENTER_FRAME, this.updateProgress);
            }
            else
            {
                removeEventListener(Event.ENTER_FRAME, this.updateProgress);
            };
        }

        public function get media():IMedia
        {
            return (this._media);
        }

        public function load():void
        {
            var _local_1:String = this.media.url;
            if (((_local_1 == null) || (_local_1 == "")))
            {
            };
            this._controllerStates.state = ControllerStates.LOADING;
            dispatchEvent(new ControllerEvent(ControllerEvent.LOADING, this.populateData()));
            this._isPlayerStarted = false;
        }

        public function destroy():void
        {
            if (this._cuePointManager)
            {
                this._cuePointManager.destroy();
            };
            delete this[this];
        }

        public function pause():void
        {
            this.startTrackProgress(false);
            this._controllerStates.state = ControllerStates.PAUSED;
            dispatchEvent(new ControllerEvent(ControllerEvent.PAUSE, this.populateData()));
        }

        public function seek(_arg_1:Number):void
        {
            this._controllerStates.state = ControllerStates.SEEKING;
            if (this._cuePointManager !== null)
            {
                this._cuePointManager.resetCuePoint(this.position);
                LogManager.getInstance().log(("Seek to: " + _arg_1));
                LogManager.getInstance().log(("Position: " + this.position));
                LogManager.getInstance().log(("CuePoint Trigger: " + this._cuePointManager.currentCuePoint.timeCode));
            };
            dispatchEvent(new ControllerEvent(ControllerEvent.SEEK, this.populateData()));
        }


    }
}//package com.disney.mpf.media.controller
