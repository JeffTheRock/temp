//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.libs.utils
{
    public class SimpleParserXML 
    {

        public static const IS_ARRAY:String = "array";


        public function getObjectTreeFromXml(_arg_1:XML):Object
        {
            var _local_2:Object;
            if (_arg_1)
            {
                return (this.processNode(_arg_1, new Object()));
            };
            throw (new Error("Cannot parse a null reference."));
        }

        private function processNode(_arg_1:XML, _arg_2:Object):Object
        {
            var _local_5:String;
            var _local_3:Object = {};
            var _local_4:Boolean;
            if (_arg_1.@type == IS_ARRAY)
            {
                _local_4 = true;
                _local_5 = _arg_1.name();
            };
            if (_local_4)
            {
                _local_3 = this.processArrayNode(_arg_1, _arg_2, _local_5);
            }
            else
            {
                _local_3 = this.processObjectNode(_arg_1, _arg_2);
            };
            return (_local_3);
        }

        private function processArrayNode(_arg_1:XML, _arg_2:Object, _arg_3:String):Object
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:XMLList;
            var _local_7:int;
            var _local_8:XML;
            if (_arg_1)
            {
                _arg_2[_arg_3] = new Array();
                _local_4 = 0;
                _local_5 = _arg_1.*.length();
                while (_local_4 < _local_5)
                {
                    _local_8 = _arg_1.*[_local_4];
                    _arg_2[_arg_3].push(this.processNode(_local_8, new Object()));
                    _local_4++;
                };
                _local_6 = _arg_1.attributes();
                _local_7 = 0;
                while (_local_7 < _local_6.length())
                {
                    _arg_2[_local_6[_local_7].name().localName] = _local_6[_local_7].toXMLString();
                    _local_7++;
                };
            };
            return (_arg_2);
        }

        private function processObjectNode(_arg_1:XML, _arg_2:Object):Object
        {
            var _local_3:Number;
            var _local_4:XMLList;
            var _local_5:XML;
            var _local_6:int;
            var _local_7:XMLList;
            var _local_8:int;
            if (_arg_1)
            {
                _local_3 = 0;
                _local_4 = _arg_1.children();
                _local_6 = 0;
                while (_local_6 < _local_4.length())
                {
                    _local_5 = _local_4[_local_6];
                    if (_local_5.@type == IS_ARRAY)
                    {
                        this.processArrayNode(_local_5, _arg_2, _local_5.name().localName);
                    }
                    else
                    {
                        if (_local_5.nodeKind() == "text")
                        {
                            _arg_2.text = _local_5.toString();
                        }
                        else
                        {
                            _arg_2[_local_5.name().localName] = new Object();
                            this.processObjectNode(_local_5, _arg_2[_local_5.name().localName]);
                        };
                    };
                    _local_6++;
                };
                _local_7 = _arg_1.attributes();
                _local_8 = 0;
                while (_local_8 < _local_7.length())
                {
                    _arg_2[_local_7[_local_8].name().localName] = _local_7[_local_8].toXMLString();
                    _local_8++;
                };
            };
            return (_arg_2);
        }


    }
}//package com.clubpenguin.web.libs.utils
