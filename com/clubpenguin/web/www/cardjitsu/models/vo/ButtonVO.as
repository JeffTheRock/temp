//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.models.vo
{
    public class ButtonVO 
    {

        public var id:String;
        public var fontSrc:String;
        public var fontSize:int;
        public var label:String;
        public var href:String;
        public var height:int;
        public var language:String;

        public function ButtonVO(_arg_1:Object)
        {
            this.id = _arg_1.id;
            this.fontSrc = _arg_1.fontSrc;
            this.fontSize = _arg_1.fontSize;
            this.label = _arg_1.text;
            this.href = String(_arg_1.href).replace("&amp;", "&");
            this.height = _arg_1.height;
        }

    }
}//package com.clubpenguin.web.www.cardjitsu.models.vo
