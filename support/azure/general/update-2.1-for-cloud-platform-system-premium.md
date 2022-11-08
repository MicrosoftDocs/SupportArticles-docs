---
title: Update 2.1 for Cloud Platform System Premium
description: Describes the steps to install Update 2.1 for Cloud Platform System Premium.
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.date: 08/14/2020
ms.reviewer: 
---
# Update 2.1 for Cloud Platform System Premium

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3119861

Update 2.1 for Cloud Platform System (CPS) Premium 1.0 includes critical Windows updates, an additional private hotfix for VMM 2012 R2, and a new functionality that enables you to run a health check before you perform an update run. The list of Windows Updates is included at the end of this article.

> [!NOTE]
> There are no driver or firmware updates included in this update package.

## More information

To install update 2.1 for CPS Premium 1.0, follow these steps. This update procedure assumes that you have already installed Update 2.0:

### Step 1: Prepare the package

Follow steps 1 and 2 in the "Prepare the patching environment" section of the CPS Administrators Guide that was provided by your account team. Because there are no firmware or driver updates, steps 3 and 4 from the CPS Administrators Guide do not apply.

IMPORTANT: Do not start the patching process.

### Step 2: Run a health check and fix any discovered issues

The Microsoft Patch and Update (P&U) Framework supports new functionality that enables you to run a non-invasive, read-only health check. This ensures fundamental stamp health before you run the actual update.

To run the health check, use the -HealthCheckOnly parameter when you invoke the P&U run.

1. Make sure that you are logged on as the account that you created for patching, such as CPS-Update-Admin. Then, run the following Windows PowerShell command: $cred = Get-Credential (whoami).
2. When prompted, enter the account password.
3. Run the following command, where CPSPU Folder Name is the folder name that you used for the specific update package:

```
\\<Name of SOFS in rack 1>\SU1_InfrastructureShare1\<CPSPU Folder Name>\Framework\PatchingUpgrade\Invoke-PURun.ps1 -HealthCheckOnly -PUCredential $cred
```

4. Try to fix any discovered issues. Ideally, you should try to resolve all critical Operations Manager alerts before a P&U run.

#### General overview of the types of health checks for Update 2.1

1. Ensures that P&U was invoked by an Administrator.
2. Checks the minimum disk space on management virtual machines and hosts required for offline VHD servicing.

3. Checks for password expiration on the service accounts.

4. Checks to ensure the Firewall Service is running.

5. Checks to ensure the Windows Update Agent can get a list of installed KB updates on hosts and management virtual machines.

6. Checks to ensure there are no unresolved Critical System Center Operations Manager alerts. This check uses the newly added -ScomAlertAction parameter. By default, this parameter is set to "Stop." This does not stop the health check if a critical alert is encountered. All checks still run, and the health check reports error information at the end of the health check.

#### WSUS related health checks (always run)

1. WSUS Server check to ensure that components are healthy.
2. Checks to ensure that the WSUS Server is not set to download Express packages.
3. Checks that the current user is a WSUS administrator.
4. Checks the WSUS Server for duplicate and/or unnecessary content revisions.
5. Ensures that the last WSUS Server synchronization was successful.

#### WSUS related health checks (second and subsequent P&U runs)

1. Ensures that the list of VMM management virtual machines matches the WSUS computer list of virtual machines.
2. Checks to ensure that the management virtual machines and hosts are regularly contacting WSUS.

#### Cluster Health

1. Ensures that cluster nodes are "Up".
2. Ensures that cluster resources are "Online".
3. Ensures that guest cluster virtual machines are not in "Failed" state.

#### Additional 2.1 specific health checks

1. Checks to ensure that all management virtual machines are running.
2. Ensures the correct WSMan connectivity to virtual machines and hosts.
3. Ensures that the correct Windows PowerShell execution policies are set.
4. Ensures that the management virtual machine service templates are valid.
5. Checks both File Server and Active Directory virtual machine health.
6. Checks for the correct state of the SCOM database Recovery Model.
7. Checks load balancer availability.
8. Checks to ensure that the FirmwareAndDrivers folder in the CAU hotfixes share does not contain unexpected content.

### Step 3: Install the prerequisite VMM hotfix before you install Update 2.1

There was an issue introduced in Update Rollup 6 for System Center 2012 R2 Virtual Machine Manager (VMM), where as soon as a host goes into legacy mode, it does not come back to eventing mode for 20 days. Therefore, the VM properties are not refreshed, and no events are received from Hyper-V for 20 days.

This issue occurs because of a change in UR6 that sets the expiry as 20 days for both eventing mode and legacy mode. The legacy refresher, which should ideally run after 2 minutes, now runs after 20 days; and until then, eventing is disabled.

To resolve this issue, you must install the VMM hotfix by using the following instructions.

#### How to apply the private hotfix for VMM 2012 R2

> [!NOTE]
> The highly-available VMM role (*&#60;Prefix&#62;-HA-VMM*) clustered role has two nodes; *&#60;Prefix&#62;-VMM-01* and *&#60;Prefix&#62;-VMM-02*. In the instructions, we refer to these as Node1 and Node2.

1. From the specified location, copy the HostMode_Hotfix.exe file to a folder on a Console VM, such as C:\HostModeHotfix.
2. Double-click the HostMode_Hotfix.exe file, review the EULA, and then click Yes to accept.
3. Choose a folder to store the extracted files, such as C:\HostModeHotfix, and then click OK .
4. Determine the passive VMM node. To do this, open a Windows PowerShell ISE session and run the following script, where Prefix is your stamp prefix.

    ```
    $VmmServerName = "<Prefix>-HA-VMM"
    $vmmServer = Get-SCVMMServer -ComputerName $VmmServerName 
    $activeNode = $vmmServer.ActiveVMMNode
    $passiveNodes = @()
    $vmmServer.FailoverVMMNodes | ForEach-Object { 
     if($_.ToLower() -ne $activeNode.ToLower()){
     $passiveNodes += $_
     }
    }
    $passiveNodes
    ```

    This script returns the server name of the passive VMM node. (In our example, we will assume that initially, Node2 is the passive node.)
5. In File Explorer, browse to the following folder on the passive node:

     \\&#60;Prefix&#62;-VMM-0#>\c$\Program  
     Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin
1. Make backup copies of the following files in the \bin folder:
     - Engine.Common.dll  
     - Utils.dll
1. In the VMM console, determine which host (in the management cluster) the passive VMM node is running on.
1. Open Hyper-V Manager, connect to the management cluster host that you identified in the previous step, and connect to the passive VMM node.
1. On the VMM node, type PowerShell to open an elevated Windows PowerShell session, and run the following commands:

    ```
    Stop-Service SCVMMService
    Stop-Service SCVMMAgent 
    ```

1. Verify the services have stopped. Type the following commands:

    ```
    Get-Service SCVMMService
    Get-Service SCVMMAgent
    ```

    Verify that the status of each is Stopped. If you are prompted to close the System Center Management Service Host process, click Ignore.

1. On the Console VM, browse to the following folder on the passive node:
 \\&#60;Prefix&#62;-VMM-0#>\c$\Program  
 Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin
1. In the \bin folder, replace the following files with the new versions of the files that you extracted from the hotfix package.
    - Engine.Common.dll  
    - Utils.dll
1. On the passive VMM node, run the following commands to start the services: `Start-Service SCVMMAgent`

    The SCVMMService will not start when the passive VMM server node is not active. The SCVMMService will start only when the node becomes the Active node. This is by design.
1. In Failover Cluster Manager, initiate a failover. This will result in Node1 becoming the new passive node and Node2 (which has already been updated) becoming the active node.
1. Open Failover Cluster Manager and connect to the &#60;Prefix&#62;-CL-VMM cluster.
1. Click Roles. The Roles pane displays the active node in the Owner Node column. Right-click the active node, point to Move , and then click Select Node . Select the other node, and make sure the status changes to Running for the new active node. This may take a few seconds.

15. Follow steps 6 through 13 to update the VMM files on the new passive node (in this example, Node1).

#### To revert the patch (if needed)

1. On the passive VMM node, stop the SCVMMService service, and then stop the SCVMMAgent service.
2. Replace the files under your Virtual Machine Manager Install directory with your backup files.
3. Start the SCVMMAgent service.
4. Start the SCVMMService service.
5. In Failover Cluster Manager, initiate a failover of the &#60;Prefix&#62;-HA-VMM clustered role.
6. Repeat steps 1 through 4 on the new passive node.

### Step 4: Run the P&U update package

Follow the procedures in the "Update the computers" section of the CPS Administrators Guide to apply Update 2.1. However, note that starting with Update 2.1, P&U automatically runs a health check as part of the update process. You can control what happens if critical Operations Manager alerts are discovered by changing the value of the -ScomAlertAction parameter.

The -ScomAlertAction parameter has the following possible values:

Parameter Value: Stop
Description: The default behavior for a P&U run. Runs all health checks, and then stops the P&U update run if there are critical Operations Manager alerts.

Parameter Value: Prompt
Description: Runs all health checks. If critical Operations Manager alerts are discovered, asks if you want to continue with the update process.

Parameter Value: Continue
Description: Runs all health checks. Outputs warning information if critical Operations Manager alerts are encountered, but continues with the update process.

The Administrators Guide shows the following command to start the P&U run.

```
\\<Name of SOFS in rack 1>\SU1_InfrastructureShare1\<CPSPU Folder Name>\Framework\PatchingUpgrade\Invoke-PURun.ps1 -PUCredential $cred
```

If you run this command exactly as shown, P&U will run a health check as part of the update process, with the default behavior, where -ScomAlertAction is set to "Stop."

To change to "Prompt" or "Continue", specify the -ScomAlertAction parameter with the desired value, for example:

```
\\<Name of SOFS in rack 1>\SU1_InfrastructureShare1\Framework\PatchingUpgrade\Invoke-PURun.ps1 -ScomAlertAction "Continue" -PUCredential $cred
```

> [!NOTE]
> Because you already have Update 2.0 installed, you can ignore the "Additional prerequisites for Update 2" section in the CPS Administrators Guide.

## Updates for Windows Server 2012 R2  

MS15-105: Description of the security update for Hyper-V: September 8, 2015 - [https://support.microsoft.com/kb/3087088](https://support.microsoft.com/help/3087088)
MS15-109: Description of the security update for Windows Shell: October 13, 2015 - [https://support.microsoft.com/kb/3080446](https://support.microsoft.com/help/3080446)
MS15-115: Description of the security update for Windows: November 10, 2015 - [https://support.microsoft.com/kb/3097877](https://support.microsoft.com/help/3097877)
Files aren't fully optimized and a deduplication cache lock contention issue occurs in Windows Server 2012 R2 - [https://support.microsoft.com/kb/3094197](https://support.microsoft.com/help/3094197)
Hyper-V host crashes and has errors when you perform a VM live migration in Windows 8.1 and Windows Server 2012 R2 - [https://support.microsoft.com/kb/3031598](https://support.microsoft.com/help/3031598)"STATUS_CONNECTION_RESET" error when an application reads a file in Windows Server 2012 R2 or Windows Server 2012 R2 - [https://support.microsoft.com/kb/3076950](https://support.microsoft.com/help/3076950)

## References

- [Read the CPS overview white paper](https://download.microsoft.com/download/0/e/7/0e74a4a3-6d35-4a14-ad94-fedf8d265d36/microsoft_cloud_platform_system_white_paper.pdf)
- [Download the CPS datasheet](https://download.microsoft.com/download/1/4/c/14ce6fe8-e5ea-4979-8278-8156a5cdae2b/cloud_platform_system_datasheet.pdf)
- [Download the IDC Solution brief on the value of integrated systems](http://idcdocserv.com/idc_solution_brief_254796)

> [!NOTE]
> The version of the VMM Service template in this article is 3.2.8039.0.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
