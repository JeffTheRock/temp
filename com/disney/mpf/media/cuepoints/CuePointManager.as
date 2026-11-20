//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.cuepoints
{
    import com.disney.mpf.collections.CuePointCollection;

    public class CuePointManager 
    {

        private var _isChapter:Boolean;
        private var CLASS_NAME:String = "com.disney.mpf.media.model.cuepoint.CuePointManager";
        private var _cuePointList:CuePointCollection;
        private var _finalCuePoint:Boolean;

        public function CuePointManager(_arg_1:CuePointCollection)
        {
            this._cuePointList = _arg_1;
            this._finalCuePoint = false;
        }

        public function destroy():void
        {
            delete this[this];
        }

        public function getCuePointById(_arg_1:String):CuePoint
        {
            var _local_3:CuePoint;
            var _local_4:Number;
            var _local_2:Number = this._cuePointList.allCuePoints.length;
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_3 = this._cuePointList.getCuePointAtIndex(_local_4);
                if (_local_3.id == _arg_1)
                {
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }

        public function advanceCuePoint():CuePoint
        {
            var _local_1:CuePoint = this.currentCuePoint;
            if (this._cuePointList.next() == null)
            {
                this._finalCuePoint = true;
            };
            return (_local_1);
        }

        public function resetCuePoint(_arg_1:Number):Boolean
        {
            var _local_3:Number;
            var _local_2:CuePoint = this.findClosestCuePoint(_arg_1);
            if (_local_2 !== null)
            {
                _local_3 = this.getCuePointIndex(_local_2.id);
                this._finalCuePoint = false;
                return (true);
            };
            return (false);
        }

        public function hasNext():Boolean
        {
            return (!(this._finalCuePoint));
        }

        public function get currentCuePoint():CuePoint
        {
            return (CuePoint(this._cuePointList.getCurrentCuePoint()));
        }

        public function findClosestCuePoint(_arg_1:Number):CuePoint
        {
            var _local_3:CuePoint;
            var _local_4:Number;
            var _local_2:Number = this._cuePointList.allCuePoints.length;
            var _local_5:CuePoint = CuePoint(this._cuePointList.first());
            do 
            {
                _local_3 = this._cuePointList.getCurrentCuePoint();
                if (_local_3.timeCode >= _arg_1)
                {
                    if (_local_3 != _local_5)
                    {
                        return (CuePoint(this._cuePointList.previous()));
                    };
                    return (_local_3);
                };
            } while (this._cuePointList.next());
            return (null);
        }

        public function getCuePointIndex(_arg_1:Object):Number
        {
            var _local_4:Number;
            var _local_2:Number = this._cuePointList.allCuePoints.length;
            var _local_3:* = "id";
            if (typeof(_arg_1) == "number")
            {
                _local_3 = "timeCode";
            };
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                if (this._cuePointList.getCuePointAtIndex(_local_4)[_local_3] == _arg_1)
                {
                    return (_local_4);
                };
                _local_4++;
            };
            return (-1);
        }


    }
}//package com.disney.mpf.media.cuepoints
