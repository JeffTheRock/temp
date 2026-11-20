//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.decorator
{
    import com.disney.mpf.media.model.IMedia;
    import com.disney.mpf.media.model.IAsset;
    import com.disney.mpf.media.model.StreamItem;
    import com.disney.mpf.media.utils.MediaTypes;
    import com.disney.mpf.media.utils.ProtocolTypes;
    import com.disney.mpf.media.utils.DeliveryModes;
    import com.disney.mpf.media.controller.IController;
    import com.disney.mpf.collections.ICollection;
    import com.disney.mpf.collections.CuePointCollection;

    public class MediaObject implements IMedia, IAsset 
    {

        private var _connectorType:Class;
        protected var _parent:IAsset;
        private var _bufferTime:Number = 0.1;
        private var _streamItem:StreamItem;
        private var _media:IMedia;
        private var _protocol:String;

        public function MediaObject(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String="progressive", _arg_6:StreamItem=null)
        {
            this._media = MediaTypes.getMediaType(_arg_4);
            this._media.id = _arg_3;
            this._media.url = _arg_2;
            this._media.name = _arg_1;
            this._protocol = ProtocolTypes.getProtocolType(_arg_5);
            this.streamItem = _arg_6;
        }

        public function set deliveryMode(_arg_1:int):void
        {
            this._media.deliveryMode = _arg_1;
        }

        public function get name():String
        {
            return (this._media.name);
        }

        public function get duration():Number
        {
            return (this._media.duration);
        }

        public function get id():String
        {
            return (this._media.id);
        }

        public function set name(_arg_1:String):void
        {
            this._media.name = _arg_1;
        }

        public function get protocol():String
        {
            return (this._protocol);
        }

        public function getParent():IAsset
        {
            return (this._parent);
        }

        public function get connectorType():Class
        {
            return (this._connectorType);
        }

        public function setParent(_arg_1:IAsset):void
        {
            this._parent = _arg_1;
        }

        public function get bufferTime():Number
        {
            return (this._bufferTime);
        }

        public function set protocol(_arg_1:String):void
        {
            this._protocol = _arg_1;
        }

        public function get isLive():Boolean
        {
            switch (this._media.deliveryMode)
            {
                case DeliveryModes.LIVE_DVR:
                case DeliveryModes.LIVE_NODVR:
                    return (true);
                case DeliveryModes.VOD:
                default:
                    return (false);
            };
        }

        public function get deliveryMode():int
        {
            return (this._media.deliveryMode);
        }

        public function get streamItem():StreamItem
        {
            return (this._streamItem);
        }

        public function get mediaType():IMedia
        {
            return (this._media);
        }

        public function createController():IController
        {
            return (this._media.createController());
        }

        public function set duration(_arg_1:Number):void
        {
            this._media.duration = _arg_1;
        }

        public function iterator():ICollection
        {
            return (null);
        }

        public function get cuePointCollection():CuePointCollection
        {
            return (this._media.cuePointCollection);
        }

        public function set connectorType(_arg_1:Class):void
        {
            this._connectorType = _arg_1;
        }

        public function removeItem(_arg_1:String):void
        {
        }

        public function addItem(_arg_1:IAsset):void
        {
        }

        public function set id(_arg_1:String):void
        {
            this._media.id = _arg_1;
        }

        public function set bufferTime(_arg_1:Number):void
        {
            this._bufferTime = _arg_1;
        }

        public function set cuePointCollection(_arg_1:CuePointCollection):void
        {
            this._media.cuePointCollection = _arg_1;
        }

        public function set url(_arg_1:String):void
        {
            this._media.url = _arg_1;
        }

        public function set streamItem(_arg_1:StreamItem):void
        {
            this._streamItem = _arg_1;
        }

        public function set format(_arg_1:String):void
        {
            this._media.format = _arg_1;
        }

        public function get url():String
        {
            return (this._media.url);
        }

        public function destroy():void
        {
            this._media.destroy();
            delete this[this];
        }

        public function get format():String
        {
            return (this._media.format);
        }


    }
}//package com.disney.mpf.media.decorator
