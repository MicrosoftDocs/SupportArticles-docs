---
title: Dialog box not including Connection tab
description: Describes an issue that prevents the Connection tab from being displayed in an Exchange Server dialog box in Outlook 2010. Troubleshooting steps and a workaround are provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: abarglo, aruiz
appliesto: 
  - Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Exchange Server dialog box does not include a Connection tab in Outlook 2010

_Original KB number:_ &nbsp; 3050278

## Summary

Consider the following scenario:

- You are using Outlook 2010.
- You have the January 8, 2015, update for Outlook 2010 (KB2878264) installed.
- You are connected to a Microsoft Exchange Server 2013 Service Pack 1 (SP1) mailbox.
- The Exchange 2013 mailbox and Client Access Server (CAS) servers that you connect to all have SP1 installed.
- The server settings for establishing MapiHttp connections are configured correctly.

In this scenario, you discover that the Exchange email account settings dialog box does not include a **Connection** tab. This dialog box is located along the path: **File** > **Account Settings** > **Account Settings** > **Settings**.

## More information

When an account is enabled for MapiHTTP, the **Connection** tab is removed.

If you disable MapiHTTP, the **Connection** tab reappears. Outlook then connects by using RCP/HTTP. To disable MapiHTTP through the system registry, follow these steps:

1. Exit Outlook if it is running.
2. Open Registry Editor:
   1. Open the **Run** box:
      - For Windows 8, press the Windows key+R.
      - For Windows 7 or Windows Vista, select **Start**, and then select **Run**.
   2. Type *regedit.exe*, and then select **OK**.
3. Locate the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Exchange`

4. Select this subkey, point to **New** on the **Edit** menu, and then select **DWORD Value**.
5. Type *MapiHttpDisabled* for the **DWORD Value** name, and then press Enter.
6. Right-click MapiHttpDisabled, and then select **Modify**.
7. In the **Value data** box, type *1*, and then select **OK**.
8. Close Registry Editor.
9. Start Outlook.
10. Restart Outlook.

> [!IMPORTANT]
> We recommend that you remove this registry value as soon as testing is completed. This value should be used only for testing and is not a long-term solution. Any information that's displayed on the **Connection** tab is not related to MapiHttp, because MapiHttp is disabled.
