---
title: Blank default gateway may occur after configuring Static IP address following network driver upgrade on Windows 7 and Server 2008 R2
description: If a Windows 7 Service Pack 1 or Windows Server 2008 R2 Service Pack 1 system is configured with a Static IPv4 address, and the underlying network driver is uninstalled and reinstalled, reconfiguring the same Static IPv4 address information may result in a blank default gateway. The Static IP address information must be reentered twice before the information persists to the registry.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, steved
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Blank default gateway may occur after configuring Static IP address following network driver upgrade in Windows 7 Service Pack 1 and Server 2008 R2 Service Pack 1

This article provides a solution to an issue where blank default gateway may occur after you configure Static IP address following network driver upgrade in Windows 7 Service Pack 1 and Server 2008 R2 Service Pack 1.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2555789

## Symptoms

After upgrading a network driver and reentering static IPv4 address information within the **Local Area Connection Properties**/**Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, or when using the `netsh interface ipv4 [add | set] address` command, network connectivity may not work correctly. The following behavior may be observed:

- When viewing **Local Area Connection Properties**/**Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, the **Default gateway** entry will be blank, though the previously entered IP address and Subnet mask will display correctly.

- If ipconfig.exe is run from a command prompt, the Local Area Connection "Autoconfiguration IPv4 Address" will begin with "169.254...."

This problem does not occur if the computer receives an address from a DHCP server.

## Cause

When removing a network driver using a vendor-provided uninstallation program or through Device Manager, previously entered static IP address information may not be removed correctly from the registry. After reinstalling the network driver and reentering the same static IP address, the presence of previous registry information prevents the newly entered address information from being saved correctly.

## Resolution

Once the machine is experiencing this problem, the static IP address, Subnet mask, and Default gateway must be reentered TWICE in order for the values to be saved correctly.

1. Open the **Local Area Connection Properties**/**Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, and select **Obtain an IP address automatically**, and choose **OK**. From the **Local Area Connection Properties** dialog box, choose **OK**.

2. Reenter the **Local Area Connection Properties**/**Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, and select **Use the following IP address**.

3. Perform the first two steps AGAIN, even though the IP address appears to be displaying properly. Or, open a command prompt under the administrator context and run the following command TWICE, using the desired static address information. For example:

    ```console
    netsh interface ipv4 set address "Local Area Connection" static 10.0.0.55 255.0.0.0 10.0.0.1
    ```

    This first command may return an error "Object already exists".

    ```console
    netsh interface ipv4 set address "Local Area Connection" static 10.0.0.55 255.0.0.0 10.0.0.1
    ```

    This command should succeed with no errors.

## More information

This problem is difficult to reproduce, and may only occur once in five or more network driver uninstallation attempts. This issue may occur with any network adapter.
