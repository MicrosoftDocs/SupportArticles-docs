---
title: Scheduled Updates fails with error 0x800700a1
description: Discusses an issue in which Scheduled Updates fails if Configuration Manager SMS Provider server is running on Windows Server 2012 R2 or Windows Server 2012.
ms.date: 12/05/2023
ms.custom: sap:Operating Systems Deployment (OSD)\Offline Servicing (Scheduled Updates)
ms.reviewer: kaushika, frankroj, lamosley
---
# Scheduled Updates fails if Configuration Manager SMS Provider server is on Windows Server 2012 R2 or Windows Server 2012

This article fixes an issue in which Scheduled Updates fails with error 0x800700a1 in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4517870

## Symptoms

Assume that SMS Provider is installed on a Windows Server 2012 R2-based server or a Windows Server 2012-based server. When you try to use **Scheduled Updates** (offline servicing) in Configuration Manager current branch on a captured custom Windows 10 WIM image, **Scheduled Updates** fails to unmount the image.

In OfflineServicingMgr.log, you find the following error messages:

> SMS_OFFLINE_SERVICING_MANAGER UnMounting Image (Commit Changes = 1)...  
> SMS_OFFLINE_SERVICING_MANAGER WIM::UnMountWIMImage returned code 0x800700a1~  
> SMS_OFFLINE_SERVICING_MANAGER UnMountImage returned code 0x800700a1~  
> SMS_OFFLINE_SERVICING_MANAGER Image UnMount failed with error 161  
> SMS_OFFLINE_SERVICING_MANAGER STATMSG: ID=7913 SEV=E LEV=M SOURCE="SMS Server" COMP="SMS_OFFLINE_SERVICING_MANAGER" SYS=<SMS_Provider_Server> SITE=<Site_Code> PID=\<PID> TID=\<TID> GMTDATE=<Date_Time> ISTR0="<OS_Image_Package_ID>" ISTR1="<Image_Index>" ISTR2="<Temporary_Image_Mount_Directory>" ISTR3="161" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0  
> SMS_OFFLINE_SERVICING_MANAGER Completed processing image package <OS_Image_Package_ID>. Status = Failed  
> SMS_OFFLINE_SERVICING_MANAGER Updated history for image package <OS_Image_Package_ID> in the database  
> SMS_OFFLINE_SERVICING_MANAGER Schedule processing failed

In DISM.log, you find the following additional error messages:

> DISM DISM WIM Provider: PID=\<PID> [GetFileStorageTierClass:(80) -> StorageTiering not supported] (null) (HRESULT=0x0) - CWimManager::WimProviderMsgLogCallback
>
> [\<PID>] [0x800700a1] ImageRecaptureDirectory:(141): The specified path is invalid.  
> [\<PID>] [0x800700a1] WIMCommitImageHandle:(1417): The specified path is invalid.  
>
> DISM DISM WIM Provider: PID=\<PID> TID=\<TID> onecore\base\ntsetup\opktools\dism\providers\wimprovider\dll\wimimage.cpp:194 - CWimImage::Save(hr:0x800700a1)  
> DISM DISM WIM Provider: PID=\<PID> TID=\<TID> "Could not commit changes during unmount." - CWimImage::Unmount(hr:0x800700a1)  
> DISM DISM Imaging Provider: PID=\<PID> TID=\<TID> onecore\base\ntsetup\opktools\dism\providers\imagingprovider\dll\genericimagingmanager.cpp:1082 - CGenericImagingManager::InternalCmdUnmount(hr:0x800700a1)  
> DISM DISM Imaging Provider: PID=\<PID> TID=\<TID> onecore\base\ntsetup\opktools\dism\providers\imagingprovider\dll\genericimagingmanager.cpp:536 - CGenericImagingManager::ExecuteCmdLine(hr:0x800700a1)

Error 0x800700a1 is mentioned as follows:

> Error Code: 0xA1 (161)  
> Error Name: ERROR_BAD_PATHNAME  
> Error Source: Windows  
> Error Message: The specified path is invalid.

## Cause

This issue will occur if the custom Windows 10 WIM image contains reparse points and was captured by using a version of the Windows Assessment and Deployment Kit (ADK) for Windows 10, version 1803 or a later version.

A change was made to the Windows 10, version 1803 ADK to support reparse points in Windows 10 WIM images. This change causes older operating systems, such as Windows Server 2012 R2 or Windows Server 2012, to fail when you unmount a Windows 10 WIM image that has reparse points. The issue will occur only if the image was captured by using the Windows 10, version 1803 ADK or a newer version because those versions of the ADK are the ones that added support for reparse points. Windows Server 2012 R2 and Windows Server 2012 do not have support for the new reparse points that are found in Windows 10. Therefore, it generates the **ERROR_BAD_PATHNAME/The specified path is invalid** error message. This is intentional behavior and is a limitation of Windows Server 2012 R2 and Window Server 2012.

> [!NOTE]
> Although the SMS Provider is usually installed on the same server as the site server, it may not always be installed in that manner. Additionally, the SMS Provider may be installed on multiple servers. When you check for the issue, make sure to check whether the servers that host the SMS Provider is Windows Server 2012 or Windows Server 2012 R2. For more information about how to do this, see [Plan for the SMS Provider - Location](/mem/configmgr/core/plan-design/hierarchy/plan-for-the-sms-provider#bkmk_location).

## Workaround

To work around this limitation in Windows Server 2012 and Windows Server 2012 R2, use one of the following methods:

- Upgrade the server that hosts the SMS Provider to Windows Server 2016 or a later version. Windows Server 2016 and later versions of Windows Server support Windows 10 reparse points.

- Move the SMS Provider to a server that's running Windows Server 2016 or a later version. This server can be a separate server from the site server. Make sure that the appropriate ADK is installed on the new server. For compatible and supported versions of the ADK, see the [Windows 10 ADK](/mem/configmgr/core/plan-design/configs/support-for-windows-10#windows-10-adk).

  For more information about how to move the SMS Provider and determine which servers host the SMS Provider, see [Locations](/mem/configmgr/core/plan-design/hierarchy/plan-for-the-sms-provider#bkmk_location).

- Recapture the custom image without the application that uses reparse points. Instead, install the application that uses reparse points during the task sequence that deploys the image. The offending app that has reparse points can be discovered by using the Sysinternals tools Process Monitor (ProcMon) when the issue occurs. ProcMon is available to download from [Process Monitor v3.53](/sysinternals/downloads/procmon). An example of an application that uses reparse points is Office 365.

- If you are capturing a Windows 10, version 1709 image or an earlier version, use the 1709 ADK instead. Specifically, use DISM.exe from the 1709 ADK. The capture may have to be done manually outside Configuration Manager because of the ADK requirement of a newer version of the ADK for Configuration Manager. (See the [Windows 10 ADK](/mem/configmgr/core/plan-design/configs/support-for-windows-10#windows-10-adk) about ADK compatibility and supportability.)

  > [!NOTE]
  > This method isn't recommend for Windows 10, version 1803 or a later version of Windows images because capturing images should be done by using versions of DISM that are the same or later than the Windows version that is being captured.

## Cleaning up after a failure

Because Scheduled Updates was unable to correctly unmount the WIM image when this issue occurred, you may have to manually unmount the OS WIM image and clean up the temporary directories that were left behind by Scheduled Update after it failed. Until the temporary directories are cleaned up, additional attempts to run Scheduled Updates on OS WIM images may fail, including on OS WIM images that don't have reparse points.

The temporary directory that is used by Configuration Manager for Scheduled Updates will be located at the root of one of the drives on the server and will be called **ConfigMgr_OfflineImageServicing**. The mounted image will be in a subdirectory under this directory. For example, if the temporary directory is on the D drive, the path of the mounted image would be *D:\ConfigMgr_OfflineImageServicing\\<OS_Image_Package_ID>\ImageMountDir*.

> [!NOTE]
> In this path, *OS_Image_Package_ID* is the package ID of the OS WIM that's being serviced.

You have to manually unmount the image by using DISM.exe and the `/discard` option. For example, if the package ID for the OS WIM image was CAS00123, the command-line command to unmount the image would be as follows:

```console
Dism.exe /unmount-image /mountdir:D:\ConfigMgr_OfflineImageServicing\CAS00123\ImageMountDir /discard
```

This will discard any changes that are made to the OS WIM image, including any updates that were added to the image. However, trying to use the `/commit` option will cause the original error to occur again. Therefore, to correctly clean up, the only option is to discard the changes that are made to the image. As soon as the OS WIM image is correctly unmounted, you can delete the whole **ConfigMgr_OfflineImageServicing** folder.

For more information about DISM.exe and how to unmount OS WIM images, see [Unmounting an image](/windows-hardware/manufacture/desktop/mount-and-modify-a-windows-image-using-dism#unmounting-an-image).
