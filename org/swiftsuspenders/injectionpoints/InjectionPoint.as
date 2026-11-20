//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;

    public class InjectionPoint 
    {

        public function InjectionPoint(_arg_1:XML, _arg_2:Injector)
        {
            this.initializeInjection(_arg_1, _arg_2);
        }

        public function applyInjection(_arg_1:Object, _arg_2:Injector):Object
        {
            return (_arg_1);
        }

        protected function initializeInjection(_arg_1:XML, _arg_2:Injector):void
        {
        }


    }
}//package org.swiftsuspenders.injectionpoints
