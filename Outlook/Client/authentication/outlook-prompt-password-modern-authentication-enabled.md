---
title: Outlook prompts for password when Modern Authentication is enabled
description: Describes two scenarios in which Outlook prompts for credentials and doesn't use Modern Authentication to connect Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: bwittgen, carlossa
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Exchange Online
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook prompts for password and doesn't use Modern Authentication to connect to Microsoft 365

_Original KB number:_ &nbsp;3126599

## Symptoms

Consider the following scenarios.

**Scenario 1**:

Microsoft Outlook connects to your primary mailbox in an on-premises Exchange server by using RPC, and it also connects to another mailbox that's located in Microsoft 365.

**Scenario 2**:

You migrate your mailbox to Microsoft 365 from an Exchange server that Outlook connects to by using RPC.

In these scenarios, you're prompted for credentials, and Outlook doesn't use Modern Authentication to connect to Microsoft 365. After you enter your credentials, they're transmitted to Microsoft 365 instead of to a token.

## Cause

Outlook limits its choices of authentication schemes to schemes that are supported by RPC. But the authentication schemes don't include Modern Authentication.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

Create the following registry key to force Outlook to use a newer authentication method for web services, such as EWS and Autodiscover. We recommend that users force Outlook to use Modern Authentication.

1. Exit Outlook.
1. Start Registry Editor by using one of the following procedures, as appropriate for your version of Windows:

    - **Windows 10, Windows 8.1, and Windows 8**: Press Windows Key + R to open a **Run** dialog box. Type *regedit.exe*, and then press Enter.
    - **Windows 7**: Click **Start**, type *regedit.exe* in the search box, and then press Enter.

1. In Registry Editor, locate and click the following registry subkey:

    ```console
    HKEY_CURRENT_USER\Software\Microsoft\Exchange
    ```

1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
1. Type *AlwaysUseMSOAuthForAutoDiscover*, and then press Enter.
1. Right-click **AlwaysUseMSOAuthForAutoDiscover**, and then click **Modify**.
1. In the **Value data** box, type *1*, and then click **OK**.
1. Exit Registry Editor.

## More information

If you're running Office 2013, make sure that both Outlook and MSO are updated to the December 12, 2015 updates, or a later update release, before you use this registry key.

[3114349](https://support.microsoft.com/help/3114349) December 8, 2015, update for Outlook 2013 (KB3114349)

[3114333](https://support.microsoft.com/help/3114333) December 8, 2015, update for Office 2013 (KB3114333)

> [!NOTE]
> Office 2016 doesn't require an update for this registry key to work.

For more information about RPC, see [RPC over HTTP reaches end of support in Microsoft 365 on October 31, 2017](https://support.microsoft.com/help/3201590/rpc-over-http-reaches-end-of-support-in-office-365-on-october-31-2017).
