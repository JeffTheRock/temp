//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.mvcs
{
    import org.robotlegs.core.ISignalContext;
    import org.robotlegs.core.ISignalCommandMap;
    import flash.display.DisplayObjectContainer;
    import org.robotlegs.base.SignalCommandMap;

    public class SignalContext extends Context implements ISignalContext 
    {

        protected var _signalCommandMap:ISignalCommandMap;

        public function SignalContext(_arg_1:DisplayObjectContainer=null, _arg_2:Boolean=true)
        {
            super(_arg_1, _arg_2);
        }

        public function get signalCommandMap():ISignalCommandMap
        {
            return ((this._signalCommandMap) || (this._signalCommandMap = new SignalCommandMap(injector.createChild())));
        }

        public function set signalCommandMap(_arg_1:ISignalCommandMap):void
        {
            this._signalCommandMap = _arg_1;
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(ISignalCommandMap, this.signalCommandMap);
        }


    }
}//package org.robotlegs.mvcs
