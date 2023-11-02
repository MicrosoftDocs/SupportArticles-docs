---
title: Update 1610 for Cloud Platform System (CPS) Premium
description: Describes Update 1610 for Cloud Platform System (CPS) Premium and provides detailed steps to install Update 1610 for CPS Premium.
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.reviewer: ashtons
---
# Update 1610 for Cloud Platform System (CPS) Premium

This article describes Update 1610 for Cloud Platform System (CPS) Premium and provides detailed steps to install Update 1610 for CPS Premium.

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3200950

## Summary

Update 1610 for Cloud Platform System (CPS) Premium includes updates for Windows Server, Microsoft System Center, Microsoft SQL Server, and hardware components. This update includes the contents of Updates 1605, 1606, 1607, 1608, and 1609. It also contains the following components:

- 1610-0 Update: This includes two updates that are required for Windows servicing. These updates were previously released in Updates 1605, 1606, 1607, 1608, and 1609.
- 1610-1 Update: This is the main package. It contains four new Windows updates and System Center Endpoint Protection antivirus definitions, plus the updates that were previously released in Updates 1605, 1606, 1607, 1608, and 1609.
- An update for Dell Active Fabric Manager (AFM) and the corresponding switch firmware updates (that were included in Update 1608).

> [!NOTE]
> Update 1603 is a prerequisite for installing Update 1610. Update 1610 is a rollup update that also contains the payload from Updates 1605, 1606, 1607, 1608, and 1609. You do not have to have Update 1605, 1606, 1607, 1608, or 1609 installed to install Update 1610.

## More information

To install Update 1610 for CPS Premium, follow these steps.

> [!NOTE]
>
>- This procedure assumes that Update 1603 is already installed.
>- For any references to the CPS Premium Administrators Guide, refer to the update version that is provided by your account team.

### Step 1: Update network switch firmware

A new AFM firmware update was released for Update 1609. If you applied the network switch firmware updates for 1608, you have to install only the AFM update. If you skipped Update 1608, you should install the AFM update and also update the network switches to the recommended firmware versions. If you applied both the network switch firmware from 1608 and the updated AFM from 1609, you can skip these steps because this content has not changed for Update 1610.

Follow the steps in the "Update network switch firmware" section of the "1609" version of the CPS Premium Administrators Guide that was provided by your account team. Do not use the instructions from an earlier version of the Administrators Guide.

For the download location of the AFM files for Update 1610, see [https://poweredgec.dell.com/cps/CPS_P_1611/Tools/AFM/](https://poweredgec.dell.com/cps/CPS_P_1611/Tools/AFM/).

AFM will be updated to version 2.1(0.0)P2. The following table lists the recommended firmware versions that switches should run after the update.

|Device|Recommended firmware version|CPS Premium hardware version|
|---|---|---|
|S4048|9.10(0.1)P8|2016|
|S3048|9.10(0.1)P8|2016|
|S4810|9.10(0.1)P8|2014|
|S55|8.3.5.6|2014|
  
### Step 2: Update serial port concentrator firmware

> [!NOTE]
> This is the same update that was originally released as part of Update 1607. If you made this update when you applied Update 1607, you do not have to be make it again.

Follow the steps in the "Update serial port concentrator firmware" section of the CPS Premium Administrators Guide that was provided by your account team.

Download the following:

- Avocent ACS 6000 Series
- [Digi CM 48](https://ftp1.digi.com/support/firmware/80007070_u.bin)

The following table lists the recommended firmware versions that the serial port concentrator should run after the update.

|Device|Recommended firmware version|CPS Premium hardware version|
|---|---|---|
|Avocent ACS 6000 Series|3.3.0.10|2016|
|Digi CM 48|1.9.5.3|2014|
  
### Step 3: Install the VMM hotfixes for VM placement

- If you installed the VMM hotfix for virtual machine (VM) placement that was included in Update 1606, 1607, 1608, or 1609, you do not have to install it again. If this is true, you can skip this step and go to Step 4.
- The highly available VMM clustered role (**\<Prefix>** -HA-VMM) has two nodes, **\<Prefix>** -VMM-01 and **\<Prefix>** -VMM-02. In these steps, we refer to these as Node1 and Node2.

To install the VMM hotfixes, follow these steps:

1. For the new VMM placement hotfix, follow these steps:
    1. From the update file drop location, copy the Placement_HF_UR9.exe file to a folder on a Console VM, such as `C:\VMMHotfix`.

        > [!NOTE]
        > You can use the same folder that was used for the previous hotfix.

    2. Double-click the Placement_HF_UR9.exe file, review the End User License Agreement (EULA), and then click **Yes** to accept the terms.
    3. Select a folder in which to store the extracted files. For example, select `C:\VMMHotfix`. Then, click **OK**.
2. Determine the passive VMM node. To do this, open a Windows PowerShell ISE session, and then run the following script:

    ```powershell
    $prefix = $ENV:COMPUTERNAME.split('-')[0]
    $VmmServerName = "$prefix-HA-VMM"
    $vmmServer = Get-SCVMMServer -ComputerName $VmmServerName
    $activeNode = $vmmServer.ActiveVMMNode
    $passiveNodes = @() $vmmServer.FailoverVMMNodes | ForEach-Object { if($_.ToLower() -ne $activeNode.ToLower()){ $passiveNodes += $_ } }
    Write-Host "Active Node: $activeNode" -ForegroundColor GreenWrite-Host "Passive Node: $passiveNodes" -ForegroundColor Green
    ```

    This script returns the server name of the passive VMM node. (In our example, we assume that Node2 is the default passive node.)
3. In File Explorer, locate the following folder on the passive node:`\\<Prefix>-VMM-0#>\c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin`
4. Make a backup copy of the following file in the \bin folder:
`Engine.Placement.ResourceModel.dll`.
5. In the VMM console, determine which host (in the management cluster) the passive VMM node is running on.
6. Open Hyper-V Manager, connect to the management cluster host that you identified in the step 5, and then connect to the passive VMM node.
7. On the VMM node, type `powershell` to open an elevated Windows PowerShell session, and then run the following commands:

    ```powershell
    Stop-Service SCVMMService

    Stop-Service SCVMMAgent
    ```  

8. Verify that the services have stopped. To do this, run the following commands:

    ```console
    Get-Service SCVMMService

    Get-Service SCVMMAgent
    ```  

    > [!NOTE]
    > If you are prompted to close the System Center Management Service Host process, click **Ignore**.
9. On the Console VM, locate the following folder on the passive node:`\\<Prefix>-VMM-0#\c$\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin`
10. In the \bin folder, replace the following file by using the new version of the file that you extracted from the hotfix package: `Engine.Placement.ResourceModel.dll`.
11. On the passive VMM node, run the following command to start the VMM Agent service:

    ```powershell
    Start-Service SCVMMAgent
    ```  

    > [!NOTE]
    > The SCVMMService service does not start if the passive VMM server node is not active. SCVMMService starts only when the node becomes the Active node. This behavior is by design.
12. In Failover Cluster Manager, start a failover. This will set Node1 as the new passive node and set Node2 (which has already been updated) as the active node.
13. Open Failover Cluster Manager, and then connect to the **\<Prefix>** -CL-VMM cluster.
14. Click **Roles**.

    > [!NOTE]
    > The **Roles** pane displays the active node in the **Owner Node** column.

15. Right-click the active node, point to **Move**, and then click **Select Node**.
16. Select the other node, and make sure that the status changes to **Running** for the new active node.

    > [!NOTE]
    > The change may take several seconds to occur.

17. Follow steps 5-11 to update the VMM file on the new passive node (in this example, Node1).

#### Revert the update (if necessary)

If you must revert the update, follow these steps:

1. On the passive VMM node, stop the SCVMMAgent service.
2. Replace the files under your Virtual Machine Manager Install folder by using your backup files.
3. Start the SCVMMAgent service.
4. In Failover Cluster Manager, start a failover of the **\<Prefix>** -HA-VMM clustered role.
5. Repeat steps 1-4 on the new passive node.

### Step 4: Prepare the package

Follow the steps in the "Prepare the patching environment" section of the CPS Premium Administrators Guide that was provided by your account team.

Extract both the 1610-0 and 1610-1 updates, and then put them into different folders on the Infrastructure share.

Information about the firmware download steps is in the "1609" version of the Administrators Guide in on page 183 of the "Step 3: Add the firmware and driver updates to the P&U package (if stamp not connected to internet)" section. Even if these updates were already applied, the payload must be put into the downloaded location per the Administrators Guide. Because this payload has not been changed since Update 1607, you can use the payload that is already downloaded, or download it new, per the Administrators guide.

> [!IMPORTANT]
> Do not start the update process. Instead, run the health check that is described in Step 6.

### Step 5: Clean up the WSUS server

To clean up the WSUS server, follow these steps:

1. On the Console VM, open the Windows Server Update Services console.
2. Right-click **Update Services**, click **Connect to Server**, and then connect to the WSUS VM (**\<Prefix>** -SUS-01).
3. In the navigation pane, expand **Update Services** > [ **WSUS Server** ] > **Updates**, and then click **All Updates**.
4. In the **All Updates** pane, click **Any except declined** in the **Approval** list.
5. In the **Status** list, click **Any**, and then click **Refresh**.
6. Select all updates.
7. Right-click the selection, and then click **Decline**.
8. In the navigation pane, expand the server name, and then click **Options**.
9. In the **Options** pane, click **Server Cleanup Wizard**.
10. Select all check boxes except the **Computers not contacting the server** check box.
11. Click **Next**.

### Step 6: Run the Patch & Update Health Check and fix discovered issues

In the "Update the computers" section of the CPS Premium Administrators Guide, complete "Step 1: Run a health check and fix any discovered issues." This includes functionality to check for and disable any running backup jobs.

> [!IMPORTANT]
> Do not start the update process. Instead, run the health check, fix any discovered issues, and stop any running backup jobs.

### Step 7: Run P&U update package 1610-0

In the "Update the computers" section of the CPS Administrators Guide, follow "Step 2: Apply the P&U update package" to apply Update 1610-0.

> [!NOTE]
> Starting in Update 1603, the Patch and Update (P&U) engine automatically runs a health check as part of the update process. You can control what happens if you discover any critical Operations Manager alerts. To do this, change the value of the -ScomAlertAction parameter. For more information, see the Administrators Guide.

Because of the size of this package, estimates for deployment are 12-18 hours.

If you do not intend to apply 1610-1 immediately, remember to enable DPM agents if you disabled them earlier (as described in the Administrators Guide).

Also, if you do not intend to apply 1610-1 immediately, follow the steps in "Step 3: Post-update clean up" of the Administrators Guide after the updating is completed.

### Step 8: Run P&U update package 1610-1

Follow the same steps for installing the 1610-1 package. This can be scheduled right after the 1610-0 package or later, depending on your maintenance timeframe requirements.

Because of the size of this package, estimates for deployment are 36-48 hours (per rack).

After the patching process is complete, remember to enable DPM agents if you disabled them earlier (as described in the Administrators Guide). Also, follow the steps in "Step 3: Post-update clean up" of the Administrators Guide after the updating is completed.

### Step 9: Run an optional compliance scan

To run a compliance scan, pass the following flag:

```
\\SU1_InfrastructureShare1<CPSPU FolderName>\Framework\PatchingUpgrade\Invoke-PURun.ps1 -PUCredential $cred -ComplianceScanOnly
```

The compliance scan output is written to the following location to which the update package was extracted:

`<PURoot>\MissingUpdates.json`

## Payload information

### Payload for Update 1610-0

#### Configuration changes (from previous updates)

|Computers|Update|
|---|---|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client" -Name DisabledByDefault -Type DWord -Value 1|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client" -Name Enabled -Type DWord -Value 0|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server" -Name DisabledByDefault -Type DWord -Value 1|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server" -Name Enabled -Type DWord -Value 0|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" -Name DisabledByDefault -Type DWord -Value 1|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" -Name Enabled -Type DWord -Value 0|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" -Name DisabledByDefault -Type DWord -Value 1|
|All|Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" -Name Enabled -Type DWord -Value 0|
  
#### Updates for Windows Server 2012 R2 (from previous updates)

|KB article|Description|
|---|---|
| [3138615](https://support.microsoft.com/help/3138615)|Update for Windows Server 2012 R2 (KB3138615)|
| [3173424](https://support.microsoft.com/help/3173424)|Servicing stack update for Windows 8.1 and Windows Server 2012 R2: July 12, 2016|
  
### Payload for Update 1610-1

#### Updates for Windows Server 2012 R2

|KB Article|Description|
|---|---|
| [3185331](https://support.microsoft.com/help/3185331)|October 2016 security monthly quality rollup for Windows 8.1 and Windows Server 2012 R2|
| [3188743](https://support.microsoft.com/help/3188743)|MS16-120: Description of the Security and Quality Rollup for .NET Framework 3.5 for Windows 8.1 and Windows Server 2012 R2: October 11, 2016|
| [3192392](https://support.microsoft.com/help/3192392)|October 2016 security only quality update for Windows 8.1 and Windows Server 2012 R2|
| [3200006](https://support.microsoft.com/help/3200006)|System Center Operations Manager Management Console crashes after you install MS16-118 and MS16-126|
  
#### System Center and Windows Azure Pack updates (from previous updates)

|KB article|Description|
|---|---|
| [3147172](https://support.microsoft.com/help/3147172)|This update fixes the problems described in KB article 3147172|
| [3147167](https://support.microsoft.com/help/3147167)|This update fixes the problems described in KB article 3147167|
| [3158609](https://support.microsoft.com/help/3158609)|This update fixes the problems described in KB article 3158609|
  
#### Hardware (driver and firmware) updates (from previous updates)

|Component|Category|1606 Version|
|---|---|---|
|C6320|BIOS|2.1.5|
|R620|BIOS|2.5.4|
|R620 v2|BIOS|2.5.4|
|R630|BIOS|2.1.6|
|R630|SAS HBA - Internal|6.603.07.00|
|C6320|Chipset|10.1.2.19|
|R630|Chipset|10.1.2.19|
  
#### Updates for Windows Server 2012 R2 (from previous updates)

|KB Article|Description|
|---|---|
| [3063109](https://support.microsoft.com/help/3063109)|Hyper-V integration components update for Windows virtual machines that are running on a Windows 10-based host|
| [3153224](https://support.microsoft.com/help/3153224)|Revised March 2016 anti-malware platform update for Endpoint Protection clients|
| [3174644](https://support.microsoft.com/help/3174644)|Microsoft security advisory: Updated support for Diffie-Hellman Key Exchange|
| [3175024](https://support.microsoft.com/help/3175024)|MS16-111: Description of the security update for Windows Kernel: September 13, 2016|
| [3177186](https://support.microsoft.com/help/3177186)|MS16-114: Description of the security update for Windows SMBv1 Server: September 13, 2016|
| [3178539](https://support.microsoft.com/help/3178539)|MS16-112: Description of the security update for Windows lock screen: September 13, 2016|
| [3179574](https://support.microsoft.com/help/3179574)|August 2016 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|
| [3184122](https://support.microsoft.com/help/3184122)|MS16-116: Description of the security update for OLE Automation for VBScript Scripting Engine: September 13, 2016|
| [3184943](https://support.microsoft.com/help/3184943)|MS16-115: Description of the security update for Microsoft Windows PDF Library: September 13, 2016|
| [3185319](https://support.microsoft.com/help/3185319)|MS16-104: Security update for Internet Explorer: September 13, 2016|
| [3185911](https://support.microsoft.com/help/3185911)|MS16-106: Description of the security update for Microsoft Graphics Component: September 13, 2016|
| [3187022](https://support.microsoft.com/help/3187022)|Print functionality is broken after any of the MS16-098 security updates are installed|
| [3188128](https://support.microsoft.com/help/3188128)|MS16-117: Security update for Adobe Flash Player: September 13, 2016|
| [3167679](https://support.microsoft.com/help/3167679)|MS16-101: Description of the security update for Windows authentication methods: August 9, 2016|
| [3172614](https://support.microsoft.com/help/3172614)|July 2016 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|
| [3172729](https://support.microsoft.com/help/3172729)|MS16-100: Description of the security update for Secure Boot: August 9, 2016|
| [3175443](https://support.microsoft.com/help/3175443)|MS16-095: Security update for Internet Explorer: August 9, 2016|
| [3175887](https://support.microsoft.com/help/3175887)|MS16-102: Description of the security update for Microsoft Windows PDF library: August 9, 2016|
| [3177108](https://support.microsoft.com/help/3177108)|MS16-101: Description of the security update for Windows authentication methods: August 9, 2016|
| [3177725](https://support.microsoft.com/help/3177725)|MS16-098: Description of the security update for Windows kernel-mode drivers: August 9, 2016|
| [3178034](https://support.microsoft.com/help/3178034)|MS16-097: Description of the security update for Microsoft Graphics Component: August 9, 2016|
| [3170455](https://support.microsoft.com/help/3170455)|MS16-087: Description of the security update for Windows print spooler components: July 12, 2016|
| [3172727](https://support.microsoft.com/help/3172727)|MS16-094: Description of the security update for Secure Boot: July 12, 2016|
| [3164294](https://support.microsoft.com/help/3164294)|MS16-073: Description of the security update for kernel mode drivers: June 14, 2016|
| [3164035](https://support.microsoft.com/help/3164035)|MS16-074: Description of the security update for Microsoft Graphics Component: June 14, 2016|
| [3164033](https://support.microsoft.com/help/3164033)|MS16-074: Description of the security update for Microsoft Graphics Component: June 14, 2016|
| [3162835](https://support.microsoft.com/help/3162835)|June 2016 DST and time zone update for Windows|
| [3162343](https://support.microsoft.com/help/3162343)|MS16-076: Description of the security update for Netlogon: June 14, 2016|
| [3161958](https://support.microsoft.com/help/3161958)|MS16-082: Description of the security update for Windows Structured Query: June 14, 2016|
| [3161951](https://support.microsoft.com/help/3161951)|MS16-071: Description of the security update for DNS Server: June 14, 2016|
| [3161949](https://support.microsoft.com/help/3161949)|MS16-077: Description of the security update for WPAD: June 14, 2016|
| [3161664](https://support.microsoft.com/help/3161664)|MS16-073: Description of the security update for kernel mode drivers: June 14, 2016|
| [3161561](https://support.microsoft.com/help/3161561)|MS16-075 and MS16-076: Description of the security update for Windows Netlogon and SMB Server: June 14, 2016|
| [3160352](https://support.microsoft.com/help/3160352)|MS16-081: Security Update for Active Directory: June 14, 2016|
| [3160005](https://support.microsoft.com/help/3160005)|MS16-063: Security update for Internet Explorer: June 14, 2016|
| [3159398](https://support.microsoft.com/help/3159398)|MS16-072: Description of the security update for Group Policy: June 14, 2016|
| [3157569](https://support.microsoft.com/help/3157569)|MS16-080: Description of the security update for Windows PDF: June 14, 2016|
| [3156418](https://support.microsoft.com/help/3156418)|May 2016 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|
| [3149157](https://support.microsoft.com/help/3149157)|Reliability and scalability improvements in TCP/IP for Windows 8.1 and Windows Server 2012 R2|
| [3147071](https://support.microsoft.com/help/3147071)|Connection to Oracle database fails when you use Microsoft ODBC or OLE DB Driver for Oracle or Microsoft DTC in Windows|
| [3146978](https://support.microsoft.com/help/3146978)|RDS redirected resources showing degraded performance in Windows 8.1 or Windows Server 2012 R2|
| [3146751](https://support.microsoft.com/help/3146751)|"Logon is not possible" error or a temporary file is created when you log on App-V in Windows Server 2012 R2|
| [3146604](https://support.microsoft.com/help/3146604)|WMI service crashes randomly in Windows Server 2012 R2 or Windows Server 2012|
| [3145432](https://support.microsoft.com/help/3145432)|Cluster nodes or VMs go offline when they are using VMQ capable NICs on a Windows Server 2012 R2 host|
| [3145384](https://support.microsoft.com/help/3145384)|MinDiffAreaFileSize registry value limit is increased from 3 GB to 50 GB in Windows 8.1 or Windows Server 2012 R2|
| [3144850](https://support.microsoft.com/help/3144850)|Update enables downgrade rights between Windows 10 IoT and Windows Embedded 8.1 Industry|
| [3141074](https://support.microsoft.com/help/3141074)|"0x00000001" Stop error when a shared VHDX file is accessed in Windows Server 2012 R2-based Hyper-V guest|
| [3140234](https://support.microsoft.com/help/3140234)|"0x0000009F" Stop error when a Windows VPN client computer is shutdown with an active L2TP VPN connection|
| [3140219](https://support.microsoft.com/help/3140219)|"0x00000133" Stop error after you install hotfix 3061460 in Windows Server 2012 R2|
| [3139923](https://support.microsoft.com/help/3139923)|Windows installer (MSI) repair doesn't work when MSI package is installed on an HTTP share in Windows|
| [3139921](https://support.microsoft.com/help/3139921)|"No computer account for trust" error when you change domain account password in Windows|
| [3139896](https://support.microsoft.com/help/3139896)|Hyper-V guest may freeze when it is running failover cluster service together with shared VHDX in Windows Server 2012 R2|
| [3139649](https://support.microsoft.com/help/3139649)|Print job fails if Creator Owner is removed from Windows Server 2012 R2 or Windows Server 2012|
| [3139219](https://support.microsoft.com/help/3139219)|0x1E Stop error when you restart or shut down a computer running Windows 8.1 or Windows Server 2012 R2|
| [3139165](https://support.microsoft.com/help/3139165)|High CPU load on a Windows Server 2012 R2-based server because NAT keep-alive timer isn't cleaned up|
| [3139164](https://support.microsoft.com/help/3139164)|Tracert command doesn't receive responses when you trace resources on Internet through Windows Server 2012 R2 HNV GW|
| [3139162](https://support.microsoft.com/help/3139162)|DirectAccess client receives incorrect response to reverse lookup query from a Windows Server 2012 R2-based DNS64 server|
| [3138602](https://support.microsoft.com/help/3138602)|"File contents" option is always selectable, Start screen becomes blank, or computer freezes when startup in Windows 8.1|
| [3137728](https://support.microsoft.com/help/3137728)|VSS restore fails when you use ResyncLuns VSS API in Windows Server 2012 R2-based failover cluster|
| [3137725](https://support.microsoft.com/help/3137725)|Get-StorageReliabilityCounter doesn't report correct values of temperature in Windows Server 2012 R2|
| [3137061](https://support.microsoft.com/help/3137061)|Windows Azure VMs don't recover from a network outage and data corruption issues occur|
| [3134815](https://support.microsoft.com/help/3134815)|CryptDuplicateKey function doesn't save state for an RC2 40-Bit key in Windows 8.1 or Windows Server 2012 R2|
| [3134785](https://support.microsoft.com/help/3134785)|Memory leak in RPCSS and DcomLaunch services in Windows 8.1 or Windows Serer 2012 R2|
| [3134242](https://support.microsoft.com/help/3134242)|DNS client API call fails and could lead to service restart freeze in Windows Server 2012 R2 or Windows Server 2012|
| [3134179](https://support.microsoft.com/help/3134179)|Update adds performance counters for Remote Desktop Connection Broker in Windows Server 2012 R2|
| [3133924](https://support.microsoft.com/help/3133924)|"Code 10 Device Cannot Start" error for EHCI USB Controller devices in Device Manager in Windows Server 2012 R2|
| [3133690](https://support.microsoft.com/help/3133690)|Update to add Discrete Device Assignment support for Azure that runs on Windows Server 2012 R2-based guest VMs|
| [3132080](https://support.microsoft.com/help/3132080)|The logon process hangs at the "Welcome" screen or the "Please wait for the User Profile Service" error message window|
| [3130939](https://support.microsoft.com/help/3130939)|Nonpaged pool memory leak occurs in a Windows Server 2012 R2-based failover cluster|
| [3128650](https://support.microsoft.com/help/3128650)|Access to COM+ role-based security is denied in Windows Server 2012 R2|
| [3126041](https://support.microsoft.com/help/3126041)|MS16-014: Description of the security update for Windows: February 9, 2016|
| [3126033](https://support.microsoft.com/help/3126033)|Error occurs when you use Remote Desktop in Restricted Admin mode in Windows 8.1 or Windows Server 2012 R2|
| [3125424](https://support.microsoft.com/help/3125424)|LSASS deadlocks cause Windows Server 2012 R2 or Windows Server 2012 not to respond|
| [3125210](https://support.microsoft.com/help/3125210)|Badpwdcount on PDC isn't reset when you use NTLM authentication to log on to Windows Server 2012 R2|
| [3123245](https://support.microsoft.com/help/3123245)|Update improves port exhaustion identification in Windows Server 2012 R2|
| [3123242](https://support.microsoft.com/help/3123242)|Reassociated WFP context in same flow doesn't work in Windows|
| [3121255](https://support.microsoft.com/help/3121255)|"0x00000024" Stop error in FsRtlNotifyFilterReportChange and copy file may fail in Windows|
| [3118401](https://support.microsoft.com/help/3118401)|Update for Universal C Runtime in Windows|
| [3115224](https://support.microsoft.com/help/3115224)|Reliability improvements for VMs that are running on a Windows Server 2012 R2 or Windows Server 2012 host|
| [3109976](https://support.microsoft.com/help/3109976)|Texas Instruments xHCI USB controllers may encounter a hardware issue on large data transfers in Windows 8.1|
| [3103709](https://support.microsoft.com/help/3103709)|Windows Server 2012 R2-based or Windows Server 2012-based domain controller update, April 2016|
| [3103696](https://support.microsoft.com/help/3103696)|Update for USB Type-C billboard support and Kingston thumb drive is enumerated incorrectly in Windows|
| [3103616](https://support.microsoft.com/help/3103616)|WMI query doesn't work in Windows Server 2012 R2 or Windows Server 2012|
| [3102467](https://support.microsoft.com/help/3102467)|The .NET Framework 4.6.1 for Windows Server 2012 R2 on Windows Update|
| [3100956](https://support.microsoft.com/help/3100956)|You may experience slow logon when services are in start-pending state in Windows Server 2012 R2|
| [3100919](https://support.microsoft.com/help/3100919)|Virtual memory size of Explorer increases when you open programs continuously in Windows 8.1 or Windows Server 2012 R2|
| [3100473](https://support.microsoft.com/help/3100473)|DNS records get deleted when you delete the scope on a Windows Server 2012 R2-based DHCP server|
| [3099834](https://support.microsoft.com/help/3099834)|"Access violation" error and application that uses private keys crashes in Windows 8.1 or Windows Server 2012 R2|
| [3096433](https://support.microsoft.com/help/3096433)|Chkdsk command freezes when it's running in Windows|
| [3095701](https://support.microsoft.com/help/3095701)|TPM 2.0 device can't be recognized in Windows Server 2012 R2|
| [3094486](https://support.microsoft.com/help/3094486)|KDS doesn't start or KDS root key isn't created in Windows Server 2012 R2|
| [3092627](https://support.microsoft.com/help/3092627)|September 2015 update to fix Windows or application freezes after you install security update 3076895|
| [3091297](https://support.microsoft.com/help/3091297)|You can't logon to an AD FS server from a Windows Store app on a Windows 8.1 or Windows RT 8.1 device|
| [3088195](https://support.microsoft.com/help/3088195)|MS15-111: Description of the security update for Windows Kernel: October 13, 2015|
| [3087137](https://support.microsoft.com/help/3087137)|Gradient rendering issue when an application has nested transformed geometries in Windows 8.1|
| [3087041](https://support.microsoft.com/help/3087041)|You can't select the first item in a list by touching in Windows 8.1|
| [3086255](https://support.microsoft.com/help/3086255)|MS15-097: Description of the security update for the graphics component in Windows: September 8, 2015|
| [3084135](https://support.microsoft.com/help/3084135)|MS15-102: Description of the security update for Windows Task Management: September 8, 2015|
| [3083992](https://support.microsoft.com/help/3083992)|Microsoft security advisory: Update to improve AppLocker certificate handling: September 8, 2015|
| [3082089](https://support.microsoft.com/help/3082089)|MS15-102: Description of the security update for Windows Task Management: September 8, 2015|
| [3080149](https://support.microsoft.com/help/3080149)|Update for customer experience and diagnostic telemetry|
| [3080042](https://support.microsoft.com/help/3080042)|CHM file freezes when you enter characters in Search box on the Index tab in Windows 8.1 or Windows Server 2012 R2|
| [3078676](https://support.microsoft.com/help/3078676)|Event 1530 is logged and ProfSvc leaks paged pool memory and handles in Windows 8.1 or Windows Server 2012 R2|
| [3078405](https://support.microsoft.com/help/3078405)|"0x0000004A" or "0x0000009F" Stop error occurs in Windows 8.1|
| [3077715](https://support.microsoft.com/help/3077715)|August 2015 cumulative time zone update for Windows operating systems|
| [3071663](https://support.microsoft.com/help/3071663)|Microsoft applications might crash in Windows|
| [3067505](https://support.microsoft.com/help/3067505)|MS15-076: Vulnerability in Windows Remote Procedure Call could allow elevation of privilege: July 14, 2015|
| [3063843](https://support.microsoft.com/help/3063843)|Registry bloat causes slow logons or insufficient system resources error 0x800705AA in Windows 8.1|
| [3061512](https://support.microsoft.com/help/3061512)|MS15-069: Description of the security update for Windows: July 14, 2015|
| [3060793](https://support.microsoft.com/help/3060793)|"0x0000001E" or "0x00000133" Stop error when you transfer data through a USB-based RNDIS device on Windows|
| [3060383](https://support.microsoft.com/help/3060383)|Decimal symbol and digit grouping symbol are incorrect for the Swiss language locale in Windows|
| [3055343](https://support.microsoft.com/help/3055343)|Stop error code 0xD1, 0x139, or 0x3B and cluster nodes go down in Windows Server 2012 R2 or Windows Server 2012|
| [3055323](https://support.microsoft.com/help/3055323)|Update to enable a security feature in Windows 8.1 or Windows Server 2012 R2|
| [3054464](https://support.microsoft.com/help/3054464)|Applications that use the AddEntry method may crash in Windows|
| [3054256](https://support.microsoft.com/help/3054256)|Reliability improvements for Windows 8.1: June 2015|
| [3054203](https://support.microsoft.com/help/3054203)|Update for SIP to enable WinVerifyTrust function in Windows Server 2012 R2 to work with a later version of Windows|
| [3054169](https://support.microsoft.com/help/3054169)|Update to add more information to minidump files that helps OCA servers categorize failures correctly in Windows|
| [3052480](https://support.microsoft.com/help/3052480)|Unexpected ASP.NET application shutdown after many App_Data file changes occur on a server that is running Windows Server 2012 R2|
| [3048043](https://support.microsoft.com/help/3048043)|Screen flickers or becomes blank when you drag tiles on the Start screen in Windows|
| [3047234](https://support.microsoft.com/help/3047234)|MS15-042: Vulnerability in Windows Hyper-V could allow denial of service: April 14, 2015|
| [3046737](https://support.microsoft.com/help/3046737)|"Paired" text is not translated correctly in Korean when you disconnect a paired Bluetooth device in Windows|
| [3046359](https://support.microsoft.com/help/3046359)|MS15-068: Description of the security update for Windows Hyper-V: July 14, 2015|
| [3046339](https://support.microsoft.com/help/3046339)|MS15-068: Description of the security update for Windows Hyper-V: July 14, 2015|
| [3045999](https://support.microsoft.com/help/3045999)|MS15-038: Description of the security update for Windows: April 14, 2015|
| [3045992](https://support.microsoft.com/help/3045992)|"Description cannot be found" error in event logs in Event Viewer in Windows Server 2012 R2 or Windows Server 2012|
| [3045746](https://support.microsoft.com/help/3045746)|Single string is drawn by multiple fonts in the TextBox control of Windows Store application in Windows|
| [3045719](https://support.microsoft.com/help/3045719)|Microsoft Project Siena crashes when you use galleries in the application in Windows|
| [3045717](https://support.microsoft.com/help/3045717)|Narrator does not stop reading when you press Ctrl key in Windows|
| [3045634](https://support.microsoft.com/help/3045634)|You cannot make a PPP connection after you reconnect a PLC device in Windows 8.1 or Windows 8|
| [3044673](https://support.microsoft.com/help/3044673)|Photos taken by certain Android devices show blank value in Date taken field in Windows Explorer|
| [3044374](https://support.microsoft.com/help/3044374)|Update that enables you to upgrade from Windows 8.1 to Windows 10|
| [3043812](https://support.microsoft.com/help/3043812)|Layout of Cambria font is different in Word documents when the text metric changes in Windows 8.1 or Windows 8|
| [3042085](https://support.microsoft.com/help/3042085)|Device does not respond during shutdown after you have installed November 2014 update in Windows|
| [3042058](https://support.microsoft.com/help/3042058)|Microsoft security advisory: Update to default cipher suite priority order: May 12, 2015|
| [3041857](https://support.microsoft.com/help/3041857)|"Code 0x80070057 The parameter is incorrect" error when you try to display a user's "effective access" to a file|
| [3038002](https://support.microsoft.com/help/3038002)|UHS-3 cards cannot be detected in Windows on Surface devices|
| [3037924](https://support.microsoft.com/help/3037924)|You cannot do System Image Backup to Blu-ray media in Windows|
| [3037579](https://support.microsoft.com/help/3037579)|MS15-041: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: April 14, 2015|
| [3036612](https://support.microsoft.com/help/3036612)|Windows Store apps may crash in Windows 8.1 or Windows RT 8.1|
| [3034348](https://support.microsoft.com/help/3034348)|"Access denied" error when you use a Windows Store app to configure printer property settings in Windows|
| [3033446](https://support.microsoft.com/help/3033446)|Wi-Fi connectivity issues or poor performance on CHT platform computers in Windows 8.1|
| [3031044](https://support.microsoft.com/help/3031044)|Embedded Lockdown Manager is installed unexpectedly in Windows 8.1 or Windows Server 2012 R2|
| [3030947](https://support.microsoft.com/help/3030947)|Compatibility issues for applications that rely on a certain code layout for memory in Windows|
| [3029603](https://support.microsoft.com/help/3029603)|xHCI driver crashes after you resume computer from sleep mode in Windows 8.1 or Windows Server 2012 R2|
| [3027209](https://support.microsoft.com/help/3027209)|Reliability improvements for Windows 8.1: March 2015|
| [3024755](https://support.microsoft.com/help/3024755)|Multi-touch gesture does not work after you exit the Calculator in Windows|
| [3024751](https://support.microsoft.com/help/3024751)|The TAB key does not switch the cursor to the next input box when you enter Wi-Fi credentials on a Surface Pro 3|
| [3021910](https://support.microsoft.com/help/3021910)|April 2015 servicing stack update for Windows 8.1 and Windows Server 2012 R2|
| [3016074](https://support.microsoft.com/help/3016074)|Windows activation does not work when the sppsvc.exe process is not started automatically for a long time|
| [3013791](https://support.microsoft.com/help/3013791)|"DPC_WATCHDOG_VIOLATION (0x133)" Stop error when there's faulty hardware in Windows 8.1 or Windows Server 2012 R2|
| [3013538](https://support.microsoft.com/help/3013538)|Automatic brightness option is disabled unexpectedly after you switch between PC settings pages in Windows|
| [3013410](https://support.microsoft.com/help/3013410)|December 2014 cumulative time zone update for Windows operating systems|
| [3013172](https://support.microsoft.com/help/3013172)|Individual memory devices cannot be ejected through the Safely Remove Hardware UI in Windows 8.1|
| [3012702](https://support.microsoft.com/help/3012702)|Some default program associations for a roamed user may be lost when you log on to an RDS server in Windows|
| [3006137](https://support.microsoft.com/help/3006137)|Update changes the currency symbol of Lithuania from the Lithuanian litas (Lt) to the euro (&euro;) in Windows|
| [3004394](https://support.microsoft.com/help/3004394)|Support for urgent Trusted Root updates for Windows Root Certificate Program in Windows|
| [2989930](https://support.microsoft.com/help/2989930)|"Not Connected" status for a paired Surface Pen in Bluetooth settings on Surface Pro 3|
| [2894852](https://support.microsoft.com/help/2894852)|Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: December 10, 2013|
| [890830](https://support.microsoft.com/help/890830)|The Microsoft Windows Malicious Software Removal Tool helps remove specific, prevalent malicious software from computers that are running supported versions of Windows|
| [3156059](https://support.microsoft.com/help/3156059)|MS16-057: Description of the security update for Windows shell: May 10, 2016|
| [3156019](https://support.microsoft.com/help/3156019)|MS16-055: Description of the security update for Microsoft graphics component: May 10, 2016|
| [3156017](https://support.microsoft.com/help/3156017)|MS16-062: Description of the security update for Windows Kernel-Mode Drivers: May 10, 2016|
| [3156016](https://support.microsoft.com/help/3156016)|MS16-055: Description of the security update for Microsoft graphics component: May 10, 2016|
| [3156013](https://support.microsoft.com/help/3156013)|MS16-055: Description of the security update for Microsoft graphics component: May 10, 2016|
| [3155784](https://support.microsoft.com/help/3155784)|MS16-067: Security update for volume manager driver: May 10, 2016|
| [3154070](https://support.microsoft.com/help/3154070)|MS16-051: Security update for Internet Explorer: May 10, 2016|
| [3153704](https://support.microsoft.com/help/3153704)|MS16-061: Description of the security update for RPC: May 10, 2016|
| [3153199](https://support.microsoft.com/help/3153199)|MS16-062: Description of the security update for Windows Kernel-Mode Drivers: May 10, 2016|
| [3153171](https://support.microsoft.com/help/3153171)|MS16-060 and MS16-061: Description of the security update for RPC and for Windows kernel: May 10, 2016|
| [3151058](https://support.microsoft.com/help/3151058)|MS16-064: Description of the security update for Schannel: May 10, 2016|
| [3149090](https://support.microsoft.com/help/3149090)|MS16-047: Description of the security update for SAM and LSAD remote protocols: April 12, 2016|
| [3146963](https://support.microsoft.com/help/3146963)|MS16-040: Description of the security update for Microsoft XML core services: April 12, 2016|
| [3146723](https://support.microsoft.com/help/3146723)|MS16-048: Description of the security update for CSRSS: April 12, 2016|
| [3146706](https://support.microsoft.com/help/3146706)|MS16-044: Security update for Windows OLE: April 12, 2016|
| [3142045](https://support.microsoft.com/help/3142045)|MS16-039: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: April 12, 2016|
| [3142036](https://support.microsoft.com/help/3142036)|MS16-065: Description of the security update for the .NET Framework 4.6 and 4.6.1 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: May 10, 2016|
| [3142030](https://support.microsoft.com/help/3142030)|MS16-065: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: May 10, 2016|
| [3142026](https://support.microsoft.com/help/3142026)|MS16-065: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: May 10, 2016|
| [3135998](https://support.microsoft.com/help/3135998)|MS16-035: Description of the security update for the .NET Framework 4.6 and 4.6.1 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: March 8, 2016|
| [3135994](https://support.microsoft.com/help/3135994)|MS16-035: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: March 8, 2016|
| [3135991](https://support.microsoft.com/help/3135991)|MS16-035: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: March 8, 2016|
| [3135985](https://support.microsoft.com/help/3135985)|MS16-035: Description of the security update for the .NET Framework 3.5 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: March 8, 2016|
| [3135456](https://support.microsoft.com/help/3135456)|MS16-045: Description of the security update for Windows Hyper-V: April 12, 2016|
| [3130944](https://support.microsoft.com/help/3130944)|March 2016 update for Windows Server 2012 R2 clusters to fix several issues|
| [3127231](https://support.microsoft.com/help/3127231)|MS16-019: Description of the security update for the .NET Framework 4.6 and 4.6.1 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: February 9, 2016|
| [3127226](https://support.microsoft.com/help/3127226)|MS16-019: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: February 9, 2016|
| [3127222](https://support.microsoft.com/help/3127222)|MS16-019: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: February 9, 2016|
| [3123479](https://support.microsoft.com/help/3123479)|Microsoft security advisory: Deprecation of SHA-1 hashing algorithm for Microsoft root certificate program: January 12, 2016|
| [3122660](https://support.microsoft.com/help/3122660)|MS16-019: Description of the security update for the .NET Framework 4.6 and 4.6.1 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: February 9, 2016|
| [3122654](https://support.microsoft.com/help/3122654)|MS16-019: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: February 9, 2016|
| [3122651](https://support.microsoft.com/help/3122651)|MS16-019: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: February 9, 2016|
| [3121918](https://support.microsoft.com/help/3121918)|MS16-007: Description of the security update for Windows: January 12, 2016|
| [3121461](https://support.microsoft.com/help/3121461)|MS16-007: Description of the security update for Windows: January 12, 2016|
| [3110329](https://support.microsoft.com/help/3110329)|MS16-007: Description of the security update for Windows: January 12, 2016|
| [3109560](https://support.microsoft.com/help/3109560)|MS16-007: Description of the security update for Windows: January 12, 2016|
| [3109094](https://support.microsoft.com/help/3109094)|MS15-128 and MS15-135: Description of the security update for Windows kernel-mode drivers: December 8, 2015|
| [3108604](https://support.microsoft.com/help/3108604)|Microsoft security advisory: Description of the security update for Windows Hyper-V: November 10, 2015|
| [3102939](https://support.microsoft.com/help/3102939)|MS15-120: Security update for IPsec to address denial of service: November 10, 2015|
| [3101246](https://support.microsoft.com/help/3101246)|MS15-122: Description of the security update for Windows Kerberos: November 10, 2015|
| [3098785](https://support.microsoft.com/help/3098785)|MS15-118: Description of the security update for the .NET Framework 4.6 and 4.6.1 on Windows 8.1 and Windows Server 2012 R2: November 10, 2015|
| [3098779](https://support.microsoft.com/help/3098779)|MS15-118: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: November 10, 2015|
| [3098000](https://support.microsoft.com/help/3098000)|MS15-118: Description of the security update for the .NET Framework 4.6 and 4.6 RC on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: November 10, 2015|
| [3097997](https://support.microsoft.com/help/3097997)|MS15-118: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: November 10, 2015|
| [3097992](https://support.microsoft.com/help/3097992)|MS15-118: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: November 10, 2015|
| [3097966](https://support.microsoft.com/help/3097966)|Microsoft security advisory: Inadvertently disclosed digital certificates could allow spoofing: October 13, 2015|
| [3092601](https://support.microsoft.com/help/3092601)|MS15-119: Description of the security update for Windows Winsock: November 10, 2015|
| [3081320](https://support.microsoft.com/help/3081320)|MS15-121: Security update for Schannel to address spoofing: November 10, 2015|
| [3080446](https://support.microsoft.com/help/3080446)|MS15-109: Description of the security update for Windows Shell: October 13, 2015|
| [3078601](https://support.microsoft.com/help/3078601)|MS15-080: Description of the security update for Windows: August 11, 2015|
| [3076895](https://support.microsoft.com/help/3076895)|MS15-084: Description of the security update for Windows XML core services: August 11, 2015|
| [3075220](https://support.microsoft.com/help/3075220)|MS15-082: Description of the security update for RDP in Windows: August 11, 2015|
| [3074548](https://support.microsoft.com/help/3074548)|MS15-101: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: September 8, 2015|
| [3074545](https://support.microsoft.com/help/3074545)|MS15-101: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: September 8, 2015|
| [3074228](https://support.microsoft.com/help/3074228)|MS15-101: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: September 8, 2015|
| [3072630](https://support.microsoft.com/help/3072630)|MS15-074: Vulnerability in Windows Installer service could allow elevation of privilege: July 14, 2015|
| [3072307](https://support.microsoft.com/help/3072307)|MS15-080: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: August 11, 2015|
| [3071756](https://support.microsoft.com/help/3071756)|MS15-085: Description of the security update for Windows Mount Manager: August 11, 2015|
| [3068457](https://support.microsoft.com/help/3068457)|MS15-071: Vulnerability in Netlogon could allow elevation of privilege: July 14, 2015|
| [3060716](https://support.microsoft.com/help/3060716)|MS15-090: Vulnerabilities in Windows could allow elevation of privilege: August 11, 2015|
| [3059317](https://support.microsoft.com/help/3059317)|MS15-060: Vulnerability in Microsoft common controls could allow remote code execution: June 9, 2015|
| [3055642](https://support.microsoft.com/help/3055642)|MS15-050: Vulnerability in Service Control Manager could allow elevation of privilege: May 12, 2015|
| [3048072](https://support.microsoft.com/help/3048072)|MS15-044: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: May 12, 2015|
| [3046017](https://support.microsoft.com/help/3046017)|MS15-088 Description of the security update for Windows, Internet Explorer, and Office: August 11, 2015|
| [3045755](https://support.microsoft.com/help/3045755)|Microsoft Security Advisory 3045755: Update to improve PKU2U authentication|
| [3045685](https://support.microsoft.com/help/3045685)|MS15-038: Description of the security update for Windows: April 14, 2015|
| [3042553](https://support.microsoft.com/help/3042553)|MS15-034: Vulnerability in HTTP.sys could allow remote code execution: April 14, 2015|
| [3037576](https://support.microsoft.com/help/3037576)|MS15-041: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: April 14, 2015|
| [3035126](https://support.microsoft.com/help/3035126)|MS15-029: Vulnerability in Windows Photo Decoder component could allow information disclosure: March 10, 2015|
| [3033889](https://support.microsoft.com/help/3033889)|MS15-020: Description of the security update for Windows text services: March 10, 2015|
| [3030377](https://support.microsoft.com/help/3030377)|MS15-028: Vulnerability in Windows Task Scheduler could allow security feature bypass: March 10, 2015|
| [3023266](https://support.microsoft.com/help/3023266)|MS15-001: Vulnerability in Windows Application Compatibility cache could allow elevation of privilege: January 13, 2015|
| [3023222](https://support.microsoft.com/help/3023222)|MS15-048: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: May 12, 2015|
| [3023219](https://support.microsoft.com/help/3023219)|MS15-048: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: May 12, 2015|
| [3022777](https://support.microsoft.com/help/3022777)|MS15-005: Vulnerability in Network Location Awareness service could allow security feature bypass: January 13, 2015|
| [3021674](https://support.microsoft.com/help/3021674)|MS15-003: Vulnerability in Windows User Profile service could allow elevation of privilege: January 13, 2015|
| [3019978](https://support.microsoft.com/help/3019978)|MS15-004: Description of the security update for Windows: January 13, 2015|
| [3010788](https://support.microsoft.com/help/3010788)|MS14-064: Description of the security update for Windows OLE: November 11, 2014|
| [3006226](https://support.microsoft.com/help/3006226)|MS14-064: Description of the security update for Windows OLE: November 11, 2014|
| [3004365](https://support.microsoft.com/help/3004365)|MS15-006: Vulnerability in Windows Error Reporting could allow security feature bypass: January 13, 2015|
| [3004361](https://support.microsoft.com/help/3004361)|MS15-014: Vulnerability in Group Policy could allow security feature bypass: February 10, 2015|
| [3000483](https://support.microsoft.com/help/3000483)|MS15-011: Vulnerability in Group Policy could allow remote code execution: February 10, 2015|
| [2994397](https://support.microsoft.com/help/2994397)|MS14-059: Description of the security update for ASP.NET MVC 5.1: October 14, 2014|
| [2993939](https://support.microsoft.com/help/2993939)|MS14-059: Description of the security update for ASP.NET MVC 2.0: October 14, 2014|
| [2993937](https://support.microsoft.com/help/2993937)|MS14-059: Description of the security update for ASP.NET MVC 3.0: October 14, 2014|
| [2993928](https://support.microsoft.com/help/2993928)|MS14-059: Description of the security update for ASP.NET MVC 4.0: October 14, 2014|
| [2992080](https://support.microsoft.com/help/2992080)|MS14-059: Description of the security update for ASP.NET MVC 5.0: October 14, 2014|
| [2979576](https://support.microsoft.com/help/2979576)|MS14-057: Description of the security update for the .NET Framework 4.5.1 and the .NET Framework 4.5.2 for Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: October 14, 2014|
| [2979573](https://support.microsoft.com/help/2979573)|MS14-057: Description of the security update for the .NET Framework 3.5 for Windows 8.1 and Windows Server 2012 R2: October 14, 2014|
| [2978126](https://support.microsoft.com/help/2978126)|MS14-072: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: November 11, 2014|
| [2978122](https://support.microsoft.com/help/2978122)|MS14-072: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: November 11, 2014|
| [2977765](https://support.microsoft.com/help/2977765)|MS14-053: Description of the security update for the .NET Framework 4.5.1 and the .NET Framework 4.5.2 for Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: September 9, 2014|
| [2977292](https://support.microsoft.com/help/2977292)|Microsoft security advisory: Update for Microsoft EAP implementation that enables the use of TLS: October 14, 2014|
| [2973114](https://support.microsoft.com/help/2973114)|MS14-053: Description of the security update for the .NET Framework 3.5 for Windows 8.1 and Windows Server 2012 R2: September 9, 2014|
| [2972213](https://support.microsoft.com/help/2972213)|MS14-053: Description of the security update for the .NET Framework 3.5 for Windows 8.1 and Windows Server 2012 R2: September 9, 2014|
| [2972103](https://support.microsoft.com/help/2972103)|MS14-057: Description of the security update for the .NET Framework 3.5 for Windows 8.1 and Windows Server 2012 R2: October 14, 2014|
| [2968296](https://support.microsoft.com/help/2968296)|MS14-057: Description of the security update for the .NET Framework 3.5 for Windows 8.1 and Windows Server 2012 R2: October 14, 2014|
| [2966828](https://support.microsoft.com/help/2966828)|MS14-046: Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: August 12, 2014|
| [2966826](https://support.microsoft.com/help/2966826)|MS14-046: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: August 12, 2014|
| [2934520](https://support.microsoft.com/help/2934520)|The Microsoft .NET Framework 4.5.2 for Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2|
| [2898850](https://support.microsoft.com/help/2898850)|Description of the security update for the .NET Framework 4.5.1 and the .NET Framework 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: May 13, 2014|
| [2898847](https://support.microsoft.com/help/2898847)|Description of the security update for the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2: May 13, 2014|
| [2565063](https://support.microsoft.com/help/2565063)|MS11-025: Description of the security update for Visual C++ 2010 Service Pack 1: August 9, 2011|
| [2565057](https://support.microsoft.com/help/2565057)|MS11-025: Description of the security update for Visual Studio 2010 Service Pack 1: August 9, 2011|
| [2542054](https://support.microsoft.com/help/2542054)|MS11-025: Description of the security update for Visual Studio 2010: June 14, 2011|
| [2538243](https://support.microsoft.com/help/2538243)|MS11-025: Description of the security update for Visual C++ 2008 SP1 Redistributable Package: June 14, 2011|
| [2538241](https://support.microsoft.com/help/2538241)|MS11-025: Description of the security update for Visual Studio 2008 SP1: June 14, 2011|
| [2467173](https://support.microsoft.com/help/2467173)|MS11-025: Description of the security update for Visual C++ 2010 Redistributable Package: April 12, 2011|
  
#### Updates for SQL Server 2012 (from previous updates)

|KB article|Description|
|---|---|
| [3072779](https://support.microsoft.com/help/3072779)|SQL Server 2012 Service Pack 3 release information|
  
## Troubleshooting

### Issue 1

The SQLProductUpdates subsystem fails and returns the following error message:

> The WS-Management service cannot complete the operation within the time specified in OperationTimeout.

### Description

There seems to be a timing issue in the service. Microsoft is currently researching this issue. This can cause SQLProductUpdates to fail and return an error message that resembles the following:

> The Microsoft.HotfixPlugin plug-in reported a failure while attempting to install updates on node "". Additional information reported by the plug-in: (ClusterUpdateException) There was a failure in a Common Information Model (CIM) operation, that is, an operation performed by software that Cluster-Aware Updating depends on. The computer was "", and the operation was "RunUpdateInstaller[,CauNodeWCD[]]". The failure was: (CimException) The WS-Management service cannot complete the operation within the time specified in OperationTimeout. HRESULT 0x80338029 ==> (CimException) The WS-Management service cannot complete the operation within the time specified in OperationTimeout. HRESULT 0x80338029

> [!NOTE]
> Although the Patch and Update (P&U) process fails while it waits for the action to finish, the underlying Cluster-Aware Updating (CAU) process succeeds.

### Detection

Verify that CAU succeeded. To do this, follow these steps:

1. On the Console VM, open **Cluster-Aware Updating**.
2. In the **Connect to a failover cluster** list, click the SQL Server cluster (< **Prefix** >-HA-SQL), and then click **Connect**.
3. The **Last Run** status should show a **Succeeded** value for all four SQL Server nodes.

Verify the SQL Server version. To do this, follow these steps:

1. Open SQL Server Management Studio.
2. Connect to the **\<Prefix>** -SH-SQL\SCSHAREDDB instance.
3. Click **New Query**.
4. Run the following command:

    ```
    SELECT @@VERSION
    ```  

5. The result should begin as follows:

    ```
    Microsoft SQL Server 2012 (SP3) (KB3072779) - 11.0.6020.0 (X64)
    ```

    Or as follows:

    ```
    Microsoft SQL Server 2012 (SP3-CU2) (KB3137746) - 11.0.6523.0 (X64)
    ```

6. Repeat steps 2-5 for the following SQL Server instances:

    - **\<Prefix>** -OM-SQL\SCOMDB
    - **\<Prefix>** -KT-SQL\KATALDB
    - **\<Prefix>** -DW-SQL\CPSDW
    - **\<Prefix>** -AS-SQL\CPSSSAS

### Resolution

If the CAU status displays a **Succeeded** value for all nodes, and if version information for all instances is correct, restart the P&U process, and then add "SQLProductUpdates" to the -ExcludeSubsystems parameter array.

If the CAU status does not display a **Succeeded** value for all nodes, or if version information for all instances is correct, restart the P&U process, and make no change in the parameters.

If the process fails again, escalate the case through your usual support channels.

### Issue 2

The VMM "Perform servicing on a Service" job fails.

### Description

Occasionally, servicing jobs fail because of communication issues that occur between the VMM server and its agents.

### Detection

In the VMM console, look for one or more failed "Perform servicing on a Service" jobs. The error may resemble the following example:

> Error (22655)
>
> VMM is unable to retrieve status from computer
>
> Recommended Action
>
> Check if the computer is running and the VM guest agent is in a healthy state.

### Resolution

To resolve this problem, follow these steps:

1. In the VMM console, commit the template for the affected service. To do this, follow these steps:

   1. Navigate to **VMs and Services**.
   2. In the navigation pane, select **All Hosts**.
   3. In the top ribbon, select **Services**.
   4. Right-click the affected service, and then select **Commit Template**.
2. Restart the P&U process.  

**Third-party information disclaimer**

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
