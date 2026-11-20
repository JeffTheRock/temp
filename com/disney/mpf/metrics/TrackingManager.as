//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics
{
    import flash.events.EventDispatcher;
    import com.disney.mpf.metrics.events.EventList;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.errors.events.MPFErrorEvent;
    import com.disney.mpf.metrics.trackers.ITracker;
    import flash.events.ErrorEvent;
    import flash.events.Event;

    public class TrackingManager extends EventDispatcher 
    {

        private static var _instance:TrackingManager;
        public static const AD_TRACKERS:EventList = EventList.AD_EVENTS;
        public static const CONTENT_TRACKERS:EventList = EventList.CONTENT_EVENTS;
        public static const BOTH_TRACKERS:EventList = EventList.AD_AND_CONTENT_EVENTS;

        private var _application:IEventDispatcher;
        private var _trackers:Dictionary;
        private var _eventsToBeTracked:Dictionary;

        public function TrackingManager(_arg_1:SingletonEnforcer)
        {
            if (_arg_1 == null)
            {
                throw (new MPFError("Singleton contructors may not be called directly. Please use .getInstance() method", MPFErrorCodes.CONSTRUCTOR_CALL_TO_STATIC_OBJECT));
            };
            this._trackers = new Dictionary();
            this._eventsToBeTracked = new Dictionary();
            this.addEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
            this.addEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
        }

        public static function getInstance():TrackingManager
        {
            if (TrackingManager._instance == null)
            {
                TrackingManager._instance = new TrackingManager(new SingletonEnforcer());
            };
            return (TrackingManager._instance);
        }


        public function destroy():void
        {
            this.destroyAllTrackers();
            this.removeAllTrackers();
            this.removeEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
            this.removeEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
        }

        public function getTracker(_arg_1:String):ITracker
        {
            return (this._trackers[_arg_1]);
        }

        public function addTrackerEvent(_arg_1:String, _arg_2:EventList):void
        {
            var _local_3:String;
            if (!this._trackers[_arg_1])
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.TRACKER_ID_DOES_NOT_EXIST, (("Tracker ID " + _arg_1) + ' does not exist. Use the "addTracker" method to create a tracker with this id.')));
            }
            else
            {
                for each (_local_3 in _arg_2.events)
                {
                    if (!this._eventsToBeTracked[_local_3])
                    {
                        this._eventsToBeTracked[_local_3] = new Array();
                        if (this._application)
                        {
                            this._application.addEventListener(_local_3, this.processEvent);
                        };
                    };
                    this._eventsToBeTracked[_local_3].push(_arg_1);
                };
            };
        }

        protected function handleMPFWarn(_arg_1:ErrorEvent):void
        {
            if (this._application)
            {
                this._application.dispatchEvent(_arg_1);
            };
        }

        public function track(_arg_1:Event, _arg_2:String=null):void
        {
            var _local_3:Boolean;
            var _local_4:int;
            var _local_5:String;
            var _local_6:ITracker;
            if (((!(_arg_2 == null)) && (!(this._trackers[_arg_2]))))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.TRACKER_ID_DOES_NOT_EXIST, (('Tracker ID: "' + _arg_2) + '" does not exist. Use the TrackingManager.addTracker() method to add a tracker with this id.')));
            }
            else
            {
                if (this._eventsToBeTracked[_arg_1.type])
                {
                    _local_3 = true;
                    _local_4 = 0;
                    while (_local_4 < this._eventsToBeTracked[_arg_1.type].length)
                    {
                        if (((_arg_2 == null) || (_arg_2 == this._eventsToBeTracked[_arg_1.type][_local_4])))
                        {
                            _local_5 = this._eventsToBeTracked[_arg_1.type][_local_4];
                            _local_6 = ITracker(this._trackers[this._eventsToBeTracked[_arg_1.type][_local_4]]);
                            _local_3 = false;
                            if (_local_6.enabled)
                            {
                                _local_6.track(_arg_1);
                            };
                        };
                        _local_4++;
                    };
                    if (_local_3)
                    {
                        dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.TRACKING_EVENT_DOES_NOT_EXIST, (((('The event: "' + _arg_1.type) + '" is not associated with the trackerId "') + _arg_2) + '". Use the TrackingMangager.addTrackerEvent() method to associate this event with a tracker.')));
                    };
                }
                else
                {
                    dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.TRACKING_EVENT_DOES_NOT_EXIST, (('The event: "' + _arg_1.type) + '" is not associated with any tracker. Use the TrackingMangager.addTrackerEvent() method to associate this event with a tracker.')));
                };
            };
        }

        public function removeTracker(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:int;
            for (_local_2 in this._eventsToBeTracked)
            {
                _local_3 = 0;
                while (_local_3 < this._eventsToBeTracked[_local_2].length)
                {
                    if (this._eventsToBeTracked[_local_2][_local_3] == _arg_1)
                    {
                        this._eventsToBeTracked[_local_2].splice(_local_3, 1);
                        _local_3--;
                        if (this._eventsToBeTracked[_local_2].length == 0)
                        {
                            if (this._application)
                            {
                                this._application.removeEventListener(_local_2, this.processEvent);
                            };
                            delete this._eventsToBeTracked[_local_2];
                            break;
                        };
                    };
                    _local_3++;
                };
            };
            this._trackers[_arg_1].removeEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
            this._trackers[_arg_1].removeEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
            delete this._trackers[_arg_1];
        }

        public function addTracker(_arg_1:String, _arg_2:ITracker, _arg_3:EventList):void
        {
            var _local_4:String;
            if (this._trackers[_arg_1])
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.TRACKER_ID_ALREADY_EXISTS, (("Tracker ID " + _arg_1) + " already exists.")));
            }
            else
            {
                this._trackers[_arg_1] = _arg_2;
                for each (_local_4 in _arg_3.events)
                {
                    if (!this._eventsToBeTracked[_local_4])
                    {
                        this._eventsToBeTracked[_local_4] = new Array();
                        if (this._application)
                        {
                            this._application.addEventListener(_local_4, this.processEvent);
                        };
                    };
                    this._eventsToBeTracked[_local_4].push(_arg_1);
                    this._trackers[_arg_1].addEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
                    this._trackers[_arg_1].addEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
                };
            };
        }

        public function removeAllTrackers():void
        {
            var trackerId:String;
            this.removeAllTrackerEvents();
            for (trackerId in this._trackers)
            {
                try
                {
                    this._trackers[trackerId].removeEventListener(MPFErrorEvent.ERROR, this.handleMPFError);
                }
                catch(e:Error)
                {
                };
                try
                {
                    this._trackers[trackerId].removeEventListener(MPFErrorEvent.WARN, this.handleMPFWarn);
                }
                catch(e:Error)
                {
                };
                delete this._trackers[trackerId];
            };
        }

        public function set businessApplication(_arg_1:IEventDispatcher):void
        {
            this.removePlayerListeners();
            this._application = _arg_1;
            this.addPlayerListeners();
        }

        public function removeTrackerEvent(_arg_1:String, _arg_2:EventList):void
        {
            var _local_3:String;
            var _local_4:int;
            if (!this._trackers[_arg_1])
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.TRACKER_ID_DOES_NOT_EXIST, (("Tracker ID " + _arg_1) + " does not exist.")));
            }
            else
            {
                for each (_local_3 in _arg_2.events)
                {
                    if (this._eventsToBeTracked[_local_3])
                    {
                        _local_4 = 0;
                        while (_local_4 < this._eventsToBeTracked[_local_3].length)
                        {
                            if (this._eventsToBeTracked[_local_3][_local_4] == _arg_1)
                            {
                                this._eventsToBeTracked[_local_3].splice(_local_4, 1);
                                _local_4--;
                                if (this._eventsToBeTracked[_local_3].length == 0)
                                {
                                    if (this._application)
                                    {
                                        this._application.removeEventListener(_local_3, this.processEvent);
                                    };
                                    delete this._eventsToBeTracked[_local_3];
                                    break;
                                };
                            };
                            _local_4++;
                        };
                    };
                };
            };
        }

        protected function destroyAllTrackers():void
        {
            var trackerId:String;
            for (trackerId in this._trackers)
            {
                try
                {
                    ITracker(this._trackers[trackerId]).destroy();
                }
                catch(e:Error)
                {
                };
            };
        }

        private function processEvent(_arg_1:Event):void
        {
            this.track(_arg_1);
        }

        protected function handleMPFError(_arg_1:ErrorEvent):void
        {
            if (this._application)
            {
                this._application.dispatchEvent(_arg_1);
            };
        }

        public function get businessApplication():IEventDispatcher
        {
            return (this._application);
        }

        public function removeAllTrackerEvents(_arg_1:String=null):void
        {
            var _local_2:String;
            if (((!(_arg_1 == null)) && (!(this._trackers[_arg_1]))))
            {
                dispatchEvent(new MPFErrorEvent(MPFErrorEvent.ERROR, MPFErrorCodes.TRACKER_ID_DOES_NOT_EXIST, (("Tracker ID " + _arg_1) + " does not exist.")));
            }
            else
            {
                for (_local_2 in this._eventsToBeTracked)
                {
                    if (_arg_1 == null)
                    {
                        this._eventsToBeTracked[_local_2] = null;
                        if (this._application)
                        {
                            this._application.removeEventListener(_local_2, this.processEvent);
                        };
                        delete this._eventsToBeTracked[_local_2];
                    }
                    else
                    {
                        this.removeTrackerEvent(_arg_1, new EventList(_local_2));
                    };
                };
            };
        }

        public function enableAllTrackers():void
        {
            var _local_1:ITracker;
            for each (_local_1 in this._trackers)
            {
                _local_1.enabled = true;
            };
        }

        private function removePlayerListeners():void
        {
            var _local_1:String;
            if (this._application)
            {
                for (_local_1 in this._eventsToBeTracked)
                {
                    this._application.removeEventListener(_local_1, this.track);
                };
            };
        }

        public function disableAllTrackers():void
        {
            var _local_1:ITracker;
            for each (_local_1 in this._trackers)
            {
                _local_1.enabled = false;
            };
        }

        private function addPlayerListeners():void
        {
            var _local_1:String;
            for (_local_1 in this._eventsToBeTracked)
            {
                this._application.addEventListener(_local_1, this.track);
            };
        }


    }
}//package com.disney.mpf.metrics

class SingletonEnforcer 
{


}

