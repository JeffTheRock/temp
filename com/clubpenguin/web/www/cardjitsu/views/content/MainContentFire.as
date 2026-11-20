//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.content
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.models.vo.MainContentDataVO;
    import com.clubpenguin.web.www.cardjitsu.assets.global.MainContentAreaGraphicSmall;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import com.clubpenguin.web.libs.fonts.CandombeRegular;
    import flash.text.TextFieldAutoSize;
    import com.clubpenguin.web.libs.fonts.BurbankBigRegularBold;
    import com.clubpenguin.web.www.cardjitsu.views.ui.ExternalLinkingButton;
    import com.clubpenguin.web.www.cardjitsu.assets.global.MembershipBadge;
    import flash.display.MovieClip;

    public class MainContentFire extends AbstractMainContent 
    {

        private var _contentContainer:Sprite;

        public function MainContentFire(_arg_1:MainContentDataVO)
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
            var _local_1:Sprite = new MainContentAreaGraphicSmall();
            addChild(_local_1);
        }

        private function initText():void
        {
            var _local_4:TextField;
            this._contentContainer = new Sprite();
            var _local_1:TextField = new TextField();
            _local_1.defaultTextFormat = new TextFormat(new CandombeRegular().fontName, 40, 0);
            _local_1.embedFonts = true;
            _local_1.text = _dataVO.title;
            _local_1.selectable = false;
            _local_1.autoSize = TextFieldAutoSize.LEFT;
            _local_1.wordWrap = true;
            _local_1.width = 220;
            this._contentContainer.addChild(_local_1);
            var _local_2:int = _dataVO.instructionArray.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = new TextField();
                _local_4.defaultTextFormat = new TextFormat(new BurbankBigRegularBold().fontName, 15, 0);
                _local_4.embedFonts = true;
                _local_4.text = _dataVO.instructionArray[_local_3].text;
                _local_4.selectable = false;
                _local_4.autoSize = TextFieldAutoSize.LEFT;
                _local_4.wordWrap = true;
                _local_4.width = 220;
                _local_4.y = (this._contentContainer.height + 10);
                this._contentContainer.addChild(_local_4);
                _local_3++;
            };
            this._contentContainer.x = (((width * 0.5) - (this._contentContainer.width * 0.5)) - 10);
            this._contentContainer.y = 35;
            addChild(this._contentContainer);
        }

        private function initUI():void
        {
            var _local_1:ExternalLinkingButton = new ExternalLinkingButton(_dataVO.buttonVOArray[0]);
            _local_1.init();
            Sprite(_local_1).x = ((width * 0.5) - (Sprite(_local_1).width * 0.5));
            Sprite(_local_1).y = ((this._contentContainer.y + this._contentContainer.height) + 20);
            addChild(_local_1);
            _local_1.mouseClicked.addOnce(onExternaButtonClicked);
            var _local_2:ExternalLinkingButton = new ExternalLinkingButton(_dataVO.buttonVOArray[1]);
            _local_2.init();
            Sprite(_local_2).x = ((width * 0.5) - (Sprite(_local_2).width * 0.5));
            Sprite(_local_2).y = ((Sprite(_local_1).y + Sprite(_local_1).height) + 15);
            _local_2.mouseClicked.addOnce(onExternaButtonClicked);
            var _local_3:MovieClip = new MembershipBadge();
            _local_3.y = ((Sprite(_local_2).height * 0.5) + 3);
            _local_3.gotoAndStop(_dataVO.buttonVOArray[1].language);
            Sprite(_local_2).addChild(_local_3);
            addChild(_local_2);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.content
