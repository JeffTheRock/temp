//Created by Action Script Viewer - https://www.buraks.com/asv
package org.osflash.signals.natives
{
    import org.osflash.signals.IPrioritySignal;

    public interface INativeSignalOwner extends IPrioritySignal, INativeDispatcher 
    {

        function removeAll():void;

    }
}//package org.osflash.signals.natives
