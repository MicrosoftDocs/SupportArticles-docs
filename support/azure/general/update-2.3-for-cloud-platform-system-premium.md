---
title: Update 2.3 for Cloud Platform System Premium
description: Describes Update 2.3 for Cloud Platform System (CPS) Premium 1.0. Includes summary of what the update covers and how to install it.
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.date: 08/14/2020
ms.reviewer: 
---
# Update 2.3 for Cloud Platform System Premium

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3136324

Update 2.3 for Cloud Platform System (CPS) Premium 1.0 includes critical Windows updates, an additional private hotfix for VMM 2012 R2, and functionality that lets you run a health check before you perform an update. The list of Windows updates is included at the end of this article.

> [!NOTE]
> There are no driver or firmware updates included in this update package.

## How to install the update

To install update 2.3 for CPS Premium 1.0, follow these steps. This update procedure assumes that you have already installed Update 2.0.

### Step 1: Prepare the package

Follow steps 1 and 2 in the "Prepare the patching environment" section of the CPS Administrators Guide that was provided by your account team. Because there are no firmware or driver updates, steps 3 and 4 from the CPS Administrators Guide do not apply.

> [!IMPORTANT]
> Do not start the patching process.

### Step 2: Run a health check, and fix any discovered issues

The Microsoft Patch and Update (P&U) Framework supports new functionality that lets you run a non-invasive, read- only health check. This ensures fundamental stamp health before you run the actual update.

To run the health check, use the -HealthCheckOnly parameter when you invoke the P&U run.

Make sure that you're logged on as the account that you created for patching, such as CPS-Update-Admin. Then, run the following Windows PowerShell command:

$ cred = Get- Credential (whoami)  

When you're prompted, enter the account password.

Run the following command, where \<CPSPU Folder Name\> is the folder name that you used for the specific update package:

\<Name of SOFS in rack 1\>\SU1_InfrastructureShare1\\\<CPSPU Folder Name\>\Framework\PatchingUpgrade\Invoke-PURun.ps1 -HealthCheckOnly -PUCredential $cred

Try to fix any discovered issues. (Optimally, you should resolve all critical Operations Manager alerts before a P&U run.)

### Step 3: Install the prerequisite VMM hotfix before you install Update 2.3

> [!NOTE]
> If you have already installed Update 2.1, you can skip this step.

An issue was introduced in Update Rollup 6 for System Center 2012 R2 Virtual Machine Manager (VMM): as soon as a host goes into legacy mode, it does not come back to eventing mode for 20 days. Therefore, the VM properties are not refreshed, and no events are received from Hyper-V for 20 days. This issue occurs because of a change in UR6 that sets the expiry as 20 days for both eventing mode and legacy mode. The legacy refresher, which should ideally run after 2 minutes, now runs after 20 days. Until then, eventing is disabled.

To resolve this issue, you must install the VMM hotfix by using the following instructions.

#### How to apply the private hotfix for VMM 2012 R2

> [!NOTE]
> The highly available VMM role (\<Prefix\>\-HA\-VMM) clustered role has two nodes: \<Prefix\>\-VMM\-01 and \<Prefix\>\-VMM\-02. In the instructions, we refer to these as Node1 and Node2.

1. From the specified location, copy the HostMode_Hotfix.exe file to a folder on a Console VM, such as C: \HostModeHotfix.
2. Double-click the HostMode_Hotfix.exe file, review the EULA, and then click Yes to accept.
3. Choose a folder to store the extracted files, such as C:\HostModeHotfix, and then click OK.
4. Determine the passive VMM node. To do this, open a Windows PowerShell ISE session and run the following script, where \<Prefix\> is your stamp prefix:

    ```
    $VmmServerName = "<Prefix>-HA-VMM"
    $vmmServer = Get-SCVMMServer -ComputerName $VmmServerName
    $activeNode = $vmmServer.ActiveVMMNode
    $passiveNodes = @()
    $vmmServer.FailoverVMMNodes | ForEach- Object {
    if($_.ToLower() -ne $activeNode.ToLower()){
    $passiveNodes += $_
    }
    }
    $passiveNodes
    ```

    This script returns the server name of the passive VMM node. In our example, we will assume that initially, Node2 is the passive node.
5. In File Explorer, browse to the following folder on the passive node:

    ```
    \\<Prefix>-VMM-0#>\c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager \bin
    ```

6. Make backup copies of the following files in the \bin folder:
    - Engine.Common.dll
    - Utils.dll
7. In the VMM console, determine which host (in the management cluster) the passive VMM node is running on.
8. Open Hyper-V Manager, connect to the management cluster host that you identified in the previous step, and connect to the passive VMM node.
9. On the VMM node, type powershell  to open an elevated Windows PowerShell session, and then run the following commands:

    ```azurepowershell
    Stop-Service SCVMMService 
    Stop-Service SCVMMAgent 
    ```

10. Verify that the services have stopped. To do this, run the following commands:

    ```azurepowershell
    Get- Service SCVMMService 
    Get-Service SCVMMAgent 
    ```

    Verify that the status of each is Stopped. If you're prompted to close the System Center Management Service Host process, click **Ignore**.
11. On the Console VM, browse to the following folder on the passive node:

    \\\\\<Prefix\>\-VMM\-0#\> \c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin

12. In the \bin folder, replace the following files with the new versions of the files that you extracted from the hotfix package:
    - Engine.Common.dl
    - Utils.dll
1. On the passive VMM node, run the following command to start the services:
  
    ```azurepowershell
    Start-Service SCVMMAgent 
    ```

    The SCVMMService will not start when the passive VMM server node is not active. The SCVMMService starts only when the node becomes the Active node. This is by design.
14. In Failover Cluster Manager, initiate a failover. This will make Node1 become the new passive node and Node2 (which has already been updated) become the active node:

    1. Open Failover Cluster Manager, and then connect to the \<Prefix\>\-CL\-VMM cluster.
    1. Click **Roles**. The Roles pane displays the active node in the **Owner Node** column. Right-click the active node, point to **Move**, and then click **Select Node**. Select the other node, and make sure that the status changes to **Running** for the new active node. This may take a few seconds.
1. Follow steps 6-13 to update the VMM files on the new passive node (in this example, Node1).

### To revert the patch (if necessary)

  1. On the passive VMM node, stop the SCVMMService service, and then stop the SCVMMAgent service.
  2. Replace the files under your Virtual Machine Manager Install directory with your backup files.
  3. Start the SCVMMAgent service.
  4. Start the SCVMMService service.
  5. In Failover Cluster Manager, initiate a failover of the \<Prefix\>\-HA\-VMM clustered role.
  6. Repeat steps A-D on the new passive node.

### Step 4: Run the P&U update package

Follow the procedures in the "Update the computers" section of the CPS Administrators Guide to apply Update 2.1. However, note that starting with Update 2.3, P&U automatically runs a health check as part of the update process. You can control what happens if critical Operations Manager alerts are discovered by changing the value of the -ScomAlertAction parameter.

The -ScomAlertAction parameter has the following possible values:

Parameter Value: Stop
Description: The default behavior for a P&U run. Runs all health checks, and then stops the P&U update run if there are critical Operations Manager alerts.

Parameter Value: Prompt
Description: Runs all health checks. If critical Operations Manager alerts are discovered, asks if you want to continue with the update process.

Parameter Value: Continue
Description: Runs all health checks. Outputs warning information if critical Operations Manager alerts are encountered, but continues with the update process.

The Administrators Guide shows the following command to start the P&U run:

```
\\<Name of SOFS in rack 1>\SU1_InfrastructureShare1\<CPSPU Folder Name>\Framework \PatchingUpgrade\Invoke-PURun.ps1 -PUCredential $cred
```

If you run this command exactly as shown, P&U will run a health check as part of the update process, applying the default behavior, where -ScomAlertAction is set to Stop .

To change the -ScomAlertAction option to Prompt or Continue, set the -ScomAlertAction parameter to the value that you want. For example:

```
\\\SU1_InfrastructureShare1\Framework\PatchingUpgrade\Invoke-PURun.ps1 -ScomAlertAction "Continue" -PUCredential $cred 
```

> [!NOTE]
> Because you already have Update 2.0 installed, you can ignore the "Additional prerequisites for Update 2" section in the CPS Administrators Guide.

## Updates for Windows Server 2012 R2

- "STATUS_CONNECTION_RESET" error when an application reads a file in Windows Server 2012 R2 or Windows Server 2012 R2
 [https://support.microsoft.com/kb/3076950](https://support.microsoft.com/help/3076950)
- MS15-105: Description of the security update for Hyper-V: September 8, 2015
 [https://support.microsoft.com/kb/3087088](https://support.microsoft.com/help/3087088)
- MS15-109: Description of the security update for Windows Shell: October 13, 2015
 [https://support.microsoft.com/en- us/kb/3080446](https://support.microsoft.com/help/3080446)
- Hyper-V host crashes and has errors when you perform a VM live migration in Windows 8.1 and Windows Server 2012 R2
 [https://support.microsoft.com/en- us/kb/3031598](https://support.microsoft.com/help/3031598)
- Files aren't fully optimized and a deduplication cache lock contention issue occurs in Windows Server 2012 R2 [https://support.microsoft.com/kb/3094197](https://support.microsoft.com/help/3094197)
- MS15- 115: Description of the security update for Windows: November 10, 2015
 [https://support.microsoft.com/kb/3097877](https://support.microsoft.com/help/3097877)
- MS15-128 and MS15-135: Description of the security update for Windows kernel-mode drivers: December 8, 2015
 [https://support.microsoft.com/en- us/kb/3109094](https://support.microsoft.com/help/3109094)
- MS15-127: Security update for Microsoft Windows DNS to address remote code execution: December 8, 2015
 [https://support.microsoft.com/kb/3100465](https://support.microsoft.com/help/3100465)
- MS15-133: Description of the security update for Windows PGM: December 8, 2015
 [https://support.microsoft.com/kb/3109103](https://support.microsoft.com/help/3109103)
- MS15-132: Description of the security update for Windows: December 8, 2015
 [https://support.microsoft.com/kb/3108347](https://support.microsoft.com/help/3108347)
- MS15-128: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: December 8, 2015
 [https://support.microsoft.com/kb/3099864](https://support.microsoft.com/help/3099864)
- MS15- 132: Description of the security update for Windows: December 8, 2015
 [https://support.microsoft.com/kb/3108381](https://support.microsoft.com/help/3108381)
- MS16-008: Description of the security update for Windows Kernel: January 12, 2016
 [https://support.microsoft.com/en- us/kb/3121212](https://support.microsoft.com/help/3121212)
- MS16-007: Description of the security update for Windows: January 12, 2016
 [https://support.microsoft.com/kb/3110329](https://support.microsoft.com/help/3110329)
- MS16-007: Description of the security update for Windows: January 12, 2016
 [https://support.microsoft.com/en- us/kb/3121918](https://support.microsoft.com/help/3121918)
- MS16-005: Description of the security update for Windows kernel-mode drivers: January 12, 2016
 [https://support.microsoft.com/kb/3124001](https://support.microsoft.com/help/3124001)
 Notes
- The version of the VMM Service Template in this article is 3.2.8118.0.
- This package may be also referred to as Build 1601.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
