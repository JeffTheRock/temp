//Created by Action Script Viewer - https://www.buraks.com/asv
package 
{
    import flash.display.Sprite;
    import org.osflash.signals.natives.NativeSignal;
    import flash.display.Loader;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    import flash.display.LoaderInfo;
    import flash.system.Security;
    import flash.geom.Rectangle;
    import com.clubpenguin.web.www.cardjitsu.assets.preloader.BackgroundGraphicPreloader;
    import com.clubpenguin.web.www.cardjitsu.assets.preloader.ProgressBarGraphic;
    import flash.display.Shape;
    import flash.events.Event;
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import flash.events.ProgressEvent;
    import com.clubpenguin.web.libs.utils.Environment;
    import flash.net.URLRequest;
    import flash.external.ExternalInterface;

    public class Preloader extends Sprite 
    {

        private static const MAIN_WIDTH:int = 1600;
        private static const MAIN_HEIGHT:int = 1050;

        private var browserResize:NativeSignal;
        private var _loader:Loader;
        private var _progressBarGraphicContainer:Sprite;
        private var _backgroundGraphic:Sprite;

        public function Preloader()
        {
            this.init();
        }

        private function init():void
        {
            this.initStageProperties();
            this.initSecurityPermissions();
            this.initSizePlaceHolder();
            this.initGraphics();
            this.initBrowserResize();
            this.transitionIn();
            this.onBrowserResize(null);
        }

        private function initStageProperties():void
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }

        private function initSecurityPermissions():void
        {
            var _local_1:String = LoaderInfo(this.root.loaderInfo).parameters.domain;
            Security.allowDomain(_local_1);
        }

        private function initSizePlaceHolder():void
        {
            graphics.beginFill(0xFF0000, 0);
            graphics.drawRect(0, 0, 1600, 1050);
            graphics.endFill();
            //this.scrollRect = new Rectangle(0, 0, 1600, 1050);
            this._backgroundGraphic = new BackgroundGraphicPreloader();
            this._backgroundGraphic.x = (width * 0.5);
            this._backgroundGraphic.cacheAsBitmap = true;
            this._backgroundGraphic.alpha = 0;
            addChild(this._backgroundGraphic);
        }

        private function initGraphics():void
        {
            this._progressBarGraphicContainer = new Sprite();
            var _local_1:Sprite = new ProgressBarGraphic();
            _local_1.alpha = 0.4;
            this._progressBarGraphicContainer.addChild(_local_1);
            var _local_2:Sprite = new ProgressBarGraphic();
            _local_2.alpha = 0.8;
            this._progressBarGraphicContainer.addChild(_local_2);
            var _local_3:Shape = new Shape();
            _local_3.graphics.beginFill(0xFF0000);
            _local_3.graphics.drawRect(0, -(_local_2.height), _local_2.width, _local_2.height);
            _local_3.graphics.endFill();
            _local_3.name = "progressMask";
            _local_3.y = _local_2.height;
            _local_3.scaleY = 0;
            this._progressBarGraphicContainer.addChild(_local_3);
            _local_2.mask = _local_3;
            this._progressBarGraphicContainer.x = ((width * 0.5) - (this._progressBarGraphicContainer.width * 0.5));
            this._progressBarGraphicContainer.y = ((1000 * 0.5) - (this._progressBarGraphicContainer.height * 0.5));
            addChild(this._progressBarGraphicContainer);
            this._progressBarGraphicContainer.alpha = 0;
        }

        private function initBrowserResize():void
        {
            this.browserResize = new NativeSignal(stage, Event.RESIZE, Event);
            this.browserResize.add(this.onBrowserResize);
            this.onBrowserResize(null);
        }

        private function transitionIn():void
        {
            TweenLite.to(this._backgroundGraphic, 0.5, {
                "alpha":1,
                "ease":Linear.easeOut
            });
            TweenLite.to(this._progressBarGraphicContainer, 0.5, {
                "alpha":1,
                "ease":Linear.easeOut
            });
            TweenLite.delayedCall(0.5, this.initLoad);
        }

        private function initLoad():void
        {
            var _local_3:String;
            this._loader = new Loader();
            var _local_1:NativeSignal = new NativeSignal(this._loader.contentLoaderInfo, ProgressEvent.PROGRESS, ProgressEvent);
            var _local_2:NativeSignal = new NativeSignal(this._loader.contentLoaderInfo, Event.COMPLETE, Event);
            _local_1.add(this.onLoadProgress);
            _local_2.add(this.onLoadComplete);
            if (Environment.IS_IN_BROWSER)
            {
                _local_3 = LoaderInfo(this.root.loaderInfo).parameters.swfurl;
            }
            else
            {
                _local_3 = "CardJitsuMiniSite.swf";
            };
            this._loader.load(new URLRequest(_local_3));
        }

        private function onLoadProgress(_arg_1:ProgressEvent):void
        {
            var _local_2:Number = (_arg_1.target.bytesLoaded / _arg_1.target.bytesTotal);
            this._progressBarGraphicContainer.getChildByName("progressMask").scaleY = _local_2;
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            var _local_2:Sprite = _arg_1.target.content;
            addChildAt(_local_2, 0);
            this.destroy();
        }

        private function destroy():void
        {
            removeChild(this._progressBarGraphicContainer);
            this._progressBarGraphicContainer = null;
            removeChild(this._backgroundGraphic);
            this._backgroundGraphic = null;
        }

        private function onBrowserResize(_arg_1:Event):void
        {
            var s:Number = Math.min(stage.stageWidth / MAIN_WIDTH, stage.stageHeight / MAIN_HEIGHT);
			scaleX = scaleY = s;
			x = Math.round((stage.stageWidth - MAIN_WIDTH * s) / 2);
			y = 0;
        }


    }
}//package 
    //force all classes
    import Preloader; Preloader;
    import com.greensock.easing.Linear; com.greensock.easing.Linear;
    import com.greensock.core.TweenCore; com.greensock.core.TweenCore;
    import com.greensock.TweenLite; com.greensock.TweenLite;
    import org.osflash.signals.IDeluxeSignal; org.osflash.signals.IDeluxeSignal;
    import org.osflash.signals.natives.INativeDispatcher; org.osflash.signals.natives.INativeDispatcher;
    import org.osflash.signals.natives.NativeSignal; org.osflash.signals.natives.NativeSignal;
    import com.clubpenguin.web.www.cardjitsu.assets.preloader.BackgroundGraphicPreloader; com.clubpenguin.web.www.cardjitsu.assets.preloader.BackgroundGraphicPreloader;
    import com.clubpenguin.web.www.cardjitsu.assets.preloader.ProgressBarGraphic; com.clubpenguin.web.www.cardjitsu.assets.preloader.ProgressBarGraphic;
    import com.clubpenguin.web.libs.utils.Environment; com.clubpenguin.web.libs.utils.Environment;
    import com.greensock.core.SimpleTimeline; com.greensock.core.SimpleTimeline;
    import com.greensock.core.PropTween; com.greensock.core.PropTween;
