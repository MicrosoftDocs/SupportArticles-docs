---
title: SCVMM P2V fails with error 0x80070005
description: Discusses that a P2V conversion in System Center Virtual Machine Manager 2008 fails and returns an error 2910 (0x80070005).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
---
# SCVMM and SCVMM R2 P2V fails with Error 2910 (0x80070005) Access Denied

This article provides a solution to an error 2910 (0x80070005) that occurs when a Physical-to-Virtual conversion (P2V) conversion in Microsoft System Center Virtual Machine Manager 2008 fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 969965

## Symptoms

When you use System Center Virtual Machine Manager 2008 to perform a P2V, you receive the following error message during the Scan System phase:

> Error (2910)  
VMM does not have appropriate permissions to access the resource on the %server.  
Access is denied (0x80070005))
>
> Recommended Action  
Ensure that Virtual Machine Manager has the appropriate rights to perform this action.

> [!NOTE]
> The source computer is the computer that you intend to virtualize in the P2V conversion.

## Cause

This problem typically occurs because either of the following conditions is true:

- The credentials that were entered in the P2V wizard do not belong to a member of the local Administrators group on the Source computer.
- The source computer does not permit remote WMI calls to the CIMV2 namespace to the account that was used for the P2V wizard.

## Resolution

To resolve this problem, follow these steps:

1. Make sure that the account that is used for the P2V wizard is a member of the local Administrators group on the source computer.

    > [!NOTE]
    > This is especially important if the SCVMM server and source computer are in different domains.
2. Verify WMI connectivity to the CIMV2 namespace on the source computer. To do this, follow these steps on the SCVMM server.

    > [!NOTE]
    > During the Scan System phase of the P2V conversion, SCVMM makes WMI calls to the CIMV2 namespace on the source computer to pull basic system information. If these WMI calls fail, the P2V conversion also fails.
    1. Open the WBEMtest window. To do this, click **Start**, point to **Run**, type WBEMtest in the **Open** box, and then click **OK**.
    2. Click Connect in the upper-right corner.
    3. Connect to the CIMV2 namespace on the source computer. For example, type \\Source\ROOT\CIMV2.

        > [!NOTE]
        > Make sure to use the name of your source computer.
    4. Click **Connect** to complete the connection.
    5. Verify your connection by accessing a sample object. To do this, click **Open Class**, and then type Win32_PhysicalMemory.
    
        > [!NOTE]
        > You should see objects populate the Object Editor window. The actual content that is returned is not important. This purpose of this step is only to verify that a remote connection to the CIMV2 namespace has been established.
3. Open wmimgmt.msc to verify connectivity to the local computer and also to check the Remote Enable permissions. To do this, follow these steps:
    1. Open the WMI Control (Local) window. To do this, click **Start**, point to **Run**, type wmimgmt.msc, and then click OK.
    2. Right-click the **WMI Control (Local)** node, and then click **Properties**.
    3. Click the **Security** tab, select **Root**, and then click the **Security** button in the lower-right corner.
    4. Click to select the **Remote Enable permission for Everyone or the specific user account that you want to grant this permission to** check box.
    
    > [!NOTE]
    > This action does not require that you restart the computer.
4. Open dcomcnfg to verify that the DCOM service is running and also to check the Remote Activation permission. To do this, follow these steps:
    1. Open the Component Services snap-in. To do this, click **Start**, point to **Run**, type dcomcnfg, and then click **OK**.
    2. Expand **Component Services**, expand **Computers**, and then expand **My Computer**.
    
      > [!NOTE]
      > If the **My Computer** node has a red down-arrow mark, this means that the DCOM service is not running and must be started.
    3. Right-click **My Computer**, click **Properties**, and then click the **COM Security** tab.
    4. Under **Launch and Activation Permissions**, click **Edit Limits**.
    5. For the **Everyone** user group, click to select the **Allow** check box for the **Remote Activation** row. Alternatively, add the specific user account to which you want to grant this permission.
    
      > [!NOTE]
      > You may receive an "Access Denied" error message if the appropriate WMI permission is not granted to the user. The error message may include Error code 0x80041003.
5. Verify whether the Ole registry key is missing or has an incorrect value on the source computer. To do this, follow these steps:
    1. Start Registry Editor.
    2. Locate the following subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole` 
    3. Look for an **EnableDCOM** entry that has a type of **REG_SZ** and a value of **Y**.

## References

For general troubleshooting steps of SCVMM, see the following blog: [System Center Virtual Machine Manager](https://blogs.technet.com/b/scvmmcallback/archive/2009/03/26/system-center-virtual-machine-manager.aspx) 

For more information about P2V Conversions, visit the following Microsoft Website: [Converting Physical Computers to Virtual Machines in VMM (P2V Conversions)](https://technet.microsoft.com/library/bb963740.aspx)
