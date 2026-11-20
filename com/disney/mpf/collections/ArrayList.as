//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.collections
{
    public class ArrayList implements ICollection 
    {

        private var _index:uint = 0;
        private var _collection:Array;

        public function ArrayList(_arg_1:Array)
        {
            this._collection = _arg_1;
            this._index = 0;
        }

        public function get currentIndex():uint
        {
            return (this._index);
        }

        public function next():Object
        {
            if (this.hasNext())
            {
                this._index++;
                return (this._collection[this._index]);
            };
            return (null);
        }

        public function current():Object
        {
            return (this._collection[this._index]);
        }

        public function hasNext():Boolean
        {
            return ((this._index < (this._collection.length - 1)) && (this._collection.length > 0));
        }

        public function gotoIndex(_arg_1:uint):Object
        {
            if (_arg_1 < this._collection.length)
            {
                this._index = _arg_1;
                return (this._collection[this._index]);
            };
            return (null);
        }

        public function first():Object
        {
            this._index = 0;
            return (this._collection[0]);
        }

        public function hasPrevious():Boolean
        {
            return (!(this._index == 0));
        }

        public function last():Object
        {
            this._index = (this._collection.length - 1);
            return (this._collection[(this._collection.length - 1)]);
        }

        public function previous():Object
        {
            if (this.hasPrevious())
            {
                this._index--;
                return (this._collection[this._index]);
            };
            return (null);
        }


    }
}//package com.disney.mpf.collections
