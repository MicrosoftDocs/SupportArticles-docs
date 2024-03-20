---
title: Windows VM activation no longer works in Azure
description: Resolve an issue (two new Key Management Services (KMS) IP addresses) that causes Windows Virtual Machine activation to stop working successfully in Azure.
ms.date: 04/04/2023
editor: v-jsitser
ms.reviewer: meijin, danielli, scotro, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-windows-activation
---
# Windows Virtual Machine activation no longer works in Azure

This article discusses important changes that were made to Key Management Services (KMS) IP addresses that cause problems for Microsoft Windows virtual machine (VM) activation in Windows Azure. These changes affect Azure Global cloud users who configured custom routes or firewall rules to allow KMS IP addresses and who were previously able to activate Windows VMs successfully.

## Overview

#### Who's affected

In July 2022, we announced in an Azure update that two new KMS IP addresses, `20.118.99.224` and `40.83.235.53`, are now [Generally available: New KMS DNS in Azure Global cloud](https://azure.microsoft.com/updates/new-kms-dns-in-azure-global-cloud/). Most Windows VM users on Azure aren't affected. However, you must take actions to include these two new KMS IP addresses if, in the past, you followed troubleshooting guides (such as the following articles) to configure custom routes or firewall rules that allow Windows VMs to reach KMS IP address:

- [Windows activation fails in forced tunneling scenario](custom-routes-enable-kms-activation.md)

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)

- [Use Azure Firewall to protect Azure Virtual Desktop deployments](/azure/firewall/protect-azure-virtual-desktop?tabs=azure)

If you didn't take these actions by October 3, 2022, your Windows VMs began reporting warnings about failing to reach Windows licensing servers for activation.

#### How you're affected

Because of the July 2022 Azure update, most Windows VMs in Azure Global cloud now rely on the new `azkms.core.windows.net` domain name for Windows activation. The new `azkms.core.windows.net` address initially pointed to the existing Windows activation domain name, `kms.core.windows.net`. After October 3, 2022, `azkms.core.windows.net` was reconfigured to point to the two new IP addresses. This change had the following effects:

| If you followed this article | You see this effect |
|--|--|
| [Windows activation fails in forced tunneling scenario](custom-routes-enable-kms-activation.md) | If you didn't take action to include the two new KMS IP addresses in *custom routes*, your Windows VMs can't connect to the new KMS server for Windows activation. |
| [Use Azure Firewall to protect Azure Virtual Desktop deployments](/azure/firewall/protect-azure-virtual-desktop?tabs=azure) | If you didn't take action to include the two new KMS IP addresses in *firewall rules*, your Windows VMs can't connect to the new KMS server for Windows activation. |

As explained in the [operational requirements for KMS activation planning](/windows-server/get-started/kms-activation-planning#operational-requirements), KMS activations are valid for a period of 180 days (also known as the activation validity interval). To stay activated, KMS clients must renew their activation by connecting to the KMS host at least one time every 180 days. By default, KMS client computers try to renew their activation every seven days. After a client's activation is renewed, the activation validity interval begins again.

Within the KMS activation validity interval, you can still access the full functionality of the Windows VM. You should fix activation issues during this 180-day period.

#### Timeline

- After October 3, 2022, but before March 1, 2023, most (but not all) Windows VMs in Azure relied on the new KMS IP addresses, `20.118.99.224` and `40.83.235.53`, for Windows activation. The `azkms.core.windows.net` domain name points to these two IP addresses.

- After March 1, 2023, all Windows VMs in Azure rely on the new KMS IP addresses `20.118.99.224` and `40.83.235.53` for Windows activation. The `kms.core.windows.net` domain name now points to the first of these new IP addresses (`20.118.99.224`).

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)

## Symptoms

If you can't connect successfully to a KMS server for Windows activation, your Windows VM in Azure reports warnings such as the following:

> We can't activate Windows on this device as we can't connect to your organization's activation server. Make sure you're connected to your organization's network and try again. If you continue having problems with activation, contact your organization's support person. Error code: 0xC004F074.

## Troubleshooting checklist

#### Check for connectivity to IP addresses 20.118.99.224 and 40.83.235.53

If you can connect successfully to KMS IP addresses `20.118.99.224` and `40.83.235.53` from your Windows VMs, you don't have to worry about this problem.

To check for connectivity to the new KMS IP addresses, follow these steps:

1. Sign in remotely to your Windows VM.
1. Open PowerShell.
1. Run the following [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) cmdlet calls to verify connectivity to new KMS IP addresses:

   ```powershell
   Test-NetConnection azkms.core.windows.net -Port 1688
   Test-NetConnection 20.118.99.224 -Port 1688
   Test-NetConnection 40.83.235.53 -Port 1688
   ```

If the connections are successful, no more action is necessary. If one or more of the connections fail, review the following sections to determine the specific cause for your Windows VM activation failure.

## Cause 1: Custom routes can't reach the KMS server

You previously followed the instructions in [Windows activation fails in forced tunneling scenario](custom-routes-enable-kms-activation.md) to configure a custom route to connect to the Azure KMS server. However, because the KMS IP addresses have changed, the custom route can no longer connect to the KMS server.

### Solution 1: Add the new KMS IP addresses to the custom route

Add KMS IP addresses `20.118.99.224` and `40.83.235.53` on port 1688 to your custom route by following the updated instructions in the [Windows activation fails in forced tunneling scenario](custom-routes-enable-kms-activation.md) article.

## Cause 2: The firewall is blocking access to the KMS server

You previously followed the instructions in [Use Azure Firewall to protect Azure Virtual Desktop deployments](/azure/firewall/protect-azure-virtual-desktop) to create an outbound network rule for your firewall. This network rule allowed your Windows VM to connect to the Azure KMS server. However, because the KMS IP addresses have changed, that rule no longer provides access to the correct KMS IP addresses.

### Solution 2: Add the new KMS IP addresses as exceptions to the firewall rules

Change the network rule so that KMS IP addresses `20.118.99.224` and `40.83.235.53` on port 1688 are allowed outbound access through the firewall.

## References

- [Generally available: New KMS DNS in Azure Global cloud](https://azure.microsoft.com/updates/new-kms-dns-in-azure-global-cloud/)

- [Key Management Services (KMS) activation planning operational requirements](/windows-server/get-started/kms-activation-planning#operational-requirements)

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
