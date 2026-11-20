//Created by Action Script Viewer - https://www.buraks.com/asv
package 
{
    import flash.display.Sprite;
    import com.clubpenguin.web.www.cardjitsu.teaser.context.MainContext;
    import org.osflash.signals.natives.NativeSignal;
    import flash.events.Event;
    import flash.display.LoaderInfo;
    import flash.system.Security;

    public class Main extends Sprite 
    {

        private var _mainContext:MainContext;
        private var addedToStageSignal:NativeSignal;

        public function Main()
        {
            this.addedToStageSignal = new NativeSignal(this, Event.ADDED_TO_STAGE, Event);
            this.addedToStageSignal.addOnce(this.onAddedToStage);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            this.initSecurityPermissions();
            this.initMainContext();
        }

        private function initSecurityPermissions():void
        {
            var _local_1:String = LoaderInfo(this.root.loaderInfo).parameters.domain;
            Security.allowDomain(_local_1);
        }

        private function initMainContext():void
        {
            this._mainContext = new MainContext(this);
        }


    }
}//package 
    //force all classes
    import Main; Main;
    import org.osflash.signals.IDeluxeSignal; org.osflash.signals.IDeluxeSignal;
    import org.osflash.signals.natives.INativeDispatcher; org.osflash.signals.natives.INativeDispatcher;
    import org.osflash.signals.natives.NativeSignal; org.osflash.signals.natives.NativeSignal;
    import org.robotlegs.core.IContext; org.robotlegs.core.IContext;
    import org.robotlegs.base.ContextBase; org.robotlegs.base.ContextBase;
    import org.robotlegs.mvcs.Context; org.robotlegs.mvcs.Context;
    import org.robotlegs.core.ISignalContext; org.robotlegs.core.ISignalContext;
    import org.robotlegs.mvcs.SignalContext; org.robotlegs.mvcs.SignalContext;
    import com.clubpenguin.web.www.cardjitsu.teaser.context.MainContext; com.clubpenguin.web.www.cardjitsu.teaser.context.MainContext;
    import org.robotlegs.core.IEventMap; org.robotlegs.core.IEventMap;
    import org.robotlegs.core.IReflector; org.robotlegs.core.IReflector;
    import org.robotlegs.base.EventMap; org.robotlegs.base.EventMap;
    import org.robotlegs.core.IInjector; org.robotlegs.core.IInjector;
    import org.robotlegs.core.IMediatorMap; org.robotlegs.core.IMediatorMap;
    import org.robotlegs.base.ViewMapBase; org.robotlegs.base.ViewMapBase;
    import org.robotlegs.base.MediatorMap; org.robotlegs.base.MediatorMap;
    import org.swiftsuspenders.Injector; org.swiftsuspenders.Injector;
    import org.robotlegs.adapters.SwiftSuspendersInjector; org.robotlegs.adapters.SwiftSuspendersInjector;
    import org.robotlegs.core.IViewMap; org.robotlegs.core.IViewMap;
    import org.robotlegs.core.ICommandMap; org.robotlegs.core.ICommandMap;
    import org.robotlegs.base.CommandMap; org.robotlegs.base.CommandMap;
    import org.swiftsuspenders.Reflector; org.swiftsuspenders.Reflector;
    import org.robotlegs.adapters.SwiftSuspendersReflector; org.robotlegs.adapters.SwiftSuspendersReflector;
    import org.robotlegs.base.ViewMap; org.robotlegs.base.ViewMap;
    import org.robotlegs.base.ContextEvent; org.robotlegs.base.ContextEvent;
    import org.robotlegs.core.ISignalCommandMap; org.robotlegs.core.ISignalCommandMap;
    import org.robotlegs.base.SignalCommandMap; org.robotlegs.base.SignalCommandMap;
    import org.osflash.signals.IDispatcher; org.osflash.signals.IDispatcher;
    import org.osflash.signals.ISignal; org.osflash.signals.ISignal;
    import org.osflash.signals.Signal; org.osflash.signals.Signal;
    import com.clubpenguin.web.www.cardjitsu.teaser.signals.InitTrackingServiceSignal; com.clubpenguin.web.www.cardjitsu.teaser.signals.InitTrackingServiceSignal;
    import org.robotlegs.mvcs.Command; org.robotlegs.mvcs.Command;
    import org.robotlegs.mvcs.SignalCommand; org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.commands.InitFontsCommand; com.clubpenguin.web.www.cardjitsu.teaser.commands.InitFontsCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.commands.InitTrackingServiceCommand; com.clubpenguin.web.www.cardjitsu.teaser.commands.InitTrackingServiceCommand;
    import com.clubpenguin.web.www.cardjitsu.teaser.views.VideoPlayerView; com.clubpenguin.web.www.cardjitsu.teaser.views.VideoPlayerView;
    import org.robotlegs.mvcs.Actor; org.robotlegs.mvcs.Actor;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.DataLoaderService; com.clubpenguin.web.www.cardjitsu.teaser.services.DataLoaderService;
    import com.clubpenguin.web.www.cardjitsu.teaser.commands.InitConfigCommand; com.clubpenguin.web.www.cardjitsu.teaser.commands.InitConfigCommand;
    import org.robotlegs.core.IMediator; org.robotlegs.core.IMediator;
    import org.robotlegs.base.MediatorBase; org.robotlegs.base.MediatorBase;
    import org.robotlegs.mvcs.Mediator; org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.web.www.cardjitsu.teaser.mediators.VideoPlayerMediator; com.clubpenguin.web.www.cardjitsu.teaser.mediators.VideoPlayerMediator;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.FontLoaderService; com.clubpenguin.web.www.cardjitsu.teaser.services.FontLoaderService;
    import com.clubpenguin.web.www.cardjitsu.teaser.signals.InitFontsSignal; com.clubpenguin.web.www.cardjitsu.teaser.signals.InitFontsSignal;
    import com.clubpenguin.web.www.cardjitsu.teaser.mediators.MainMediator; com.clubpenguin.web.www.cardjitsu.teaser.mediators.MainMediator;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel; com.clubpenguin.web.www.cardjitsu.teaser.models.MainModel;
    import com.clubpenguin.web.www.cardjitsu.teaser.services.TrackingService; com.clubpenguin.web.www.cardjitsu.teaser.services.TrackingService;
    import org.robotlegs.base.ContextError; org.robotlegs.base.ContextError;
    import org.swiftsuspenders.injectionresults.InjectionResult; org.swiftsuspenders.injectionresults.InjectionResult;
    import org.swiftsuspenders.injectionresults.InjectSingletonResult; org.swiftsuspenders.injectionresults.InjectSingletonResult;
    import org.swiftsuspenders.injectionpoints.InjectionPoint; org.swiftsuspenders.injectionpoints.InjectionPoint;
    import org.swiftsuspenders.injectionpoints.MethodInjectionPoint; org.swiftsuspenders.injectionpoints.MethodInjectionPoint;
    import org.swiftsuspenders.injectionpoints.ConstructorInjectionPoint; org.swiftsuspenders.injectionpoints.ConstructorInjectionPoint;
    import org.swiftsuspenders.injectionpoints.NoParamsConstructorInjectionPoint; org.swiftsuspenders.injectionpoints.NoParamsConstructorInjectionPoint;
    import org.swiftsuspenders.InjectorError; org.swiftsuspenders.InjectorError;
// //     import org.swiftsuspenders.getConstructor; org.swiftsuspenders.getConstructor;
    import org.swiftsuspenders.injectionresults.InjectValueResult; org.swiftsuspenders.injectionresults.InjectValueResult;
    import org.swiftsuspenders.injectionresults.InjectOtherRuleResult; org.swiftsuspenders.injectionresults.InjectOtherRuleResult;
    import org.swiftsuspenders.InjectionConfig; org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.injectionresults.InjectClassResult; org.swiftsuspenders.injectionresults.InjectClassResult;
    import org.swiftsuspenders.injectionpoints.PropertyInjectionPoint; org.swiftsuspenders.injectionpoints.PropertyInjectionPoint;
    import org.swiftsuspenders.injectionpoints.PostConstructInjectionPoint; org.swiftsuspenders.injectionpoints.PostConstructInjectionPoint;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.ProgressBar; com.clubpenguin.web.www.cardjitsu.teaser.assets.ProgressBar;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.VideoPlayerFrame; com.clubpenguin.web.www.cardjitsu.teaser.assets.VideoPlayerFrame;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.PlayButton; com.clubpenguin.web.www.cardjitsu.teaser.assets.PlayButton;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.VideoVO; com.clubpenguin.web.www.cardjitsu.teaser.models.vo.VideoVO;
    import com.clubpenguin.web.www.cardjitsu.teaser.media.video.VideoStream; com.clubpenguin.web.www.cardjitsu.teaser.media.video.VideoStream;
    import com.clubpenguin.web.www.cardjitsu.teaser.assets.MuteButton; com.clubpenguin.web.www.cardjitsu.teaser.assets.MuteButton;
    import com.clubpenguin.web.libs.utils.SimpleParserXML; com.clubpenguin.web.libs.utils.SimpleParserXML;
    import com.clubpenguin.web.libs.utils.Environment; com.clubpenguin.web.libs.utils.Environment;
    import com.clubpenguin.web.www.cardjitsu.teaser.views.EmbedCode; com.clubpenguin.web.www.cardjitsu.teaser.views.EmbedCode;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.FontVO; com.clubpenguin.web.www.cardjitsu.teaser.models.vo.FontVO;
    import com.clubpenguin.web.www.cardjitsu.teaser.models.vo.EmbedVO; com.clubpenguin.web.www.cardjitsu.teaser.models.vo.EmbedVO;
