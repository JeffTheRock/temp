//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.base
{
    import org.robotlegs.core.ISignalCommandMap;
    import org.robotlegs.core.IInjector;
    import flash.utils.Dictionary;
    import org.osflash.signals.ISignal;
    import flash.utils.describeType;
    import org.osflash.signals.*;

    public class SignalCommandMap implements ISignalCommandMap 
    {

        protected var injector:IInjector;
        protected var signalMap:Dictionary;
        protected var signalClassMap:Dictionary;
        protected var verifiedCommandClasses:Dictionary;

        public function SignalCommandMap(_arg_1:IInjector)
        {
            this.injector = _arg_1;
            this.signalMap = new Dictionary(false);
            this.signalClassMap = new Dictionary(false);
            this.verifiedCommandClasses = new Dictionary(false);
        }

        public function mapSignal(signal:ISignal, commandClass:Class, oneShot:Boolean=false):void
        {
            this.verifyCommandClass(commandClass);
            if (this.hasSignalCommand(signal, commandClass))
            {
                return;
            };
            var signalCommandMap:Dictionary = (this.signalMap[signal] = ((this.signalMap[signal]) || (new Dictionary(false))));
            var callback:Function = function (_arg_1:*=null, _arg_2:*=null, _arg_3:*=null, _arg_4:*=null, _arg_5:*=null, _arg_6:*=null, _arg_7:*=null):void
            {
                routeSignalToCommand(signal, arguments, commandClass, oneShot);
            };
            signalCommandMap[commandClass] = callback;
            signal.add(callback);
        }

        public function mapSignalClass(_arg_1:Class, _arg_2:Class, _arg_3:Boolean=false):ISignal
        {
            var _local_4:ISignal = this.getSignalClassInstance(_arg_1);
            this.mapSignal(_local_4, _arg_2, _arg_3);
            return (_local_4);
        }

        private function getSignalClassInstance(_arg_1:Class):ISignal
        {
            return ((ISignal(this.signalClassMap[_arg_1])) || (this.createSignalClassInstance(_arg_1)));
        }

        private function createSignalClassInstance(_arg_1:Class):ISignal
        {
            var _local_3:ISignal;
            var _local_2:IInjector = this.injector;
            if (this.injector.hasMapping(IInjector))
            {
                _local_2 = this.injector.getInstance(IInjector);
            };
            _local_3 = _local_2.instantiate(_arg_1);
            _local_2.mapValue(_arg_1, _local_3);
            this.signalClassMap[_arg_1] = _local_3;
            return (_local_3);
        }

        public function hasSignalCommand(_arg_1:ISignal, _arg_2:Class):Boolean
        {
            var _local_3:Dictionary = this.signalMap[_arg_1];
            if (_local_3 == null)
            {
                return (false);
            };
            var _local_4:Function = _local_3[_arg_2];
            return (!(_local_4 == null));
        }

        public function unmapSignal(_arg_1:ISignal, _arg_2:Class):void
        {
            var _local_3:Dictionary = this.signalMap[_arg_1];
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:Function = _local_3[_arg_2];
            if (_local_4 == null)
            {
                return;
            };
            _arg_1.remove(_local_4);
            delete _local_3[_arg_2];
        }

        public function unmapSignalClass(_arg_1:Class, _arg_2:Class):void
        {
            this.unmapSignal(this.getSignalClassInstance(_arg_1), _arg_2);
        }

        protected function routeSignalToCommand(_arg_1:ISignal, _arg_2:Array, _arg_3:Class, _arg_4:Boolean):void
        {
            this.createCommandInstance(_arg_1.valueClasses, _arg_2, _arg_3).execute();
            if (_arg_4)
            {
                this.unmapSignal(_arg_1, _arg_3);
            };
        }

        protected function createCommandInstance(_arg_1:Array, _arg_2:Array, _arg_3:Class):Object
        {
            var _local_4:uint;
            while (_local_4 < _arg_1.length)
            {
                this.injector.mapValue(_arg_1[_local_4], _arg_2[_local_4]);
                _local_4++;
            };
            return (this.injector.instantiate(_arg_3));
        }

        protected function verifyCommandClass(commandClass:Class):void
        {
            if (this.verifiedCommandClasses[commandClass])
            {
                return;
            };
            if (describeType(commandClass).factory.method.(@name == "execute").length() != 1)
            {
                throw (new ContextError(((ContextError.E_COMMANDMAP_NOIMPL + " - ") + commandClass)));
            };
            this.verifiedCommandClasses[commandClass] = true;
        }


    }
}//package org.robotlegs.base
