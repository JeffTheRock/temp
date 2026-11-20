//Created by Action Script Viewer - https://www.buraks.com/asv
package com.omniture
{
    import flash.events.Event;
    import flash.external.ExternalInterface;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObjectContainer;

    public dynamic class ActionSource_Module_ClickMap 
    {

        private static var isExternalSet:Boolean = false;

        private var s:Object;

        public function ActionSource_Module_ClickMap(s:Object)
        {
            var m:Object;
            var e:Object;
            super();
            m = this;
            m.s = s;
            m.s.addEventListener(Event.ADDED_TO_STAGE, m.onAddedToStage, false, 0, true);
            if (((ExternalInterface.available) && (!(m.isExternalSet))))
            {
                m.isExternalSet = true;
                try
                {
                    ExternalInterface.addCallback("s_getDOMIndex", m.getDOMIndex);
                    ExternalInterface.addCallback("s_getTrackClickMap", m.getTrackClickMap);
                    ExternalInterface.addCallback("s_getAccount", m.getAccount);
                    ExternalInterface.addCallback("s_getPageName", m.getPageName);
                    ExternalInterface.addCallback("s_getPageURL", m.getPageURL);
                    ExternalInterface.addCallback("s_getMovieID", m.getMovieID);
                    ExternalInterface.addCallback("s_getVersion", m.getVersion);
                    ExternalInterface.addCallback("s_getCharSet", m.getCharSet);
                    ExternalInterface.addCallback("s_getSWFURL", m.getSWFURL);
                }
                catch(e)
                {
                };
            };
        }

        public function getSWFURL():*
        {
            var _local_1:Object;
            _local_1 = this;
            if (_local_1.s.isSet(s.movie))
            {
                if (((_local_1.s.isSet(_local_1.s.movie.loaderInfo)) && (_local_1.s.isSet(_local_1.s.movie.loaderInfo.loaderURL))))
                {
                    return (_local_1.s.movie.loaderInfo.loaderURL);
                };
                if (_local_1.s.isSet(_local_1.s.movie._url))
                {
                    return (_local_1.s.movie._url);
                };
            };
            return ("");
        }

        public function getVersion():*
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.s.version);
        }

        private function parentLocalToGlobal(_arg_1:DisplayObject, _arg_2:Object):*
        {
            var _local_3:*;
            _local_3 = new Point(_arg_2.x, _arg_2.y);
            _arg_1.parent.localToGlobal(_local_3);
            _arg_2.x = _local_3.x;
            _arg_2.y = _local_3.y;
        }

        private function getFullPath(_arg_1:DisplayObject):*
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:Array;
            _local_4 = new Array();
            do 
            {
                _local_4.splice(0, 0, _arg_1.name);
                _arg_1 = _arg_1.parent;
            } while (_arg_1.parent != null);
            _local_2 = _local_4.join(".");
            _local_3 = _local_2.substr((_local_2.length - 4), 4);
            if (((_local_3 == ".frs") || (_local_3 == ".fds")))
            {
                _local_2 = _local_2.substr(0, (_local_2.length - 4));
            };
            return (_local_2);
        }

        public function getObjectID(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_4:String;
            _local_2 = this;
            _local_3 = _local_2.getMovieID();
            _local_4 = "";
            _local_4 = _local_2.getFullPath(_arg_1);
            if (_local_2.s.isSet(_local_4))
            {
                _local_4 = ((((_local_2.s.isSet(_local_3)) ? _local_3 : "") + ":") + _local_4);
            };
            return (_local_4);
        }

        public function getMovieID():*
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:String;
            var _local_4:Number;
            var _local_5:Number;
            _local_1 = this;
            _local_2 = _local_1.getSWFURL();
            _local_3 = s.movieID;
            if (((!(_local_1.s.isSet(_local_3))) && (_local_1.s.isSet(_local_2))))
            {
                _local_4 = _local_2.lastIndexOf("/");
                _local_5 = _local_2.lastIndexOf(".");
                if (_local_4 >= 0)
                {
                    _local_4++;
                }
                else
                {
                    _local_4 = 0;
                };
                if (_local_5 >= 0)
                {
                    _local_5 = (_local_5 - _local_4);
                }
                else
                {
                    _local_5 = _local_2.length;
                };
                _local_3 = _local_2.substr(_local_4, _local_5);
            };
            if (!_local_1.s.isSet(_local_3))
            {
                _local_3 = "movieID undefined";
            };
            return (_local_3);
        }

        public function getIndex():*
        {
            var _local_1:Object;
            var _local_2:String;
            _local_1 = this;
            if (_local_1.s.isSet(_local_1.s.movie))
            {
                return (((_local_1.s.movie.stage.stageWidth + ",") + _local_1.s.movie.stage.stageHeight) + _local_1.indexChildren(_local_1.s.movie));
            };
            return ("");
        }

        private function sendClickMapEvent(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:Number;
            _local_2 = this;
            _local_3 = _local_2.s.getMovieURL();
            _local_4 = _local_2.getMovieID();
            if (_local_2.s.isSet(_local_2.s.trackClickMap))
            {
                _local_2.s.objectID = _local_2.getObjectID(_arg_1);
            };
            if (_local_2.s.autoTrack)
            {
                _local_5 = _local_3;
                _local_6 = _local_5.indexOf("?");
                if (_local_6 >= 0)
                {
                    _local_5 = _local_5.substr(0, _local_6);
                };
                if (_local_5.length > (100 - 23))
                {
                    _local_5 = _local_5.substr(-(100 - 23));
                };
                _local_2.s.trackLink(_local_3, "o", ("ActionSource.AutoTrack:" + _local_5));
            };
        }

        private function nodeShift(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number):*
        {
            _arg_1.x = _arg_2;
            _arg_1.y = _arg_3;
        }

        private function parentGetBounds(_arg_1:DisplayObject):*
        {
            var _local_2:*;
            var _local_3:*;
            _local_2 = _arg_1.parent.getBounds(_arg_1.parent);
            _local_3 = new Object();
            _local_3.xMin = _local_2.x;
            _local_3.yMin = _local_2.y;
            _local_3.xMax = (_local_2.x + _local_2.width);
            _local_3.yMax = (_local_2.y + _local_2.height);
            return (_local_3);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            var _local_2:Object;
            _local_2 = this;
            _local_2.s.root.addEventListener(MouseEvent.CLICK, _local_2.onMouseClick, true, 0, true);
        }

        private function getDOMID(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:Object;
            _local_2 = this;
            if (_local_2.s.isSet(_arg_1))
            {
                _local_3 = _local_2.getGeom(_arg_1);
                return ((((((((_local_2.getFullPath(_arg_1) + ",") + _local_3.x) + ",") + _local_3.y) + ",") + _local_3.w) + ",") + _local_3.h);
            };
            return ("");
        }

        private function onMouseClick(event:MouseEvent):void
        {
            var m:Object;
            var e:Object;
            m = this;
            try
            {
                m.sendClickMapEvent(InteractiveObject(event.target));
            }
            catch(e)
            {
            };
        }

        public function getPageURL():*
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.s.pageURL);
        }

        public function getDOMIndex():*
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.getIndex());
        }

        public function getTrackClickMap():*
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.s.trackClickMap.toString());
        }

        private function indexChildren(_arg_1:DisplayObjectContainer):String
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_4:Number;
            var _local_5:DisplayObject;
            _local_2 = this;
            _local_3 = new String();
            _local_4 = 0;
            while (_local_4 < _arg_1.numChildren)
            {
                _local_5 = _arg_1.getChildAt(_local_4);
                if (_local_2.s.isSet(_local_5))
                {
                    _local_3 = (_local_3 + ("|" + _local_2.getDOMID(_local_5)));
                    if ((_local_5 is DisplayObjectContainer))
                    {
                        _local_3 = (_local_3 + _local_2.indexChildren(DisplayObjectContainer(_local_5)));
                    };
                };
                _local_4++;
            };
            return (_local_3);
        }

        private function nodePos(_arg_1:DisplayObject):*
        {
            var _local_2:*;
            _local_2 = new Object();
            _local_2.x = _arg_1.x;
            _local_2.y = _arg_1.y;
            return (_local_2);
        }

        public function getCharSet():*
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.s.charSet);
        }

        public function getAccount():*
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.s.account);
        }

        private function getGeom(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:Object;
            var _local_7:Object;
            var _local_8:Object;
            var _local_9:Object;
            _local_2 = this;
            _local_3 = new Object();
            _local_4 = null;
            _local_3.x = 0;
            _local_3.y = 0;
            _local_3.w = 0;
            _local_3.h = 0;
            if (((_local_2.s.isSet(_arg_1)) && ((_local_2.s.isSet(_arg_1, "_parent")) || (_local_2.s.isSet(_arg_1, "parent")))))
            {
                if (s.isSet(_arg_1, "_parent"))
                {
                    _local_4 = _local_2.getGeom(_arg_1._parent);
                }
                else
                {
                    if (s.isSet(_arg_1, "parent"))
                    {
                        _local_4 = _local_2.getGeom(_arg_1.parent);
                    };
                };
                if (((((((_local_2.s.isSet(_arg_1, "size")) && (typeof(_arg_1.size) == "function")) && (_local_2.s.isSet(_arg_1, "__width"))) && (_local_2.s.isSet(_arg_1, "__height"))) && (!(_arg_1.__width == _arg_1._width))) && (!(_arg_1.__height == _arg_1._height))))
                {
                    _arg_1.size();
                };
                if (((_local_2.s.isSet(_arg_1, "width")) && (_local_2.s.isSet(_arg_1, "height"))))
                {
                    _local_3.x = _arg_1.x;
                    _local_3.y = _arg_1.y;
                    _local_2.parentLocalToGlobal(_arg_1, _local_3);
                    _local_3.w = _arg_1.width;
                    _local_3.h = _arg_1.height;
                }
                else
                {
                    _local_7 = _local_2.parentGetBounds(_arg_1);
                    _local_5 = _local_2.nodePos(_arg_1);
                    _local_6 = _local_2.nodePos(_arg_1);
                    _local_2.nodeShift(_arg_1, _local_7.xMin, _local_7.yMin);
                    _local_8 = _local_2.parentGetBounds(_arg_1);
                    _local_2.nodeShift(_arg_1, _local_7.xMax, _local_7.yMax);
                    _local_9 = _local_2.parentGetBounds(_arg_1);
                    _local_2.nodeShift(_arg_1, _local_5.x, _local_5.y);
                    _local_5.x = (_local_5.x + (_local_8.xMin - _local_7.xMin));
                    _local_5.y = (_local_5.y + (_local_8.yMin - _local_7.yMin));
                    _local_6.x = (_local_6.x + (_local_9.xMax - _local_7.xMax));
                    _local_6.y = (_local_6.y + (_local_9.yMax - _local_7.yMax));
                    _local_2.parentLocalToGlobal(_arg_1, _local_5);
                    _local_2.parentLocalToGlobal(_arg_1, _local_6);
                    _local_3.x = _local_5.x;
                    _local_3.y = _local_5.y;
                    _local_3.w = (_local_6.x - _local_5.x);
                    _local_3.h = (_local_6.y - _local_5.y);
                };
                if ((((_local_2.s.isSet(_local_4)) && (_local_2.s.isSet(_local_4.x))) && (_local_2.s.isSet(_local_4.y))))
                {
                    _local_3.x = (_local_3.x + _local_4.x);
                    _local_3.y = (_local_3.y + _local_4.y);
                };
                _local_3.x = Math.round(_local_3.x);
                _local_3.y = Math.round(_local_3.y);
                _local_3.w = Math.ceil(_local_3.w);
                _local_3.h = Math.ceil(_local_3.h);
            };
            return (_local_3);
        }

        public function getPageName():*
        {
            var _local_1:Object;
            _local_1 = this;
            return (_local_1.s.pageName);
        }


    }
}//package com.omniture
