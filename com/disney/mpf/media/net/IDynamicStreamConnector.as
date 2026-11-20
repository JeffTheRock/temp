//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import flash.net.DynamicStream;

    public interface IDynamicStreamConnector extends IStreamConnector 
    {

        function closeNetStream():void;
        function get ds():DynamicStream;

    }
}//package com.disney.mpf.media.net
