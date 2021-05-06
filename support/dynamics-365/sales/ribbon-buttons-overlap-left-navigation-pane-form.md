---
title: Ribbon buttons overlap the left navigation pane of the form
description: This article provides a resolution for the problem where you may notice that ribbon buttons overlap the left navigation area within forms. 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Ribbon buttons overlap the left navigation pane of the form while working offline in the Microsoft Dynamics CRM 2011 for Outlook client

This article helps you resolve the problem where you may notice that ribbon buttons overlap the left navigation area within forms.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2792235

## Symptoms

While working offline in the Microsoft Dynamics CRM 2011 for Outlook client, users may notice that ribbon buttons overlap the left navigation area within forms.

## Cause

This is a known issue that will be addressed in a future product update.

This issue can occur if users have specified a different language in their personal options than that of the base language of the Microsoft Dynamics CRM server.

## Resolution

To access Microsoft Dynamics CRM Online through Outlook without this issue occurring in Offline mode, the user must configure the Microsoft Dynamics CRM for Outlook setup language to be the same as the current User Interface Language of Microsoft Dynamics CRM Online during the install of Microsoft Dynamics CRM for Outlook. Or the user can make the current User Interface Language the same as the base language of Microsoft Dynamics CRM Online.

If the current User Interface Language of Microsoft Dynamics CRM Online is not same as its base language:

1. While installing Microsoft Dynamics CRM for Outlook, select the setup language to be the same as the current User interface Language. This can be found in File, click Personal Options, and select Language tab when accessing Microsoft Dynamics CRM through the web interface.
2. Configure Microsoft Dynamics CRM Online for Outlook.
3. Go Offline.

If Microsoft Dynamics CRM for Outlook is already installed with the same language as the Microsoft Dynamics CRM Online base language:

1. Remove the configuration for the Microsoft Dynamics CRM for Outlook client.
2. Make the current User Interface Language the same as the base language of CRM Online through File, click Personal Options, and select Language tab.
3. Reconfigure Microsoft Dynamics CRM Online for Outlook.
4. Go offline.
