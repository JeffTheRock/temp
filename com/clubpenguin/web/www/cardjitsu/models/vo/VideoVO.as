//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.models.vo
{
    public class VideoVO 
    {

        public var id:String;
        public var language:String;
        public var vidSrc:String;
        public var width:int;
        public var height:int;
        public var embedURL:String;
        public var embedLabel:String;

        public function VideoVO(_arg_1:Object)
        {
            this.width = _arg_1.width;
            this.height = _arg_1.height;
            this.embedURL = _arg_1.embed_code.src;
            this.embedLabel = _arg_1.embed_code.text;
        }

    }
}//package com.clubpenguin.web.www.cardjitsu.models.vo
