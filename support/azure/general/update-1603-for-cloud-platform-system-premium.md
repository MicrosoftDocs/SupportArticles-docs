---
title: Update 1603 for Cloud Platform System Premium
description: Describes Update 1603 for Cloud Platform System Premium and provides installation steps.
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.date: 08/14/2020
ms.reviewer: 
---
# Update 1603 for Cloud Platform System Premium

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3143326

Update 1603 for Cloud Platform System (CPS) 1.0 Premium includes updates for Windows Server 2012 R2, Microsoft System Center 2012 R2, and Windows Azure Pack. Update 1603 also includes functionality that enables you to run a Health Check on the stamp before you do an update. The list of updates is included at the end of this article. Additionally, new functionality enables you to run a compliance scan to make sure that updates are installed successfully.

> [!NOTE]
> This update package includes driver and firmware updates in addition to configuration updates.

## How to install the update

To install update 2.3 for CPS Premium 1.0, follow these steps. This update procedure assumes that you already installed Update 2.0.

### Step 1: Prepare the package

Follow the steps in the "Prepare the patching environment" section of the CPS Administrators Guide that was provided by your account team.

> [!IMPORTANT]
> Do not start the update process. Instead, run the Health Check in the Step 2.

### Step 2: Run the Health Check and fix any issues

In the "Update the computers" section of the CPS Premium Administrators Guide, complete Step 1: "Run a health check and fix any discovered issues." This includes new functionality that lets you check for and disable any running backup jobs.

### Step 3: Install the prerequisite VMM hotfix before you install Update 1603

> [!IMPORTANT]
> If you have already installed Update 2.1 or a later version that requires the Virtual Machine Manager (VMM) hotfix that is described in this step, you can skip this step. If you use a CPS 1.0 installation that has Update 2 installed, you must complete this step.

#### How to apply the private hotfix for VMM 2012 R2

The highly available Rack_Prefix-HA-VMM clustered role has two nodes: Rack_Prefix-VMM-01 and Rack_Prefix-VMM-02. In these steps, we refer to these as Node1 and Node2. To apply the VMM 2012 R2 hotfix, follow these steps:

1. Copy the HostMode_Hotfix.exe file to a folder on a Console virtual machine (VM), such as C:\HostModeHotfix.

2. Double-click the HostMode_Hotfix.exe file, review the Microsoft Software License Terms, and then click **Yes** to accept.

3. Select a folder, such as C:\HostModeHotfix, in which to store the extracted files, and then click **OK**.

4. Determine the passive VMM node. To do this, open a Windows PowerShell ISE session, and then run the following script, where <Rack_Prefix-HA-VMM> is your stamp prefix:

    ```
    $VmmServerName = "Rack_Prefix-HA-VMM" $vmmServer = Get-SCVMMServer -ComputerName $VmmServerName $activeNode = $vmmServer.ActiveVMMNode $passiveNodes = @() $vmmServer.FailoverVMMNodes | ForEach- Object { if($.ToLower() -ne $activeNode.ToLower()){ $passiveNodes += $ } } $passiveNodes
    " $vmmServer = Get-SCVMMServer -ComputerName $VmmServerName $activeNode = $vmmServer.ActiveVMMNode $passiveNodes = @() $vmmServer.FailoverVMMNodes | ForEach- Object { if($.ToLower() -ne $activeNode.ToLower()){ $passiveNodes += $ } } $passiveNodes
    ```

    > [!NOTE]
    > This script returns the server name of the passive VMM node. (In our example, we assume that Node2 is the passive node at first.)
5. In File Explorer, locate the following folder on the passive node:

    ```
    \\Rack_Prefix-VMM-0#>\c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin 
    ```

6. Make backup copies of the following files in the \bin folder:

    - Engine.Common.dll
    - Utils.dll
7. In the VMM console, determine on which host (in the management cluster) the passive VMM node is running.
8. Open Hyper-V Manager, connect to the management cluster host that you identified in step 4, and connect to the passive VMM node.

9. On the VMM node, type powershell to open an elevated Windows PowerShell session, and then run the following command:

    ```
    Stop-Service SCVMMService Stop-Service SCVMMAgent
    ```  

10. Verify that the services have stopped. To do this, run the following command:

    ```
    Get-Service SCVMMService Get-Service SCVMMAgent
    ```  

    Verify that the status of each is **Stopped**. If you're prompted to close the System Center Management Service Host process, click **Ignore**.
11. On the Console VM, locate the following folder on the passive node:

    ```
    \\Rack_Prefix-VMM-0#>\c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin
    ```

12. In the \bin folder, replace the following files by using the new versions of the files that you extracted from the hotfix package:

    - Engine.Common.dll
    - Utils.dll
13. On the passive VMM node, run the following command to start the services:

    ```
    Start-Service SCVMMAgent
    ```  

    > [!NOTE]
    > The SCVMMService service does not start when the passive VMM server node is not active. The SCVMMService starts only when the node becomes the active node. This behavior is by design.
14. In Failover Cluster Manager, start a failover. This makes Node1 the new passive node and Node2 (which has already been updated) the active node.
15. Open Failover Cluster Manager, and then connect to the -CL-VMM cluster.
16. Click **Roles**. The **Roles** pane displays the active node in the **Owner Node** column.
17. Right-click the active node, point to **Move**, and then click **Select Node**.
18. Select the other node, and make sure that the status changes to **Running** for the new active node. This may take several seconds.
19. Follow steps 7-13 to update the VMM files on the new passive node (in this example, Node1).

#### How to revert the update

To revert the update installation (if it's necessary), follow these steps:

1. On the passive VMM node, stop the SCVMMService service, and then stop the SCVMMAgent service.
2. Replace the files in your Virtual Machine Manager Install folder by using your backup files.
3. Start the SCVMMAgent service.
4. Start the SCVMMService service.
5. In Failover Cluster Manager, start a failover of the -HA-VMM clustered role.
6. Repeat steps 1-4 on the new passive node.

### Step 4: Run the P&U update package

In the "Update the computers" section of the CPS Administrators Guide, follow "Step 2: Apply the P&U update package" and "Step 3: Post-update clean up" to apply Update 1603.

> [!NOTE]
> Starting in Update 1603, the Microsoft Patch and Update Framework (P&U) automatically runs a health check as part of the update process. You can control what happens if critical Operations Manager alerts are discovered. To do this, change the value of the -ScomAlertAction parameter. See the Administrators Guide for more information.

After the update installation is complete, remember to enable DPM agents if you disabled them earlier (as described in the Administrators Guide).

### Step 5: Run an optional compliance scan

To run a compliance scan, pass the following flag:

```
\\SU1_InfrastructureShare1<CPSPU Folder Name>\Framework\PatchingUpgrade\Invoke-PURun.ps1 -PUCredential $cred -ComplianceScanOnly
```

> [!NOTE]
> The compliance scan output is written to the location where the update package was extracted. For example, the scan is written to "PURoot"\MissingUpdates.json.

### Step 6: Update network switch firmware

> [!IMPORTANT]
> Only customers who run CPS Premium with 2014 hardware (S4810 and S55 switches) have to update switch firmware for Update 1603.

To update the network switch firmware, follow the steps in the "Update network switch firmware" section of the CPS Premium Administrators Guide.

### Step 7: Update the F5 load balancer firmware

To update the network switch firmware, follow the steps in the "Update F5 load balancer firmware" section of the CPS Premium Administrators Guide.

### Updates for Windows Server 2012 R2

- ["STATUS_CONNECTION_RESET" error when an application reads a file in Windows Server 2012 R2 or Windows Server 2012 R2](https://support.microsoft.com/help/3076950)
- [MS15-105: Description of the security update for Hyper-V: September 8, 2015](https://support.microsoft.com/help/3087088)
- [S15-109: Description of the security update for Windows Shell: October 13, 2015](https://support.microsoft.com/help/3080446)
- [Hyper-V host crashes and has errors when you perform a VM live migration in Windows 8.1 and Windows Server 2012 R2](https://support.microsoft.com/help/3031598)
- [Files aren't fully optimized and a deduplication cache lock contention issue occurs in Windows Server 2012 R2](https://support.microsoft.com/help/3094197)
- [MS15- 115: Description of the security update for Windows: November 10, 2015](https://support.microsoft.com/help/3097877)
- [MS15-128 and MS15-135: Description of the security update for Windows kernel-mode drivers: December 8, 2015](https://support.microsoft.com/help/3109094)
- [MS15-127: Security update for Microsoft Windows DNS to address remote code execution: December 8, 2015](https://support.microsoft.com/help/3100465)
- [MS15-133: Description of the security update for Windows PGM: December 8, 2015](https://support.microsoft.com/help/3109103)
- [MS15-132: Description of the security update for Windows: December 8, 2015](https://support.microsoft.com/help/3108347)
- [MS15-128: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: December 8, 2015](https://support.microsoft.com/help/3099864)
- [MS15- 132: Description of the security update for Windows: December 8, 2015](https://support.microsoft.com/help/3108381)
- [MS16-008: Description of the security update for Windows Kernel: January 12, 2016](https://support.microsoft.com/help/3121212)
- [MS16-007: Description of the security update for Windows: January 12, 2016](https://support.microsoft.com/help/3110329)
- [MS16-007: Description of the security update for Windows: January 12, 2016](https://support.microsoft.com/help/3121918)
- [MS16-005: Description of the security update for Windows kernel-mode drivers: January 12, 2016](https://support.microsoft.com/help/3124001)
- [Hyper-V integration components update for Windows virtual machines that are running on a Windows 10-based host](https://support.microsoft.com/help/3063109)
- [Space doesn't regenerate upon reallocation in Windows Server 2012 R2](https://support.microsoft.com/help/3090322)
- [Site-to-site VPN goes down in Windows 8.1 or Windows Server 2012 R2](https://support.microsoft.com/help/3091402)
- [System fails back to a host copy instead of an array copy or storages go down after LUN reset in Windows Server 2012 R2](https://support.microsoft.com/help/3121261)
- [All disks in a storage pool can't be brought online in a Windows Server 2012 R2-based cluster](https://support.microsoft.com/help/3123538)
- [MS16-035: Description of the security update for the .NET Framework 3.5 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: March 8, 2016](https://support.microsoft.com/help/3135985)
- [MS16-035: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: March 8, 2016](https://support.microsoft.com/help/3135991)
- [MS16-035: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: March 8, 2016](https://support.microsoft.com/help/3135994)
- [MS16-028: Description of the security update for Windows PDF Library: March 8, 2016](https://support.microsoft.com/help/3137513)
- [MS16-033: Description of the security update for Windows USB mass storage class driver: March 8, 2016](https://support.microsoft.com/help/3139398)
- [MS16-034: Description of the security update for Windows kernel-mode drivers: March 8, 2016](https://support.microsoft.com/help/3139852)
- [MS16-032: Description of the security update for the Windows Secondary Logon Service: March 8, 2016](https://support.microsoft.com/help/3139914)
- [MS16-030: Description of the security update for Windows OLE: March 8, 2016](https://support.microsoft.com/help/3139940)
- [MS16-026: Description of the security update for graphic fonts: March 8, 2016](https://support.microsoft.com/help/3140735)
- [MS16-019: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: February 9, 2016](https://support.microsoft.com/help/3122651)
 -[MS16-019: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: February 9, 2016](https://support.microsoft.com/help/3122654)
- [MS16-012: Description of the security update for Windows PDF Library: February 9, 2016](https://support.microsoft.com/help/3123294)
- [MS16-014: Description of the security update for Windows 8.1 and Windows Server 2012 R2: February 9, 2016](https://support.microsoft.com/help/3126434)
- [MS16-017: Description of the security update for Remote Desktop display driver: February 9, 2016](https://support.microsoft.com/help/3126446)
- [MS16-014: Description of the security update for Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows Server 2012, Windows 8.1, and Windows Server 2012 R2: February 9, 2016](https://support.microsoft.com/help/3126587)
- [MS16-014: Description of the security update for Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows Server 2012, Windows 8.1, and Windows Server 2012 R2: February 9, 2016](https://support.microsoft.com/help/3126593)
- [MS16-021: Security update for NPS RADIUS server to address denial of service: February 9, 2016](https://support.microsoft.com/help/3133043)
- [MS16-018: Description of the security update for Windows kernel-mode drivers: February 9, 2016](https://support.microsoft.com/help/3134214)
- [MS16-020: Security update for Active Directory Federation Services to address denial of service: February 9, 2016](https://support.microsoft.com/help/3134222)

### Updates for System Center 2012 R2 and Windows Azure Pack

- [Update Rollup 9 for System Center 2012 R2 Data Protection Manager](https://support.microsoft.com/help/3112306)
- [Update Rollup 9 for System Center 2012 R2 Operations Manager](https://support.microsoft.com/help/3129774)
- [Update Rollup 9 for System Center 2012 R2 Orchestrator - Service Provider Foundation](https://support.microsoft.com/help/3133705)
- [Update Rollup 9 for System Center 2012 R2 Virtual Machine Manager](https://support.microsoft.com/help/3129784)
- [Security Update Rollup 9.1 for Windows Azure Pack](https://support.microsoft.com/help/3146301)

### Hardware updates

Firmware and driver updates are incorporated into the Microsoft Patch and Update Framework (P&U) for this release. As part of the P&U process, every node is updated to have the most current tested version of firmware or drivers to help provide optimal system performance.

The following automated firmware updates are applied as part of CPS 1.0 Update 1603.

|Component|Platform|Version|
|---|---|---|
|LSI 9207-8e (Dell Part # 4G89X)|R620|2.00.78.00|
|LSI 9207-8e (Dell Part # 4G89X)|R620 v2|2.00.78.00|
|LSI 9207-8e (Dell Part # 4G89X)|R630|2.00.78.00|
|BMC|C6220 II|2.62|
|BIOS|C6320|1.1.4|
|IDRAC8|C6320|2.30.30.30|
|iDRAC7|R620|2.30.30.30|
|iDRAC7|R620 v2|2.30.30.30|
|BIOS|R630|1.5.4|
|iDRAC8|R630|2.30.30.30|
|LifeCycle Controller2|R630|2.30.30.30|
|PERC H330|R630|25.4.0.0015|
|Toshiba Phoenix M2 MU P/N K41XJ|R630|A3AF|
|Active Fabric Manager (AFM)|Force10|AFM-CPS-2.0.0.0PX|
|Switch|S4810|9.9.0.0|
|Switch|S55|8.3.5.6|
|Load Balancer|VIPRION 2150|11.5.3 HF2|
|Load Balancer|VIPRION 2100|11.5.3 HF2|

> [!NOTE]
> The version of the VMM Service Template in this update is 3.2.8226.0 .

### Configuration changes

|Node|Update|
|---|---|
|Storage|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\spaceport\Parameters" -Name ResetInterval -Type DWord -Value 20000|
|Storage|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\spaceport\Parameters" -Name ResetUnresponsiveTimeout -Type DWord -Value 10000|
  
[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
