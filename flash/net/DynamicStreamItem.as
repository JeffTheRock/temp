//Created by Action Script Viewer - https://www.buraks.com/asv
package flash.net
{
    public class DynamicStreamItem 
    {

        public var start:Number;
        public var startRate:Number;
        public var streamCount:int;
        public var len:Number;
        public var reset:Boolean;
        private var streamArray:Array;

        public function DynamicStreamItem()
        {
            this.streamArray = new Array();
            this.streamCount = NaN;
            this.start = 0;
            this.len = -1;
            this.reset = true;
            this.startRate = -1;
        }

        public function addStream(_arg_1:String, _arg_2:Number):void
        {
            if (!isNaN(_arg_2))
            {
                this.streamArray.push({
                    "name":_arg_1,
                    "rate":_arg_2
                });
            };
            this.streamArray.sortOn("rate", Array.NUMERIC);
        }

        public function get streams():Array
        {
            return (this.streamArray);
        }

        public function removeStreamRate(_arg_1:Number):Boolean
        {
            var _local_2:int = -1;
            var _local_3:int;
            while (_local_3 < this.streamArray.length)
            {
                if (this.streamArray[_local_3]["rate"] == _arg_1)
                {
                    _local_2 = _local_3;
                    break;
                };
                _local_3++;
            };
            if (_local_2 != -1)
            {
                this.streamArray.splice(_local_2, 1);
                if (this.streamCount > 0)
                {
                    this.streamCount--;
                };
                return (true);
            };
            return (false);
        }


    }
}//package flash.net
