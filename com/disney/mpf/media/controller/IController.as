//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller
{
    import com.disney.mpf.media.model.IMedia;

    public interface IController 
    {

        function get position():Number;
        function stop():void;
        function get duration():Number;
        function get media():IMedia;
        function load():void;
        function set media(_arg_1:IMedia):void;
        function set state(_arg_1:uint):void;
        function set volume(_arg_1:Number):void;
        function set duration(_arg_1:Number):void;
        function init():void;
        function get state():uint;
        function get volume():Number;
        function play(_arg_1:Number=undefined):void;
        function pause():void;
        function seek(_arg_1:Number):void;
        function destroy():void;
        function get id():Number;

    }
}//package com.disney.mpf.media.controller
