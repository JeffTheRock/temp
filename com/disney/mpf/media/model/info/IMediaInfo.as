//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model.info
{
    import com.disney.mpf.media.model.info.meta.IMetaInfo;
    import com.disney.mpf.media.model.IMedia;
    import com.disney.mpf.media.model.info.qos.AbstractQOSData;
    import com.disney.mpf.media.controller.IController;

    public interface IMediaInfo 
    {

        function get meta():IMetaInfo;
        function get bufferLength():Number;
        function set media(_arg_1:IMedia):void;
        function set meta(_arg_1:IMetaInfo):void;
        function set bufferLength(_arg_1:Number):void;
        function get bitRate():Number;
        function get bytesLoaded():Number;
        function get state():uint;
        function set percentLoaded(_arg_1:Number):void;
        function get currentShowId():String;
        function get bytesTotal():Number;
        function set time(_arg_1:Number):void;
        function get duration():Number;
        function get time():Number;
        function get qosData():AbstractQOSData;
        function set bytesLoaded(_arg_1:Number):void;
        function set bitRate(_arg_1:Number):void;
        function set state(_arg_1:uint):void;
        function get controller():IController;
        function get media():IMedia;
        function set duration(_arg_1:Number):void;
        function set currentShowId(_arg_1:String):void;
        function get percentLoaded():Number;
        function set newShowId(_arg_1:String):void;
        function set bytesTotal(_arg_1:Number):void;
        function set volume(_arg_1:Number):void;
        function set controller(_arg_1:IController):void;
        function set availableDuration(_arg_1:Number):void;
        function get volume():Number;
        function get availableDuration():Number;
        function set qosData(_arg_1:AbstractQOSData):void;
        function get newShowId():String;

    }
}//package com.disney.mpf.media.model.info
