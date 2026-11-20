//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.effects.ambient
{
    import flash.display.Sprite;
    import flash.display.Shape;
    import com.greensock.TweenMax;
    import com.greensock.easing.Sine;

    public class AmbientEffectsView extends Sprite 
    {

        private static const COUNT_LIMIT:int = 20;
        private static const EFFECT_WIDTH:int = 300;


        public function init():void
        {
            var _local_1:int;
            while (_local_1 < COUNT_LIMIT)
            {
                this.generateParticle();
                _local_1++;
            };
        }

        private function generateParticle():void
        {
            var _local_1:Shape;
            var _local_3:int;
            var _local_4:int;
            _local_1 = new Shape();
            _local_1.graphics.beginFill(0xFFFFFF, 0.4);
            _local_1.graphics.drawEllipse(0, 0, ((Math.random() * 3) + 2), ((Math.random() * 3) + 2));
            _local_1.graphics.endFill();
            _local_1.x = (Math.random() * EFFECT_WIDTH);
            _local_1.alpha = 0;
            addChild(_local_1);
            var _local_2:int = int((Math.random() * 25));
            if (Math.random() > 0.5)
            {
                _local_3 = 100;
                _local_4 = 620;
            }
            else
            {
                _local_3 = 620;
                _local_4 = 100;
            };
            _local_1.y = _local_3;
            TweenMax.to(_local_1, 25, {
                "delay":_local_2,
                "y":_local_4,
                "x":(_local_1.x - ((Math.random() * 200) - 100)),
                "ease":Sine.easeInOut
            });
            TweenMax.to(_local_1, 10, {
                "delay":_local_2,
                "alpha":1,
                "ease":Sine.easeInOut
            });
            TweenMax.to(_local_1, 10, {
                "delay":((_local_2 + (Math.random() * 7)) + 8),
                "alpha":0,
                "x":(_local_1.x + ((Math.random() * 200) - 100)),
                "ease":Sine.easeInOut,
                "onComplete":this.destroyEffectElement,
                "onCompleteParams":[_local_1]
            });
        }

        private function destroyEffectElement(_arg_1:Shape):void
        {
            removeChild(_arg_1);
            _arg_1 = null;
            this.generateParticle();
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.effects.ambient
