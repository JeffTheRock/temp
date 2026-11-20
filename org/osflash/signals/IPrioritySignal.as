//Created by Action Script Viewer - https://www.buraks.com/asv
package org.osflash.signals
{
    public interface IPrioritySignal extends ISignal 
    {

        function addWithPriority(_arg_1:Function, _arg_2:int=0):Function;
        function addOnceWithPriority(_arg_1:Function, _arg_2:int=0):Function;

    }
}//package org.osflash.signals
