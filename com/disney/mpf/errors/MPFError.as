//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.errors
{
    public class MPFError extends Error 
    {

        private var _code:int;

        public function MPFError(_arg_1:String, _arg_2:int)
        {
            super(_arg_1, _arg_2);
            this._code = _arg_2;
        }

        public function get code():int
        {
            return (this._code);
        }


    }
}//package com.disney.mpf.errors
