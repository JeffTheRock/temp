//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.extensions
{
    import com.disney.mpf.errors.MPFError;
    import flash.utils.getQualifiedClassName;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.MPF;

    public class VersionChecker implements IVersionChecker 
    {

        protected var _minFlashPlayerVersion:String;
        protected var _minMPFVersion:String;
        protected var _version:String;

        public function VersionChecker(_arg_1:IMPFExtension, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Boolean=false)
        {
            this._version = _arg_2;
            this._minMPFVersion = _arg_3;
            this._minFlashPlayerVersion = _arg_4;
            if (_arg_5)
            {
                if (((!(this.isMPFVersionCompatible)) || (!(this.isFlashPlayerVersionCompatible))))
                {
                    throw (new MPFError((((getQualifiedClassName(_arg_1) + " is not compatible with this version of the MPF. It requires MPF ") + _arg_3) + " or higher."), MPFErrorCodes.EXTENSION_INCOMPATIBLE_MPF_VERSION_REQUIREMENTS_NOT_MET));
                };
            };
        }

        public function get minFlashPlayerVersion():String
        {
            return (this._minFlashPlayerVersion);
        }

        protected function isVersionCompatible(_arg_1:Array, _arg_2:Array):Boolean
        {
            var _local_3:Number = 0;
            while (_local_3 < 4)
            {
                if (Number(_arg_1[_local_3]) > Number(_arg_2[_local_3])) break;
                if (Number(_arg_1[_local_3]) < Number(_arg_2[_local_3]))
                {
                    return (false);
                };
                _local_3++;
            };
            return (true);
        }

        public function get isFlashPlayerVersionCompatible():Boolean
        {
            var _local_1:Array = MPF.TARGET_FLASH_PLAYER_VERSION.split(".");
            var _local_2:Array = this.minFlashPlayerVersion.split(".");
            return (this.isVersionCompatible(_local_1, _local_2));
        }

        public function get minMPFVersion():String
        {
            return (this._minMPFVersion);
        }

        public function get isMPFVersionCompatible():Boolean
        {
            var _local_1:Array = MPF.VERSION.split(".");
            var _local_2:Array = this.minMPFVersion.split(".");
            return (this.isVersionCompatible(_local_1, _local_2));
        }

        public function get version():String
        {
            return (this._version);
        }


    }
}//package com.disney.mpf.extensions
