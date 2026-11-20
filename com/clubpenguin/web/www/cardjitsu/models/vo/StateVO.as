//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.web.www.cardjitsu.models.vo
{
    public class StateVO 
    {

        public static const STANDARD:String = "standard";
        public static const FIRE:String = "fire";
        public static const WATER:String = "water";

        private var _mainState:String;
        private var _isValid:Boolean;

        public function StateVO(_arg_1:Array)
        {
            this.setMainState(_arg_1[0]);
        }

        private function setMainState(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "":
                    this._isValid = true;
                    _arg_1 = StateVO.STANDARD;
                    break;
                case StateVO.FIRE:
                case StateVO.WATER:
                    this._isValid = true;
                    break;
                default:
                    this._isValid = false;
                    _arg_1 = StateVO.STANDARD;
            };
            this._mainState = _arg_1;
        }

        public function get mainState():String
        {
            return (this._mainState);
        }

        public function get isValid():Boolean
        {
            return (this._isValid);
        }


    }
}//package com.clubpenguin.web.www.cardjitsu.models.vo
