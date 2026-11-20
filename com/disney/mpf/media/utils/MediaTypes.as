//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.utils
{
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.media.model.IMedia;

    public class MediaTypes 
    {

        private static var _installedSystem:Object = new Object();


        public static function getMediaType(_arg_1:String):IMedia
        {
            var _local_2:Class = _installedSystem[_arg_1.toUpperCase()];
            if (_local_2 == null)
            {
                throw (new MPFError("unsupported media type", MPFErrorCodes.UNSUPPORTED_MEDIA_TYPE));
            };
            var _local_3:IMedia = new (_local_2)();
            _local_3.format = _arg_1;
            return (_local_3);
        }

        public static function install(_arg_1:String, _arg_2:Class):void
        {
            _installedSystem[_arg_1.toUpperCase()] = _arg_2;
        }


    }
}//package com.disney.mpf.media.utils
