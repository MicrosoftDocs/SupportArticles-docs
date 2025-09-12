---
title: DNS query failed when email stuck in Draft
description: Email messages are stuck in the Draft folder if the Register this connection's addresses in DNS check box is not selected. DNS query failed error occurs in this scenario. Provides resolutions to solve the problem.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: ajama, navesai, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# DNS query failed error when an email message is stuck in the Draft folder in Exchange Server 2013

_Original KB number:_ &nbsp; 3007623

## Symptoms

Assume that you have a computer that is a member of an Exchange Server 2016 or Exchange Server 2013 environment. You do not have the **Register this connection's addresses in DNS** check box selected on the DNS tab of the **Advanced TCP/IP Settings** dialog box of TCP/IPv4. In this situation, email messages remain stuck in the Drafts folder.

Additionally, when you check the transport queue, you see an error message that resembles the following:

> 4.4.0 DNS query failed. The error was: DNS query failed with error ErrorRetry.

## Cause

This issue occurs because the DNS service cannot be used if the **Register this connection's addresses in DNS** check box is not selected in an Exchange Server 2016 or Exchange Server 2013 environment.

## Resolution - Method 1: Select the Register this connection's addresses in DNS check box

On your computer, select the **Register this connection's addresses in DNS** check box on the **DNS** tab of the **Advanced TCP/IP Settings** dialog box of TCP/IPv4.

## Resolution - Method 2: Enable the DNS service by using a registry key

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Select **Start**, select **Run**, type **regedit** in the **Open** box, and then select **OK**.
2. Locate and then select the following registry subkey:  
   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netbt\Parameters`
3. On the **Edit** menu, point to **New**, and then select **DWORD (32-bit) Value**.
4. Type **EnableDNS**, and then press Enter.
5. In the **Details** pane, right-click **EnableDNS**, and then select **Modify**.
6. In the **Value data** box, type *1*, and then select **OK**.
7. Exit Registry Editor.
8. Restart the Microsoft Exchange Transport service.
