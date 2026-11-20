//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.services
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import com.clubpenguin.web.libs.utils.SimpleParserXML;

    public class DataLoaderService extends Actor 
    {

        public var loadComplete:Signal = new Signal(Array);
        private var _isLoading:Boolean = false;
        private var _urlArray:Array = [];
        private var _objectTreeArray:Array = [];
        private var _currentCount:int = 0;
        private var _totalCount:int = 0;


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
            var _local_2:URLLoader;
            if (!this._isLoading)
            {
                this._isLoading = true;
                this._totalCount = this._urlArray.length;
                _local_1 = 0;
                while (_local_1 < this._totalCount)
                {
                    _local_2 = new URLLoader();
                    _local_2.addEventListener(Event.COMPLETE, this.onTextLoadComplete);
                    _local_2.load(new URLRequest(this._urlArray[_local_1]));
                    _local_1++;
                };
            }
            else
            {
                trace((this + "\n\tERROR: execute() operation illegal as class is currently loading"));
            };
        }

        private function onTextLoadComplete(_arg_1:Event):void
        {
            var _local_2:XML = new XML(_arg_1.target.data);
            _arg_1.target.removeEventListener(Event.COMPLETE, this.onTextLoadComplete);
            var _local_3:SimpleParserXML = new SimpleParserXML();
            var _local_4:Object = _local_3.getObjectTreeFromXml(_local_2);
            this._objectTreeArray.push(_local_4);
            this._currentCount++;
            if (this._currentCount == this._totalCount)
            {
                this.loadComplete.dispatch(this._objectTreeArray);
            };
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.services
