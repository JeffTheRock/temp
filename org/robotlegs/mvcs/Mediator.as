//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.mvcs
{
    import org.robotlegs.base.MediatorBase;
    import flash.display.DisplayObjectContainer;
    import org.robotlegs.core.IMediatorMap;
    import flash.events.IEventDispatcher;
    import org.robotlegs.core.IEventMap;
    import org.robotlegs.base.EventMap;
    import flash.events.Event;

    public class Mediator extends MediatorBase 
    {

        [Inject]
        public var contextView:DisplayObjectContainer;
        [Inject]
        public var mediatorMap:IMediatorMap;
        protected var _eventDispatcher:IEventDispatcher;
        protected var _eventMap:IEventMap;


        override public function preRemove():void
        {
            if (this._eventMap)
            {
                this._eventMap.unmapListeners();
            };
            super.preRemove();
        }

        public function get eventDispatcher():IEventDispatcher
        {
            return (this._eventDispatcher);
        }

        [Inject]
        public function set eventDispatcher(_arg_1:IEventDispatcher):void
        {
            this._eventDispatcher = _arg_1;
        }

        protected function get eventMap():IEventMap
        {
            return ((this._eventMap) || (this._eventMap = new EventMap(this.eventDispatcher)));
        }

        protected function dispatch(_arg_1:Event):Boolean
        {
            if (this.eventDispatcher.hasEventListener(_arg_1.type))
            {
                return (this.eventDispatcher.dispatchEvent(_arg_1));
            };
            return (false);
        }

        protected function addViewListener(_arg_1:String, _arg_2:Function, _arg_3:Class=null, _arg_4:Boolean=false, _arg_5:int=0, _arg_6:Boolean=true):void
        {
            this.eventMap.mapListener(IEventDispatcher(viewComponent), _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        protected function addContextListener(_arg_1:String, _arg_2:Function, _arg_3:Class=null, _arg_4:Boolean=false, _arg_5:int=0, _arg_6:Boolean=true):void
        {
            this.eventMap.mapListener(this.eventDispatcher, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }


    }
}//package org.robotlegs.mvcs
