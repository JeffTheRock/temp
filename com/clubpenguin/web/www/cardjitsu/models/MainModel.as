//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.models
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.web.www.cardjitsu.signals.InitTrackingServiceSignal;
    import com.clubpenguin.web.www.cardjitsu.signals.InitSWFAddressSignal;
    import com.clubpenguin.web.www.cardjitsu.services.SWFAddressService;
    import com.clubpenguin.web.www.cardjitsu.services.TrackingService;
    import org.osflash.signals.Signal;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.clubpenguin.web.libs.utils.Environment;
    import com.clubpenguin.web.www.cardjitsu.models.vo.MainContentDataVO;
    import com.clubpenguin.web.www.cardjitsu.models.vo.ButtonVO;
    import com.clubpenguin.web.www.cardjitsu.models.vo.VideoVO;
    import com.clubpenguin.web.www.cardjitsu.models.vo.CalloutDataVO;
    import com.omniture.ActionSource;
    import com.greensock.TweenMax;

    public class MainModel extends Actor 
    {

        private static const TRACKING_STRING_INITIAL:String = "lp_cardjitsu_";
        private static var CDN_URL:String = "../";
        private static var CURRENT_LANGUAGE:String = "EN";

        [Inject]
        public var initTrackingServiceSignal:InitTrackingServiceSignal;
        [Inject]
        public var initSWFAddressSignal:InitSWFAddressSignal;
        [Inject]
        public var swfAddressService:SWFAddressService;
        [Inject]
        public var trackingService:TrackingService;
        public var initialLoadComplete:Signal = new Signal();
        public var stateChangedSignal:Signal = new Signal(StateVO);
        private var _configObjectTree:Object;
        private var _mainContentDataVOArray:Array = [];
        private var _calloutDataVOArray:Array = [];
        private var _stateVO:StateVO;
        private var _trackingURL:String;


        public function initConfigData(_arg_1:Object):void
        {
            this._configObjectTree = _arg_1;
            this.initTrackingURL();
            this.initBaseURL();
            this.initCurrentLanguage();
            this.initMainContentDataVO();
            this.initCalloutVOArray();
            this.initTrackingServiceSignal.dispatch();
        }

        private function initTrackingURL():void
        {
            this._trackingURL = this._configObjectTree.tracking.src;
        }

        public function get trackingURL():String
        {
            return (this._trackingURL);
        }

        private function initBaseURL():void
        {
            if (Environment.IS_IN_BROWSER)
            {
                CDN_URL = this._configObjectTree.cdn_url.href;
            };
        }

        private function initCurrentLanguage():void
        {
            CURRENT_LANGUAGE = this._configObjectTree.language.text;
        }

        public function get currentLanguage():String
        {
            return (CURRENT_LANGUAGE);
        }

        private function initMainContentDataVO():void
        {
            var _local_3:MainContentDataVO;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Object;
            var _local_9:Object;
            var _local_10:ButtonVO;
            var _local_11:VideoVO;
            var _local_1:int = this._configObjectTree.section_list.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = new MainContentDataVO();
                _local_3.title = this._configObjectTree.section_list[_local_2].title.text;
                _local_4 = this._configObjectTree.section_list[_local_2].instruction_list.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_8 = this._configObjectTree.section_list[_local_2].instruction_list[_local_5];
                    _local_9 = {
                        "text":_local_8.text,
                        "x":_local_8.x,
                        "y":_local_8.y,
                        "src":_local_8.src
                    };
                    _local_3.instructionArray.push(_local_9);
                    _local_5++;
                };
                _local_6 = this._configObjectTree.ui_list.length;
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    _local_10 = new ButtonVO(this._configObjectTree.ui_list[_local_7]);
                    _local_10.language = this.currentLanguage.toLowerCase();
                    _local_3.buttonVOArray[_local_7] = _local_10;
                    _local_7++;
                };
                if (this._configObjectTree.section_list[_local_2].video)
                {
                    _local_11 = new VideoVO(this._configObjectTree.section_list[_local_2].video);
                    _local_11.id = this._configObjectTree.section_list[_local_2].id;
                    _local_11.language = CURRENT_LANGUAGE;
                    _local_11.vidSrc = (CDN_URL + this._configObjectTree.section_list[_local_2].video.src);
                    _local_3.videoVO = _local_11;
                };
                this._mainContentDataVOArray[_local_2] = _local_3;
                _local_2++;
            };
        }

        public function get mainContentDataVOArray():Array
        {
            return (this._mainContentDataVOArray);
        }

        private function initCalloutVOArray():void
        {
            var _local_3:CalloutDataVO;
            var _local_1:int = this._configObjectTree.callout_list.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = new CalloutDataVO(this._configObjectTree.callout_list[_local_2]);
                this._calloutDataVOArray[_local_2] = _local_3;
                _local_2++;
            };
        }

        public function get calloutVOArray():Array
        {
            return (this._calloutDataVOArray);
        }

        public function trackingServiceLoaded():void
        {
            this.initSWFAddressSignal.dispatch();
            this.initialLoadComplete.dispatch();
        }

        public function get actionsource():ActionSource
        {
            return (this.trackingService.actionsource);
        }

        public function initSWFAddressService():void
        {
            this.swfAddressService = new SWFAddressService();
            this.swfAddressService.addressChanged.add(this.onAddressChanged);
            this.swfAddressService.init();
        }

        public function onAddressChanged(_arg_1:StateVO):void
        {
            this._stateVO = _arg_1;
            TweenMax.killAll(true, false);
            this.trackPage(this._stateVO.mainState);
            this.stateChangedSignal.dispatch(this._stateVO);
        }

        private function trackPage(_arg_1:String):void
        {
            var _local_2:String = TRACKING_STRING_INITIAL;
            switch (_arg_1)
            {
                case StateVO.FIRE:
                    _local_2 = (_local_2 + "fire_");
                    break;
                case StateVO.WATER:
                    _local_2 = (_local_2 + "water_");
                    break;
            };
            _local_2 = (_local_2 + this.currentLanguage.toLowerCase());
            this.trackingService.submitPageView("cardjitsu", _local_2);
        }

        public function trackLink(_arg_1:String):void
        {
            var _local_2:String = TRACKING_STRING_INITIAL;
            switch (this._stateVO.mainState)
            {
                case StateVO.FIRE:
                    _local_2 = (_local_2 + "fire_");
                    break;
                case StateVO.WATER:
                    _local_2 = (_local_2 + "water_");
                    break;
            };
            _local_2 = (_local_2 + ((_arg_1 + "_") + this.currentLanguage.toLowerCase()));
            this.trackingService.submitLinkClick("cardjitsu", _local_2);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.models
