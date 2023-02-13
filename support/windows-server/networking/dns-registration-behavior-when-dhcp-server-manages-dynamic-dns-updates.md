---
title: DNS record registration behavior when the DHCP server manages dynamic DNS updates
description: Describes a change in Windows 8.1 and later versions that may cause unexpected behavior when the DHCP server configuration is "Always dynamically update DNS records."
ms.date: 2/14/2023
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: <upper-level folder>
localization_priority: medium
ms.reviewer: kaushika
ms.custom: <sap/see CI>
ms.technology: <subfolder>
keywords: DNS dynamic updates, DHCP option 81, client FQDN option, DHCP client
---

# DNS record registration behavior when the DHCP server is set to "Always dynamically update DNS records"

_Applies to:_ &nbsp; Windows 11, Windows 10, Windows 8.1

## Symptoms

You have an infrastructure that uses Windows Dynamic Host Configuration Protocol (DHCP) clients and Microsoft DHCP servers to assign and manage IP addresses. On the DHCP server, you've selected **Enable DNS dynamic updates according to the settings below** and **Always dynamically update DNS records**. In this configuration, you expect the DHCP server to manage dynamic DNS updates for A records and PTR records. However, you observe that both the client and the server create DNS records. Depending on your configuration, this behavior has the following effects:

- If you've configured the DNS zones for **Nonsecure and secure** dynamic updates, you see the DHCP server create records, and then the DHCP client deletes and recreates the same records.
- If you've configured the DNS zones for **Secure only** dynamic updates, DNS records might become inconsistent. Both the DHCP server and the DHCP client create records, but the DHCP server cannot update records that the DHCP client created. Conversely, the DHCP client cannot update records that the DHCP server created.

## Cause

To obtain an IP address, the DHCP client sends a DHCP Request message to the DHCP server. Typically, this message includes the client's fully qualified domain name (FQDN) and flags that govern dynamic DNS update behavior. This information is collectively named _Option 81_ (also known as the _Client FQDN option_).

> [!NOTE]  
> Some older DHCP clients do not use Option 81. To provide dynamic updates for these clients, configure the DHCP server to enable the **Dynamically update DNS records for DHCP clients that do not request updates (for example, clients running Windows NT 4.0)** option.

The DHCP server also stores a set of Option 81 flags that govern dynamic DNS update behavior. Part of the DHCP DORA (Discover/Offer/Request/Acknowledge) process involves the client and the server comparing their values of the Option 81 flags to determine who is responsible for DNS updates. The flags that are involved in the behavior that's described in the [Symptoms](#symptoms) section are called the **O** (override) and **S** (server) bits:

- If **S** = **0**, the client is responsible for updating A records
- If **S** = **1**, the server is responsible for updating A records
- If the **S** value that the client sends in its request differs from the server's **S** value, the server sets its **O** value to **1**.

As described in the RFC, the DHCP server's reply to the request message should include its flag values. If **O** is set to **1** in the server's message, the client should understand that the server is overriding the client's **S** value.

A deliberate design change was introduced in Windows 8.1 onward to the DHCP client's dynamic DNS update behavior. This change supports continued development and enhancements of the TCP/IP (Transmission Control Protocol/Internet Protocol) stack in later releases of Microsoft operating systems. In Windows 8.1 and later versions, the DHCP client doesn't honor the DHCP server's Option 81 **O** and **S** values. If the client is configured to update A records, it continues to do so even when the server is also configured to update A records. This is the case when you select **Always dynamically update DNS records** in the DHCP management console.

If you've configured your DNS zones for **Secure only** dynamic updates, then only the entity (the DHCP client, DHCP server, or an account that the DHCP services are configured to use) that created a DNS record can update or delete that record. If the DHCP client creates a DNS record instead of the DHCP server, the DHCP server can't modify that record later.

> [!NOTE]  
> Microsoft's DHCP client doesn't provide a way to directly set the client's **O** and **S** values in the user interface. By default, both values are **0**. You can view the values by recording a [netsh trace](previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd878498(v=ws.10).md) of a DHCP client request, and using a utility such as Netmon to view the results.
>  
> You can use the Windows PowerShell [Get-DhcpServerv4OptionValue](/powershell/module/dhcpserver/get-dhcpserverv4optionvalue.md) cmdlet to view the DHCP server's Option 81 value. However, the cmdlet reports this value as a single integer that combines several different settings as bit values. For example, selecting **Always dynamically update DNS records** on the **DNS** tab of a DHCP scope's properties sets the **S** value to **1**. However, the cmdlet reports one of eight possible values for Option 81 (all of which use **S**=**1**). The specific value depends on the combination of settings on the **DNS** tab.

For more information about how dynamic updates work between the DHCP client, the DHCP server, and the DNS server, see [DNS Processes and Interactions](previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd197552(v=ws.10).md)

## Resolution

If your architecture requires that you use **Always dynamically update DNS records**, you can use a registry key on the client computer to force the DHCP client to honor the DHCP server override.

[!INCLUDE [Registry](../../support/includes/registry-important-alert.md)]

1. Navigate to the following subkey:
   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters`

1. Under the subkey, create the following entry:
   - Name: **RegistrationOverwrite**
   - Type: **REG_DWORD**
   - Value: **2**
   > [!NOTE]  
   > **RegistrationOverwrite** has the following possible values:
   >
   > - **0** - No overwrite.
   > - **1** - Records that the DNS client creates overwrite records that the DHCP server creates. This is the default value.
   > - **2** - Records that the DHCP server creates overwrite records that the DNS client creates).  

1. Restart the client computer.

1. In the DNS server management console, check the forward and reverse lookup zones. Depending on your specific environment, you may have to manually delete A and PTR records that the DHCP server does not have permission to delete or change.
