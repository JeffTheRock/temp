//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model
{
    import com.disney.mpf.media.controller.video.FLVController;
    import com.disney.mpf.media.controller.IController;

    public class FLVMediaType extends AbstractMediaType 
    {


        override public function createController():IController
        {
            var _local_1:FLVController = new FLVController();
            _local_1.media = this;
            return (_local_1);
        }


    }
}//package com.disney.mpf.media.model
