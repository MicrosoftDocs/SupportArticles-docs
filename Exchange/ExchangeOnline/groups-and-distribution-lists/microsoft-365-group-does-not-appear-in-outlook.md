---
title: Microsoft 365 group missing in Outlook and Outlook on the Web
description: Learn how to fix a Microsoft 365 group or calendar that doesn't appear in Outlook or Outlook on the web by checking membership, visibility, and settings.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online, Outlook on the web, Outlook for Microsoft 365, New Outlook for Windows, Classic Outlook for Windows.
  - CSSTroubleshoot
  - CI 4150
ms.reviewer: batre, meerak, v-shorestris, v-kccross
appliesto:
  - Exchange Online
  - Outlook for Microsoft 365
  - New Outlook for Windows
  - Classic Outlook for Windows
  - Outlook on the web
search.appverid: MET150
ms.date: 08/18/2026
---

# Microsoft 365 group doesn't appear in Outlook or Outlook on the web

## Summary

A Microsoft 365 group or its calendar might not appear in Outlook, Outlook on the web, or the Groups hub even though the group exists. This issue can occur if the user isn't a member of the group, the group is hidden from Outlook clients, the user is accessing a shared mailbox, or Outlook is configured in a way that doesn't support the Groups experience. This article provides steps to verify group membership, check group visibility settings, and confirm Outlook configuration so that users can access the group and its calendar.

## Symptoms

A member of a [Microsoft 365 group](https://support.microsoft.com/Outlook/people/learn-about-groups-in-outlook) reports any of the following symptoms in Microsoft Outlook or Outlook on the web:

- The group isn't listed under the **Groups** folder.
- The group isn't listed on the [Groups Home](https://support.microsoft.com/Outlook/people/the-new-microsoft-365-groups-experience-in-outlook) page.
- The group Calendar is missing.

- The "Go to Groups" or Groups hub itself isn't visible.

The issue applies to:

- Microsoft 365 groups that users create
- Microsoft 365 groups that are associated with Microsoft Teams

## Resolution

To fix the issue, verify the following settings:

- Ensure that the user is a member of the Microsoft 365 group:

   1. In the [Exchange admin center](https://admin.exchange.microsoft.com) (EAC), select **Groups**, and then select the group name to open a pane that shows group details.

   1. In the group details pane, check the **Members** tab to see if the user is listed. If the user isn't listed, add the user as a group member.

      To view a group in Outlook or Outlook on the web, users must be mailbox-enabled and in the same tenant as the group. External (guest) users don't meet that criteria. For information about how guests can interact with Microsoft 365 groups, see [Use Groups in Outlook as a guest](https://support.microsoft.com/Outlook/people/use-groups-in-outlook-as-a-guest).

- If the **Go to Groups** or Groups hub itself isn't visible:

  - Ensure that the mailbox isn't a shared mailbox. For more information, see [Microsoft 365 groups not visible from shared mailbox](/troubleshoot/exchange/user-and-shared-mailboxes/office-365-groups-not-visible-from-shared-mail).
  
  - For classic Outlook, ensure that the user's Outlook profile is set to [Cached Exchange Mode](https://support.microsoft.com/Outlook/turn-on-cached-exchange-mode) instead of Online mode.

- Ensure that the Microsoft 365 group isn't hidden from Outlook clients and the global address list (GAL). To do this, complete the following steps:

  1. Using a work or school account that has sufficient permissions in your organization, such as Exchange Administrator, start a Windows PowerShell session and connect to Exchange Online. For instructions, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

  1. To get the value of the [HiddenFromExchangeClientsEnabled](/powershell/module/exchange/set-unifiedgroup#-hiddenfromexchangeclientsenabled) parameter, run the [Get-UnifiedGroup](/powershell/module/exchange/get-unifiedgroup) PowerShell cmdlet as shown in the following example:
  
     ```PowerShell
     Get-UnifiedGroup -Identity <group name> | FL HiddenFromExchangeClientsEnabled
     ```

  1. If the value of the **HiddenFromExchangeClientsEnabled** parameter is `True`, unhide the group by running the [Set-UnifiedGroup](/powershell/module/exchange/set-unifiedgroup) PowerShell cmdlet as shown in the following example:
  
     ```PowerShell
     Set-UnifiedGroup -Identity <group name> -HiddenFromExchangeClientsEnabled:$false
     ```

The user should now be able to access the group and its calendar in both Outlook and Outlook on the web.
