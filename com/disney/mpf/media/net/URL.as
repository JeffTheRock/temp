//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    public class URL 
    {

        protected static const PROTOCOL_PATTERN:RegExp = /^([a-z][a-z0-9+\-.]*):/;
        protected static const HOST_PATTERN:RegExp = /([a-zA-Z0-9]+\.[a-zA-Z0-9\-._]+)|\/([a-zA-Z0-9\-._]+)/;
        protected static const PORT_PATTERN:RegExp = /:([0-9]{2,4})/;
        protected static const PATH_PATTERN:RegExp = /([a-zA-Z0-9]+\.[a-zA-Z0-9\-._]+)\/([a-zA-Z0-9\-._~%!$&'()*+,;=;@\/]+)/;
        protected static const QUERY_PATTERN:RegExp = /\?([^#]+)/;

        protected var _port:String;
        protected var _path:String;
        protected var _host:String;
        protected var _query:URLQueryParams;
        protected var _protocol:String;
        protected var _source:String;

        public function URL(_arg_1:String)
        {
            this._source = _arg_1;
            this.parseURI();
        }

        public function get port():String
        {
            return (this._port);
        }

        protected function parseHost():void
        {
            if (HOST_PATTERN.test(this._source))
            {
                this._host = HOST_PATTERN.exec(this._source).pop();
            };
        }

        protected function parsePort():void
        {
            if (PORT_PATTERN.test(this._source))
            {
                this._port = PORT_PATTERN.exec(this._source).pop();
            };
        }

        public function get path():String
        {
            return (this._path);
        }

        public function get host():String
        {
            return (this._host);
        }

        protected function parseProtocol():void
        {
            if (PROTOCOL_PATTERN.test(this._source))
            {
                this._protocol = PROTOCOL_PATTERN.exec(this._source).pop();
            };
        }

        protected function parseQuery():void
        {
            if (QUERY_PATTERN.test(this._source))
            {
                this._query = new URLQueryParams(QUERY_PATTERN.exec(this._source).pop());
            };
        }

        public function get protocol():String
        {
            return (this._protocol);
        }

        protected function parseURI():void
        {
            this.parseProtocol();
            this.parseHost();
            this.parsePort();
            this.parsePath();
            this.parseQuery();
        }

        public function get source():String
        {
            return (this._source);
        }

        public function get query():URLQueryParams
        {
            return (this._query);
        }

        protected function parsePath():void
        {
            if (PATH_PATTERN.test(this._source))
            {
                this._path = PATH_PATTERN.exec(this._source).pop();
            };
        }


    }
}//package com.disney.mpf.media.net
