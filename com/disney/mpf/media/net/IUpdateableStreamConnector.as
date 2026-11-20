//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.net
{
    import com.disney.mpf.media.model.IMedia;

    public interface IUpdateableStreamConnector 
    {

        function updateConnectionComplete():void;
        function dispatchConnectionUpdateFailure():void;
        function dispatchConnectionUpdateSuccess():void;
        function updateConnection(_arg_1:IMedia=null):void;

    }
}//package com.disney.mpf.media.net
