---
title: Can't manage boot images in Configuration Manager
description: Describes an issue in which you can't manager boot images in Configuration Manager if the WIMMount service is corrupted, misconfigured, or missing.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Operating Systems Deployment (OSD)\Boot Images
---
# Error when managing boot images in Configuration Manager

This article fixes an issue in which you can't manager boot images in Configuration Manager if the WIMMount service is corrupted, misconfigured, or missing.

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 4096324

## Symptoms

In an environment that has Windows Assessment and Deployment Kit (ADK) installed and up-to-date on the server that hosts the SMS Provider, you can't manage boot images by using Configuration Manager. This includes the following actions:

- Update boot images on distribution points.
- Import new boot images.
- Create new boot images by using the Microsoft Deployment Toolkit (MDT) wizard.
- Modify boot images, such as to add drivers.

In this scenario, the following error is logged in the SMSProv.log file on the SMS Provider server:

> SMS Provider    ExecMethodAsync : SMS_BootImagePackage.PackageID="\<Boot_Image_Package_ID>"::RefreshPkgSource~  
> SMS Provider    Requested class =SMS_BootImagePackage~  
> SMS Provider    Requested num keys =1~  
> SMS Provider    IExtClassManager::ValidateAuthenticationLevel...  
> SMS Provider    CExtProviderClassObject::DoExecuteMethod RefreshPkgSource~  
> SMS Provider    Loaded wimgapi.dll version 10.0.16299.15 from location 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\wimgapi.dll'  
> SMS Provider    WIM index is 1.  
> SMS Provider    Image language ID 1033 and en-US~  
> SMS Provider    Loaded the image from \\\\<Boot_Image_Path>\boot.wim  
> SMS Provider    Temporary path for WIM file is C:\Windows\TEMP\BootImages\\{\<Random_GUID>}\temp.  
> SMS Provider    Loaded the image index 1.  
> SMS Provider    ERROR> failed to mount wim file, err=-1052638943~  
> SMS Provider    ~\*~\*~..\sspbootimagepackage.cpp(5198) : Failed to inject OSD binaries into mounted WIM file (often happens if unsigned drivers are inserted into x64 boot image)~\*~\*~  
> SMS Provider    ~\*~\*~Failed to inject OSD binaries into mounted WIM file (often happens if unsigned drivers are inserted into x64 boot image) ~\*~\*~  

When you manually run DISM.exe on the SMS Provider server, the following error is logged in the DISM.log file:

> DISM       DISM.EXE: Successfully registered commands for the provider: Compatibility Manager.  
> [10780] [0x8007007b] OpenFilterPort:(408): The filename, directory name, or volume label syntax is incorrect.  
> [10780] [0x8007007b] FltCommVerifyFilterPresent:(502): The filename, directory name, or volume label syntax is incorrect.  
> [10780] [0x8007007b] WIMMountImageHandle:(1089): The filename, directory name, or volume label syntax is incorrect.  
> [10780] [0x80070002] StateStoreRemoveMountedImage:(1030): The system cannot find the file specified.  
> [10780] [0x80070002] WIMMountImageHandle:(1331): The system cannot find the file specified.
>
> DISM       DISM WIM Provider: PID=10780 TID=1096 "Failed to mount the image." - CWimImageInfo::Mount(hr:0x8007007b)  
> DISM       DISM WIM Provider: PID=10780 TID=1096 onecore\base\ntsetup\opktools\dism\providers\wimprovider\dll\wimmanager.cpp:2684 - CWimManager::InternalOpMount(hr:0x8007007b)  
> DISM       DISM WIM Provider: PID=10780 TID=1096 onecore\base\ntsetup\opktools\dism\providers\wimprovider\dll\wimmanager.cpp:4028 - CWimManager::InternalCmdMount(hr:0x8007007b)  
> DISM       DISM WIM Provider: PID=10780 TID=1096 "Error executing command" - CWimManager::InternalExecuteCmd(hr:0x8007007b)  
> DISM       DISM WIM Provider: PID=10780 TID=1096 onecore\base\ntsetup\opktools\dism\providers\wimprovider\dll\wimmanager.cpp:2201 - CWimManager::ExecuteCmdLine(hr:0x8007007b)

> [!NOTE]
> Using Process Monitor when you manually run DISM can't identify which file or directory can't be found.

## Cause

This issue occurs if the WIMMount service is corrupted, misconfigured, or missing on the SMS Provider server.

To verify, check the following registry entry on the server that hosts the SMS Provider:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WIMMount\ImagePath`

The value of this entry should be the location of the Wimmount.sys file, which is under the installation directory of Windows ADK.

> [!NOTE]
> The server that hosts the SMS provider may not be the central administration site or primary site server. If there are multiple servers that host the SMS Provider, make sure that you check this registry entry on all SMS Provider servers.

To find the servers that host the SMS Provider at a site, follow these steps:

1. In the Configuration Manager console, go to **Administration** > **Overview** > **Site Configuration** > **Sites**.
2. Right-click the site, and then select **Properties**.
3. On the **General** tab, find the servers that are listed under **SMS Provider location**.

## Resolution

To fix the issue, follow these steps to reinstall the WIMMount service:

1. On the server that hosts the SMS Provider, go to the location where Windows ADK is installed. For example, the default path of Windows ADK 10 is `C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64`.

2. Go to the DISM folder, and then run the following command:

   ```console
   WimMountAdkSetupAmd64.exe /Install
   ```
