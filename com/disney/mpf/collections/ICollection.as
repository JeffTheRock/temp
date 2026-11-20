//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.collections
{
    public interface ICollection 
    {

        function first():Object;
        function hasPrevious():Boolean;
        function next():Object;
        function last():Object;
        function previous():Object;
        function get currentIndex():uint;
        function current():Object;
        function hasNext():Boolean;
        function gotoIndex(_arg_1:uint):Object;

    }
}//package com.disney.mpf.collections
