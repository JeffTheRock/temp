//Created by Action Script Viewer - https://www.buraks.com/asv
package com.omniture
{
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.URLRequest;

    public dynamic class ActionSource_XML 
    {

        public var data:Object;
        public var loaded:Boolean = true;
        public var onDataReady:String = "";
        private var _url:String;
        private var loader:URLLoader;

        public function ActionSource_XML(_arg_1:Object)
        {
            this.s = _arg_1;
            this.loader = new URLLoader();
            this.loader.addEventListener(Event.COMPLETE, this.onComplete);
        }

        private function handleNode(_arg_1:XML, _arg_2:Object):*
        {
            var _local_3:String;
            var _local_4:XMLList;
            var _local_5:Number;
            _local_3 = _arg_1.name();
            if (((this.s.isSet(_local_3)) && (_arg_1.nodeKind() == "element")))
            {
                _local_4 = _arg_1.children();
                if (((this.s.isSet(_local_4)) && (_local_4.length() > 0)))
                {
                    if (_local_4[0].nodeKind() == "text")
                    {
                        _arg_2[_local_3] = ("" + _local_4[0]);
                    }
                    else
                    {
                        _arg_2[_local_3] = new Object();
                        _local_5 = 0;
                        while (_local_5 < _local_4.length())
                        {
                            this.handleNode(_local_4[_local_5], _arg_2[_local_3]);
                            _local_5++;
                        };
                    };
                };
            };
        }

        public function get url():String
        {
            return (this._url);
        }

        private function loadXML():*
        {
            this.loaded = false;
            this.loader.load(new URLRequest(this._url));
        }

        private function onComplete(_arg_1:Event):*
        {
            var _local_2:Object;
            var _local_3:XML;
            _local_2 = XML.settings();
            XML.ignoreWhitespace = true;
            XML.ignoreProcessingInstructions = true;
            XML.ignoreComments = true;
            _local_3 = new XML(this.loader.data);
            this.data = new Object();
            if (((_local_3.name() == "config") && (_local_3.nodeKind() == "element")))
            {
                this.handleNode(_local_3, this.data);
            };
            XML.setSettings(_local_2);
            if (this.s.isSet(this.onDataReady))
            {
                var _local_4:* = this.s;
                (_local_4[onDataReady](this.data));
            };
            this.loaded = true;
        }

        public function set url(_arg_1:String):*
        {
            var _local_2:String;
            this._url = _arg_1;
            if (this.s.isSet(this._url))
            {
                _local_2 = this._url.toLowerCase();
                if (this.s.isSet(this.s.ssl))
                {
                    if (_local_2.substr(0, 7) == "http://")
                    {
                        this._url = this._url.substr(7);
                        _local_2 = this._url.toLowerCase();
                    };
                    if (_local_2.substr(0, 8) != "https://")
                    {
                        this._url = ("https://" + this._url);
                    };
                }
                else
                {
                    if (((!(_local_2.substr(0, 7) == "http://")) && (!(_local_2.substr(0, 8) == "https://"))))
                    {
                        this._url = ("http://" + this._url);
                    };
                };
                this.loadXML();
            };
        }


    }
}//package com.omniture
