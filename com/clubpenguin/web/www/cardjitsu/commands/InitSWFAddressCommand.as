//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;

    public class InitSWFAddressCommand extends SignalCommand 
    {

        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            this.mainModel.initSWFAddressService();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.commands
