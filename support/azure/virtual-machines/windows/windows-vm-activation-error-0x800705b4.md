---
title: Windows VM activation error 0x800705B4
description: Provides a solution to the error 0x800705B4 that occurs when you try to activate an Azure Windows virtual machine (VM).
ms.date: 03/14/2024
ms.service: virtual-machines
ms.subservice: vm-windows-activation
ms.collection: windows
ms.reviewer: cwhitley, v-naqviadil, v-weizhu
---
# Error 0x800705B4 when you activate an Azure Windows virtual machine

This article provides a solution to the error 0x800705B4 that occurs when you try to activate an Azure Windows virtual machine (VM).

## Symptoms

When you try to activate an Azure Windows VM, you receive the 0x800705B4 error:

> **Windows Activation**  
> A problem occurred when Windows tried to activate. Error Code 0x800705B4.  
> For a possible resolution, click More Information.  
> Contact your system administrator or technical support department for assistance.

It can also be displayed as a Security-SPP error (Event ID 8196) in the Application log.

## Cause

This error indicates a time-out. It might be caused by network connectivity or Domain Name System (DNS) resolution problems.

## Troubleshooting steps

Perform the following steps to check network connectivity problems, and then retry the activation.

### Verify the connectivity between the VM and the Azure KMS service

1. Make sure that the VM is configured to use the correct Azure Key Management Services (KMS) server. To do this, run the following command:
  
    ```powershell
    Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /skms azkms.core.windows.net:1688"
    ```

    The command should return the following text:

    > Key Management Service machine name set to `azkms.core.windows.net:1688` successfully.

2. Ensure that the outbound network traffic to the KMS endpoint on port 1688 isn't blocked by the firewall in the VM. To do this, run the [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) PowerShell cmdlet or the [PsPing](/sysinternals/downloads/psping) tool.

    - Verify by running `Test-NetConnection`:

        ```powershell
        Test-NetConnection azkms.core.windows.net -port 1688
        ```

       If the connectivity is permitted, you can see `TcpTestSucceeded: True` in the output.

    - Verify by using PsPing. Switch to the folder in which you extracted the `Pstools.zip` archive, and then run the following command:

        ```cmd
        .\psping.exe azkms.core.windows.net:1688
        ```

        On the second-to-last line of the output, make sure that you see the following text:

        `Sent = 4, Received = 4, Lost = 0 (0% loss)`

        If `Lost` is greater than 0 (zero), the VM doesn't have connectivity to the KMS server. In this situation, if the VM is in a virtual network and has specified a custom DNS server, you must make sure that the DNS server is able to resolve `azkms.core.windows.net`. Or, change the DNS server to one that does resolve `azkms.core.windows.net`.

        > [!NOTE]  
        > If you remove all DNS servers from a virtual network, the VMs use Azure's internal DNS service. This service can resolve `azkms.core.windows.net`.

3. Verify using [Azure Network Watcher next hop](/azure/network-watcher/network-watcher-next-hop-overview) that the next hop type from the VM in question to the destination IPs `20.118.99.224` and `40.83.235.53` (for `azkms.core.windows.net`) or the IP of the appropriate KMS endpoint that applies to your region is **Internet**.

   If the result is **VirtualAppliance** or **VirtualNetworkGateway**, a default route likely exists. Contact your network administrator and work with them to determine the correct course of action. This might be a [custom route](./custom-routes-enable-kms-activation.md) if that solution is consistent with your organization's policies.

4. After you verify successful connectivity to `azkms.core.windows.net`, run the following command at an elevated Windows PowerShell prompt. This command tries activation multiple times:

    ```powershell
    1..12 | ForEach-Object {
        Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /ato" ; start-sleep 5
    }
    ```

    A successful activation returns information that resembles the following text:

    > Activating Windows(R), ServerDatacenter edition (12345678-1234-1234-1234-12345678) …
    Product activated successfully.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
