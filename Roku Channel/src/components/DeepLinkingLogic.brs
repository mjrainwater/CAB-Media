function IsDeepLinking(args as Object)
    ' check if deep linking args is valid
    return args <> invalid and args.mediaType <> invalid and args.mediaType <> "" and args.contentId <> invalid and args.contentId <> "" 
end function

sub PerformDeepLinking(args as Object)
    ' Implement your deep linking logic. For more details, please see Roku_Recommends sample.

    '! :-) MRainwater 27 Oct 2023 - Deep Link Implementation
    ' Found this code here: 
    ' https://stackoverflow.com/questions/47823142/how-to-implement-deep-linking-in-roku-videoplayer-sample-channel

    if args.contentId <> invalid AND args.mediaType <> invalid
        m.scene.contentDLId = args.contentId
        m.scene.mediaDPType = args.mediaType
        m.scene.deepLinkingLand = true
    end if
    
end sub
