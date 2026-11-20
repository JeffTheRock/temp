//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model
{
    import com.disney.mpf.collections.CuePointCollection;
    import com.disney.mpf.media.utils.DeliveryModes;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.media.controller.IController;

    public class AbstractMediaType implements IMedia 
    {

        private var _format:String;
        private var _autoAdvance:Boolean;
        private var _deliveryMode:int;
        private var _url:String;
        private var _id:String;
        private var _cuePointCollection:CuePointCollection = null;
        private var _isLive:Boolean;
        private var _name:String;
        private var _duration:Number;

        public function AbstractMediaType()
        {
            this._deliveryMode = DeliveryModes.VOD;
        }

        public function set format(_arg_1:String):void
        {
            this._format = _arg_1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get cuePointCollection():CuePointCollection
        {
            return (this._cuePointCollection);
        }

        public function set duration(_arg_1:Number):void
        {
            this._duration = _arg_1;
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get duration():Number
        {
            return (this._duration);
        }

        public function set id(_arg_1:String):void
        {
            this._id = _arg_1;
        }

        public function get deliveryMode():int
        {
            return (this._deliveryMode);
        }

        public function createController():IController
        {
            throw (new MPFError("AbstractMediaType::createController must be overridden in derived class", MPFErrorCodes.ABSTRACT_METHOD_OVERRIDE));
        }

        public function get isLive():Boolean
        {
            return (this._isLive);
        }

        public function set cuePointCollection(_arg_1:CuePointCollection):void
        {
            this._cuePointCollection = _arg_1;
        }

        public function set url(_arg_1:String):void
        {
            this._url = _arg_1;
        }

        public function set isLive(_arg_1:Boolean):void
        {
            this._isLive = _arg_1;
        }

        public function set deliveryMode(_arg_1:int):void
        {
            this._deliveryMode = _arg_1;
        }

        public function get url():String
        {
            return (this._url);
        }

        public function get format():String
        {
            return (this._format);
        }

        public function destroy():void
        {
            if (this._cuePointCollection != null)
            {
                this._cuePointCollection.destroy();
            };
            delete this[this];
        }


    }
}//package com.disney.mpf.media.model
