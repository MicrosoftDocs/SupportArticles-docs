---
title: Update 1602 for Cloud Platform System Premium
description: Describes Update 1602 for Cloud Platform System Premium. Also provides installation instructions and a list of Windows Server 2012 R2 updates.
author: genlin
ms.author: genli
ms.service: azure-stack
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.reviewer: justini, delhan
---
# Update 1602 for Cloud Platform System Premium

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3141090

Update 1602 for Cloud Platform System (CPS) Premium 1.0 includes critical Windows updates, an additional private hotfix for Microsoft System Center 2012 R2 Virtual Machine Manager (VMM), and functionality that lets you run a health check before you perform an update. A list of the Windows updates is included at the end of this article.

> [!NOTE]
> There are no driver or firmware updates included in this update package.

## How to install the update

This update procedure assumes that you have already installed Update 2.0. To install update 1602 for CPS Premium 1.0, follow these steps.

### Step 1: Prepare the package

Follow steps 1 and 2 in the "Prepare the patching environment" section of the CPS Administrators Guide that was provided by your account team. Because there are no firmware or driver updates in this package, steps 3 and 4 from the CPS Administrators Guide do not apply.

> [!IMPORTANT]
> Do not start the patching process.

### Step 2: Run a health check and fix any issues

The Microsoft Patch and Update (P&U) Framework supports new functionality that lets you run a non-invasive, read-only health check. This ensures fundamental stamp health before you run the actual update.

To run the health check, use the -HealthCheckOnly parameter when you start the P&U process.

Make sure that you're logged on by using the account that you created for patching, such as CPS-Update-Admin. Then, run the following Windows PowerShell command:

```
$cred = Get- Credential (whoami)
```  

Enter the account password when you're prompted to do this.

Run the following command, in which &#60;CPSPU Folder Name&#62; is the folder name that you used for the specific update package:

```
<Name of SOFS in rack 1> \SU1_InfrastructureShare1\<CPSPU Folder Name>\Framework\PatchingUpgrade\Invoke-PURun.ps1 -HealthCheckOnly -PUCredential $cred
```  

Try to fix any issues that are discovered. You should try to resolve all critical Operations Manager alerts before you start the P&U process.

### Step 3: Install the prerequisite VMM hotfix before you install Update 1602

> [!NOTE]
> If you have already installed Update 2.1, you can skip this step.

An issue was introduced in Update Rollup 6 for SystemCenter 2012 R2 VMM: When a host goes into legacy mode, it does not return to eventing mode for 20 days. Therefore, the VM properties are not refreshed, and no events are received from Hyper-V for 20 days. This issue occurs because of a change in UR6 that sets the expiry as 20 days for both eventing mode and legacy mode. The legacy refresher should ideally run after two minutes have passed. However, the refresher now does not start until after 20 days have passed. During those 20 days, eventing is disabled.

To resolve this issue, you must install the VMM hotfix by using the following method.

### How to apply the private hotfix for VMM 2012 R2

> [!NOTE]
> The highly available VMM clustered role, <Prefix>-HA-VMM, has two nodes: -VMM-01 and VMM-02. This procedure refers to the nodes as Node1 and Node2.

To apply the hotfix, follow these steps:


1. From the specified location, copy the HostMode_Hotfix.exe file to a folder on a Console VM, such as C: \HostModeHotfix.
2. Double-click the HostMode_Hotfix.exe file, review the EULA, and then click **Yes** to accept the terms.
3. Select a folder in which to store the extracted files. For example, select C:\HostModeHotfix. Then, click **OK**.
4. Determine the passive VMM node. To do this, open a Windows PowerShell ISE session and run the following script, in which "< **Prefix** >" is your stamp prefix:

```
$VmmServerName = "<Prefix>-HA-VMM"$vmmServer = Get-SCVMMServer -ComputerName $VmmServerName 
$activeNode = $vmmServer.ActiveVMMNode
$passiveNodes = @()
$vmmServer.FailoverVMMNodes | ForEach- Object { 
if($_.ToLower() -ne $activeNode.ToLower()){
$passiveNodes += $_
}
}
$passiveNodes
```

> [!NOTE]
> This script returns the server name of the passive VMM node. (In our example, we assume that Node2 is initially the passive node.)

5. In File Explorer, locate the following folder on the passive node:
    ```
     \\<Prefix>-VMM-0#>\c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager \bin
    ```
6. Make backup copies of the following files in the \bin folder

    - Engine.Common.dll
    - Utils.dll
7. In the VMM console, determine which host (in the management cluster) it is that the passive VMM node is running on.
8. Open Hyper-V Manager, connect to the management cluster host that you determined in step 7, and then connect to the passive VMM node.
9. On the VMM node, type powershell to open an elevated Windows PowerShell session, and then run the following commands:
    
    ```
    Stop-Service SCVMMService Stop-Service SCVMMAgent
    ```

10. Verify that the services have stopped. To do this, run the following commands:

    ```
    Get- Service SCVMMService Get-Service SCVMMAgent
    ```

    Verify that the status of each is **Stopped**. If you're prompted to close the System Center Management Service Host process, click **Ignore**.
11. On the Console VM, locate the following folder on the passive node:
    ```
    \\<Prefix>-VMM-0#> \c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin
    ```

12. In the \bin folder, replace the following files with the new versions of the files that you extracted from the hotfix package:

    - Engine.Common.dl
    - Utils.dll
13. On the passive VMM node, run the following command to start the services:

    ```
    Start-Service SCVMMAgent
    ```  
    SCVMMService does not start when the passive VMM server node is not active. SCVMMService starts only when the node becomes the active node. This behavior is by design.
14. In Failover Cluster Manager, start a failover. This makes Node1 the new passive node and Node2 (which is already updated) the active node. To do this, follow these steps:

    1. Open Failover Cluster Manager, and then connect to the &#60;**Prefix**&#62;-CL-VMM cluster.
    2. Click **Roles**. The Roles pane displays the active node in the **Owner Node** column. Right-click the active node, point to **Move**, and then click **Select Node**. Select the other node, and make sure that the status changes to **Running** for the new active node. This may take a few seconds.
15. Follow steps 6-13 to update the VMM files on the new passive node (in this example, Node1).

### How to revert the patch

To revert the patch (if necessary), follow these steps:

1. On the passive VMM node, stop the SCVMMService service, and then stop the SCVMMAgent service.
2. Replace the files in your VMM installation folder with your backup files.
3. Start the SCVMMAgent service.
4. Start the SCVMMService service.
5. In Failover Cluster Manager, initiate a failover of the < **Prefix** >-HA-VMM clustered role.
6. Repeat these steps 1-4 on the new passive node.

### Step 4: Run the P&U update package

Follow the procedures in the "Update the computers" section of the CPS Administrators Guide to apply Update 2.1. However, starting in Update 1602, P&U automatically runs a health check as part of the update process. You can control what happens if critical Operations Manager alerts are discovered. To do this, change the value of the -ScomAlertAction parameter.

The -ScomAlertAction parameter has the following possible values:

Parameter Value: Stop
Description: The default behavior for a P&U process. Runs all health checks, and then stops the P&U update if there are critical Operations Manager alerts.

Parameter Value: Prompt
Description: Runs all health checks. If critical Operations Manager alerts are discovered, asks if you want to continue the update process.

Parameter Value: Continue
Description: Runs all health checks. Outputs warning information if critical Operations Manager alerts are encountered, but continues the update process.

The Administrators Guide shows the following command to start the P&U run:

```
\\<Name of SOFS in rack 1>\SU1_InfrastructureShare1\<CPSPU Folder Name>\Framework \PatchingUpgrade\Invoke-PURun.ps1 -PUCredential $cred
```  

If you run this command exactly as shown, P&U runs a health check as part of the update process by applying the default behavior in which -ScomAlertAction is set to **Stop**.

To change the -ScomAlertAction option to **Prompt** or **Continue**, set the -ScomAlertAction parameter to the value that you want. For example, set it to the following value:

```
\\\SU1_InfrastructureShare1\Framework\PatchingUpgrade\Invoke-PURun.ps1 -ScomAlertAction "Continue" -PUCredential $cred
```  

> [!NOTE]
> Because you already have Update 2.0 installed, you can ignore the "Additional prerequisites for Update 2" section in the CPS Administrators Guide.

### Updates for Windows Server 2012 R2

- ["STATUS_CONNECTION_RESET" error when an application reads a file in Windows Server 2012 R2 or Windows Server 2012 R2 (KB3076950)](https://support.microsoft.com/help/3076950) 

- [MS15-105: Description of the security update for Hyper-V: September 8, 2015 (KB3087088)](https://support.microsoft.com/help/3087088) 

- [MS15-109: Description of the security update for Windows Shell: October 13, 2015 (KB3080446)](https://support.microsoft.com/help/3080446) 

- [Hyper-V host crashes and has errors when you perform a VM live migration in Windows 8.1 and Windows Server 2012 R2 (KB3031598)](https://support.microsoft.com/help/3031598) 

- [Files aren't fully optimized and a deduplication cache lock contention issue occurs in Windows Server 2012 R2 (KB3094197)](https://support.microsoft.com/help/3094197) 

- [MS15- 115: Description of the security update for Windows: November 10, 2015 (KB3097877)](https://support.microsoft.com/help/3097877) 

- [MS15-128 and MS15-135: Description of the security update for Windows kernel-mode drivers: December 8, 2015 (KB3109094)](https://support.microsoft.com/help/3109094) 

- [MS15-127: Security update for Microsoft Windows DNS to address remote code execution: December 8, 2015 (KB3100465)](https://support.microsoft.com/help/3100465) 

- [MS15-133: Description of the security update for Windows PGM: December 8, 2015 (KB3109103)](https://support.microsoft.com/help/3109103) 

- [MS15-132: Description of the security update for Windows: December 8, 2015 (KB3108347)](https://support.microsoft.com/help/3108347) 

- [MS15-128: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: December 8, 2015 (KB3099864)](https://support.microsoft.com/help/3099864) 

- [MS15- 132: Description of the security update for Windows: December 8, 2015 (KB3108381)](https://support.microsoft.com/help/3108381) 

- [MS16-007: Description of the security update for Windows: January 12, 2016 (KB3110329)](https://support.microsoft.com/help/3110329) 

- [MS16-007: Description of the security update for Windows: January 12, 2016 (KB3121918)](https://support.microsoft.com/help/3121918) 

- [MS16-005: Description of the security update for Windows kernel-mode drivers: January 12, 2016 (KB3124001)](https://support.microsoft.com/help/3124001) 

- [MS16-019: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: February 9, 2016 (KB3122651 )](https://support.microsoft.com/help/3122651)

- [MS16-019: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: February 9, 2016 (KB3122654)](https://support.microsoft.com/help/3122654) 

- [MS16-012: Description of the security update for Windows PDF Library: February 9, 2016 (KB3123294)](https://support.microsoft.com/help/3123294) 

- [MS16-014: Description of the security update for Windows 8.1 and Windows Server 2012 R2: February 9, 2016 (KB3126434)](https://support.microsoft.com/help/3126434) 

- [MS16-017: Description of the security update for Remote Desktop display driver: February 9, 2016 (KB3126446)](https://support.microsoft.com/help/3126446) 

- [MS16-014: Description of the security update for Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows Server 2012, Windows 8.1, and Windows Server 2012 R2: February 9, 2016 (KB3126587)](https://support.microsoft.com/help/3126587) 

- [MS16-014: Description of the security update for Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows Server 2012, Windows 8.1, and Windows Server 2012 R2: February 9, 2016 (KB3126593)](https://support.microsoft.com/help/3126593) 

- [MS16-021: Security update for NPS RADIUS server to address denial of service: February 9, 2016 (KB3133043)](https://support.microsoft.com/help/3133043) 

- [MS16-018: Description of the security update for Windows kernel-mode drivers: February 9, 2016 (KB3134214)](https://support.microsoft.com/help/3134214) 

- [MS16-020: Security update for Active Directory Federation Services to address denial of service: February 9, 2016 (KB3134222)](https://support.microsoft.com/help/3134222) 

> [!NOTE]
> The version of the VMM Service Template in this article is 3.2.8139.0 .
