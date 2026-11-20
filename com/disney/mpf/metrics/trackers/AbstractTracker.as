//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.metrics.trackers
{
    import flash.events.EventDispatcher;
    import com.disney.mpf.metrics.trackers.model.ITrackerModel;
    import flash.events.Event;

    public class AbstractTracker extends EventDispatcher implements ITracker 
    {

        protected var _enabled:Boolean;
        protected var _gateway:String;
        protected var _model:ITrackerModel;

        public function AbstractTracker()
        {
            this._enabled = true;
        }

        public function get enabled():Boolean
        {
            return (this._enabled);
        }

        public function destroy():void
        {
        }

        public function set enabled(_arg_1:Boolean):void
        {
            this._enabled = _arg_1;
        }

        public function set gateway(_arg_1:String):void
        {
            this._gateway = _arg_1;
        }

        public function get model():ITrackerModel
        {
            return (this._model);
        }

        public function track(_arg_1:Event):void
        {
            if (this.model != null)
            {
                this.model.update(_arg_1);
            };
        }

        public function set model(_arg_1:ITrackerModel):void
        {
            this._model = _arg_1;
        }

        public function get gateway():String
        {
            return (this._gateway);
        }

        public function set dataModel(_arg_1:ITrackerModel):void
        {
            this._model = _arg_1;
        }

        public function get dataModel():ITrackerModel
        {
            return (this._model);
        }


    }
}//package com.disney.mpf.metrics.trackers
