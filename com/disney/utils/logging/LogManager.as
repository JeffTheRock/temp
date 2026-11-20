//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.utils.logging
{
    import com.disney.utils.logging.types.ILogger;

    public class LogManager 
    {

        public static const DEBUG:String = "logDebug";
        public static const INFO:String = "logInfo";
        public static const ERROR:String = "logError";
        public static const WARN:String = "logWarn";
        private static var _instance:LogManager;

        private var _loggers:Array;
        private var _useDebug:Boolean;
        private var _useInfo:Boolean;

        public function LogManager(_arg_1:SingletonEnforcer)
        {
            this._loggers = new Array();
            this._useDebug = true;
            this._useInfo = true;
        }

        public static function getInstance():LogManager
        {
            if (_instance == null)
            {
                _instance = new LogManager(new SingletonEnforcer());
            };
            return (_instance);
        }


        private function loggerIndex(_arg_1:ILogger):int
        {
            var _local_2:uint = this._loggers.length;
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                if (this._loggers[_local_3] == _arg_1)
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (-1);
        }

        public function set useInfo(_arg_1:Boolean):void
        {
            this._useInfo = _arg_1;
        }

        public function addLogger(_arg_1:ILogger):void
        {
            if (this.loggerIndex(_arg_1) == -1)
            {
                this._loggers.push(_arg_1);
            };
        }

        public function removeLogger(_arg_1:ILogger):void
        {
            var _local_2:int = this.loggerIndex(_arg_1);
            if (_local_2 > -1)
            {
                this._loggers.splice(_local_2, 1);
            };
        }

        public function get useInfo():Boolean
        {
            return (this._useInfo);
        }

        public function set useDebug(_arg_1:Boolean):void
        {
            this._useDebug = _arg_1;
        }

        public function get useDebug():Boolean
        {
            return (this._useDebug);
        }

        public function log(_arg_1:String, _arg_2:String="logDebug"):void
        {
            var _local_5:ILogger;
            var _local_3:uint = this._loggers.length;
            var _local_4:uint;
            while (_local_4 < _local_3)
            {
                _local_5 = this._loggers[_local_4];
                switch (_arg_2)
                {
                    case DEBUG:
                        if (this._useDebug)
                        {
                            _local_5.debug(_arg_1);
                        };
                        break;
                    case INFO:
                        if (this._useInfo)
                        {
                            _local_5.info(_arg_1);
                        };
                        break;
                    case WARN:
                        _local_5.warn(_arg_1);
                        break;
                    case ERROR:
                        _local_5.error(_arg_1);
                        break;
                    default:
                        _local_5.log(_arg_1);
                };
                _local_4++;
            };
        }


    }
}//package com.disney.utils.logging

class SingletonEnforcer 
{


}

