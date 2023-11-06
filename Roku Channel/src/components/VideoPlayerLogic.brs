' ********** Copyright 2019 Roku Corp.  All Rights Reserved. **********

' This is logic for video playback
function OpenVideoPlayer(content as Object, index as Integer, isContentList as Boolean) as Object
    video = CreateObject("roSGNode", "MediaView")
    video.content = content
    video.jumpToItem = index
    video.isContentList = isContentList
    video.control = "play"

    '! MRainwater (28 Oct 2023) - Debug print the content object when playing a video.  This might help me use this method in Deep Linking 29 Oct 2023
    ? "Debug VideoPlayerLogic.brs - line 12"
    ? "index="
    ? index
    ? "content="
    ? content
    ? "content.change="
    ? content.change
    ? "content.focusedChild="
    ? content.focusedChild

    m.top.ComponentController.CallFunc("show", {
        view: video
    })
    return video
end function


function OpenVideoPlayerItem(contentItem as Object) as Object
    video = CreateObject("roSGNode", "MediaView")
    video.content = contentItem
    video.isContentList = false
    video.control = "play"
    m.top.ComponentController.CallFunc("show", {
        view: video
    })
    return video
end function

sub OnEndcardItemSelected(event as Object)
    item = event.GetData()
    video = event.GetRoSGNode()
    video.UnobserveField("endcardItemSelected")
    video.close = true

    if item.url <> invalid
        video = OpenVideoPlayerItem(item)
        video.ObserveField("endcardItemSelected", "OnEndcardItemSelected")
    end if
end sub

