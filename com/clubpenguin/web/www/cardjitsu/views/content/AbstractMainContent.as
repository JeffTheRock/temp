//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.content
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import com.clubpenguin.web.www.cardjitsu.models.vo.MainContentDataVO;

    public class AbstractMainContent extends Sprite 
    {

        public var buttonClicked:Signal = new Signal(String);
        protected var _dataVO:MainContentDataVO;

        public function AbstractMainContent(_arg_1:MainContentDataVO)
        {
            this._dataVO = _arg_1;
        }

        public function init():void
        {
        }

        protected function onExternaButtonClicked(_arg_1:String):void
        {
            this.buttonClicked.dispatch(_arg_1);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.content
