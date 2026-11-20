//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model
{
    import com.disney.mpf.collections.ICollection;

    public interface IAsset 
    {

        function getParent():IAsset;
        function get name():String;
        function addItem(_arg_1:IAsset):void;
        function set name(_arg_1:String):void;
        function removeItem(_arg_1:String):void;
        function destroy():void;
        function get id():String;
        function setParent(_arg_1:IAsset):void;
        function set id(_arg_1:String):void;
        function iterator():ICollection;

    }
}//package com.disney.mpf.media.model
