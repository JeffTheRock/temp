//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import flash.display.DisplayObjectContainer;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.teaser.views.VideoPlayerView;
    import com.clubpenguin.web.www.cardjitsu.teaser.views.EmbedCode;

    public class MainMediator extends Mediator 
    {

        [Inject]
        public var view:DisplayObjectContainer;
        [Inject]
        public var mainModel:MainModel;


        override public function onRegister():void
        {
            this.mainModel.initialLoadComplete.addOnce(this.init);
        }

        public function init():void
        {
            this.initVideoPlayer();
            this.initEmbedCode();
        }

        private function initVideoPlayer():void
        {
            var _local_1:VideoPlayerView = new VideoPlayerView();
            this.view.addChild(_local_1);
        }

        private function initEmbedCode():void
        {
            var _local_1:EmbedCode = new EmbedCode(this.mainModel.embedVO);
            _local_1.init();
            _local_1.x = ((this.view.stage.stageWidth - _local_1.width) - 20);
            _local_1.y = 378;
            this.view.addChild(_local_1);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.mediators
