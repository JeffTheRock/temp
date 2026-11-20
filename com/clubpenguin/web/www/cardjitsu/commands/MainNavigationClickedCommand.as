//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.services.SWFAddressService;

    public class MainNavigationClickedCommand extends SignalCommand 
    {

        [Inject]
        public var buttonName:String;
        [Inject]
        public var swfAddressService:SWFAddressService;


        override public function execute():void
        {
            this.swfAddressService.setValue((this.buttonName + "/"));
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.commands
