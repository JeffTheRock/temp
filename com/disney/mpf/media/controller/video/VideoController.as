//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller.video
{
    import com.disney.mpf.media.controller.AbstractController;
    import com.disney.mpf.media.model.info.meta.IMetaInfo;
    import com.disney.mpf.media.model.info.MediaInfo;
    import com.disney.mpf.media.controller.utils.ControllerStates;
    import com.disney.mpf.media.model.info.IMediaInfo;

    public class VideoController extends AbstractController implements IVideoController 
    {

        public static const WIDTH:String = "WIDTH";
        public static const HEIGHT:String = "HEIGHT";
        public static const WIDE_SCREEN:String = "16:9";
        public static const STANDARD_SCREEN:String = "4:3";
        public static var aspectRatioTolerance:Number = 0.05;
        protected static const WIDE_SCREEN_RATIO:Number = 1.77777777777778;
        protected static const NORMAL_SCREEN_RATIO:Number = 1.33333333333333;

        protected var _currentAspectRatio:Number = 0;
        protected var _maxWidth:Number = -1;
        protected var _metaInfo:IMetaInfo;
        private var _autoSize:Boolean;
        private var _clip:*;
        protected var _maxHeight:Number = -1;
        protected var _maintainAspectRatio:Boolean = true;
        protected var _realAspectRatio:Number = 0;
        protected var _maintainAspectRatioAnchor:String = "HEIGHT";


        public function set maxWidth(_arg_1:Number):void
        {
            this._maxWidth = _arg_1;
        }

        public function get maintainAspectRatio():Boolean
        {
            return (this._maintainAspectRatio);
        }

        public function realAspectRatio():String
        {
            return (null);
        }

        public function set maintainAspectRatio(_arg_1:Boolean):void
        {
            this._maintainAspectRatio = _arg_1;
        }

        public function set autoSize(_arg_1:Boolean):void
        {
            this._autoSize = _arg_1;
        }

        public function get maxHeight():Number
        {
            return (this._maxHeight);
        }

        public function set clip(_arg_1:*):void
        {
            this._clip = _arg_1;
        }

        public function resize(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=false, _arg_4:String="4:3", _arg_5:String="WIDTH"):void
        {
            var _local_6:Number;
            if (_arg_3)
            {
                _local_6 = -1;
                switch (_arg_5)
                {
                    case VideoController.WIDTH:
                        _local_6 = _arg_1;
                        break;
                    case VideoController.HEIGHT:
                        _local_6 = _arg_2;
                        break;
                    default:
                        return;
                };
                this.changeAspectRatio(_arg_4, _arg_5, _local_6);
            }
            else
            {
                width = _arg_1;
                height = _arg_2;
            };
        }

        public function set maintainAspectRatioAnchor(_arg_1:String):void
        {
            this._maintainAspectRatioAnchor = _arg_1;
        }

        public function changeAspectRatio(_arg_1:String, _arg_2:String="WIDTH", _arg_3:Number=-1):void
        {
            var _local_4:Array = _arg_1.split(":");
            var _local_5:Number = Number(_local_4[0]);
            var _local_6:Number = Number(_local_4[1]);
            var _local_7:Number = 0;
            var _local_8:Number = 0;
            switch (_arg_1)
            {
                case VideoController.WIDE_SCREEN:
                    this._currentAspectRatio = VideoController.WIDE_SCREEN_RATIO;
                    break;
                case VideoController.STANDARD_SCREEN:
                    this._currentAspectRatio = VideoController.NORMAL_SCREEN_RATIO;
                    break;
                default:
                    this._currentAspectRatio = (_local_5 / _local_6);
            };
            if (_arg_3 > -1)
            {
                switch (_arg_2)
                {
                    case VideoController.WIDTH:
                        _local_7 = ((_arg_3 > -1) ? _arg_3 : width);
                        if (((this.maxWidth > 0) && (_local_7 > this.maxWidth)))
                        {
                            _local_7 = this.maxWidth;
                        };
                        _local_8 = Math.round(((_local_7 / _local_5) * _local_6));
                        if (((this.maxHeight > 0) && (_local_8 > this.maxHeight)))
                        {
                            _local_8 = this.maxHeight;
                            _local_7 = Math.round(((_local_8 / _local_6) * _local_5));
                        };
                        break;
                    case VideoController.HEIGHT:
                        _local_8 = ((_arg_3 > -1) ? _arg_3 : height);
                        if (((this.maxHeight > 0) && (_local_8 > this.maxHeight)))
                        {
                            _local_8 = this.maxHeight;
                        };
                        _local_7 = Math.round(((_local_8 / _local_6) * _local_5));
                        if (((this.maxWidth > 0) && (_local_7 > this.maxWidth)))
                        {
                            _local_7 = this.maxWidth;
                            _local_8 = Math.round(((_local_7 / _local_5) * _local_6));
                        };
                        break;
                    default:
                        return;
                };
                this.resize(_local_7, _local_8);
            };
        }

        override public function populateData():IMediaInfo
        {
            var _local_1:MediaInfo = new MediaInfo();
            _local_1.controller = this;
            _local_1.state = state;
            _local_1.media = media;
            _local_1.bytesLoaded = 0;
            _local_1.bytesTotal = 0;
            _local_1.meta = this._metaInfo;
            if (_local_1.state > ControllerStates.INITIALIZING)
            {
                _local_1.time = position;
                _local_1.duration = duration;
                _local_1.volume = volume;
            };
            if (_local_1.state > ControllerStates.LOADED)
            {
                _local_1.percentLoaded = 1;
            };
            return (_local_1);
        }

        public function get clip():*
        {
            return (this._clip);
        }

        public function get maxWidth():Number
        {
            return (this._maxWidth);
        }

        public function currentAspectRatio():String
        {
            return (null);
        }

        public function get maintainAspectRatioAnchor():String
        {
            return (this._maintainAspectRatioAnchor);
        }

        public function get autoSize():Boolean
        {
            return (this._autoSize);
        }

        public function set maxHeight(_arg_1:Number):void
        {
            this._maxHeight = _arg_1;
        }


    }
}//package com.disney.mpf.media.controller.video
