---
title: PXE boot in Configuration Manager
description: Introduces basic processes of PXE boot in Configuration Manager, how they work, and how they interoperate with each other.
ms.date: 12/05/2023
ms.custom: sap:PXE
ms.reviewer: kaushika
---
# Understand PXE boot in Configuration Manager

This article describes basic processes of Preboot Execution Environment (PXE) boot in Configuration Manager, how they work, and how they interoperate with each other.

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 4468601

## Introduction

Preboot Execution Environment (PXE) boot in System Center 2012 Configuration Manager (ConfigMgr 2012 or ConfigMgr 2012 R2) and later versions enables administrators to easily access the Windows Preinstallation Environment (WinPE) across the network via PXE. PXE is an industry standard created by Intel that provides pre-boot services within the devices firmware that enables devices to download network boot programs to client computers.

Configuration Manager relies on the Windows Deployment Services (WDS) server role via the WDS PXE provider. In ConfigMgr 2012 and later versions, the SMS PXE provider (SMSPXE) registers with the WDS service and supplies the logic for the PXE client requests.

Before troubleshooting PXE-related problems in Configuration Manager, it's important to understand the basic processes involved, how they work and how they interoperate with each other.

In all instances in this document, we are using System Center 2012 Configuration Manager R2 Cumulative Update 2 (ConfigMgr 2012 R2 CU2) and a remote site system installed on Windows Server 2012 with the Distribution Point (DP) role installed.

## PXE service point installation

We will first look at the processes involved in the installation of the SMSPXE provider.

Installation is initiated by selecting the **Enable PXE support for clients** option on the **PXE** tab in **Distribution point properties**. When PXE support is enabled, an instance of `SMS_SCI_SysResUse` class is created.

```output
SMSProv.log  
PutInstanceAsync SMS_SCI_SysResUseSMS Provider04/09/2014 11:30:131552 (0x0610)  
CExtProviderClassObject::DoPutInstanceInstanceSMS Provider04/09/2014 11:30:131552 (0x0610)  
INFO: 'RemoteDp.contoso.com' is a valid FQDN.SMS Provider04/09/2014 11:30:131552 (0x0610)
```

In the WMI namespace `Root\SMS\Site_RR2` (where RR2 is the site code of the site), the `SMS_SCI_SYSResUse` class contains all the site systems roles on the primary site server. You can run the following query in **WBEMTEST** to identify all the DPs on that site server:

```sql
SELECT * FROM SMS_SCI_SysResUse WHERE rolename like 'SMS Distribution Point'
```

Changing the properties of these roles via the SDK will alter the site control file and configure the DP. The `IsPXE` property name is a member of the props property and is set to **1** when the DP is PXE enabled.

The SMS Database Monitor component detects the change to the `DPNotificaiton` and `DistributionPoints` tables and drops files in distmgr.box:

```output
Smsdbmon.log  
RCV:UPDATE on SiteControl for SiteControl_AddUpd_HMAN [RR2 ][19604]  
RCV: UPDATE on SiteControl for SiteControl_AddUpd_SiteCtrl [RR2 ][19605]  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\RR2.SCU [19604]  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\sitectrl.box\RR2.CT0 [19605]  
RCV: UPDATE on Sites for Sites_Interop_Update_HMAN [RR2 ][19606]  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\RR2.ITC [19606]  
RCV: UPDATE on DistributionPoints for DP_Properties_Upd [15 ][19607]  
RCV: INSERT on PkgNotification for PkgNotify_Add [RR200002 ][19608]  
RCV: INSERT on PkgNotification for PkgNotify_Add [RR200003 ][19609]  
RCV: INSERT on DPNotification for DPNotify_ADD [15 ][19610]  
RCV: UPDATE on SiteControlNotification for SiteCtrlNot_Add_DDM [RR2 ][19611]  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\distmgr.box\15.NOT [19607]  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\distmgr.box\RR200002.PKN [19608]  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\distmgr.box\RR200003.PKN [19609]  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\distmgr.box\15.DPN [19610]  
Site Control Notification.
```

The Distribution Manager component on the primary site server then initiates the configuration of the remote DP:

```output
ConfigureDPSMS_DISTRIBUTION_MANAGER04/09/2014 11:30:263776 (0x0EC0)  
IISPortsList in the SCF is "80".SMS_DISTRIBUTION_MANAGER04/09/2014 11:30:263776 (0x0EC0)  
ISSSLPortsList in the SCF is "443".SMS_DISTRIBUTION_MANAGER04/09/2014 11:30:263776 (0x0EC0)  
IISWebSiteName in the SCF is "".SMS_DISTRIBUTION_MANAGER04/09/2014 11:30:263776 (0x0EC0)  
IISSSLState in the SCF is 448.SMS_DISTRIBUTION_MANAGER04/09/2014 11:30:263776 (0x0EC0)  
DP registry settings have been successfully updated on RemoteDp.contoso.com  
SMS_DISTRIBUTION_MANAGER04/09/2014 11:30:263776 (0x0EC0)  
ConfigurePXESMS_DISTRIBUTION_MANAGER04/09/2014 11:30:263776 (0x0EC0)
```

In the SMS DP Provider log on the remote DP, we can see the following information about the PXE installation, where initially the `PxeInstalled` registry key isn't found:

```output
Smsdpprov.log  
[66C][Thu 09/04/2014 11:30:28]:CcmInstallPXE  
[66C][Thu 09/04/2014 11:30:28]:RegQueryValueExW failed for Software\Microsoft\SMS\DP, PxeInstalled  
[66C][Thu 09/04/2014 11:30:28]:RegReadDWord failed; 0x80070002
```

The Visual C++ Redistributable is installed:

```output
Smsdpprov.log  
[66C][Thu 09/04/2014 11:30:28]:Running: C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /log "C:\SMS_DP$\sms\bin\vcredist.log"  
[66C][Thu 09/04/2014 11:30:28]:Waiting for the completion of: C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /log "C:\SMS_DP$\sms\bin\vcredist.log"  
[66C][Thu 09/04/2014 11:30:39]:Run completed for: C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /log "C:\SMS_DP$\sms\bin\vcredist.log"
```

WDS is installed:

```output
Smsdpprov.log  
[66C][Thu 09/04/2014 11:30:39]:Created the DP mutex key for WDS.  
[66C][Thu 09/04/2014 11:30:39]:Failed to open WDS service.  
[66C][Thu 09/04/2014 11:30:39]:WDS is NOT INSTALLED  
[66C][Thu 09/04/2014 11:30:39]:Installing WDS.  
[66C][Thu 09/04/2014 11:30:39]:Running: ServerManagerCmd.exe -i WDS -a  
[66C][Thu 09/04/2014 11:30:39]:Failed (2) to run: ServerManagerCmd.exe -i WDS -a  
[66C][Thu 09/04/2014 11:30:39]:Running: PowerShell.exe -Command Import-Module ServerManager; Get-WindowsFeature WDS; Add-WindowsFeature WDS  
[66C][Thu 09/04/2014 11:30:39]:Waiting for the completion of: PowerShell.exe -Command Import-Module ServerManager; Get-WindowsFeature WDS; Add-WindowsFeature WDS  
[66C][Thu 09/04/2014 11:31:35]:Run completed for: PowerShell.exe -Command Import-Module ServerManager; Get-WindowsFeature WDS; Add-WindowsFeature WDS  
[66C][Thu 09/04/2014 11:31:35]:Successfully installed WDS.
```

TFTP read filters are configured:

```output
Smsdpprov.log  
[66C][Thu 09/04/2014 11:31:35]:Setting TFTP config key as: System\CurrentControlSet\Services\WDSSERVER\Providers\WDSTFTP  
[66C][Thu 09/04/2014 11:31:35]:Configuring TFTP read filters  
[66C][Thu 09/04/2014 11:31:35]:SetupComplete is set to 0
```

The `REMINST` share is created and WDS is configured:

```output
Smsdpprov.log  
[66C][Thu 09/04/2014 11:31:35]:RegQueryValueExW failed for Software\Microsoft\Windows\CurrentVersion\Setup, REMINST  
[66C][Thu 09/04/2014 11:31:35]:RegReadDWord failed; 0x80070002  
[66C][Thu 09/04/2014 11:31:35]:REMINST not set in WDS  
[66C][Thu 09/04/2014 11:31:35]:WDS is NOT Configured  
[66C][Thu 09/04/2014 11:31:35]:Share (REMINST) does not exist. (NetNameNotFound) (0x00000906)  
[66C][Thu 09/04/2014 11:31:35]:GetFileSharePath failed; 0x80070906  
[66C][Thu 09/04/2014 11:31:35]:REMINST share does not exist. Need to create it.  
[66C][Thu 09/04/2014 11:31:35]:Enumerating drives A through Z for the NTFS drive with the most free space.  
[66C][Thu 09/04/2014 11:31:37]:Drive 'C:\' is the best drive for the SMS installation directory.  
[66C][Thu 09/04/2014 11:31:37]:Creating REMINST share to point to: C:\RemoteInstall  
[66C][Thu 09/04/2014 11:31:37]:Succesfully created share REMINST  
[66C][Thu 09/04/2014 11:31:37]:Removing existing PXE related directories  
[66C][Thu 09/04/2014 11:31:37]:Registering WDS provider: SourceDir: C:\SMS_DP$\sms\bin  
[66C][Thu 09/04/2014 11:31:37]:Registering WDS provider: ProviderPath: C:\SMS_DP$\sms\bin\smspxe.dll  
[66C][Thu 09/04/2014 11:31:37]:DoPxeProviderRegister  
[66C][Thu 09/04/2014 11:31:37]:PxeLoadWdsPxe  
[66C][Thu 09/04/2014 11:31:37]:Loading wdspxe.dll from C:\Windows\system32\wdspxe.dll  
[66C][Thu 09/04/2014 11:31:37]:wdspxe.dll is loaded  
[66C][Thu 09/04/2014 11:31:37]:PxeProviderRegister has suceeded (0x00000000)  
[66C][Thu 09/04/2014 11:31:37]:Disabling WDS/RIS functionality  
[66C][Thu 09/04/2014 11:31:39]:WDSServer status is 1  
[66C][Thu 09/04/2014 11:31:39]:WDSServer is NOT STARTED  
[66C][Thu 09/04/2014 11:31:39]:Running: WDSUTIL.exe /Initialize-Server /REMINST:"C:\RemoteInstall"  
[66C][Thu 09/04/2014 11:31:39]:Waiting for the completion of: WDSUTIL.exe /Initialize-Server /REMINST:"C:\RemoteInstall"  
[66C][Thu 09/04/2014 11:31:50]:Run completed for: WDSUTIL.exe /Initialize-Server /REMINST:"C:\RemoteInstall"  
[66C][Thu 09/04/2014 11:31:50]:CcmInstallPXE: Deleting the DP mutex key for WDS.  
[66C][Thu 09/04/2014 11:31:50]:Installed PXE  
[66C][Thu 09/04/2014 11:32:03]:CcmInstallPXE  
[66C][Thu 09/04/2014 11:32:03]:PXE provider is already installed.  
[66C][Thu 09/04/2014 11:32:03]:Installed PXE
```

On the remote DP, we can now see the following values added in `HKEY_LOCAL_MACHINE\Software\Microsoft\SMS\DP`:

:::image type="content" source="media/understand-pxe-boot/pxeinstalled-registy.png" alt-text="Screenshot of the values added in registry.":::

> [!NOTE]
> `PxeInstalled` and `IsPXE` are set to **1**.

If we look at the remote DP's file system, there is a new login `C:\SMS_DP$\sms\logs`:

```output
SMSPXE.log  
Machine is running Windows Longhorn. (NTVersion=0X602, ServicePack=0)  
Cannot read the registry value of MACIgnoreListFile (00000000)  
MAC Ignore List Filename in registry is empty  
Begin validation of Certificate [Thumbprint B64B9DAF9BFB76A99DC050C21E33B3489643D111] issued to 'e728f6ce-29a6-4ac3-974e-ba3dc855d9a4'  
Completed validation of Certificate [Thumbprint B64B9DAF9BFB76A99DC050C21E33B3489643D111] issued to 'e728f6ce-29a6-4ac3-974e-ba3dc855d9a4'
```

The Distribution Point should now be PXE-enabled and ready to accept incoming requests.

## Add boot images to a PXE-enabled DP

Whenever a new PXE-enabled distribution point is configured, there are additional steps that need to be completed to enable full functionality. One of these is that you must distribute the x86 and x64 boot images to the new PXE-enabled DP.

To do this, navigate to **Software Library** > **Operating Systems** > **Boot Images** > **Boot Image (x86)**, and then right-click and select **Distribute Content** > **Add the Boot Image to the PXE enabled DP**. Repeat this process for **Boot Image (x64)**.

Once this is done, Distribution Manager will start processing the request and initiate the distribution to the remote DP:

```output
DistMgr.log  
Found notification for package 'RR200004'Used 0 out of 30 allowed processing threads.  
Starting package processing thread, thread ID = 0x152C (5420)  
Start adding package to server ["Display=\\RemoteDp.contoso.com\"]MSWNET:["SMS_SITE=RR2"]\\RemoteDp.contoso.com\...  
Attempting to add or update a package on a distribution point.  
Successfully made a network connection to \\RemoteDp.contoso.com\ADMIN$.  
CreateSignatureShare, connecting to DP  
Signature share exists on distribution point path \\RemoteDp.contoso.com\SMSSIG$  
Share SMSPKGC$ exists on distribution point \\RemoteDp.contoso.com\SMSPKGC$  
Checking configuration of IIS virtual directories on DP ["Display=\\RemoteDp.contoso.com\"]MSWNET:["SMS_SITE=RR2"]\\RemoteDp.contoso.com\  
Creating, reading or updating IIS registry key for a distribution point.  
Virtual Directory SMS_DP_SMSSIG$ for the physical path C:\SMSSIG$ already exists.  
Created package transfer job to send package RR200004 to distribution point ["Display=\\RemoteDp.contoso.com\"]MSWNET:["SMS_SITE=RR2"]\\RemoteDp.contoso.com\.  
StoredPkgVersion (9) of package RR200004. StoredPkgVersion in database is 9.  
SourceVersion (9) of package RR200004. SourceVersion in database is 9.
```

Package Transfer Manager (the DP is remote) then initiates sending of the content:

```output
PkgXferMgr.log  
DeleteJobNotificationFiles deleted 1 *.PKN file(s) this cycle.  
Found send request with ID: 105, Package: RR200004, Version:9, Priority: 2, Destination: REMOTEDP.CONTOSO.COM, DPPriority: 200  
Created sending thread (Thread ID = 0x1140)  
Sending thread starting for Job: 105, package: RR200004, Version: 9, Priority: 2, server: REMOTEDP.CONTOSO.COM, DPPriority: 200  
Sending legacy content RR200004.9 for package RR200004  
Finished sending SWD package RR200004 version 9 to distribution point REMOTEDP.CONTOSO.COM  
Sent status to the distribution manager for pkg RR200004, version 9, status 3 and distribution point ["Display=\\RemoteDp.contoso.com\"]MSWNET:["SMS_SITE=RR2"]\\RemoteDp.contoso.com\  
StateTable::CState::Handle - (8210:1 2014-09-10 13:19:12.087+00:00) >> (8203:3 2013-11-26 15:43:48.108+00:00)  
Successfully send state change notification 7F6041B0-3EE2-427F-AB72-B89610A6331C  
Sending thread complete
```

SMS Distribution Point Provider then deploys the WIM to the remote install directory:

```output
Smsdpprov.log  
[468][Wed 09/10/2014 14:09:59]:A DP usage gathering task has been registered successfully  
[99C][Wed 09/10/2014 14:19:07]:Content 'RR200004.9' for package 'RR200004' has been added to content library successfully  
[99C][Wed 09/10/2014 14:19:07]:Expanding C:\SCCMContentLib\FileLib\E8A1\E8A136A1348B4CFE97334D0F65934845F2B4675D0B7D925AB830378F4ECF39B9 from package RR200004  
[99C][Wed 09/10/2014 14:19:07]:Finding Wimgapi.Dll  
[99C][Wed 09/10/2014 14:19:07]:Found C:\Windows\system32\wimgapi.dll  
[99C][Wed 09/10/2014 14:19:07]:Expanding RR200004 to C:\RemoteInstall\SMSImages
```

SMSPXE discovers the new image:

```output
SMSPXE.log  
Found new image RR200004  
PXE::CBootImageManager::QueryWIMInfo  
Loaded C:\Windows\system32\wimgapi.dll  
Opening image file C:\RemoteInstall\SMSImages\RR200004\boot.RR200004.wim  
Found Image file: C:\RemoteInstall\SMSImages\RR200004\boot.RR200004.wim  
PackageID: RR200004  
ProductName: Microsoft&reg; Windows&reg; Operating System  
Architecture: 0  
Description: Microsoft Windows PE (x86)  
Version:  
Creator:  
SystemDir: WINDOWS  
Closing image file C:\RemoteInstall\SMSImages\RR200004\boot.RR200004.wim  
PXE::CBootImageManager::InstallBootFilesForImage  
Temporary path to copy extract files from: C:\RemoteInstall\SMSTempBootFiles\RR200004.
```

Make sure that these boot images are configured to deploy from the PXE-enabled DP. Right-click the boot image and select **Properties** > **Data Source**, and then select **Deploy this boot image from the PXE-enabled distribution point**.

## The PXE boot process

The example boot process described here involves three machines: The DHCP server, the PXE-enabled DP, and the client (an x64 BIOS computer). All are located on the same subnet.

> [!NOTE]
> You must make sure that the DHCP (67 and 68), TFTP (69) and BINL (4011) ports are open between the client computer, the DHCP server and the PXE enabled DP.

In the PXE boot process, the client must first acquire TCP/IP parameters and the location of the TFTP boot server. Once a device is powered on and completes the POST, it begins the PXE boot process (prompted via the boot selection menu).

1. The first thing the PXE firmware does is sending a **DHCPDISCOVER** (a UDP packet) broadcast to get TCP/IP details. This includes a list of parameter requests, and below is a sample network trace with the parameter list from a **DHCPDISCOVER** packet:

    :::image type="content" source="media/understand-pxe-boot/network-trace-dhcpdiscover.png" alt-text="Screenshot of a sample network trace with the parameter list from a DHCPDISCOVER packet.":::

   The PXE client then identifies the vendor and machine-specific information so that it can request the location and file name of the appropriate boot image file.

2. The DHCP server and the PXE-enabled DP then send a **DHCPOFFER** to the client containing all of the relevant TCP/IP parameters.

   In the example DHCP offer below, it doesn't contain the server name or boot file information because this is the offer from the DHCP server rather than the PXE enabled DP.

    :::image type="content" source="media/understand-pxe-boot/dhcp-offer.png" alt-text="Screenshot shows DHCP without server name or boot file information.":::

3. The client then replies with a **DHCPREQUEST** once it has selected a **DHCPOFFER**. This contains the IP address from the offer that was selected.
4. The DHCP server responds to the **DHCPREQUEST** with a **DHCPACK** that contains the same details as the **DHCPOFFER**. The server host name and the boot file name are not provided here:

    :::image type="content" source="media/understand-pxe-boot/dhcp-request.png" alt-text="Screenshot shows DHCPACK contains the same details as the DHCPOFFER.":::

5. At this point, we still don't have the boot file information, however now the client has an IP address. Next, the PXE client sends a new **DHCPREQUEST** to the PXE-enabled DP after receiving a **DHCPOFFER** from the earlier **DHCPDISCOVER** broadcast.
6. The PXE-enabled DP sends a **DHCPACK** that contains the BootFileName location and the WDS network boot program (NBP).

     :::image type="content" source="media/understand-pxe-boot/dhcp-pack.png" alt-text="Screenshot shows DHCPACK contains BootFileName and WDS network boot program.":::

## Downloading the boot files

1. After the DHCP conversation completes, the client will start the TFTP session with a read request:

     :::image type="content" source="media/understand-pxe-boot/tftp-session.png" alt-text="Screenshot shows the TFTP session with a read request.":::

   The server responds with the tsize and then the blksize. The client will then transfer the file from the server.

   > [!NOTE]
   > The size of these blocks is the blksize, and in this case it's set to 1456 bytes. The blksize is configurable on Windows Server 2008 and later versions. See [Operating system deployment over a network by using WDS fails in Windows Server 2008 and in Windows Server 2008 R2](https://support.microsoft.com/help/975710).

   Here we can see the end of the DHCP conversation and the start of the TFTP transfer:

    :::image type="content" source="media/understand-pxe-boot/tftp-transfer.png" alt-text="Screenshot shows the end of the DHCP conversation and the start of the TFTP transfer.":::

   When the WDS network boot program (NBP) has been transferred to the client computer, it will be executed. In our example, it starts by downloading `wdsnbp.com`. The NBP dictates whether the client can boot from the network, whether the client must press F12 to initiate the boot and which boot image the client will receive.

   NBPs are both architecture and firmware specific (BIOS or UEFI). On BIOS computers, the NBP is a 16-bit real-mode application, therefore it's possible to use the same NBP for both x86-based and x64-based operating systems.

   In our case (an x64 BIOS machine), the NBP is located in the following directory on the PXE enabled DP: `\\remotedp\c$\RemoteInstall\SMSBoot\x64`

    :::image type="content" source="media/understand-pxe-boot/nbp-location.png" alt-text="Screenshot shows the WDS NBP location.":::

   The files perform the following functions:

   - `PXEboot.com` - x86 and x64 BIOS: Requires the end user to press F12 for PXE boot to continue (this is the default NBP).
   - `PXEboot.n12` - x86 and x64 BIOS: Immediately begins PXE boot (doesn't require pressing F12 on the client).
   - `AbortPXE.com` - x86 and x64 BIOS: Allows the device to immediately begin booting by using the next boot device specified in the BIOS. This allows for devices that should not be booting using PXE to immediately begin their secondary boot process without waiting for a timeout.
   - `Bootmgfw.efi` - x64 UEFI and IA64 UEFI: The EFI version of `PXEboot.com` or `PXEboot.n12` (in EFI, the choice of whether or not to PXE boot is handled within the EFI shell and not by the NBP). `Bootmgfw.efi` is the equivalent of combining the functionality of `PXEboot.com`, `PXEboot.n12`, `abortpxe.com` and `bootmgr.exe`.
   - `wdsnbp.com` - x86 and x64 BIOS: A special NBP developed for use by Windows Deployment Services that serves the following general purposes:

     - Architecture detection
     - Pending devices scenarios

   - `Wdsmgfw.efi` - x64 UEFI and IA64 UEFI: A special NBP developed for use by Windows Deployment Services that serves the following general purposes:

     - Handles prompting the user to press a key to continue PXE boot
     - Pending devices scenarios

2. The NBP downloads the operating system loader and the boot files via TFTP, which include the following:
   - `smsboot\x64\pxeboot.com`
   - `smsboot\x64\bootmgr.exe`
   - `\SMSBoot\Fonts\wgl4_boot.ttf`
   - `\SMSBoot\boot.sdi`
   - `\SMSImages\RR200004\boot.RR200004.wim`

3. A RAMDISK is created using these files and the WinPE WIM file in memory.

     :::image type="content" source="media/understand-pxe-boot/ram-disk.png" alt-text="Diagram shows RAMDISK is created." border="false":::

4. The client boots from the RAMDISK.

## WinPE boot

Once WinPE has booted, the TS boot shell is initiated from the SMS folder that's included in the WinPE image (this folder is injected into the boot WIM when it's imported into Configuration Manager). You can see this process logged in **SMSTS.log** that's located under `X:\Windows\Temp\SMSTSLog\`.

> [!TIP]
> To access this login WinPE, enable the command prompt on the boot image. To do this, right-click **Boot Image** > **Properties** > **Customization**, and then check **Enable command support (testing only)**. You can then access the command prompt by pressing F8 in WinPE.

Here is the initial TS boot shell process:

```output
SMSTS.log  
========================[ TSBootShell.exe ]========================  
Succeeded loading resource DLL 'X:\sms\bin\i386\1033\TSRES.DLL'  
Debug shell is enabled  
Waiting for PNP initialization...  
RAM Disk Boot Path: NET(0)\SMSIMAGES\RR200004\BOOT.RR200004.WIM  
Booted from network (PXE)  
Network(PXE) path: X:\sms\data\  
Found config path X:\sms\data\  
This is not a fixed non usb disk  
Booting from removable media, not restoring bootloaders on hard drive  
X:\sms\data\WinPE does not exist.  
X:\_SmsTsWinPE\WinPE does not exist.  
Executing command line: wpeinit.exe -winpe  
The command completed successfully.  
Starting DNS client service.  
Executing command line: X:\sms\bin\i386\TsmBootstrap.exe /env:WinPE /configpath:X:\sms\data\  
The command completed successfully.
```

Followed by the Task Sequence Manager boot strap:

```output
SMSTS.log  
========================[ TSMBootStrap.exe ]========================  
Command line: X:\sms\bin\i386\TsmBootstrap.exe /env:WinPE /configpath:X:\sms\data\  
Succeeded loading resource DLL 'X:\sms\bin\i386\1033\TSRES.DLL'  
Succeeded loading resource DLL 'X:\sms\bin\i386\TSRESNLC.DLL'  
Current OS version is 6.2.9200.0  
Adding SMS bin folder "X:\sms\bin\i386" to the system environment PATH  
PXE Boot with Root = X:\  
Executing from PXE in WinPE  
Loading TsPxe.dll from X:\sms\bin\i386\TsPxe.dll
```

Once TSPXE is loaded, it downloads the TS variables using TFTP:

```output
SMSTS.log  
TsPxe.dll loaded  
Device has PXE booted  
Variable Path: \SMSTemp\2014.09.05.18.20.31.0001.{0C616323-A027-41B0-A215-057AF4F1E361}.boot.var  
Succesfully added firewall rule for Tftp  
Executing: X:\sms\bin\i386\smstftp.exe -i 10.238.0.2 get \SMSTemp\2014.09.05.18.20.31.0001.{0C616323-A027-41B0-A215-057AF4F1E361}.boot.var X:\sms\data\variables.dat  
Executing command line: "X:\sms\bin\i386\smstftp.exe" -i 10.238.0.2 get \SMSTemp\2014.09.05.18.20.31.0001.{0C616323-A027-41B0-A215-057AF4F1E361}.boot.var X:\sms\data\variables.dat  
Process completed with exit code 0  
Succesfully removed firewall rule for Tftp  
Successfully downloaded pxe variable file.  

Loading Media Variables from "X:\sms\data\variables.dat"  
Loading Media Variables from "X:\sms\data\variables.dat"  
Found network adapter "Intel 21140-Based PCI Fast Ethernet Adapter (Emulated)" with IP Address 10.238.0.3.  
Loading Media Variables from "X:\sms\data\variables.dat"  
Loading variables from the Task Sequencing Removable Media.  
Loading Media Variables from "X:\sms\data\variables.dat"  
Succeeded loading resource DLL "X:\sms\bin\i386\1033\TSRES.DLL"  

Setting SMSTSMP TS environment variable  
Setting _SMSMediaGuid TS environment variable  
Setting _SMSTSBootMediaPackageID TS environment variable  
Setting _SMSTSHTTPPort TS environment variable  
Setting _SMSTSHTTPSPort TS environment variable  
Setting _SMSTSIISSSLState TS environment variable  
Setting _SMSTSLaunchMode TS environment variable  
Setting _SMSTSMediaPFX TS environment variable  
Setting _SMSTSPublicRootKey TS environment variable  
Setting _SMSTSRootCACerts TS environment variable  
Setting _SMSTSSiteCode TS environment variable  
Setting _SMSTSSiteSigningCertificate TS environment variable  
Setting _SMSTSUseFirstCert TS environment variable  
Setting _SMSTSx64UnknownMachineGUID TS environment variable  
Setting _SMSTSx86UnknownMachineGUID TS environment variable
```

At this point, TSPXE locates the Management Point (MP) and downloads policy before presenting the user interface for the user to select the optional Task Sequence:

```output
SMSTS.log  
site=RR2, MP=<http://ConfigMgrR2.CONTOSO.COM>, ports: http=80,https=443  
certificates are received from MP.  
CLibSMSMessageWinHttpTransport::Send: URL: ConfigMgrR2.CONTOSO.COM:80 CCM_POST /ccm_system/request  
Request was successful.  
Downloading policy from <http://ConfigMgrR2.CONTOSO.COM>.  
Retrieving Policy Assignments:  
Processing Policy Assignment {7898f153-a6de-43e9-98c3-ca5cc61483b0}.  
Processing Policy Assignment {fba19677-0e9b-490d-b601-07e247979bd4}.  
Processing Policy Assignment {6306ca4c-e7ed-4cf5-8419-af9b1695a909}.  
Processing Policy Assignment {05a027ff-e9cf-4fa1-8bd8-4565481061e2}.  
Processing Policy Assignment {b3c991f6-9f83-43c3-875c-f60c4492d278}.  
...  
Successfully read 152 policy assignments.
```

Lastly, the collection and machine variables are downloaded and the Welcome Page is activated:

```output
SMSTS.log  
Retrieving collection variable policy.  
Found 0 collection variables.  
Retrieving machine variable policy.  
Downloading policy body {01000053}-{RR2}.  
Response ID: {01000053}-{RR2}  
Reading Policy Body.  
Parsing Policy Body.  
Found 0 machine variables.  
Setting collection variables in the task sequencing environment.  
Setting machine variables in the task sequencing environment.  
Running Wizard in Interactive mode  
Loading Media Variables from "X:\sms\data\variables.dat"  
Activating Welcome Page.  
Loading bitmap
```

## More information

For more information about troubleshooting PXE boot issues, see the following articles:

- [Troubleshooting PXE boot issues](troubleshoot-pxe-boot-issues.md)
- [Advanced troubleshooting for PXE boot issues in Configuration Manager](advanced-troubleshooting-pxe-boot.md).
