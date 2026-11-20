//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.services
{
    import org.osflash.signals.Signal;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class FontLoaderService 
    {

        public var loadComplete:Signal = new Signal();
        private var _isLoading:Boolean = false;
        private var _urlArray:Array = [];
        private var _totalCount:int = 0;
        private var _currentCount:int = 0;


        public function addURL(_arg_1:String):void
        {
            if (!this._isLoading)
            {
                this._urlArray.push(_arg_1);
            }
            else
            {
                trace((this + "\n\taddUrl() operation illegal as class is currently loading"));
            };
        }

        public function execute():void
        {
            var _local_1:int;
            var _local_2:Loader;
            if (!this._isLoading)
            {
                this._isLoading = true;
                this._totalCount = this._urlArray.length;
                _local_1 = 0;
                while (_local_1 < this._totalCount)
                {
                    _local_2 = new Loader();
                    _local_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onFontLoadComplete);
                    _local_2.load(new URLRequest(this._urlArray[_local_1]));
                    _local_1++;
                };
            }
            else
            {
                trace((this + "\n\tERROR: execute() operation illegal as class is currently loading"));
            };
        }

        private function onFontLoadComplete(_arg_1:Event):void
        {
            _arg_1.target.removeEventListener(Event.COMPLETE, this.onFontLoadComplete);
            this._currentCount++;
            if (this._currentCount == this._totalCount)
            {
                this.loadComplete.dispatch();
            };
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.services
