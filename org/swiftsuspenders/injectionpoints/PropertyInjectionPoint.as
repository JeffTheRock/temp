//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.Injector;
    import org.swiftsuspenders.InjectorError;

    public class PropertyInjectionPoint extends InjectionPoint 
    {

        private var propertyName:String;
        private var propertyType:String;
        private var m_injectionConfig:InjectionConfig;

        public function PropertyInjectionPoint(_arg_1:XML, _arg_2:Injector)
        {
            super(_arg_1, _arg_2);
        }

        override public function applyInjection(_arg_1:Object, _arg_2:Injector):Object
        {
            var _local_3:Object = this.m_injectionConfig.getResponse(_arg_2);
            if (_local_3 == null)
            {
                throw (new InjectorError(((("Injector is missing a rule to handle injection into target " + _arg_1) + ". Target dependency: ") + this.propertyType)));
            };
            _arg_1[this.propertyName] = _local_3;
            return (_arg_1);
        }

        override protected function initializeInjection(_arg_1:XML, _arg_2:Injector):void
        {
            this.propertyType = _arg_1.parent().@type.toString();
            this.propertyName = _arg_1.parent().@name.toString();
            this.m_injectionConfig = _arg_2.getMapping(Class(_arg_2.getApplicationDomain().getDefinition(this.propertyType)), _arg_1.arg.attribute("value").toString());
        }


    }
}//package org.swiftsuspenders.injectionpoints
