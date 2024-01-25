---
title: Certificate in the connection information has expired when accessing an AVD VM
description: Helps resolve the error certificate in the connection information has expired when accessing an AVD VM by using the Remote Desktop client for Windows.
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
ms.date: 11/23/2023
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-nehaborkar, jasone, v-lianna
ms.custom: sap:setup, csstroubleshoot, ikb2lmc
ms.subservice: deployment
---
# Error "certificate in the connection information has expired" when accessing an AVD VM

This article helps resolve an issue in which you receive the "certificate in the connection information has expired" error when accessing an Azure Virtual Desktop (AVD) virtual machine (VM).

When you try to connect to an AVD VM by using the Remote Desktop client for Windows, you receive the following error message:

> We have blocked the connection because the certificate in the connection information has expired. Either refresh your Workspace or contact Support for help.  
  Error code: 0x1608  
  Extended error code: 0x0  
  Timestamp (UTC): \<DateTime\>  
  Activity ID: 00000000-0000-0000-0000-000000000000

This issue occurs when multiple users try to connect to the AVD VMs.

> [!NOTE]
> When the issue occurs, the trace log is saved in the *%temp%\\DiagOutputDir\\RdClientAutoTrace* folder.

## Reset and reinstall the Remote Desktop client for Windows

To fix this issue, follow these steps:

> [!NOTE]
> You can also use the `.\msrdcw.exe /reset /f` cmdlet to force a reset of the user data.

1.	Start the Remote Desktop client for Windows, select the three dots (…) at the top right corner, and then select Reset.

	:::image type="content" source="./media/error-certificate-connection-information-expired/remote-desktop-reset-user-data.png" alt-text="Screenshot of the Remote Desktop client with the Reset button which you can reset user data.":::

2.	Close and uninstall the client.
3.	Install [the latest version of the client](/azure/virtual-desktop/whats-new-client-windows).

For proper functionality, make sure that safe URLs are not subject to Secure Sockets Layer (SSL) inspection from the perspective of the Remote Desktop client. Also, verify that no blocking mechanisms are interfering with the safe URLs listed for the Remote Desktop client. If the above method doesn't work, try to disable or uninstall the antivirus software.
