//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.ui
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.NativeSignal;
    import flash.display.MovieClip;
    import com.clubpenguin.web.www.cardjitsu.models.vo.ButtonVO;
    import com.clubpenguin.web.www.cardjitsu.assets.global.PlayNowButtonGraphic;
    import flash.utils.getDefinitionByName;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quart;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;

    public class ExternalLinkingButton extends Sprite 
    {

        public var mouseClicked:Signal = new Signal();
        protected var rollOverSignal:NativeSignal;
        protected var rollOutSignal:NativeSignal;
        protected var mouseClickSignal:NativeSignal;
        protected var _graphic:MovieClip;
        protected var _buttonVO:ButtonVO;

        public function ExternalLinkingButton(_arg_1:ButtonVO)
        {
            this._buttonVO = _arg_1;
        }

        public function init():void
        {
            this.initGraphic();
            this.initLabel();
            this.activate();
        }

        private function initGraphic():void
        {
            this._graphic = new PlayNowButtonGraphic();
            this._graphic.height = this._buttonVO.height;
            this._graphic.active.alpha = 0;
            this._graphic.active.visible = false;
            addChild(this._graphic);
        }

        private function initLabel():void
        {
            var _local_1:Object = (getDefinitionByName(this._buttonVO.fontSrc.split(":").join(".")) as Class);
            var _local_2:TextField = new TextField();
            _local_2.defaultTextFormat = new TextFormat(new (_local_1)().fontName, this._buttonVO.fontSize, 0);
            _local_2.embedFonts = true;
            _local_2.text = String(this._buttonVO.label);
            _local_2.selectable = false;
            _local_2.autoSize = TextFieldAutoSize.LEFT;
            _local_2.x = ((this._graphic.width * 0.5) - (_local_2.width * 0.5));
            _local_2.y = (((this._graphic.height * 0.5) - (_local_2.height * 0.5)) + 2);
            addChild(_local_2);
        }

        private function activate():void
        {
            this.rollOverSignal = new NativeSignal(this, MouseEvent.ROLL_OVER, MouseEvent);
            this.rollOutSignal = new NativeSignal(this, MouseEvent.ROLL_OUT, MouseEvent);
            this.mouseClickSignal = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
            this.rollOverSignal.add(this.onRollOver);
            this.rollOutSignal.add(this.onRollOut);
            this.mouseClickSignal.add(this.onMouseClick);
            buttonMode = true;
            mouseChildren = false;
        }

        private function onRollOver(_arg_1:MouseEvent):void
        {
            TweenMax.to(this._graphic.active, 0.2, {
                "autoAlpha":1,
                "ease":Quart.easeOut
            });
        }

        private function onRollOut(_arg_1:MouseEvent):void
        {
            TweenMax.to(this._graphic.active, 0.2, {
                "autoAlpha":0,
                "ease":Quart.easeOut
            });
        }

        private function onMouseClick(_arg_1:MouseEvent):void
        {
            this.mouseClicked.dispatch(this._buttonVO.id);
            navigateToURL(new URLRequest(this._buttonVO.href), "_self");
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.ui
