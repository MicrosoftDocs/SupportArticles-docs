---
title: Video doesn't play in Windows Media Player 11
description: Describes error messages and other problems that occur in Windows Media Player when you try to play an audio file or a video file. A resolution is provided.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bchee
ms.custom: sap:windows-media-player, csstroubleshoot
---
# You receive a codec error message, or audio plays but video doesn't play when you play media files in Windows Media Player 11

This article provides a solution to an issue where the video doesn't play when you play it in Windows Media Player 11.

_Applies to:_ &nbsp; Windows Media Player 11  
_Original KB number:_ &nbsp; 926373

## Symptoms

When you try to play a video file in Windows Media Player 11, the video doesn't play. However, the audio plays.

Additionally, when you try to play an audio file or a video file in Windows Media Player 11, you may receive an error message that resembles one of the following error messages:

> Windows Media Player cannot play the file because the required video codec is not installed on your computer.

> Windows Media Player cannot play, burn, rip, or sync the file because a required audio codec is not installed on your computer.

> A codec is required to play this file. To determine if this codec is available to download from the Web, click Web Help.

> Invalid File Format.

## Cause

This problem occurs if a codec that's required to play the file isn't installed on the computer.

## Resolution

To resolve this problem, configure Windows Media Player to download codecs automatically. To do so, follow these steps in Windows Media Player 11:

1. On the **Tools** menu, select **Options**.
2. Select the **Player** tab, select the **Download codecs automatically** check box, and then select **OK**.
3. Try to play the file.

If you're prompted to install the codec, select **Install**. If you still can't play the file correctly, try the steps in the **Advanced troubleshooting** section. If you aren't comfortable with advanced troubleshooting, ask someone for help, or contact [Microsoft Support](https://support.microsoft.com/contactus/).

### Advanced troubleshooting

The following steps are intended for advanced computer users.

Obtain and install the codec by following these steps in Windows Media Player 11:

1. Determine whether the codec is installed on the computer that you are using to play the file. To do so, follow these steps:

    1. In the **Now Playing** area, right-click the file that you try to play, and then select **Properties**.
    2. Select the **File** tab, note the codecs that are specified in the **Audio codec** and the **Video codec** areas, and then select **OK**. If the following conditions are true, go to step 2.
        - No audio codec is specified.
        - No video codec is specified.
    3. On the **Help** menu, select **About Windows Media Player**.
    4. Select the **Technical Support Information** hyperlink.
    5. If you're trying to play an audio file, determine whether the audio codec that you noted in step 1b is listed in the **Audio Codecs** area. If you are trying to play a video file, determine whether the video codec or the audio codec that you noted in step 1b is listed in the **Video Codecs** area. If the codec isn't listed, go to step 2.
    6. Try to reinstall the codec. If you can't reinstall the codec, go to step 2.
    7. Try to play the file. If you can play the file, skip steps 2 and 3.

2. Install the codec by following these steps:

    1. If you receive an error message when you try to play the file, select **Web Help**. If you don't receive an error message when you try to play the file, go to step 3.
    2. On the Microsoft Web site, select the link to the Wmplugins Web site.

    3. Follow the instructions on the Web site to download and install the codec for the file. If the Web site doesn't automatically find a codec for the file, and if either of the following conditions is true, go to step 3:
          - You didn't note a codec in step 1b.
          - You can't find the codec that you noted in step 1b on the Web site.
    4. Try to play the file. If you can play the file, skip step 3.

3. Obtain the codec from a third-party vendor.

> [!NOTE]
> If you are using Windows Media Player in an environment that is managed by a network administrator, you may have to contact the network administrator to download and install the codec.

## More information

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft doesn't specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article doesn't describe. Because Microsoft must respond to changing market conditions, this information shouldn't be interpreted to be a commitment by Microsoft. Microsoft can't guarantee or endorse the accuracy of any information or of any solution that's presented by Microsoft, or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but aren't limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
