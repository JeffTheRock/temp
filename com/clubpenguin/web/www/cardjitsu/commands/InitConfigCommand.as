//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.services.DataLoaderService;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.libs.utils.Environment;
    import flash.display.LoaderInfo;

    public class InitConfigCommand extends SignalCommand 
    {

        [Inject]
        public var dataLoaderService:DataLoaderService;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            var _local_1:String;
            if (Environment.IS_IN_BROWSER)
            {
                _local_1 = LoaderInfo(contextView.parent.loaderInfo).parameters.data;
            }
            else
            {
                _local_1 = "../xml/config.xml";
            };
            this.dataLoaderService.loadComplete.addOnce(this.onDataLoaded);
            this.dataLoaderService.init(_local_1);
        }

        private function onDataLoaded(_arg_1:Object):void
        {
            this.mainModel.initConfigData(_arg_1);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.commands
