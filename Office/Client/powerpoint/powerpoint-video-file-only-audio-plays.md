---
title: Only audio plays when playing a video file in a presentation
description: Describes an issue in which only the audio is played when you play a video file in a PowerPoint slide presentation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft PowerPoint
---

# Only the audio plays when you play a video file in a PowerPoint slide presentation

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

You insert a video file, such as a .wmv file, an .mpeg file, or an .avi file, into a Microsoft PowerPoint slide presentation. When you play the video file, the video does not play. However, the audio plays as expected.

## Cause

This issue may occur if any one of the following conditions is true:

- The hardware acceleration setting of the display device is too high.
- The required codec is missing or damaged.
- Conflicting third-party video software is installed on the computer.
- The video acceleration of Windows Media Player is too high.

## Workaround

To work around this issue, use one of the following procedures, depending on your situation.

### The hardware acceleration setting of the display device is too high

To work around this issue, follow these steps:

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**.
2. Click the **Settings** tab, and then click **Advanced**.
3. Click the **Troubleshoot** tab, and then move the **Hardware acceleration** slider to **None**.
4. Click **Apply**, and then click **OK** two times.
5. If the issue is resolved after you move the **Hardware acceleration** slider to **None**, contact the manufacturer of the graphics adaptor driver to determine whether there is an upgrade that addresses this specific issue.

### The required codec is missing or damaged

To work around this issue, perform one of the following actions:

- If the issue occurs when you use a .wmv file, download or reinstall the current version of Windows Media Player. If you are using an earlier version of Windows Media Player, upgrade it to the current version of Windows Media Player for your operating system.
- If the issue occurs when you use another video file format, such as an .mpeg file or an .avi file, download or reinstall the appropriate third-party codec. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

  [926373](https://support.microsoft.com/help/926373) You receive a codec error message, or audio plays but video does not play when you play media files in Windows Media Player 11

### Conflicting third-party video software is installed

To work around this issue, remove the conflicting third-party video software from the computer. This software may be shareware or other software utilities that the Original Equipment Manufacturer (OEM) installed on the computer.

### Reduce video acceleration for Microsoft Windows Media Player 9.0

To work around this issue, follow these steps:

1. On the **Tools** menu, click **Options**.
2. Click the **Performance** tab.
3. Click **Advanced**.
4. Click to remove the **Use overlays** check box.
5. Click **OK** two times.

### Reduce video acceleration for Microsoft Windows Media Player 10.0 or a later version

To work around this issue, follow these steps:

1. Click **Plug-ins**, and then click **Options**.
2. Click the **Performance** tab.
3. Click **Advanced**.
4. Click to remove the **Use overlays** check box.
5. Click **OK**.
6. Click **Yes** when you receive the following prompt:

   If you are currently playing or paused, this change might result in restarting the media from the beginning. Do you want to apply the new settings?

## More Information

For more information about how Microsoft Office PowerPoint 2003 plays multimedia files in a presentation, visit the following Microsoft Web site:

[How PowerPoint 2003 Plays Multimedia Files in a Presentation](httpS://msdn2.microsoft.com/library/aa168133%28office.11%29.aspx)