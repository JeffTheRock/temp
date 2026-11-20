//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.views.content
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import com.clubpenguin.web.www.cardjitsu.views.video.VideoPlayerView;
    import com.omniture.ActionSource;
    import com.clubpenguin.web.www.cardjitsu.assets.global.ContentFrameGraphic;
    import com.clubpenguin.web.www.cardjitsu.models.vo.StateVO;
    import com.greensock.TweenMax;
    import com.greensock.easing.Linear;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import com.clubpenguin.web.libs.fonts.CandombeRegular;
    import flash.text.TextFieldAutoSize;

    public class ContentFrameView extends Sprite 
    {

        public static var CURRENT_STATE:String;
        private static const HEADER_GRAPHIC_TRANSITION_TIME:Number = 0.5;
        private static const CALLOUT_PANEL_OPEN_POSITION:int = 730;
        private static const CALLOUT_PANEL_CLOSED_POSITION:int = 495;
        private static const SEPARATOR_RIGHT_POSITION:int = 428;
        private static const SEPARATOR_MIDDLE_POSITION:int = 111;
        private static const SEPARATOR_LEFT_POSITION:int = -450;

        public var mainContentAreaButtonClicked:Signal = new Signal();
        public var transitionOutComplete:Signal = new Signal();
        private var _contentFrameGraphic:MovieClip;
        private var _contentMask:Shape;
        private var _currentHeaderGraphic:Sprite;
        private var _mainContentDataArray:Array;
        private var _currentMainContent:AbstractMainContent;
        private var _videoPlayer:VideoPlayerView;
        private var _actionsource:ActionSource;

        public function ContentFrameView(_arg_1:Array)
        {
            this._mainContentDataArray = _arg_1;
        }

        public function set actionsource(_arg_1:ActionSource):void
        {
            this._actionsource = _arg_1;
        }

        public function init():void
        {
            this.initContentFrameGraphic();
        }

        public function initContentFrameGraphic():void
        {
            this._contentFrameGraphic = new ContentFrameGraphic();
            this._contentFrameGraphic.calloutPanel.visible = false;
            this._contentFrameGraphic.calloutPanel.y = CALLOUT_PANEL_CLOSED_POSITION;
            this._contentFrameGraphic.contentSeparator.x = SEPARATOR_RIGHT_POSITION;
            this._contentFrameGraphic.headerStandard.visible = false;
            this._contentFrameGraphic.headerFire.visible = false;
            this._contentFrameGraphic.headerWater.visible = false;
            this._contentFrameGraphic.headerStandard.alpha = 0;
            this._contentFrameGraphic.headerFire.alpha = 0;
            this._contentFrameGraphic.headerWater.alpha = 0;
            addChild(this._contentFrameGraphic);
            var _local_1:Shape = new Shape();
            _local_1.graphics.beginFill(13153677);
            _local_1.graphics.drawRect(-465, 0, 930, 445);
            _local_1.graphics.endFill();
            _local_1.y = 270;
            addChildAt(_local_1, 0);
        }

        public function transitionInHeaderGraphic():void
        {
            switch (CURRENT_STATE)
            {
                case StateVO.STANDARD:
                    this._currentHeaderGraphic = this._contentFrameGraphic.headerStandard;
                    break;
                case StateVO.FIRE:
                    this._currentHeaderGraphic = this._contentFrameGraphic.headerFire;
                    break;
                case StateVO.WATER:
                    this._currentHeaderGraphic = this._contentFrameGraphic.headerWater;
                    break;
            };
            TweenMax.to(this._currentHeaderGraphic, HEADER_GRAPHIC_TRANSITION_TIME, {
                "autoAlpha":1,
                "ease":Linear.easeOut
            });
        }

        public function transitionOutHeaderGraphic():void
        {
            TweenMax.to(this._currentHeaderGraphic, HEADER_GRAPHIC_TRANSITION_TIME, {
                "autoAlpha":0,
                "ease":Linear.easeNone
            });
        }

        public function initMainContent():void
        {
            var _local_1:Number;
            switch (CURRENT_STATE)
            {
                case StateVO.STANDARD:
                    this._currentMainContent = new MainContentStandard(this._mainContentDataArray[0]);
                    _local_1 = SEPARATOR_LEFT_POSITION;
                    break;
                case StateVO.FIRE:
                    this._currentMainContent = new MainContentFire(this._mainContentDataArray[1]);
                    _local_1 = SEPARATOR_MIDDLE_POSITION;
                    break;
                case StateVO.WATER:
                    this._currentMainContent = new MainContentWater(this._mainContentDataArray[2]);
                    _local_1 = SEPARATOR_MIDDLE_POSITION;
                    break;
            };
            this._currentMainContent.init();
            this._currentMainContent.x = (_local_1 + this._contentFrameGraphic.contentSeparator.width);
            this._currentMainContent.y = 270;
            this._currentMainContent.buttonClicked.addOnce(this.onMainContentAreaButtonClicked);
            addChildAt(this._currentMainContent, 1);
            this._contentMask = new Shape();
            this._contentMask.graphics.beginFill(0xFF0000, 0.5);
            this._contentMask.graphics.drawRect(0, 0, 1, this._currentMainContent.height);
            this._contentMask.graphics.endFill();
            this._contentMask.x = (SEPARATOR_RIGHT_POSITION + this._contentFrameGraphic.contentSeparator.width);
            this._contentMask.y = 280;
            addChildAt(this._contentMask, (getChildIndex(this._currentMainContent) + 1));
            this._currentMainContent.mask = this._contentMask;
        }

        private function onMainContentAreaButtonClicked(_arg_1:String):void
        {
            this.mainContentAreaButtonClicked.dispatch(_arg_1);
        }

        public function transitionInMainContent():void
        {
            switch (CURRENT_STATE)
            {
                case StateVO.STANDARD:
                    TweenMax.to(this._contentMask, 0.8, {
                        "x":(ContentFrameView.SEPARATOR_LEFT_POSITION + this._contentFrameGraphic.contentSeparator.width),
                        "width":this._currentMainContent.width
                    });
                    return;
                case StateVO.FIRE:
                case StateVO.WATER:
                    TweenMax.to(this._contentMask, 0.6, {
                        "x":(ContentFrameView.SEPARATOR_MIDDLE_POSITION + this._contentFrameGraphic.contentSeparator.width),
                        "width":this._currentMainContent.width
                    });
                    return;
            };
        }

        public function transitionOutMainContent():void
        {
            TweenMax.to(this._contentMask, 0.6, {
                "x":(ContentFrameView.SEPARATOR_RIGHT_POSITION + this._contentFrameGraphic.contentSeparator.width),
                "width":0
            });
            TweenMax.delayedCall(1.5, this.transitionOutComplete.dispatch);
        }

        public function destroyMainContent():void
        {
            removeChild(this._currentMainContent);
            this._currentMainContent = null;
            removeChild(this._contentMask);
            this._contentMask = null;
        }

        public function transitionInSeparator():void
        {
            switch (CURRENT_STATE)
            {
                case StateVO.STANDARD:
                    TweenMax.to(this._contentFrameGraphic.contentSeparator, 0.8, {"x":ContentFrameView.SEPARATOR_LEFT_POSITION});
                    return;
                case StateVO.FIRE:
                case StateVO.WATER:
                    TweenMax.to(this._contentFrameGraphic.contentSeparator, 0.6, {"x":ContentFrameView.SEPARATOR_MIDDLE_POSITION});
                    return;
            };
        }

        public function transitionOutSeparator():void
        {
            TweenMax.to(this._contentFrameGraphic.contentSeparator, 0.6, {"x":ContentFrameView.SEPARATOR_RIGHT_POSITION});
        }

        public function initCalloutPanel(_arg_1:Array):void
        {
            var _local_2:Sprite = new Sprite();
            var _local_3:TextField = new TextField();
            _local_3.defaultTextFormat = new TextFormat(new CandombeRegular().fontName, 30, 0);
            _local_3.embedFonts = true;
            _local_3.text = _arg_1[0].title;
            _local_3.autoSize = TextFieldAutoSize.LEFT;
            _local_3.selectable = false;
            _local_2.addChild(_local_3);
            var _local_4:TextField = new TextField();
            _local_4.defaultTextFormat = new TextFormat(new CandombeRegular().fontName, 22, 0);
            _local_4.embedFonts = true;
            _local_4.text = _arg_1[0].body;
            _local_4.autoSize = TextFieldAutoSize.LEFT;
            _local_4.selectable = false;
            _local_4.x = -20;
            _local_4.wordWrap = true;
            _local_4.width = 165;
            _local_4.y = (_local_3.y + _local_3.height);
            _local_2.addChild(_local_4);
            _local_2.x = -200;
            _local_2.y = 108;
            var _local_5:Sprite = new Sprite();
            var _local_6:TextField = new TextField();
            _local_6.defaultTextFormat = new TextFormat(new CandombeRegular().fontName, 30, 0);
            _local_6.embedFonts = true;
            _local_6.text = _arg_1[1].title;
            _local_6.autoSize = TextFieldAutoSize.LEFT;
            _local_6.selectable = false;
            _local_5.addChild(_local_6);
            var _local_7:TextField = new TextField();
            _local_7.defaultTextFormat = new TextFormat(new CandombeRegular().fontName, 22, 0);
            _local_7.embedFonts = true;
            _local_7.text = _arg_1[1].body;
            _local_7.autoSize = TextFieldAutoSize.LEFT;
            _local_7.selectable = false;
            _local_7.x = -20;
            _local_7.wordWrap = true;
            _local_7.width = 165;
            _local_7.y = (_local_6.y + _local_6.height);
            _local_5.addChild(_local_7);
            _local_5.x = 215;
            _local_5.y = 108;
            this._contentFrameGraphic.calloutPanel.addChild(_local_2);
            this._contentFrameGraphic.calloutPanel.addChild(_local_5);
            var _local_8:Shape = new Shape();
            _local_8.graphics.beginFill(267386880);
            _local_8.graphics.drawRect((-(this._contentFrameGraphic.calloutPanel.width) * 0.5), 0, this._contentFrameGraphic.calloutPanel.width, this._contentFrameGraphic.calloutPanel.height);
            _local_8.graphics.endFill();
            _local_8.y = CALLOUT_PANEL_OPEN_POSITION;
            this._contentFrameGraphic.addChild(_local_8);
            this._contentFrameGraphic.calloutPanel.mask = _local_8;
            this._contentFrameGraphic.calloutPanel.cacheAsBitmap = true;
        }

        public function transitionInCalloutContent():void
        {
            switch (CURRENT_STATE)
            {
                case StateVO.FIRE:
                case StateVO.WATER:
                    this._contentFrameGraphic.calloutPanel.visible = true;
                    TweenMax.to(this._contentFrameGraphic.calloutPanel, 0.5, {
                        "y":ContentFrameView.CALLOUT_PANEL_OPEN_POSITION,
                        "ease":Linear.easeOut
                    });
                    return;
            };
        }

        public function transitionOutCalloutContent():void
        {
            switch (CURRENT_STATE)
            {
                case StateVO.STANDARD:
                    TweenMax.to(this._contentFrameGraphic.calloutPanel, 0.5, {
                        "y":ContentFrameView.CALLOUT_PANEL_CLOSED_POSITION,
                        "ease":Linear.easeOut
                    });
                    TweenMax.to(this._contentFrameGraphic.calloutPanel, 0, {
                        "delay":0.5,
                        "visible":false
                    });
                    return;
            };
        }

        public function initVideoPlayer():void
        {
            switch (CURRENT_STATE)
            {
                case StateVO.FIRE:
                    this._videoPlayer = new VideoPlayerView(this._mainContentDataArray[1].videoVO, this._actionsource);
                    this._videoPlayer.init();
                    this._videoPlayer.x = -448;
                    this._videoPlayer.y = 284;
                    this._videoPlayer.alpha = 0;
                    this._videoPlayer.visible = false;
                    addChild(this._videoPlayer);
                    return;
                case StateVO.WATER:
                    this._videoPlayer = new VideoPlayerView(this._mainContentDataArray[2].videoVO, this._actionsource);
                    this._videoPlayer.init();
                    this._videoPlayer.x = -448;
                    this._videoPlayer.y = 284;
                    this._videoPlayer.alpha = 0;
                    this._videoPlayer.visible = false;
                    addChild(this._videoPlayer);
                    return;
            };
        }

        public function transitionInVideoPlayer():void
        {
            switch (CURRENT_STATE)
            {
                case StateVO.FIRE:
                case StateVO.WATER:
                    TweenMax.to(this._videoPlayer, 0.4, {
                        "autoAlpha":1,
                        "ease":Linear.easeOut,
                        "onComplete":this._videoPlayer.play
                    });
                    return;
            };
        }

        public function transitionOutVideoPlayer():void
        {
            if (this._videoPlayer)
            {
                this._videoPlayer.destroy();
                TweenMax.to(this._videoPlayer, 0.4, {
                    "autoAlpha":0,
                    "ease":Linear.easeOut
                });
            };
        }

        public function destroyVideoPlayer():void
        {
            if (this._videoPlayer)
            {
                removeChild(this._videoPlayer);
                this._videoPlayer = null;
            };
        }

        public function set currentState(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case StateVO.STANDARD:
                case StateVO.FIRE:
                case StateVO.WATER:
                    CURRENT_STATE = _arg_1;
                    return;
            };
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.views.content
