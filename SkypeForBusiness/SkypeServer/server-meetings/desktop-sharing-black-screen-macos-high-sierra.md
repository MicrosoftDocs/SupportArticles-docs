---
title: Black screen during desktop sharing in Skype for Business on macOS High Sierra
description: Discusses that you see a black screen during desktop sharing in Skype for Business or Lync Web App on macOS High Sierra. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Skype for Business Web App
  - Lync Web App
ms.date: 03/31/2022
---

# Black screen during desktop sharing in Skype for Business or Lync Web App on macOS High Sierra

## Symptoms

Consider the following scenario. 
 
- You join an online meeting by using the Skype for Business Web App or Lync Web App on macOS High Sierra 10.13 (including beta versions).    
- Someone in the online meeting shares their desktop.    
 
In this scenario, you see only a black screen instead of the shared desktop. 

This problem occurs when the meeting is hosted in Skype for Business Server 2015 or Lync Server 2013. This problem doesn't occur if the meeting is hosted in Skype for Business Online. 

## Workaround

### Skype for Business Web App

To work around this issue for Skype for Business Web App, use the Skype Meetings App instead. To do this, the system administrator must follow these steps: 
 
1. Install [the May 2017 update for Skype for Business Server 2015](https://support.microsoft.com/help/3061064/updates-for-skype-for-business-server-2015).    
2. Enable the Skype Meetings App by following the instructions in the "Enable Skype Meetings App" section of [Deploy Web downloadable clients in Skype for Business Server 2015](/skypeforbusiness/deploy/deploy-clients/deploy-web-downloadable-clients).    
 
After these steps are done, web app users will automatically use the Skype Meetings App when they join a meeting.

### Lync Web App

There is no workaround yet for this problem for Lync Web App. 

## Status

Microsoft is working closely with Apple to resolve this problem.

## More information

This issue can also occur when the camera isn't granted access permission to Skype for Business. 

1. Select Apple menu > **System Preferences**, select **Security & Privacy**, and then **Privacy**.
2. Grant Skype for Business access to the camera. You will be prompted to restart Skype for Business.  
3. Check if the issue is resolved after the restart.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).