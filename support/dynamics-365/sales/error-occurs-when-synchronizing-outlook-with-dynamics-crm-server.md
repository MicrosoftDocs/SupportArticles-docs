---
title: Cannot synchronize Outlook with Dynamics CRM server
description: Describes an error message that occurs when you try to synchronize Microsoft Office Outlook with the Microsoft Dynamics CRM server.
ms.reviewer: jbsimon
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Error occurs when synchronizing Microsoft Office Outlook with the Microsoft Dynamics CRM server

This article provides a resolution for the issue that you can't synchronize Microsoft Office Outlook with the Microsoft Dynamics CRM client for Outlook due to the **You already have Microsoft CRM Client for Outlook installed on another computer** error.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 953774

## Symptoms

You install the Microsoft Dynamics CRM client for Microsoft Office Outlook by using load balancing and a roaming profile. Then, you connect the client to a server and define it as a synchronizing client. Next, you connect the client to another server as the same user. When you try to synchronize Outlook with the Microsoft Dynamics CRM client for Outlook, you receive the following error message:

> You already have Microsoft CRM Client for Outlook installed on another computer. Only one client computer per user can run the automatic process that does bulk updates of Outlook items with Mic. CRM data. This client should be the computer that is most often online (such as a desktop computer) or the user's primary computer. To change the Synchronizing client, on the CRM menu, click Options, and click the synchronizing tab.

## Cause

This problem occurs because the `HKEY_CURRENT_USER (HKCU)` registry key is not copied properly when you connect to a new server in a roaming profile scenario.

The synchronizing client is determined by the `outlooksyncsubscriptionid` registry entry and the `outlooksyncclientid` registry entry. If the registry entries are not present in the `HKCU` registry key, the client is not considered as a synchronizing client.

## Resolution

To resolve this problem, follow these steps:

1. Check whether the `outlooksyncsubscriptionid` registry entry and the `outlooksyncclientid` register entry are present in the `HKCU\software\microsoft\mscrmclient` registry key when you connect to a new server.
2. If the registry entries are not in the `HKCU\software\microsoft\mscrmclient` register key, check whether any of the following Group Policy object (GPO) settings are enabled.
   - Prevent Roaming Profile changes from propagating to the server
   - Only allow local user profiles
3. If the GPO settings are enabled, then disable them.
