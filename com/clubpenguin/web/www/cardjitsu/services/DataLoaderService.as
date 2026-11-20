//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.services
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import org.osflash.signals.natives.NativeSignal;
    import flash.events.Event;
    import flash.net.URLRequest;
    import com.clubpenguin.web.libs.utils.SimpleParserXML;

    public class DataLoaderService extends Actor 
    {

        public var loadComplete:Signal = new Signal(Object);


        public function init(_arg_1:String):void
        {
            var _local_2:URLLoader = new URLLoader();
            var _local_3:NativeSignal = new NativeSignal(_local_2, Event.COMPLETE, Event);
            _local_3.addOnce(this.onLoadComplete);
            _local_2.load(new URLRequest(_arg_1));
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            var _local_2:XML = new XML(_arg_1.target.data);
            var _local_3:Object = new SimpleParserXML().getObjectTreeFromXml(_local_2);
            this.loadComplete.dispatch(_local_3);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.services
