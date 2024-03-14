---
title: Meeting conversation window disappears for C2R clients
description: Describes a workaround for users who experience a situation where the meeting conversation window in Skype for Business 2016 disappears in the middle of a meeting.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
ms.date: 03/31/2022
---

# Meeting conversation window disappears for Click-to-Run (C2R) clients in Skype for Business 2016

## Symptoms

In some situations, the meeting conversation window in Skype for Business 2016 disappears. These situations include the following: 
 
- Skype for Business 2016 Click-to-Run (C2R) is deployed and running the Monthly Channel update from January 3, 2019 (16.0.11126.20188), or a later version.   
- A Skype for Business conference has seven or more participants who are connected to the audio output, and the Gallery View is displayed.    
- When you hover over the small user icon on the second row and move the mouse away from the conversation window, the window disappears.    
- Audio remains connected.    
- The conversation window cannot be restored or located either by using Alt+Tab or by hovering over the Skype for Business icon in the taskbar.    

> [!NOTE]
> This may not be the only scenario in which this issue occurs. 

## Workaround

To work around this issue and restore the conversation window, follow these steps: 
 
1. Drag another application over the entire screen area that the Skype for Business conversation window occupied.

    > [!NOTE]
    > We recommend that you expand the application window to full screen.    
2. Double-click the name in the call control window that opens.    
 
> [!NOTE]
> This workaround may not work for the user who is sharing their screen. If this occurs, that user should exit and then restart Skype for Business 2016. 

## Resolution

This issue has been resolved in Office. If you are experiencing this issue, restart all open Office applications, or restart your computer.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
