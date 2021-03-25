---
title: Certificates are missing after you update a device to a newer version of Windows 10
description: This article provides workarounds for an issue in which a device loses its system and user certificates after an update.
ms.date: 02/15/2020
author: Teresa-Motiv
ms.author: v-tea
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: deployment
ms.technology: windows-client-deployment
keywords: managed devices, certificates, WSUS, MECM
---

# Certificates are missing after you update a device to a newer version of Windows 10

This article provides workarounds for an issue in which a device loses its system and user certificates after an update.

_Original product version:_ &nbsp;Windows 10, version 20H2; Windows 10, version 2004; Windows 10, version 1909; Windows 10, version 1903

## Symptoms

You have a device that runs Windows 10, version 1809 or later. The device also has a latest cumulative update (LCU) that was released on September 16, 2020, or later. After you update the device to a later version of Windows, the device loses its system and user certificates.

## Cause

This behavior might occur when the installation source or media that was used to update the device is out-of-date. The update doesn't include an LCU that was released on October 13, 2020, or later. The behavior typically affects managed devices in environments in which an update management tool such as Windows Server Update Services (WSUS) or Microsoft Endpoint Configuration Manager downloads updates and then distributes them to devices. It also affects devices that are updated by using outdated physical media or ISO images.

This behavior doesn't affect devices that use Windows Update for Business or that connect directly to Windows Update. Any device that connects to Windows Update should always receive the latest versions of the feature update, including the latest LCU, without any extra steps.  

## Workaround

To mitigate this issue, do one of the following:

- Download a new source image from the Microsoft Update Catalog or from the Volume Licensing Service Center to replace your previous source image. Then use that image to update the device.
- Roll the device back to the previous Windows version, add the missing LCU to the update, and then reinstall the update.

> [!IMPORTANT]  
>  
> - The rollback process does not affect your personal files, but it removes any apps and drivers that you installed after you installed the update. It also reverses any changes to settings that you made after you installed the update.
> - By default, you can only roll back an update within 10 days of installing it. You can change this time limit by opening a Command Prompt window and running the following command:
>  
>   ```console
>   Dism /Online /Set-OSUninstallWindow /Value:<days>
>   ```
>  
>   In this command, \<*days*> is an integer between 2 and 60.

To roll back, follow these steps:

1. Select **Start** > **Settings** > **Update & Security** > **Recovery**.
1. Under **Go back to the previous version of Windows 10**, select **Get started**.  

To add the latest LCU to the update source, follow these steps:

1. Mount the source ISO image, and then copy the install.wim file to a writeable location.  

   > [!NOTE]  
   > If the image has an install.esd file instead of an install.wim file, use the [**Dism /Export-Image**](https://docs.microsoft.com/windows-hardware/manufacture/desktop/dism-image-management-command-line-options-s14#export-image) command to convert the .esd file to a .wim file.

1. Go to [Windows 10 update history](https://support.microsoft.com/help/4581839/windows-10-update-history) and look up the correct LCU number for your system version.

1. Go to [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx), and then download the LCU.

   > [!NOTE]  
   > If you are using WSUS to manage updates, see [WSUS and the Catalog Site](/windows-server/administration/windows-server-update-services/manage/wsus-and-the-catalog-site#the-microsoft-update-catalog-site). This article describes how to use WSUS to download updates from the Microsoft Update Catalog.

1. To add the LCU to the image, open an administrative Command Prompt window and run the following command:

   ```console
   Dism /Add-Package /Image:"C:\Mount\Windows" /PackagePath="windows10.0-kb4586781-x64_bd543ce012ec1695201cdb2d324a2206bd445132.msu"  /LogPath=C:\Mount\Dism.log
   ```

1. Review the list of packages that the **Dism** command produced, and verify that the list contains the package. To view the list, run the following command:

   ```console
   Dism /Get-Packages /Image:<Path_to_Image>
   ```

   > [!NOTE]  
   > In this command, \<*Path_to_Image*> is the path and filename of the image file.

1. Commit and unmount the image. To do this, run the following command:

   ```console
   Dism /Unmount-Image /MountDir:<Path_to_Mount_Directory> /Commit
   ```

   > [!NOTE]  
   > In this command, \<*Path_to_Mount_Directory*> is the path to the mounted image.

1. (Optional) Use the updated file to recreate the image. to do this, run the following command:

   ```console
   Oscdimg –n –d –m “<Source>” “<Target.iso>”
   ```

   > [!NOTE]  
   > In this command, \<*Source*> is the location of the files that you intend to build into an image and \<*Target.iso*> is the name of the ISO image file.

## More information

- [Add updates to a Windows image](https://docs.microsoft.com/windows-hardware/manufacture/desktop/servicing-the-image-with-windows-updates-sxs)
- [Add-WindowsPackage](https://docs.microsoft.com/powershell/module/dism/add-windowspackage?view=win10-ps)
- [Modify a Windows image using DISM](https://docs.microsoft.com/windows-hardware/manufacture/desktop/mount-and-modify-a-windows-image-using-dism)
- [Oscdimg Command-Line Options](https://docs.microsoft.com/windows-hardware/manufacture/desktop/oscdimg-command-line-options)
