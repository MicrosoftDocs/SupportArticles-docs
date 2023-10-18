---
title: Troubleshoot Windows virtual machine activation problems in Azure
description: Provides the troubleshoot steps for fixing Windows virtual machine activation problems in Azure
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: top-support-issue, azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-windows-activation
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 10/17/2023
ms.author: genli
---
# Troubleshoot Azure Windows virtual machine activation problems

If you have trouble when activating Azure Windows virtual machine (VM) that is created from a custom image, you can use the information provided in this document to troubleshoot the issue.

## Understanding Azure KMS endpoints for Windows product activation of Azure Virtual Machines

Azure uses different endpoints for KMS (Key Management Services) activation depending on the cloud region where the VM resides. When using this troubleshooting guide, use the appropriate KMS endpoint that applies to your region.

- Azure public cloud regions: kms.core.windows.net:1688 or azkms.core.windows.net:1688
- Azure China 21Vianet national cloud regions: kms.core.chinacloudapi.cn:1688 or azkms.core.chinacloudapi.cn:1688
- Azure Germany national cloud regions: kms.core.cloudapi.de:1688
- Azure US Gov national cloud regions: kms.core.usgovcloudapi.net:1688

## Symptom

When you try to activate an Azure Windows VM, you receive an error message resembles the following sample:

**Error: 0xC004F074 The Software LicensingService reported that the computer could not be activated. No Key ManagementService (KMS) could be contacted. Please see the Application Event Log for additional information.**

## Cause

Generally, Azure VM activation issues occur if the Windows VM isn't configured by using the appropriate KMS client setup key, or the Windows VM has a connectivity problem to the Azure KMS service (kms.core.windows.net, port 1688).

## Solution

>[!NOTE]
>If you are using a site-to-site VPN and forced tunneling, see [Use Azure custom routes to enable KMS activation with forced tunneling](custom-routes-enable-kms-activation.md).
>
>If you are using ExpressRoute and you have a default route published, see [Can I block Internet connectivity to virtual networks connected to ExpressRoute circuits?](/azure/expressroute/expressroute-faqs).

### Step 1 Configure the appropriate KMS client setup key

> [!NOTE]
> For VMs running **Windows 10 Enterprise multi-session** (also known as **Windows 10 Enterprise for Virtual Desktops**) in [Azure Virtual Desktop](/azure/virtual-desktop/overview), this step **isn't** required.
>
> If you deploy a Windows 10 Enterprise multi-session VM, and then update the product key to another edition, you won't be able to switch the VM back to Windows 10 Enterprise multi-session, and you will need to redeploy the VM.
>
> To determine if your VM is running multi-session, run the following command:
>
> ```cmd
> slmgr.vbs /dlv
> ```
>
> If the result returns **Name: Windows(R), ServerRdsh edition**, then this step isn't required.
>
> For more information, please refer to: [Windows 10 Enterprise multi-session FAQ](/azure/virtual-desktop/windows-10-multisession-faq#can-i-upgrade-a-windows-10-vm-to-windows-10-enterprise-multi-session)

For the VM that is created from a custom image, you must configure the appropriate KMS client setup key for the VM.

1. Run **slmgr.vbs /dlv** at an elevated command prompt. Check the Description value in the output, and then determine whether it was created from retail (RETAIL channel) or volume (VOLUME_KMSCLIENT) license media:

    ```cmd
    cscript c:\windows\system32\slmgr.vbs /dlv
    ```

2. If **slmgr.vbs /dlv** shows RETAIL channel, run the following commands to set the [KMS client setup key](/windows-server/get-started/kmsclientkeys) for the version of Windows Server being used, and force it to retry activation:

    ```cmd
    cscript c:\windows\system32\slmgr.vbs /ipk <KMS client setup key>

    cscript c:\windows\system32\slmgr.vbs /ato
     ```

    For example, for Windows Server 2016 Datacenter, you would run the following command:

    ```cmd
    cscript c:\windows\system32\slmgr.vbs /ipk CB7KF-BWN84-R7R2Y-793K2-8XDDG
    ```

### Step 2 Verify the connectivity between the VM and Azure KMS service

1. Make sure that the VM is configured to use the correct Azure KMS server. To do this, run the following command:
  
    ```powershell
    Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /skms kms.core.windows.net:1688"
    ```

    The command should return: Key Management Service machine name set to kms.core.windows.net:1688 successfully.

2. Ensure that the outbound network traffic to KMS endpoint on port 1688 isn't blocked by the firewall in the VM. To do this, Use [Test-NetConnection](/powershell/module/nettcpip/test-netconnection?view=windowsserver2022-ps&preserve-view=true) PowerShell command or [PSping](/sysinternals/downloads/psping) tool.

    - Verify by using Test-NetConnection, run the following command:

        ```powershell
        Test-NetConnection kms.core.windows.net -port 1688
        ```
       If the connectivity is permitted, you will observe "TcpTestSucceeded: True" in the output.
    - Verify by using Psping. Switch to the folder where you extracted the Pstools.zip, and then run the following:
    
        ```cmd
        .\psping.exe kms.core.windows.net:1688
        ```

        In the second-to-last line of the output, make sure that you see: Sent = 4, Received = 4, Lost = 0 (0% loss).

        If Lost is greater than 0 (zero), the VM doesn't have connectivity to the KMS server. In this situation, if the VM is in a virtual network and has a custom DNS server specified, you must make sure that DNS server is able to resolve kms.core.windows.net. Or, change the DNS server to one that does resolve kms.core.windows.net.

        Notice that if you remove all DNS servers from a virtual network, VMs use Azure's internal DNS service. This service can resolve kms.core.windows.net.

5. Verify using [Network Watcher Next Hop](/azure/network-watcher/network-watcher-next-hop-overview) that the next hop type from the VM in question to the destination IP 23.102.135.246 (for kms.core.windows.net) or the IP of the appropriate KMS endpoint that applies to your region is **Internet**.

   If the result is VirtualAppliance or VirtualNetworkGateway, it's likely that a default route exists.  Contact your network administrator and work with them to determine the correct course of action.  This might be a [custom route](./custom-routes-enable-kms-activation.md) if that solution is consistent with your organization's policies.

6. After you verify successful connectivity to kms.core.windows.net, run the following command at that elevated Windows PowerShell prompt. This command tries activation multiple times.

    ```powershell
    1..12 | ForEach-Object { Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /ato" ; start-sleep 5 }
    ```

    A successful activation returns information that resembles the following:

    **Activating Windows(R), ServerDatacenter edition (12345678-1234-1234-1234-12345678) …
    Product activated successfully.**

## FAQ

### I created a Windows Server virtual machine from Azure Marketplace. Do I need to configure a KMS key for activating the system?

No. The image in Azure Marketplace has the appropriate KMS client setup key already configured.

### Does Windows activation work the same way regardless if the VM is using Azure Hybrid Use Benefit (HUB) or not?

Yes.

### What happens if Windows activation period expires?

When the grace period has expired and Windows is still not activated, Windows Server 2008 R2 and later versions of Windows will show additional notifications about activating. The desktop wallpaper remains black, and Windows Update will install security and critical updates only, but not optional updates. See  the Notifications section at the bottom of the [Licensing Conditions](/previous-versions/tn-archive/ff793403(v=technet.10)) page.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
