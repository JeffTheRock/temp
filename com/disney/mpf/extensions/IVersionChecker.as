//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.extensions
{
    public interface IVersionChecker 
    {

        function get isFlashPlayerVersionCompatible():Boolean;
        function get minMPFVersion():String;
        function get version():String;
        function get minFlashPlayerVersion():String;
        function get isMPFVersionCompatible():Boolean;

    }
}//package com.disney.mpf.extensions
