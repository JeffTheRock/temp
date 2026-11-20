//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.services
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.asual.swfaddress.SWFAddress;
    import com.asual.swfaddress.SWFAddressEvent;

    public class SWFAddressService extends Actor 
    {

        public var addressChanged:Signal = new Signal(StateVO);


        public function init():void
        {
            SWFAddress.addEventListener(SWFAddressEvent.INIT, this.onSWFAddressInit, false, 0, true);
        }

        private function onSWFAddressInit(_arg_1:SWFAddressEvent):void
        {
            SWFAddress.removeEventListener(SWFAddressEvent.INIT, this.onSWFAddressInit, false);
            SWFAddress.addEventListener(SWFAddressEvent.CHANGE, this.onSWFAddressChange);
        }

        private function onSWFAddressChange(_arg_1:SWFAddressEvent):void
        {
            var _local_4:String;
            var _local_2:Array = SWFAddress.getPathNames();
            var _local_3:StateVO = new StateVO(_local_2);
            this.addressChanged.dispatch(_local_3);
        }

        public function setValue(_arg_1:String):void
        {
            SWFAddress.setValue(_arg_1);
        }

        public function getValue():String
        {
            return (SWFAddress.getValue());
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.services
