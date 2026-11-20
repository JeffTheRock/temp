//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;
    import org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.InjectorError;
    import flash.utils.getQualifiedClassName;

    public class MethodInjectionPoint extends InjectionPoint 
    {

        protected var methodName:String;
        protected var m_injectionConfigs:Array;
        protected var requiredParameters:int = 0;

        public function MethodInjectionPoint(_arg_1:XML, _arg_2:Injector)
        {
            super(_arg_1, _arg_2);
        }

        override public function applyInjection(_arg_1:Object, _arg_2:Injector):Object
        {
            var _local_3:Array = this.gatherParameterValues(_arg_1, _arg_2);
            var _local_4:Function = _arg_1[this.methodName];
            _local_4.apply(_arg_1, _local_3);
            return (_arg_1);
        }

        override protected function initializeInjection(node:XML, injector:Injector):void
        {
            var nameArgs:XMLList;
            var methodNode:XML;
            nameArgs = node.arg.(@key == "name");
            methodNode = node.parent();
            this.methodName = methodNode.@name.toString();
            this.gatherParameters(methodNode, nameArgs, injector);
        }

        protected function gatherParameters(_arg_1:XML, _arg_2:XMLList, _arg_3:Injector):void
        {
            var _local_5:XML;
            var _local_6:String;
            var _local_7:String;
            var _local_8:Class;
            this.m_injectionConfigs = [];
            var _local_4:int;
            for each (_local_5 in _arg_1.parameter)
            {
                _local_6 = "";
                if (_arg_2[_local_4])
                {
                    _local_6 = _arg_2[_local_4].@value.toString();
                };
                _local_7 = _local_5.@type.toString();
                if (_local_7 == "*")
                {
                    if (_local_5.@optional.toString() == "false")
                    {
                        throw (new Error(("Error in method definition of injectee. Required " + "parameters can't have type \"*\".")));
                    };
                    _local_7 = null;
                }
                else
                {
                    _local_8 = Class(_arg_3.getApplicationDomain().getDefinition(_local_7));
                };
                this.m_injectionConfigs.push(_arg_3.getMapping(_local_8, _local_6));
                if (_local_5.@optional.toString() == "false")
                {
                    this.requiredParameters++;
                };
                _local_4++;
            };
        }

        protected function gatherParameterValues(_arg_1:Object, _arg_2:Injector):Array
        {
            var _local_6:InjectionConfig;
            var _local_7:Object;
            var _local_3:Array = [];
            var _local_4:int = this.m_injectionConfigs.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = this.m_injectionConfigs[_local_5];
                _local_7 = _local_6.getResponse(_arg_2);
                if (_local_7 == null)
                {
                    if (_local_5 >= this.requiredParameters) break;
                    throw (new InjectorError(((((((("Injector is missing a rule to handle injection into target " + _arg_1) + ". Target dependency: ") + getQualifiedClassName(_local_6.request)) + ", method: ") + this.methodName) + ", parameter: ") + (_local_5 + 1))));
                };
                _local_3[_local_5] = _local_7;
                _local_5++;
            };
            return (_local_3);
        }


    }
}//package org.swiftsuspenders.injectionpoints
