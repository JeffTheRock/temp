//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.teaser.views.VideoPlayerView;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel;

    public class VideoPlayerMediator extends Mediator 
    {

        [Inject]
        public var view:VideoPlayerView;
        [Inject]
        public var model:MainModel;


        override public function onRegister():void
        {
            this.view.data = this.model.videoVO;
            this.view.init();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.mediators
