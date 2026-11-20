//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.mpf.media.model.info.meta
{
    public class FLVMetaInfo extends MetaInfo 
    {

        public function FLVMetaInfo(_arg_1:Object)
        {
            this.height = Number(_arg_1.height);
            this.width = Number(_arg_1.width);
            this.creationDate = _arg_1.creationdate;
            this.encodedWith = _arg_1.Encoded_With;
            this.canSeekToEnd = Boolean(_arg_1.canSeekToEnd);
            this.framerate = Number(_arg_1.framerate);
            this.duration = Number(_arg_1.duration);
            this.audioCodecId = _arg_1.audiocodecid;
            this.audioDataRate = Number(_arg_1.audiodatarate);
            this.videoCodecId = _arg_1.videocodecid;
            this.videoDataRate = Number(_arg_1.videodatarate);
        }

    }
}//package com.disney.mpf.media.model.info.meta
