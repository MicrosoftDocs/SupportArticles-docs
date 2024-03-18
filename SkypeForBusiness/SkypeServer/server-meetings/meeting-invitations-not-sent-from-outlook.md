---
title: Meeting invitations are not sent from Outlook in Skype for Business
description: Discusses a problem in which meeting invitations are not sent from Outlook in Skype for Business. Provides a workaround.
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
  - Skype for Business
ms.date: 03/31/2022
---

# Meeting invitations are not sent from Outlook in Skype for Business

## Symptoms

Consider the following scenario:

- You're on a computer that has Microsoft Outlook 2010 or Outlook 2013 and Microsoft Skype for Business installed.   
- The Skype for Business client has [the March 8, 2016 update](https://support.microsoft.com/help/3114831) applied.   
- You have the **Use Auto-Complete list to suggest names when typing in the To, Cc and Bcc lines** option enabled in Outlook.   
- You create an online meeting, and then you select the meeting recipients from cache instead of the global address list (GAL).   
- You select the **send** option to send a meeting invitation.   

In this scenario, you receive the following error message:

**The request failed. Please try again. Make sure that you are signed in to Skype for Business.**

## Cause

This problem occurs because of a known issue in the KB 3114831 version of UCAddin.dll (a Skype for Business plug-in for Outlook).

## Resolution

To fix this problem, install the [June 7, 2016 update (KB3115033)](https://support.microsoft.com/help/3115033) for Microsoft Lync 2013 (Skype for Business).

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To work around this problem, clear the Auto-Complete cache. To do this, use one of the following methods.

### Method 1

Change the manner in which the Skype for Business Add-in for Outlook (UCAddin.dll) resolves recipients for meetings. To do this, create the following registry key:

**Subkey location:** HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Lync\AddinPreference

**DWord name:** RecipientResolutionMode

**Value data (decimal):** 2

### Method 2

Follow these steps:   

1. Open **Outlook Options**.   
2. On the **Mail** tab, locate the **Send messages** section.   
3. Clear the **Use Auto-Complete List to suggest names when typing in the To, CC, and Bcc lines** check box. The, click the **Empty Auto-Complete List** button.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
