---
title: Exchange dialog doesn't include a Connection tab
description: Microsoft Exchange dialog does not include a Connection tab when the Exchange account is configured for MapiHttp in Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: abarglo
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2013
ms.date: 10/30/2023
---
# Microsoft Exchange dialog doesn't include a Connection tab in Outlook 2013

_Original KB number:_ &nbsp; 3000090

## Symptoms

Consider the following scenario:

- You are using Outlook 2013 Service Pack 1 (SP1).
- You are connected to an Exchange Server 2013 Service Pack 1 (SP1) mailbox.
- The Exchange 2013 mailbox and Client Access (CAS) servers that you connect to all have SP1 installed.
- The necessary server settings to establish MapiHttp connections are configured correctly.

In this scenario, the Exchange email account settings dialog box is changed, and the Microsoft Exchange dialog doesn't include a Connection tab. The location of this dialog box is **File** > **Account Settings** > **Account Settings** > **Settings**.

## Cause

When an account is enabled for MapiHTTP, it is expected that the Connection tab be removed.

## Resolution

If this tab must be temporarily re-enabled for troubleshooting, add a registry key by following these steps:

1. Exit Outlook if it is running.
1. Open **Registry Editor**.
   1. Open the **Run** box.
      - For Windows 8, press the Windows key + R.
      - For Windows 7 or Windows Vista, click **Start**, and then click **Run**.
   2. Type *Regedit.exe*, and then click **OK**.
1. Locate the `HKEY_CURRENT_USER\Software\Microsoft\Exchange` registry key.
1. Select the key that was specified in step 3, click the **Edit** menu, point to **New**, and then select **DWORD Value**.
1. Type `MapiHttpDisabled` as the name of the **DWORD Value**, and then press Enter.
1. Right-click `MapiHttpDisabled`, and then click **Modify**.
1. In the **Value data** box, type *1*, and then click **OK**.
1. Close **Registry Editor**.
1. Start Outlook.

## More information

We recommend that you remove this registry key as soon as testing is completed. This key should only be used for testing and is not a long term solution.
