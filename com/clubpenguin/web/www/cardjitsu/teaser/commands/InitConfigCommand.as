//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.DataLoaderService;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel;
    import com.clubpenguin.web.libs.utils.Environment;
    import flash.display.LoaderInfo;

    public class InitConfigCommand extends SignalCommand 
    {

        [Inject]
        public var dataLoaderService:DataLoaderService;
        [Inject]
        public var mainModel:MainModel;
        private var _flashVars:Object;


        override public function execute():void
        {
            if (Environment.IS_IN_BROWSER)
            {
                this._flashVars = LoaderInfo(contextView.loaderInfo).parameters;
                this.dataLoaderService.addURL(this._flashVars.data);
            }
            else
            {
                this.dataLoaderService.addURL("../xml/config.xml");
            };
            this.dataLoaderService.loadComplete.addOnce(this.onDataLoaded);
            this.dataLoaderService.execute();
        }

        private function onDataLoaded(_arg_1:Array):void
        {
            if (Environment.IS_IN_BROWSER)
            {
                _arg_1[0].video.src = this._flashVars.vidSrc;
            };
            this.mainModel.initConfigData(_arg_1);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.commands
