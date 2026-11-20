//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.models.vo
{
    public class CalloutDataVO 
    {

        public var title:String;
        public var body:String;

        public function CalloutDataVO(_arg_1:Object)
        {
            this.title = _arg_1.title.text;
            this.body = _arg_1.body.text;
        }

    }
}//package com.clubpenguin.web.www.cardjitsu.models.vo
