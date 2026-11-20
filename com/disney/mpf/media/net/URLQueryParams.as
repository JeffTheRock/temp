//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class URLQueryParams 
    {

        protected var _params:Dictionary;
        protected var _query:String;

        public function URLQueryParams(_arg_1:String)
        {
            this._query = _arg_1;
            this._params = new Dictionary();
            this.parseQuery();
        }

        public function getKeys():Vector.<String>
        {
            var _local_2:String;
            var _local_1:Vector.<String> = new Vector.<String>();
            for (_local_2 in this._params)
            {
                _local_1.push(_local_2);
            };
            return (_local_1);
        }

        public function getValue(_arg_1:String):String
        {
            return (this._params[_arg_1]);
        }

        protected function parseQuery():void
        {
            var _local_4:String;
            var _local_5:Array;
            var _local_1:RegExp = new RegExp("(&amp;)");
            var _local_2:String = ((_local_1.test(this._query)) ? "&amp;" : "&");
            var _local_3:Array = this._query.split(_local_2);
            for each (_local_4 in _local_3)
            {
                _local_5 = _local_4.split("=");
                this._params[_local_5[0]] = _local_5[1];
            };
        }

        public function get source():String
        {
            return (this._query);
        }


    }
}//package com.disney.mpf.media.net
