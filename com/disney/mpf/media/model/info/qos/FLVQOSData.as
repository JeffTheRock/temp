//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model.info.qos
{
    import flash.net.NetStreamInfo;
    import flash.net.NetStream;

    public class FLVQOSData extends AbstractQOSData 
    {

        private var _droppedFrames:Number;
        private var _videoBufferByteLength:Number;
        private var _bytesLoaded:Number;
        private var _dataBufferByteLength:Number;
        private var _audioLossRate:Number;
        private var _currentBytesPerSecond:Number;
        private var _bufferLength:Number;
        private var _dataBytesPerSecond:Number;
        private var _bytesTotal:Number;
        private var _audioBufferLength:Number;
        private var _maxBytesPerSecond:Number;
        private var _currentFPS:Number;
        private var _audioByteCount:Number;
        private var _videoByteCount:Number;
        private var _dataByteCount:Number;
        private var _playbackBytesPerSecond:Number;
        private var _videoBufferLength:Number;
        private var _playheadTime:Number;
        private var _byteCount:Number;
        private var _videoBytesPerSecond:Number;
        private var _audioBufferByteLength:Number;
        private var _dataBufferLength:Number;
        private var _liveDelay:Number;
        private var _audioBytesPerSecond:Number;
        private var _SRTT:Number;

        public function FLVQOSData(_arg_1:NetStream)
        {
            var _local_2:NetStreamInfo;
            super();
            this._bufferLength = _arg_1.bufferLength;
            this._bytesLoaded = _arg_1.bytesLoaded;
            this._bytesTotal = _arg_1.bytesTotal;
            this._currentFPS = _arg_1.currentFPS;
            this._liveDelay = _arg_1.liveDelay;
            this._playheadTime = _arg_1.time;
            _local_2 = _arg_1.info;
            this._audioBufferLength = _local_2.audioBufferByteLength;
            this._audioBufferByteLength = _local_2.audioBufferLength;
            this._audioByteCount = _local_2.audioByteCount;
            this._audioBytesPerSecond = _local_2.audioBytesPerSecond;
            this._audioLossRate = _local_2.audioLossRate;
            this._byteCount = _local_2.byteCount;
            this._currentBytesPerSecond = _local_2.currentBytesPerSecond;
            this._dataBufferByteLength = _local_2.dataBufferByteLength;
            this._dataBufferLength = _local_2.dataBufferLength;
            this._dataByteCount = _local_2.dataByteCount;
            this._dataBytesPerSecond = _local_2.dataBytesPerSecond;
            this._droppedFrames = _local_2.droppedFrames;
            this._maxBytesPerSecond = _local_2.maxBytesPerSecond;
            this._playbackBytesPerSecond = _local_2.playbackBytesPerSecond;
            this._SRTT = _local_2.SRTT;
            this._videoBufferByteLength = _local_2.videoBufferByteLength;
            this._videoBufferLength = _local_2.videoByteCount;
            this._videoByteCount = _local_2.videoByteCount;
            this._videoBytesPerSecond = _local_2.videoBytesPerSecond;
        }

        public function get liveDelay():Number
        {
            return (this._liveDelay);
        }

        public function get playheadTime():Number
        {
            return (this._playheadTime);
        }

        public function get videoBufferByteLength():Number
        {
            return (this._videoBufferByteLength);
        }

        public function get droppedFrames():Number
        {
            return (this._droppedFrames);
        }

        public function get dataBufferLength():Number
        {
            return (this._dataBufferLength);
        }

        public function get bytesTotal():Number
        {
            return (this._bytesTotal);
        }

        public function get currentBytesPerSecond():Number
        {
            return (this._currentBytesPerSecond);
        }

        public function get videoBytesPerSecond():Number
        {
            return (this._videoBytesPerSecond);
        }

        public function get SRTT():Number
        {
            return (this._SRTT);
        }

        public function get audioLossRate():Number
        {
            return (this._audioLossRate);
        }

        public function get videoByteCount():Number
        {
            return (this._videoByteCount);
        }

        public function get currentFPS():Number
        {
            return (this._currentFPS);
        }

        public function get audioByteCount():Number
        {
            return (this._audioByteCount);
        }

        public function get dataBytesPerSecond():Number
        {
            return (this._dataBytesPerSecond);
        }

        public function get dataBufferByteLength():Number
        {
            return (this._dataBufferByteLength);
        }

        public function get playbackBytesPerSecond():Number
        {
            return (this._playbackBytesPerSecond);
        }

        public function get audioBufferLength():Number
        {
            return (this._audioBufferLength);
        }

        public function get bufferLength():Number
        {
            return (this._bufferLength);
        }

        public function get audioBytesPerSecond():Number
        {
            return (this._audioBytesPerSecond);
        }

        public function get maxBytesPerSecond():Number
        {
            return (this._maxBytesPerSecond);
        }

        public function get dataByteCount():Number
        {
            return (this._dataByteCount);
        }

        public function get bytesLoaded():Number
        {
            return (this._bytesLoaded);
        }

        public function get videoBufferLength():Number
        {
            return (this._videoBufferLength);
        }

        public function get audioBufferByteLength():Number
        {
            return (this._audioBufferByteLength);
        }

        public function get byteCount():Number
        {
            return (this._byteCount);
        }


    }
}//package com.disney.mpf.media.model.info.qos
