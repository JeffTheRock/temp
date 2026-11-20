//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.video
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import com.clubpenguin.web.www.cardjitsu.models.vo.VideoVO;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import org.osflash.signals.natives.NativeSignal;
    import flash.events.MouseEvent;
    import flash.display.Shape;

    public class EmbedCode extends Sprite 
    {

        private var _label:TextField;
        private var _vo:VideoVO;

        public function EmbedCode(_arg_1:VideoVO)
        {
            this._vo = _arg_1;
        }

        public function init():void
        {
            this.initLabel();
            this.initEmbedCode();
            this.initBackingGraphic();
        }

        private function initLabel():void
        {
            this._label = new TextField();
            this._label.defaultTextFormat = new TextFormat("CandombeRegular", 26, 0);
            this._label.embedFonts = true;
            this._label.text = this._vo.embedLabel;
            this._label.autoSize = TextFieldAutoSize.LEFT;
            this._label.selectable = false;
            addChild(this._label);
        }

        private function initEmbedCode():void
        {
            var _local_1:TextField = new TextField();
            _local_1.defaultTextFormat = new TextFormat("Arial", 11, "0x333333");
            _local_1.htmlText = this._vo.embedURL;
            _local_1.x = (this._label.width + 5);
            _local_1.y = 4;
            _local_1.background = true;
            _local_1.backgroundColor = 0xFFFFFF;
            _local_1.border = true;
            _local_1.borderColor = 12296058;
            _local_1.width = 160;
            _local_1.height = 16;
            addChild(_local_1);
            var _local_2:NativeSignal = new NativeSignal(_local_1, MouseEvent.CLICK, MouseEvent);
            _local_2.add(this.onMouseClicked);
        }

        private function initBackingGraphic():void
        {
            var _local_1:Number = (width + 20);
            var _local_2:Number = (height + 5);
            var _local_3:Shape = new Shape();
            _local_3.graphics.beginFill(15984066);
            _local_3.graphics.drawRect(-10, -3.5, _local_1, _local_2);
            _local_3.graphics.endFill();
            _local_3.graphics.lineStyle(2, 12296058);
            _local_3.graphics.moveTo(-10, -3.5);
            _local_3.graphics.lineTo(-10, (_local_2 - 3.5));
            _local_3.graphics.lineTo((_local_1 - 10), (_local_2 - 3.5));
            _local_3.graphics.lineTo((_local_1 - 10), -3.5);
            _local_3.graphics.lineTo(-10, -3.5);
            addChildAt(_local_3, 0);
        }

        private function onMouseClicked(_arg_1:MouseEvent):void
        {
            _arg_1.target.setSelection(0, _arg_1.target.length);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.video
