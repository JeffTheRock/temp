//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.Injector;

    public class InjectOtherRuleResult extends InjectionResult 
    {

        private var m_rule:InjectionConfig;

        public function InjectOtherRuleResult(_arg_1:InjectionConfig)
        {
            this.m_rule = _arg_1;
        }

        override public function getResponse(_arg_1:Injector):Object
        {
            return (this.m_rule.getResponse(_arg_1));
        }


    }
}//package org.swiftsuspenders.injectionresults
