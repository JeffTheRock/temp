//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.controller.video
{
    import com.disney.mpf.media.controller.IController;

    public interface IVideoController extends IController 
    {

        function set clip(_arg_1:*):void;
        function set maintainAspectRatioAnchor(_arg_1:String):void;
        function get maxWidth():Number;
        function changeAspectRatio(_arg_1:String, _arg_2:String="WIDTH", _arg_3:Number=-1):void;
        function set visible(_arg_1:Boolean):void;
        function get width():Number;
        function set autoSize(_arg_1:Boolean):void;
        function get maintainAspectRatio():Boolean;
        function get maintainAspectRatioAnchor():String;
        function set maxWidth(_arg_1:Number):void;
        function set width(_arg_1:Number):void;
        function get maxHeight():Number;
        function get height():Number;
        function get clip():*;
        function get visible():Boolean;
        function resize(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=false, _arg_4:String="4:3", _arg_5:String="WIDTH"):void;
        function realAspectRatio():String;
        function set maxHeight(_arg_1:Number):void;
        function get autoSize():Boolean;
        function currentAspectRatio():String;
        function set height(_arg_1:Number):void;
        function set maintainAspectRatio(_arg_1:Boolean):void;

    }
}//package com.disney.mpf.media.controller.video
