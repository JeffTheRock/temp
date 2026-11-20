//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.teaser.views
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.EmbedVO;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import org.osflash.signals.natives.NativeSignal;
    import flash.events.MouseEvent;

    public class EmbedCode extends Sprite 
    {

        private var _label:TextField;
        private var _vo:EmbedVO;

        public function EmbedCode(_arg_1:EmbedVO)
        {
            this._vo = _arg_1;
        }

        public function init():void
        {
            this.initLabel();
            this.initEmbedCode();
        }

        private function initLabel():void
        {
            this._label = new TextField();
            this._label.defaultTextFormat = new TextFormat("CandombeRegular", 26, "0xF8EFC4");
            this._label.embedFonts = true;
            this._label.text = this._vo.label;
            this._label.autoSize = TextFieldAutoSize.LEFT;
            this._label.selectable = false;
            addChild(this._label);
        }

        private function initEmbedCode():void
        {
            var _local_1:TextField = new TextField();
            _local_1.defaultTextFormat = new TextFormat("Arial", 10, "0x990000");
            _local_1.htmlText = this._vo.embedCode;
            _local_1.x = (this._label.width + 5);
            _local_1.y = 5;
            _local_1.background = true;
            _local_1.backgroundColor = 16314308;
            _local_1.width = 150;
            _local_1.height = 16;
            addChild(_local_1);
            var _local_2:NativeSignal = new NativeSignal(_local_1, MouseEvent.CLICK, MouseEvent);
            _local_2.add(this.onMouseClicked);
        }

        private function onMouseClicked(_arg_1:MouseEvent):void
        {
            _arg_1.target.setSelection(0, _arg_1.target.length);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.teaser.views
