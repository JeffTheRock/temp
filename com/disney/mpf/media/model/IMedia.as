//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model
{
    import com.disney.mpf.collections.CuePointCollection;
    import com.disney.mpf.media.controller.IController;

    public interface IMedia 
    {

        function get cuePointCollection():CuePointCollection;
        function set cuePointCollection(_arg_1:CuePointCollection):void;
        function get deliveryMode():int;
        function set duration(_arg_1:Number):void;
        function get name():String;
        function set format(_arg_1:String):void;
        function get url():String;
        function get duration():Number;
        function set deliveryMode(_arg_1:int):void;
        function set name(_arg_1:String):void;
        function get format():String;
        function createController():IController;
        function destroy():void;
        function get id():String;
        function set id(_arg_1:String):void;
        function set url(_arg_1:String):void;

    }
}//package com.disney.mpf.media.model
