//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller.utils
{
    import com.disney.mpf.media.model.info.meta.IMetaInfo;
    import com.disney.mpf.media.controller.IController;

    public class MetaDataInfo implements IMetaInfo 
    {

        private var _videodatarate:Number;
        private var _creationDate:String;
        private var _videocodecid:String;
        private var _canSeekToEnd:Boolean;
        private var _controller:IController;
        private var _encodedWith:String;
        private var _height:Number;
        private var _width:Number;
        private var _framerate:Number;
        private var _audiodatarate:Number;
        private var _timelineInfo:Object;
        private var _duration:Number;
        private var _audiocodecid:String;

        public function MetaDataInfo()
        {
            this._controller = null;
            this._encodedWith = null;
            this._creationDate = null;
            this._framerate = 0;
            this._audiocodecid = null;
            this._audiodatarate = 0;
            this._videocodecid = null;
            this._canSeekToEnd = false;
            this._videodatarate = 0;
            this._height = 0;
            this._width = 0;
            this._duration = 0;
        }

        public function set videoDataRate(_arg_1:Number):void
        {
            this._videodatarate = _arg_1;
        }

        public function get timelineInfo():Object
        {
            return (this._timelineInfo);
        }

        public function get duration():Number
        {
            return (this._duration);
        }

        public function set timelineInfo(_arg_1:Object):void
        {
            this._timelineInfo = _arg_1;
        }

        public function set framerate(_arg_1:Number):void
        {
            this._framerate = _arg_1;
        }

        public function get audioCodecId():String
        {
            return (this._audiocodecid);
        }

        public function get controller():IController
        {
            return (this._controller);
        }

        public function get audioDataRate():Number
        {
            return (this._audiodatarate);
        }

        public function set duration(_arg_1:Number):void
        {
            this._duration = _arg_1;
        }

        public function set videoCodecId(_arg_1:String):void
        {
            this._videocodecid = _arg_1;
        }

        public function get height():Number
        {
            return (this._height);
        }

        public function set canSeekToEnd(_arg_1:Boolean):void
        {
            this._canSeekToEnd = _arg_1;
        }

        public function get creationDate():String
        {
            return (this._creationDate);
        }

        public function set audioCodecId(_arg_1:String):void
        {
            this._audiocodecid = _arg_1;
        }

        public function set controller(_arg_1:IController):void
        {
            this._controller = _arg_1;
        }

        public function set width(_arg_1:Number):void
        {
            this._width = _arg_1;
        }

        public function set audioDataRate(_arg_1:Number):void
        {
            this._audiodatarate = _arg_1;
        }

        public function get videoDataRate():Number
        {
            return (this._videodatarate);
        }

        public function get framerate():Number
        {
            return (this._framerate);
        }

        public function set height(_arg_1:Number):void
        {
            this._height = _arg_1;
        }

        public function get videoCodecId():String
        {
            return (this._videocodecid);
        }

        public function get canSeekToEnd():Boolean
        {
            return (this._canSeekToEnd);
        }

        public function set creationDate(_arg_1:String):void
        {
            this._creationDate = _arg_1;
        }

        public function get width():Number
        {
            return (this._width);
        }

        public function set encodedWith(_arg_1:String):void
        {
            this._encodedWith = _arg_1;
        }

        public function get frameRate():Number
        {
            return (this._framerate);
        }

        public function set frameRate(_arg_1:Number):void
        {
            this._framerate = _arg_1;
        }

        public function get encodedWith():String
        {
            return (this._encodedWith);
        }


    }
}//package com.disney.mpf.media.controller.utils
