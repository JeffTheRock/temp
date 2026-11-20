//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.models
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.web.www.cardjitsu.teaser.signals.InitFontsSignal;
    import com.clubpenguin.web.www.cardjitsu.teaser.signals.InitTrackingServiceSignal;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.TrackingService;
    import org.osflash.signals.Signal;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.VideoVO;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.EmbedVO;
    import com.clubpenguin.web.libs.utils.Environment;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.FontVO;

    public class MainModel extends Actor 
    {

        private static var BASE_DATA_URL:String = "";

        [Inject]
        public var initFontsSignal:InitFontsSignal;
        [Inject]
        public var initTrackingServiceSignal:InitTrackingServiceSignal;
        [Inject]
        public var trackingService:TrackingService;
        private var _dataObjectTreeArray:Array;
        private var _fontVOArray:Array;
        public var configDataLoaded:Signal = new Signal();
        public var initialLoadComplete:Signal = new Signal();
        private var _videoVO:VideoVO;
        private var _embedVO:EmbedVO;


        public function initConfigData(_arg_1:Array):void
        {
            this._dataObjectTreeArray = _arg_1;
            this.initBaseURL();
            this.initFontVOArray();
            this.initVideoVO();
            this.initEmbedVO();
            this.initFontsSignal.dispatch(this._fontVOArray);
        }

        private function initBaseURL():void
        {
            if (Environment.IS_IN_BROWSER)
            {
                BASE_DATA_URL = this._dataObjectTreeArray[0].base_url.href;
            }
            else
            {
                BASE_DATA_URL = "../";
            };
        }

        private function initFontVOArray():void
        {
            var _local_4:FontVO;
            this._fontVOArray = [];
            var _local_1:Object = this._dataObjectTreeArray[0].font_list;
            var _local_2:int = _local_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = new FontVO();
                _local_4.src = (BASE_DATA_URL + _local_1[_local_3].src);
                this._fontVOArray[_local_3] = _local_4;
                _local_3++;
            };
        }

        private function initVideoVO():void
        {
            this._videoVO = new VideoVO();
            this._videoVO.videoSrc = (BASE_DATA_URL + this._dataObjectTreeArray[0].video.src);
            this._videoVO.width = this.dataObjectTreeArray[0].video.width;
            this._videoVO.height = this.dataObjectTreeArray[0].video.height;
        }

        public function get videoVO():VideoVO
        {
            return (this._videoVO);
        }

        private function initEmbedVO():void
        {
            this._embedVO = new EmbedVO();
            this._embedVO.label = this.dataObjectTreeArray[0].embed_code.text;
            this._embedVO.embedCode = this.dataObjectTreeArray[0].embed_code.src;
        }

        public function get embedVO():EmbedVO
        {
            return (this._embedVO);
        }

        public function fontsLoaded():void
        {
            this.initTrackingServiceSignal.dispatch();
        }

        public function trackingServiceLoaded():void
        {
            this.configDataLoaded.dispatch();
            this.initialLoadComplete.dispatch();
        }

        public function get dataObjectTreeArray():Array
        {
            return (this._dataObjectTreeArray);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.models
