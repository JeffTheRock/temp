//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.FontLoaderService;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel;

    public class InitFontsCommand extends SignalCommand 
    {

        [Inject]
        public var fontVOArray:Array;
        [Inject]
        public var fontLoaderService:FontLoaderService;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            var _local_3:String;
            var _local_1:int = this.fontVOArray.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = this.fontVOArray[_local_2].src;
                this.fontLoaderService.addURL(_local_3);
                _local_2++;
            };
            this.fontLoaderService.loadComplete.addOnce(this.onFontsLoaded);
            this.fontLoaderService.execute();
        }

        private function onFontsLoaded():void
        {
            this.mainModel.fontsLoaded();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.commands
