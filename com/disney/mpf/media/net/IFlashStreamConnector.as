//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import flash.net.NetStream;

    public interface IFlashStreamConnector extends IStreamConnector 
    {

        function closeNetStream():void;
        function get ns():NetStream;

    }
}//package com.disney.mpf.media.net
