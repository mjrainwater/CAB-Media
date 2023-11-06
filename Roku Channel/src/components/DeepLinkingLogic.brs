function IsDeepLinking(args as Object)
    ' check if deep linking args is valid
    return args <> invalid and args.mediaType <> invalid and args.mediaType <> "" and args.contentId <> invalid and args.contentId <> "" 
end function

sub PerformDeepLinking(args as Object)
    ' Implement your deep linking logic. For more details, please see Roku_Recommends sample.

    '! MRainwater (28 Oct 2023) - Debug print deeplink

    '<Component: roAssociativeArray> =
    '{
    '    contentId: "LIVE001"
    '    instant_on_run_mode: "foreground"
    '    lastExitOrTerminationReason: "EXIT_USER_NAV"
    '    mediaType: "movie"
    '    source: "external-control"
    '    splashTime: "2000"
    '}

    deeplink = getDeepLinks(args)

    ? "Debug: DeepLinkingLogic.brs - line 23"
    ? "deeplink="
    ? deeplink 

    '? "Debug Print m.top.content="
    '? m.top.content

    '! MRainwater: Problem:  I cannot find out how to populate the content object 29 Oct 2023
    'content = GetContent()
    '? "Debug: DeepLinkingLogic.brs - line 27"
    '? "content="
    '? content 

    'if content <> invalid 
    '    playableItem = FindNodeById( m.content, deeplink.id)
    'end if 

    '? "Debug: DeepLinkingLogic.brs - line 29"
    '? "playableItem="
    '? playableItem 

    ' Debug example of a content object
    '<Component: roSGNode:ContentNode> =
    '{
    '    change: <Component: roAssociativeArray>
    '    focusable: false
    '    focusedChild: <Component: roInvalid>
    '    id: ""
    '    CM_focusedItem: 0
    '    cm_row_id_index: 0
    '    isFailed: false
    '    isLoaded: true
    '    isLoading: false
    '    TITLE: "Watch Live Services"
    '}

' If I can get the content, I believe this is the way to play it...

    'if playableItem <> invalid
    '    video = CreateObject("roSGNode", "MediaView")
    '    video.content = playableItem
    '    video.jumpToItem = index
    '    video.control = "play"
    'end if

end sub

Function getDeepLinks(args) as Object
    deeplink = Invalid

    if args.contentid <> Invalid and args.mediaType <> Invalid
        deeplink = {
            id: args.contentId
            type: args.mediaType
        }
    end if

    return deeplink
end Function

' Helper function finds child node by specified contentId
function FindNodeById(content as Object, contentId as String) as Object
    for each element in content.GetChildren(-1, 0)
        if element.id = contentId
            return element
        else if element.getChildCount() > 0
            result = FindNodeById(element, contentId)
            if result <> invalid
                return result
            end if
        end if
    end for
    return invalid
end function