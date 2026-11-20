//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model
{
    import com.disney.mpf.collections.ArrayList;
    import com.disney.mpf.errors.MPFError;
    import com.disney.mpf.errors.MPFErrorCodes;
    import com.disney.mpf.media.decorator.MediaObject;
    import com.disney.mpf.collections.ICollection;

    public class Playlist implements IAsset 
    {

        private var _parent:IAsset;
        private var _bufferTime:Number = 0.1;
        private var _iterator:ArrayList;
        private var _assets:Array;
        private var _name:String;
        private var _id:String;

        public function Playlist(_arg_1:String)
        {
            this._id = _arg_1;
            this._assets = new Array();
            this._iterator = new ArrayList(this._assets);
        }

        public function get items():Array
        {
            return (this._assets);
        }

        public function destroy():void
        {
            var _local_3:IAsset;
            var _local_1:uint = this._assets.length;
            var _local_2:uint;
            while (_local_2 < _local_1)
            {
                _local_3 = this._assets.shift();
                _local_3.destroy();
                _local_2++;
            };
            delete this[this];
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function getMediaItemById(_arg_1:String, _arg_2:Boolean=false):IAsset
        {
            var _local_3:int;
            while (_local_3 < this._assets.length)
            {
                if (_arg_1 == IAsset(this._assets[_local_3]).id)
                {
                    if (_arg_2)
                    {
                        return (IAsset(this._iterator.gotoIndex(_local_3)));
                    };
                    return (IAsset(this._assets[_local_3]));
                };
                _local_3++;
            };
            throw (new MPFError("Media ID not found in playlist.", MPFErrorCodes.PLAYLIST_MEDIA_ID_NOT_FOUND));
        }

        public function addItem(_arg_1:IAsset):void
        {
            if (this._bufferTime != 0.1)
            {
                if (MediaObject(_arg_1).bufferTime == 0.1)
                {
                    MediaObject(_arg_1).bufferTime = this._bufferTime;
                };
            };
            this._assets.push(_arg_1);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function getParent():IAsset
        {
            return (this._parent);
        }

        public function getMediaItemByIndex(_arg_1:uint, _arg_2:Boolean=false):IAsset
        {
            var _local_3:IAsset;
            if (_arg_2)
            {
                _local_3 = IAsset(this._iterator.gotoIndex(_arg_1));
            }
            else
            {
                if (_arg_1 < this._assets.length)
                {
                    _local_3 = this._assets[_arg_1];
                };
            };
            if (_local_3 != null)
            {
                return (_local_3);
            };
            throw (new MPFError("Media index exceeds the length of the array.", MPFErrorCodes.PLAYLIST_INDEX_OUTOFBOUNDS));
        }

        public function get length():uint
        {
            return (this._assets.length);
        }

        public function set bufferTime(_arg_1:Number):void
        {
            var _local_2:MediaObject;
            this._bufferTime = _arg_1;
            for each (_local_2 in this._assets)
            {
                if (this._bufferTime != 0.1)
                {
                    if (_local_2.bufferTime == 0.1)
                    {
                        _local_2.bufferTime = this._bufferTime;
                    };
                };
            };
        }

        public function get bufferTime():Number
        {
            return (this._bufferTime);
        }

        public function iterator():ICollection
        {
            return (this._iterator);
        }

        public function set id(_arg_1:String):void
        {
            this._id = _arg_1;
        }

        public function removeItem(_arg_1:String):void
        {
            var _local_2:IAsset = this.getMediaItemById(_arg_1);
            var _local_3:int = -1;
            var _local_4:uint;
            while (_local_4 < this._assets.length)
            {
                if (this._assets[_local_4] == _local_2)
                {
                    _local_3 = _local_4;
                    break;
                };
                _local_4++;
            };
            if (_local_3 != -1)
            {
                this._assets.splice(_local_3, 1);
            };
        }

        public function setParent(_arg_1:IAsset):void
        {
            this._parent = _arg_1;
        }


    }
}//package com.disney.mpf.media.model
