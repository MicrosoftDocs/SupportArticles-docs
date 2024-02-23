---
title: Outlook doesn't connect using MAPI over HTTP as expected
description: Describes an issue in which Outlook for Microsoft 365 doesn't connect Exchange using MAPI over HTTP as expected.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, aruiz
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Service Pack 1
  - Outlook 2016
  - Microsoft Outlook 2013 Service Pack 1
  - Outlook 2019
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook 2010, 2013, 2016, or Outlook for Microsoft 365 doesn't connect Exchange using MAPI over HTTP as expected

_Original KB number:_ &nbsp;2937684

## Symptoms

Consider the following scenario:

- You're using Microsoft Outlook 2010, Outlook 2013 Service Pack 1 (SP1), or a later version.
- You're connected to a Microsoft Exchange Server 2013 SP1 or Exchange Server 2016 mailbox.
- The Exchange mailbox and Client Access (CAS) servers that you're connecting to all have Exchange Server 2013 SP1 or a later version installed or Exchange Server 2016.
- The necessary server settings to establish MapiHttp connections are correctly configured.

In the above scenario, the **Protocol** column in the **Outlook Connection Status** dialog shows Outlook 2013 is connected to the Exchange server using a connection mechanism other than MAPI/HTTP. For example, the following figure shows a connection using RPC/HTTP.

:::image type="content" source="./media/outlook-not-connect-exchange-use-mapi-over-http/rpc-http-protocol.png" alt-text="Screenshot of Outlook connection status dialog, which shows the Protocol column as RPC/HTTP.":::

> [!NOTE]
> MAPI/HTTP connections are designated in the **Protocol** column using the string **HTTP**.

Additionally, if MAPI/HTTP is disabled, Microsoft 365 users receive a Basic Authentication prompt instead of a Modern Authentication prompt.

## Cause

This problem can occur if the MapiHttp feature is disabled on the Outlook client using the following registry value:

```console
Key: HKEY_CURRENT_USER\Software\Microsoft\Exchange
DWORD: MapiHttpDisabled
Value: 1
```

## Resolution

To resolve this problem, change the value of **MapiHttpDisabled** to *0*  (zero) or delete the **MapiHttpDisabled** DWORD value. This registry data is intended for testing purposes only.

1. Exit Outlook.
1. Open Registry Editor by using one of the following procedures, as appropriate for your version of Windows:
    - **Windows 10, Windows 8.1, and Windows 8**: Press Windows Key + R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
    - **Windows 7**: Click Start, type *regedit.exe* in the search box, and then press **Enter**.
1. Locate and select the following key in the registry:

    ```console
    HKEY_CURRENT_USER\Software\Microsoft\Exchange
    ```

1. Right-click **MapiHttpDisabled** and then click **Modify**.
1. Change the **Value data** to *0* and then click **OK**.
1. Close Registry Editor.
1. Start Outlook.

## More information

For more information about the requirements for MAPI over HTTP connections, see [MAPI over HTTP](https://technet.microsoft.com/library/dn635177%28v=exchg.150%29.aspx).
