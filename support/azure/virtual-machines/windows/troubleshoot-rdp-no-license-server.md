---
title: The Remote Desktop license server isn't available when you connect to an Azure VM
description: Learn how to troubleshoot RDP fail issues because no Remote Desktop license server is available
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 10/23/2018
ms.author: genli
ms.custom: sap:Cannot connect to my VM
---
# Remote Desktop license server isn't available when you connect to an Azure VM

**Applies to:** :heavy_check_mark: Windows VMs

This article helps resolve the issue when you can't connect to an Azure virtual machine (VM) because no Remote Desktop license server is available to provide a license.

## Symptoms

When you try to connect to a VM, you may encounter the following scenarios:

- The VM screenshot shows that the operating system is fully loaded and waiting for credentials.
- You receive the following error messages when you try to make a Microsoft Remote Desktop Protocol (RDP) connection:

  - The remote session was disconnected because there are no Remote Desktop license servers available to provide a license.

  - No Remote Desktop license server is available. Remote Desktop Services will stop working because this computer is past its grace period and hasn't contacted at least a valid Windows Server 2008 license server. Select this message to open RD Session Host Server Configuration to use Licensing Diagnosis.

  - A licensing error occurred while the client was attempting to connect (Licensing timed out). Please try connecting to the remote computer again.

- The RDP connection appears to be stuck in the "Configuring remote session" status.

## Cause

This problem occurs if a Remote Desktop license server is unavailable to provide a license to start a remote session. It can be caused by several scenarios, even though a Remote Desktop Session Host role was set up on the VM:

- There was never a Remote Desktop licensing role in the environment, and the grace period, 180 days, is over.
- A Remote Desktop license was installed in the environment, but it's never activated.
- A Remote Desktop license has Client Access Licenses (CALs), and it was activated. However, there are more active users than available CALs.
- A Remote Desktop license in the environment doesn't have CALs injected to set up the connection.
- A Remote Desktop license was installed in the environment. There are available CALs, but they weren't configured properly.
- A Remote Desktop license has CALs, and it was activated. However, some other issues on the Remote Desktop license server prevent it from providing licenses in the environment.

## Solution

To resolve this problem, [back up the OS disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk) and follow these steps:

1. Connect to the VM by using an administrative session. To do this, use one of the following ways:

    - Run the following command:

      ```
      mstsc /v:<Server>[:<Port>] /admin
      ```

    - In the Azure portal, go to the VM, select **Connect** under **Settings**. In the right panel, select **Download RDP File** to download a connection file.

    If you can't connect to the VM by using an administrative session, you can use the [Virtual Machine Serial Console on Azure](serial-console-windows.md) to access the VM as follows:

    1. Access the Serial Console by selecting **Support & Troubleshooting** > **Serial console**. If the feature is enabled on the VM, you can connect the VM successfully.

    2. Create a new channel for a CMD instance. Enter **CMD** to start the channel and get the channel name.

    3. Switch to the channel that runs the CMD instance. In this case, it should be channel 1:

       ```
       ch -si 1
       ```

    4. Select **Enter** again and enter a valid username and password, local or domain ID, for the VM.

2. Check whether the VM has a Remote Desktop Session Host role enabled. If the role is enabled, make sure that it's functioning properly. Open an elevated CMD instance and follow these steps:

    1. Use the following command to check the status of the Remote Desktop Session Host role:

       ```
        reg query "HKLM\SOFTWARE\Microsoft\ServerManager\ServicingStorage\ServerComponentCache\RDS-RD-Server" /v InstallState
        ```

        If this command returns a value of 0, it means that the role is disabled, and you can go to step 3.

    2. Use the following command to check the policies and reconfigure as needed:

       ```
        reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\Licensing Core" /v LicensingMode

        reg query "HKLM\SYSTEM\CurrentControlSet\Services\TermService\Parameters\LicenseServers" /v SpecifiedLicenseServers
       ```

        If the **LicensingMode** value is set to any value other than 4, per user, then set the value to 4:

         ```
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\Licensing Core" /v LicensingMode /t REG_DWORD /d 4
        ```

       If the **SpecifiedLicenseServers** value doesn't exist, or it has incorrect license server information, then change it as follows:

       ```
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\TermService\Parameters\LicenseServers" /v SpecifiedLicenseServers /t REG_MULTI_SZ /d "<FQDN / IP License server>"
       ```

    3. After you make any changes to the registry, restart the VM.

    4. If you don't have CALs or you don't need more than two concurrent users, remove the Remote Desktop Session Host role. Then RDP will be set back to allow only two concurrent RDP connections to the VM:

        ```
        dism /ONLINE /Disable-feature /FeatureName:Remote-Desktop-Services
        ```

        If the VM has the Remote Desktop licensing role and it isn't used, you can also remove that role:

        ```
        dism /ONLINE /Disable-feature /FeatureName:Licensing
        ```

    5. Make sure that the VM can connect to the Remote Desktop license server. You can test the connectivity to the port 135 between the VM and the license server:

       ```
       telnet <FQDN / IP License Server> 135
       ```

3. If there's no Remote Desktop license server in the environment and you want one, you can [install a Remote Desktop licensing role service](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731765(v=ws.11)). Then [configure the RDS licensing](https://techcommunity.microsoft.com/t5/Ask-The-Performance-Team/RD-Licensing-Configuration-on-Windows-Server-2012/ba-p/375383).

4. If a Remote Desktop license server is configured and healthy, make sure that the Remote Desktop license server is activated with CALs.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
