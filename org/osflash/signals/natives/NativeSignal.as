//Created by Action Script Viewer - https://www.buraks.com/asv
package org.osflash.signals.natives
{
    import org.osflash.signals.IDeluxeSignal;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import flash.errors.IllegalOperationError;

    public class NativeSignal implements IDeluxeSignal, INativeDispatcher 
    {

        protected var _eventClass:Class;
        protected var listenerBoxes:Array;
        protected var _target:IEventDispatcher;
        protected var _eventType:String;

        public function NativeSignal(_arg_1:IEventDispatcher, _arg_2:String, _arg_3:Class=null)
        {
            _target = _arg_1;
            _eventType = _arg_2;
            _eventClass = ((_arg_3) || (Event));
            listenerBoxes = [];
        }

        public function dispatch(_arg_1:Event):Boolean
        {
            if (!(_arg_1 is _eventClass))
            {
                throw (new ArgumentError((((("Event object " + _arg_1) + " is not an instance of ") + _eventClass) + ".")));
            };
            if (_arg_1.type != _eventType)
            {
                throw (new ArgumentError((((("Event object has incorrect type. Expected <" + _eventType) + "> but was <") + _arg_1.type) + ">.")));
            };
            return (_target.dispatchEvent(_arg_1));
        }

        public function addOnce(_arg_1:Function, _arg_2:int=0):Function
        {
            registerListener(_arg_1, true, _arg_2);
            return (_arg_1);
        }

        public function remove(_arg_1:Function):Function
        {
            var _local_2:int = indexOfListener(_arg_1);
            if (_local_2 == -1)
            {
                return (_arg_1);
            };
            var _local_3:Object = listenerBoxes.splice(_local_2, 1)[0];
            _target.removeEventListener(_eventType, _local_3.execute);
            return (_arg_1);
        }

        public function get eventClass():Class
        {
            return (_eventClass);
        }

        public function get valueClasses():Array
        {
            return ([_eventClass]);
        }

        public function get target():IEventDispatcher
        {
            return (_target);
        }

        public function add(_arg_1:Function, _arg_2:int=0):Function
        {
            registerListener(_arg_1, false, _arg_2);
            return (_arg_1);
        }

        public function set target(_arg_1:IEventDispatcher):void
        {
            _target = _arg_1;
        }

        protected function indexOfListener(_arg_1:Function):int
        {
            var _local_2:int = listenerBoxes.length;
            while (_local_2--)
            {
                if (listenerBoxes[_local_2].listener == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (-1);
        }

        public function get numListeners():uint
        {
            return (listenerBoxes.length);
        }

        public function get eventType():String
        {
            return (_eventType);
        }

        protected function registerListener(listener:Function, once:Boolean=false, priority:int=0):void
        {
            var prevlistenerBox:Object;
            var signal:NativeSignal;
            if (listener.length != 1)
            {
                throw (new ArgumentError("Listener for native event must declare exactly 1 argument."));
            };
            var prevListenerIndex:int = indexOfListener(listener);
            if (prevListenerIndex >= 0)
            {
                prevlistenerBox = listenerBoxes[prevListenerIndex];
                if (((prevlistenerBox.once) && (!(once))))
                {
                    throw (new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first."));
                };
                if (((!(prevlistenerBox.once)) && (once)))
                {
                    throw (new IllegalOperationError("You cannot add() then addOnce() the same listener without removing the relationship first."));
                };
                return;
            };
            var listenerBox:Object = {
                "listener":listener,
                "once":once,
                "execute":listener
            };
            if (once)
            {
                signal = this;
                listenerBox.execute = function (_arg_1:Event):void
                {
                    signal.remove(listener);
                    listener(_arg_1);
                };
            };
            listenerBoxes[listenerBoxes.length] = listenerBox;
            _target.addEventListener(_eventType, listenerBox.execute, false, priority);
        }

        public function removeAll():void
        {
            var _local_1:int = listenerBoxes.length;
            while (_local_1--)
            {
                remove((listenerBoxes[_local_1].listener as Function));
            };
        }


    }
}//package org.osflash.signals.natives
