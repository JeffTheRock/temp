//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller.events
{
    import flash.events.Event;
    import com.disney.mpf.media.model.info.IMediaInfo;

    public class ControllerEvent extends Event 
    {

        private static const CLASS_NAME:String = "com.disney.mpf.media.controller.events.ControllerEvent";
        public static const INITIALIZING:String = (CLASS_NAME + ".INITIALIZING");
        public static const INITIALIZED:String = (CLASS_NAME + ".INITIALIZED");
        public static const AUTHORIZING:String = (CLASS_NAME + ".AUTHORIZING");
        public static const WAITING:String = (CLASS_NAME + ".WAITING");
        public static const STALLED:String = (CLASS_NAME + ".STALLED");
        public static const LOAD_ERROR:String = (CLASS_NAME + ".LOAD_ERROR");
        public static const LOADING:String = (CLASS_NAME + ".LOADING");
        public static const LOADED:String = (CLASS_NAME + ".LOADED");
        public static const START:String = (CLASS_NAME + ".START");
        public static const PLAY_STATE_CHANGED:String = (CLASS_NAME + ".PLAY_STATE_CHANGED");
        public static const PLAY_PENDING:String = (CLASS_NAME + ".PLAY_PENDING");
        public static const PLAY:String = (CLASS_NAME + ".PLAY");
        public static const PAUSE_PENDING:String = (CLASS_NAME + ".PAUSE_PENDING");
        public static const PAUSE:String = (CLASS_NAME + ".PAUSE");
        public static const STOP_PENDING:String = (CLASS_NAME + ".STOP_PENDING");
        public static const STOP:String = (CLASS_NAME + ".STOP");
        public static const NEXT:String = (CLASS_NAME + ".NEXT");
        public static const PREVIOUS:String = (CLASS_NAME + ".PREVIOUS");
        public static const SEEK_PENDING:String = (CLASS_NAME + ".SEEK_PENDING");
        public static const SEEK:String = (CLASS_NAME + ".SEEK");
        public static const PROGRESS_UPDATE:String = (CLASS_NAME + ".PROGRESS_UPDATE");
        public static const LIVE_PUBLISH:String = (CLASS_NAME + ".LIVE_PUBLISH");
        public static const LIVE_UNPUBLISH:String = (CLASS_NAME + ".LIVE_UNPUBLISH");
        public static const COMPLETE:String = (CLASS_NAME + ".COMPLETE");
        public static const PLAYLIST_START:String = (CLASS_NAME + ".PLAYLIST_START");
        public static const PLAYLIST_COMPLETE:String = (CLASS_NAME + ".PLAYLIST_COMPLETE");
        public static const MUTE:String = (CLASS_NAME + ".MUTE");
        public static const UNMUTE:String = (CLASS_NAME + ".UNMUTE");
        public static const VOLUME_CHANGE:String = (CLASS_NAME + ".VOLUME_CHANGE");
        public static const ON_BITRATE_CHANGED:String = (CLASS_NAME + ".ON_BITRATE_CHANGED");
        public static const ON_BITRATE_CHANGE_REQUESTED:String = (CLASS_NAME + ".ON_BITRATE_CHANGE_REQUESTED");
        public static const SHOW_CHANGED:String = (CLASS_NAME + ".SHOW_CHANGED");
        public static const BUFFER_FULL:String = (CLASS_NAME + ".BUFFER_FULL");
        public static const BUFFER_EMPTY:String = (CLASS_NAME + ".BUFFER_EMPTY");
        public static const BUFFER_FLUSH:String = (CLASS_NAME + ".BUFFER_FLUSH");
        public static const DOWNLOAD_START:String = (CLASS_NAME + ".DOWNLOAD_START");
        public static const DOWNLOAD_PROGRESS:String = (CLASS_NAME + ".DOWNLOAD_PROGRESS");
        public static const DOWNLOAD_COMPLETE:String = (CLASS_NAME + ".DOWNLOAD_COMPLETE");
        public static const UPDATE_SUCCESS:String = (CLASS_NAME + ".UPDATE_SUCCESS");
        public static const UPDATE_FAILURE:String = (CLASS_NAME + ".UPDATE_FAILURE");

        private var _cancelable:Boolean;
        private var _bubbles:Boolean;
        private var _type:String;
        private var _info:IMediaInfo;

        public function ControllerEvent(_arg_1:String, _arg_2:IMediaInfo, _arg_3:Boolean=true, _arg_4:Boolean=true)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._type = _arg_1;
            this._info = _arg_2;
            this._bubbles = _arg_3;
            this._cancelable = _arg_4;
        }

        override public function clone():Event
        {
            return (new ControllerEvent(this._type, this._info, this._bubbles, this._cancelable));
        }

        public function get info():IMediaInfo
        {
            return (this._info);
        }


    }
}//package com.disney.mpf.media.controller.events
