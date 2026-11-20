//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.libs.utils
{
    import flash.system.Capabilities;
    import flash.net.LocalConnection;

    public class Environment 
    {


        public static function get IS_IN_BROWSER():Boolean
        {
            return ((Capabilities.playerType == "PlugIn") || (Capabilities.playerType == "ActiveX"));
        }

        public static function get DOMAIN():String
        {
            return (new LocalConnection().domain);
        }


    }
}//package com.clubpenguin.web.libs.utils
