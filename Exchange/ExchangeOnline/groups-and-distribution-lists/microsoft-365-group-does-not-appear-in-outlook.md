---
title: Microsoft 365 Group Doesn't Appear in Outlook or Outlook on the Web
description: Provides a resolution for an issue in which a Microsoft 365 group or its calendar doesn't appear in Outlook or Outlook on the web.
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
ms.reviewer: batre, meerak, v-shorestris
appliesto:
  - Exchange Online
  - Outlook for Microsoft 365
  - New Outlook for Windows
  - Classic Outlook for Windows
  - Outlook on the web
search.appverid: MET150
ms.date: 03/10/2025
---

# Microsoft 365 group doesn't appear in Outlook or Outlook on the web

## Symptoms

A member of a [Microsoft 365 group](https://support.microsoft.com/office/learn-about-groups-in-outlook-b565caa1-5c40-40ef-9915-60fdb2d97fa2) reports any of the following symptoms in Microsoft Outlook or Outlook on the web:

- The group isn't listed under the **Groups** folder.
- The group isn't listed on the [Groups Home](https://support.microsoft.com/office/the-new-microsoft-365-groups-experience-in-outlook-a86bf173-7e7f-4c9c-b769-eab0aad4a541) page.
- The group Calendar is missing.

The issue applies to:

- Microsoft 365 groups that users create
- Microsoft 365 groups that are associated with Microsoft Teams

## Resolution

To fix the issue, verify the following settings:

- Make sure that the user is a member of the Microsoft 365 group:

   1. In the [Exchange admin center](https://admin.exchange.microsoft.com) (EAC), select **Groups**, and then select the group name to open a pane that shows group details.

   2. In the pane, check the **Members** tab to see whether the user is listed. If the user isn't listed, add the user as a group member.

   > [!NOTE]
   > To view a group in Outlook or Outlook on the web, users must be mailbox-enabled and in the same tenant as the group. External (guest) users don't meet that criteria. For information about how guests can interact with Microsoft 365 groups, see [Use Groups in Outlook as a guest](https://support.microsoft.com/office/use-groups-in-outlook-as-a-guest-1f4aa594-d81f-4294-b1b3-49982062cc82).

- Make sure that the Microsoft 365 group isn't hidden from Outlook clients and the global address list (GAL):

   1. Run the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to get the value of the [HiddenFromExchangeClientsEnabled](/powershell/module/exchange/set-unifiedgroup#-hiddenfromexchangeclientsenabled) parameter:

       ```PowerShell
       Get-UnifiedGroup -Identity <group name> | FL HiddenFromExchangeClientsEnabled
       ```

   2. If the value of the **HiddenFromExchangeClientsEnabled** parameter is `True`, run the following PowerShell cmdlet to unhide the group:

       ```PowerShell
       Set-UnifiedGroup -Identity <group name> -HiddenFromExchangeClientsEnabled:$false
       ```

- For classic Outlook, make sure that the user's Outlook profile is set to  [Cached Exchange Mode](https://support.microsoft.com/office/turn-on-cached-exchange-mode-7885af08-9a60-4ec3-850a-e221c1ed0c1c) instead of Online mode.

The user should now be able to access the group and its calendar in both Outlook and Outlook on the web.
