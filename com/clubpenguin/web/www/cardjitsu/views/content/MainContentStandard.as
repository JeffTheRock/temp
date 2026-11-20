//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.content
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.models.vo.MainContentDataVO;
    import com.clubpenguin.web.www.cardjitsu.assets.global.MainContentAreaGraphicLarge;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import com.clubpenguin.web.libs.fonts.CandombeRegular;
    import flash.text.TextFieldAutoSize;
    import com.clubpenguin.web.www.cardjitsu.assets.standard.ContentAreaBackingGraphic;
    import com.clubpenguin.web.libs.fonts.BurbankBigRegularBold;
    import flash.utils.getDefinitionByName;
    import com.clubpenguin.web.www.cardjitsu.views.ui.ExternalLinkingButton;

    public class MainContentStandard extends AbstractMainContent 
    {

        private var _contentContainer:Sprite = new Sprite();

        public function MainContentStandard(_arg_1:MainContentDataVO)
        {
            super(_arg_1);
        }

        override public function init():void
        {
            this.initBackgroundGraphic();
            this.initText();
            this.initUI();
        }

        private function initBackgroundGraphic():void
        {
            var _local_1:Sprite = new MainContentAreaGraphicLarge();
            addChild(_local_1);
        }

        private function initText():void
        {
            var _local_1:TextField;
            var _local_6:Sprite;
            var _local_7:Object;
            var _local_8:Sprite;
            var _local_9:TextField;
            _local_1 = new TextField();
            _local_1.defaultTextFormat = new TextFormat(new CandombeRegular().fontName, 40, 0);
            _local_1.embedFonts = true;
            _local_1.text = _dataVO.title;
            _local_1.selectable = false;
            _local_1.autoSize = TextFieldAutoSize.LEFT;
            _local_1.x = (((width * 0.5) - (_local_1.width * 0.5)) - 20);
            _local_1.y = 30;
            addChild(_local_1);
            this._contentContainer.addChild(new ContentAreaBackingGraphic());
            var _local_2:TextField = new TextField();
            _local_2.defaultTextFormat = new TextFormat(new BurbankBigRegularBold().fontName, 20, 0);
            _local_2.embedFonts = true;
            _local_2.text = _dataVO.instructionArray[0].text;
            _local_2.selectable = false;
            _local_2.autoSize = TextFieldAutoSize.LEFT;
            _local_2.x = ((this._contentContainer.width * 0.5) - (_local_2.width * 0.5));
            _local_2.y = 10;
            this._contentContainer.addChild(_local_2);
            var _local_3:int = _dataVO.instructionArray.length;
            var _local_4:Sprite = new Sprite();
            var _local_5:int = 1;
            while (_local_5 < _local_3)
            {
                _local_6 = new Sprite();
                _local_7 = (getDefinitionByName(_dataVO.instructionArray[_local_5].src.split(":").join(".")) as Class);
                _local_8 = new (_local_7)();
                _local_6.addChild(_local_8);
                _local_9 = new TextField();
                _local_9.defaultTextFormat = new TextFormat(new BurbankBigRegularBold().fontName, 15, 0);
                _local_9.embedFonts = true;
                _local_9.text = _dataVO.instructionArray[_local_5].text;
                _local_9.selectable = false;
                _local_9.autoSize = TextFieldAutoSize.LEFT;
                _local_9.wordWrap = true;
                _local_9.width = 210;
                _local_9.x = 5;
                _local_9.y = (_local_6.height + 5);
                _local_6.addChild(_local_9);
                if (_local_5 != 1)
                {
                    _local_6.x = (_local_4.width + 10);
                };
                _local_4.addChild(_local_6);
                _local_5++;
            };
            _local_4.x = ((this._contentContainer.width * 0.5) - (_local_4.width * 0.5));
            _local_4.y = ((_local_2.y + _local_2.height) + 25);
            this._contentContainer.addChild(_local_4);
            this._contentContainer.x = (((width * 0.5) - (this._contentContainer.width * 0.5)) - 20);
            this._contentContainer.y = ((_local_1.y + _local_1.height) + 15);
            addChild(this._contentContainer);
        }

        private function initUI():void
        {
            var _local_1:ExternalLinkingButton = new ExternalLinkingButton(_dataVO.buttonVOArray[0]);
            _local_1.init();
            _local_1.x = ((width * 0.5) - (_local_1.width * 0.5));
            _local_1.y = ((this._contentContainer.y + this._contentContainer.height) - 30);
            addChild(_local_1);
            _local_1.mouseClicked.addOnce(onExternaButtonClicked);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.content
