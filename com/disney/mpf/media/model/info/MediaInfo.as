//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model.info
{
    import com.disney.mpf.media.model.info.qos.AbstractQOSData;
    import com.disney.mpf.media.controller.IController;
    import com.disney.mpf.media.model.info.meta.IMetaInfo;
    import com.disney.mpf.media.model.IMedia;

    public class MediaInfo implements IMediaInfo 
    {

        private var _state:uint;
        private var _deliveryMode:int;
        private var _qosData:AbstractQOSData;
        private var _bufferLength:Number;
        private var _totalBytes:Number;
        private var _loadedBytes:Number;
        private var _time:Number;
        private var _percentLoaded:Number;
        private var _newShowId:String;
        private var _controller:IController;
        private var _live:Boolean;
        private var _bitRate:Number;
        private var _currentShowId:String;
        private var _volume:Number;
        private var _meta:IMetaInfo;
        private var _media:IMedia;
        private var _duration:Number;
        private var _availableDuration:Number;


        public function set availableDuration(_arg_1:Number):void
        {
            this._availableDuration = _arg_1;
            this._percentLoaded = (_arg_1 / this._duration);
        }

        public function set bufferLength(_arg_1:Number):void
        {
            this._bufferLength = _arg_1;
        }

        public function get state():uint
        {
            return (this._state);
        }

        public function get duration():Number
        {
            return (this._duration);
        }

        public function get bytesTotal():Number
        {
            return (this._totalBytes);
        }

        public function set time(_arg_1:Number):void
        {
            this._time = _arg_1;
        }

        public function set state(_arg_1:uint):void
        {
            this._state = _arg_1;
        }

        public function set duration(_arg_1:Number):void
        {
            this._duration = _arg_1;
        }

        public function get percentLoaded():Number
        {
            var _local_1:Number;
            if (((!(this._percentLoaded)) && (!(this._percentLoaded == 0))))
            {
                _local_1 = (this._loadedBytes / this._totalBytes);
                return ((isNaN(_local_1)) ? 0 : _local_1);
            };
            return ((isNaN(this._percentLoaded)) ? 0 : this._percentLoaded);
        }

        public function get controller():IController
        {
            return (this._controller);
        }

        public function set volume(_arg_1:Number):void
        {
            this._volume = _arg_1;
        }

        public function set meta(_arg_1:IMetaInfo):void
        {
            this._meta = _arg_1;
        }

        public function get bitRate():Number
        {
            return (this._bitRate);
        }

        public function get meta():IMetaInfo
        {
            return (this._meta);
        }

        public function set controller(_arg_1:IController):void
        {
            this._controller = _arg_1;
        }

        public function set bytesTotal(_arg_1:Number):void
        {
            this._totalBytes = _arg_1;
        }

        public function set currentShowId(_arg_1:String):void
        {
            this._currentShowId = _arg_1;
        }

        public function set qosData(_arg_1:AbstractQOSData):void
        {
            this._qosData = _arg_1;
        }

        public function get bufferLength():Number
        {
            return (this._bufferLength);
        }

        public function get volume():Number
        {
            return (this._volume);
        }

        public function get time():Number
        {
            return (this._time);
        }

        public function set media(_arg_1:IMedia):void
        {
            this._media = _arg_1;
        }

        public function get bytesLoaded():Number
        {
            return (this._loadedBytes);
        }

        public function set bytesLoaded(_arg_1:Number):void
        {
            this._loadedBytes = _arg_1;
        }

        public function get newShowId():String
        {
            return (this._newShowId);
        }

        public function set bitRate(_arg_1:Number):void
        {
            this._bitRate = _arg_1;
        }

        public function get currentShowId():String
        {
            return (this._currentShowId);
        }

        public function get media():IMedia
        {
            return (this._media);
        }

        public function set percentLoaded(_arg_1:Number):void
        {
            this._percentLoaded = _arg_1;
            this._availableDuration = (_arg_1 * this._duration);
        }

        public function set newShowId(_arg_1:String):void
        {
            this._newShowId = _arg_1;
        }

        public function get qosData():AbstractQOSData
        {
            return (this._qosData);
        }

        public function get availableDuration():Number
        {
            if (!this._availableDuration)
            {
                this._availableDuration = (this._percentLoaded * this._duration);
            };
            return ((isNaN(this._availableDuration)) ? 0 : this._availableDuration);
        }


    }
}//package com.disney.mpf.media.model.info
