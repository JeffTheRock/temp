//Created by Action Script Viewer - https://www.buraks.com/asv
package org.osflash.signals
{
    public interface ISignal 
    {

        function get valueClasses():Array;
        function set valueClasses(_arg_1:Array):void;
        function get numListeners():uint;
        function add(_arg_1:Function):Function;
        function addOnce(_arg_1:Function):Function;
        function remove(_arg_1:Function):Function;

    }
}//package org.osflash.signals
