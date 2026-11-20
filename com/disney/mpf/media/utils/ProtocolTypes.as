//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.utils
{
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;

    public class ProtocolTypes 
    {

        public static const PROGRESSIVE:String = "progressive";
        public static const STREAMING:String = "streaming";


        public static function getProtocolType(_arg_1:String):String
        {
            var _local_2:String = ProtocolTypes[_arg_1.toUpperCase()];
            if (_local_2 == null)
            {
                throw (new MPFError("unsupported protocol type", MPFErrorCodes.UNSUPPORTED_PROTOCOL_TYPE));
            };
            return (_arg_1);
        }


    }
}//package com.disney.mpf.media.utils
