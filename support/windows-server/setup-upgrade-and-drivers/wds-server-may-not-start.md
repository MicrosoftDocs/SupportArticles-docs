---
title: WDS server may not start
description: Resolves an issue that occurs when you start the WDS server on a Windows 2008-based computer. The WDS server may not start, and an error message is logged in the System log.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# The WDS server may not start, and an error is logged in the System log when you start the WDS server

This article provides a solution to an issue that occurs when you start the Windows Deployment Services (WDS) server, the WDS server may not start.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954410

## Symptoms

On a Windows 2008 Server-based computer, when you try to start WDS server, the WDS server may not start. Additionally, you may receive an error message, and the message is logged in the WDS Server Log.

This issue occurs if the following conditions are true:

- The DHCP server and the WDS server are installed on the same computer.
- The **Do not listen on port 67** option isn't enabled in the **DHCP** tab.

## Cause

When the DHCP server and the WDS server are installed on the same computer, the WDS Service tries to use the port 67. However, the DHCP server already uses this port.

## Resolution

To resolve this issue, configure the WDS Pre-boot execution Environment (PXE) client to stop listening on port 67. To do it, use one of the following methods, as appropriate for your situation.

### Method 1

At the command prompt, type the following command, and then press **ENTER**:  
    `wdsutil /set-Server /UseDhcpPorts:No`

### Method 2

1. Select **Start**, select **Run**, type **wdsmgmt.msc**, and then press **OK**.
2. In the **Windows Deployment Services** window, expand **Servers**, right-click the WDS server name, and then select **Properties**.

3. In the **Server Properties** dialog box, select the **DHCP** tab.

4. Click to select the **Do not listen on port 67** check box, and then select **Apply**.

## More information

The following registry subkey controls whether the PXE server listens on the DHCP port:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSPXE`

To enable the PXE server to listen on port 67, set the value of the `UseDHCPPorts` registry entry to 1. Use this setting in configurations where the Windows Deployment Services PXE server and the DHCP server are installed on different computers.

To disable the PXE server from listening on port 67, set the `UseDHCPPorts` registry value to 0. Use this setting in configurations where the Windows Deployment Services PXE server and the DHCP server are installed on the same computer.

## References

For more information about how to enable WDS Server logging, see [How to enable logging in Windows Deployment Services (WDS) in Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, and in Windows Server 2012](enable-logging-windows-deployment-service.md).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
