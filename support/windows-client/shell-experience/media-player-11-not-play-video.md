---
title: Video doesn't play in Windows Media Player 11
description: Describes error messages and other problems that occur in Windows Media Player when you try to play an audio file or a video file. A resolution is provided.
ms.date: 09/22/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, bchee
ms.prod-support-area-path: Windows Media Player
ms.technology: windows-client-shell-experience
---
# You receive a codec error message, or audio plays but video doesn't play when you play media files in Windows Media Player 11

This article provides a solution to an issue where the video doesn't play when you play it in Windows Media Player 11.

_Original product version:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 926373

## Symptoms

When you try to play a video file in Windows Media Player 11, the video does not play. However, the audio plays.

Additionally, when you try to play an audio file or a video file in Windows Media Player 11, you may receive an error message that resembles one of the following error messages:

> Windows Media Player cannot play the file because the required video codec is not installed on your computer.

> Windows Media Player cannot play, burn, rip, or sync the file because a required audio codec is not installed on your computer.

> A codec is required to play this file. To determine if this codec is available to download from the Web, click Web Help.

> Invalid File Format.

## Cause

This problem occurs if a codec that is required to play the file is not installed on the computer.

## Resolution

To resolve this problem, configure Windows Media Player to download codecs automatically. To do this, follow these steps in Windows Media Player 11:

1. On the **Tools** menu, click **Options**.
2. Click the **Player** tab, click to select the **Download codecs automatically** check box, and then click **OK**.
3. Try to play the file.

If you are prompted to install the codec, click **Install**. If you still cannot play the file correctly, try the steps in the **Advanced troubleshooting** section. If you are not comfortable with advanced troubleshooting, you might want to ask someone for help or contact support. For information about how contact support, contact [Microsoft Support][https://support.microsoft.com/contactus/] 

### Advanced troubleshooting

The following steps are intended for advanced computer users.

Obtain and install the codec. To do this, follow these steps in Windows Media Player 11:

1. Determine whether the codec is installed on the computer that you are using to play the file. To do this, follow these steps:

    1. In the **Now Playing** area, right-click the file that you are trying to play, and then click **Properties**.
    2. Click the **File** tab, note the codecs that are specified in the **Audio codec** and the **Video codec** areas, and then click **OK**. If the following conditions are true, go to step 2.
        - No audio codec is specified.
        - No video codec is specified.
    3. On the **Help** menu, click **About Windows Media Player**.
    4. Click the **Technical Support Information** hyperlink.
    5. If you are trying to play an audio file, determine whether the audio codec that you noted in step 1b is listed in the **Audio Codecs** area. If you are trying to play a video file, determine whether the video codec or the audio codec that you noted in step 1b is listed in the **Video Codecs** area. If the codec is not listed, go to step 2.
    6. Try to reinstall the codec. If you cannot reinstall the codec, go to step 2.
    7. Try to play the file. If you can play the file, skip steps 2 and 3.

2. Install the codec. To do this, follow these steps:

    1. If you receive an error message when you try to play the file, click **Web Help**. If you do not receive an error message when you try to play the file, go to step 3.
    2. On the Microsoft Web site, click the link to the Wmplugins Web site.

    3. Follow the instructions on the Web site to download and install the codec for the file. If the Web site does not automatically find a codec for the file, and if either of the following conditions is true, go to step 3:
          - You did not note a codec in step 1b.
          - You cannot find the codec that you noted in step 1b on the Web site.
    4. Try to play the file. If you can play the file, skip step 3.

3. Obtain the codec from a third-party vendor.

> [!NOTE]
> If you are using Windows Media Player in an environment that is managed by a network administrator, you may have to contact the network administrator to download and install the codec.

## More information

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
