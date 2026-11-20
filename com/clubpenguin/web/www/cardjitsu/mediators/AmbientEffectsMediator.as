//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.views.effects.ambient.AmbientEffectsView;

    public class AmbientEffectsMediator extends Mediator 
    {

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var view:AmbientEffectsView;


        override public function onRegister():void
        {
            this.view.init();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.mediators
