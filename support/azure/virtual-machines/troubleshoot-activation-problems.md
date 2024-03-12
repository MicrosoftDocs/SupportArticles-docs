---
title: Troubleshoot Windows virtual machine activation problems in Azure
description: Provides the troubleshoot steps for fixing Windows virtual machine activation problems in Azure
services: virtual-machines, azure-resource-manager
author: genlin
tags: top-support-issue, azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-windows-activation
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.date: 03/12/2024
ms.author: genli
ms.reviewer: cwhitley, jusilver, v-naqviadil, v-leedennis, v-weizhu
---
# Troubleshoot Azure Windows virtual machine activation problems

[!INCLUDE [Feedback](../../includes/feedback.md)]

If you have trouble activating a Microsoft Azure Windows virtual machine (VM) created from a custom image, you can use the information provided in this document to troubleshoot the issue.

## Understanding Azure KMS endpoints for Windows product activation of Azure Virtual Machines

Azure uses different endpoints for Key Management Services (KMS) activation depending on the cloud region in which the VM resides. When using this troubleshooting guide, use the appropriate KMS endpoint that applies to your region.

| Region | KMS endpoint |
|--|--|
| Azure public cloud regions | `azkms.core.windows.net:1688` |
| Azure China 21Vianet national cloud regions | `kms.core.chinacloudapi.cn:1688` or `azkms.core.chinacloudapi.cn:1688` |
| Azure Germany national cloud regions | `kms.core.cloudapi.de:1688` |
| Azure US Gov national cloud regions | `kms.core.usgovcloudapi.net:1688` |

> [!NOTE]
> `kms.core.windows.net` for Azure public cloud regions was updated to `azkms.core.windows.net` in July of 2022. For more information, see [KMS endpoints - new endpoints](windows-activation-stopped-working.md).

## Symptoms

When you try to activate an Azure Windows VM, you receive an error message that resembles the following text:

> Error: 0xC004F074 The Software LicensingService reported that the computer could not be activated. No Key ManagementService (KMS) could be contacted. Please see the Application Event Log for additional information.

## Cause

Generally, Azure VM activation issues occur if the Windows VM has one or both of the following issues:

- Isn't configured by using the appropriate KMS client setup key

- Has a connectivity problem to the Azure KMS service (`azkms.core.windows.net`, port 1688)

## Solution

> [!NOTE]  
> If you're using a site-to-site VPN and forced tunneling, see [Use Azure custom routes to enable KMS activation with forced tunneling](custom-routes-enable-kms-activation.md).
>
> If you're using ExpressRoute and you have a default route published, see [Can Internet traffic be blocked for virtual networks connected to ExpressRoute circuits?](/azure/expressroute/expressroute-faqs#can-internet-traffic-be-blocked-for-virtual-networks-connected-to-expressroute-circuits)

#### Step 1: Configure the appropriate KMS client setup key

> [!NOTE]
> For VMs running **Windows 10 Enterprise multi-session** (also known as **Windows 10 Enterprise for Virtual Desktops**) in [Azure Virtual Desktop](/azure/virtual-desktop/overview), this step **isn't** required.
>
> If you deploy a Windows 10 Enterprise multi-session VM, and then update the product key to another edition, you can't switch the VM back to Windows 10 Enterprise multi-session, and you have to redeploy the VM.
>
> To determine if your VM is running multi-session, run the following command:
>
> ```cmd
> slmgr.vbs /dlv
> ```
>
> If the result returns `Name: Windows(R), ServerRdsh edition`, then this step isn't required.
>
> For more information, see [Can I upgrade a Windows VM to Windows Enterprise multi-session?](/azure/virtual-desktop/windows-10-multisession-faq#can-i-upgrade-a-windows-vm-to-windows-enterprise-multi-session)

For the VM created from a custom image, you must configure the appropriate KMS client setup key for the VM.

1. Run the following command at an elevated command prompt. Check the `Description` value in the output, and then determine whether it was created from retail (`RETAIL` channel) or volume (`VOLUME_KMSCLIENT`) license media:

    ```cmd
    cscript c:\windows\system32\slmgr.vbs /dlv
    ```

2. If the previous command indicates a `RETAIL` channel, run the following commands to set the [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for the version of Windows Server in use, and force it to retry activation:

    ```cmd
    cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>

    cscript c:\windows\system32\slmgr.vbs /ato
     ```

    For example, for Windows Server 2016 Datacenter, you run the following command:

    ```cmd
    cscript c:\windows\system32\slmgr.vbs /ipk CB7KF-BWN84-R7R2Y-793K2-8XDDG
    ```

#### Step 2: Verify the connectivity between the VM and Azure KMS service

1. Make sure that the VM is configured to use the correct Azure KMS server. To do this, run the following command:
  
    ```powershell
    Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /skms azkms.core.windows.net:1688"
    ```

    The command should return the following text:

    > Key Management Service machine name set to `azkms.core.windows.net:1688` successfully.

2. Ensure that the outbound network traffic to KMS endpoint on port 1688 isn't blocked by the firewall in the VM. To do this, run the [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) PowerShell cmdlet or [PsPing](/sysinternals/downloads/psping) tool.

    - Verify by running `Test-NetConnection`:

        ```powershell
        Test-NetConnection azkms.core.windows.net -port 1688
        ```

       If the connectivity is permitted, you can see `TcpTestSucceeded: True` in the output.

    - Verify by using PsPing. Switch to the folder in which you extracted the `Pstools.zip` archive, and then run the following command:

        ```cmd
        .\psping.exe azkms.core.windows.net:1688
        ```

        In the second-to-last line of the output, make sure that you see the following text:

        > Sent = 4, Received = 4, Lost = 0 (0% loss)

        If Lost is greater than 0 (zero), the VM doesn't have connectivity to the KMS server. In this situation, if the VM is in a virtual network and has specified a custom DNS server, you must make sure that DNS server is able to resolve `azkms.core.windows.net`. Or, change the DNS server to one that does resolve `azkms.core.windows.net`.

        > [!NOTE]  
        > If you remove all DNS servers from a virtual network, the VMs use Azure's internal DNS service. This service can resolve `azkms.core.windows.net`.

3. Verify using [Azure Network Watcher next hop](/azure/network-watcher/network-watcher-next-hop-overview) that the next hop type from the VM in question to the destination IP ` 20.118.99.224` or `40.83.235.53` (for `azkms.core.windows.net`) or the IP of the appropriate KMS endpoint that applies to your region is **Internet**.

   If the result is **VirtualAppliance** or **VirtualNetworkGateway**, it's likely that a default route exists. Contact your network administrator and work with them to determine the correct course of action. This might be a [custom route](./custom-routes-enable-kms-activation.md) if that solution is consistent with your organization's policies.

4. After you verify successful connectivity to `azkms.core.windows.net`, run the following command at that elevated Windows PowerShell prompt. This command tries activation multiple times:

    ```powershell
    1..12 | ForEach-Object {
        Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /ato" ; start-sleep 5
    }
    ```

    A successful activation returns information that resembles the following text:

    > Activating Windows(R), ServerDatacenter edition (12345678-1234-1234-1234-12345678) …
    Product activated successfully.

## More information

- [Azure Windows virtual machine activation FAQ](./windows-virtual-machine-activation-faq.yml)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
