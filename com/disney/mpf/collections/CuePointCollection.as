//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.collections
{
    import com.disney.mpf.media.cuepoints.CuePoint;

    public class CuePointCollection implements ICollection 
    {

        private var CLASS_NAME:String = "com.disney.mpf.collections";
        private var _cuePointsList:Array;
        private var _cuePointIndex:uint;

        public function CuePointCollection()
        {
            this._cuePointsList = new Array();
            this._cuePointIndex = 0;
        }

        public function getCurrentCuePoint():CuePoint
        {
            return (this.allCuePoints[this.cuePointIndex]);
        }

        public function destroy():void
        {
            var _local_3:CuePoint;
            var _local_1:uint = this._cuePointsList.length;
            var _local_2:uint;
            while (_local_2 < _local_1)
            {
                _local_3 = this._cuePointsList.shift();
                _local_3.destroy();
                _local_2++;
            };
            delete this[this];
        }

        public function getCuePointAtIndex(_arg_1:Number):CuePoint
        {
            return (this.allCuePoints[_arg_1]);
        }

        public function get allCuePoints():Array
        {
            return (this._cuePointsList);
        }

        public function get currentIndex():uint
        {
            return (this._cuePointIndex);
        }

        public function last():Object
        {
            this._cuePointIndex = (this._cuePointsList.length - 1);
            return (this._cuePointsList[(this._cuePointsList.length - 1)]);
        }

        public function addCuePoint(_arg_1:CuePoint):void
        {
            var _local_2:CuePoint = this.getCurrentCuePoint();
            this.allCuePoints.push(_arg_1);
            this.allCuePoints.sortOn("timeCode", Array.NUMERIC);
            if (((!(this.cuePointIndex == 0)) && (!(_local_2 === this.getCurrentCuePoint()))))
            {
                this.cuePointIndex++;
            };
        }

        public function gotoIndex(_arg_1:uint):Object
        {
            if (_arg_1 < this._cuePointsList.length)
            {
                this._cuePointIndex = _arg_1;
                return (this._cuePointsList[this._cuePointIndex]);
            };
            return (null);
        }

        public function first():Object
        {
            this._cuePointIndex = 0;
            return (this._cuePointsList[0]);
        }

        public function set cuePointIndex(_arg_1:Number):void
        {
            var _local_2:Number = _arg_1;
            if (_arg_1 >= this.allCuePoints.length)
            {
                _local_2 = (this.allCuePoints.length - 1);
            }
            else
            {
                if (_arg_1 < 0)
                {
                    _local_2 = 0;
                };
            };
            this._cuePointIndex = _local_2;
        }

        public function next():Object
        {
            var _local_1:Number = this.cuePointIndex;
            var _local_2:Number = this.allCuePoints.length;
            if (this.hasNext())
            {
                _local_1++;
                this.cuePointIndex = _local_1;
                return (this.allCuePoints[_local_1]);
            };
            return (null);
        }

        public function hasNext():Boolean
        {
            return ((this._cuePointIndex < (this._cuePointsList.length - 1)) && (this._cuePointsList.length > 0));
        }

        public function previous():Object
        {
            var _local_1:Number = this.cuePointIndex;
            var _local_2:Number = this.allCuePoints.length;
            if (this.hasPrevious())
            {
                _local_1--;
                this.cuePointIndex = _local_1;
                return (this.allCuePoints[_local_1]);
            };
            return (null);
        }

        public function hasPrevious():Boolean
        {
            return (!(this._cuePointIndex == 0));
        }

        public function current():Object
        {
            return (this.allCuePoints[this.cuePointIndex]);
        }

        public function get cuePointIndex():Number
        {
            return (this._cuePointIndex);
        }


    }
}//package com.disney.mpf.collections
