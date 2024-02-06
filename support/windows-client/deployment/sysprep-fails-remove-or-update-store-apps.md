---
title: Sysprep fails with Microsoft Store apps
description: Describes an issue that occurs when you remove a provisioned Windows Store app or update a Windows Store app by using the Windows Store and then running sysprep on the machine.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, vimalsh, shijithk, kaushika, wcheng, jodav
ms.custom: sap:servicing, csstroubleshoot
---
# Sysprep fails after you remove or update Microsoft Store apps that include built-in Windows images

This article discusses an issue that occurs when you remove or update a provisioned Microsoft Store app by using the Microsoft Store and then running sysprep on the computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 11  
_Original KB number:_ &nbsp; 2769827

## Introduction

Sysprep is a tool for IT administrators who want to prepare an installation of Windows for duplication, auditing, and customer delivery. The guidance in this article is intended for use by support agents and IT professionals. If you are a home user who is encountering issues while using Microsoft Store apps, see [Fix problems with apps from Microsoft Store](https://support.microsoft.com/help/4027498).

Several Microsoft Store apps are built in Windows images. These apps include the Mail, Maps, Messaging, Bing, Travel, and News apps, among others. These apps are known as *provisioned* apps. Provisioned apps are staged in the image and are scheduled to be installed for every user of the Windows image at first logon. In addition to the built-in apps, you can side-load your own line-of-business Microsoft Store apps into the Windows image without having to publish them to the Microsoft Store. You can side-load `Appx` packages by using online or offline servicing commands that are available in DISM.exe or through the DISM PowerShell module.

## Symptoms

Consider the following scenarios:

Scenario 1

- You are creating a custom Windows 10 or Windows 11 reference computer that you want to sysprep and capture.
- You want to remove some of the provisioned Microsoft Store apps (`Appx` packages) from this reference computer.
- You run `dism -online /Remove-ProvisionedAppxPackage /PackageName:<packagename>` to deprovision the `Appx` packages.

When you run sysprep operation in this scenario, the operation may fail with the following error:

> System Preparation Tool 3.14  
> A fatal error occurred while trying to sysprep the machine

Scenario 2

- You have an existing Windows image, and several Microsoft Store apps are side-loaded in the image.
- You want to remove some of the side-loaded `Appx` packages from your image and customize it further.
- You boot into the reference computer and run one of the following PowerShell commands to remove the provisioning of the `Appx` package:
  - `Remove-AppxProvisionedPackage -PackageName <packagename>`
  - `Remove-ProvisionedAppxPackage -PackageName <packagename>`
  
When you run sysprep operation in this scenario, the operation may fail with the following error:

> System Preparation Tool 3.14  
> A fatal error occurred while trying to sysprep the machine

Scenario 3

- You are creating a Windows 10 or Windows 11 reference image.
- You connect to the Microsoft Store, and then you update the built-in Microsoft Store apps by using the Microsoft Store.

When you run sysprep operation in this scenario, the operation may fail with the following error:

> System Preparation tool 3.14
> A fatal error occurred while trying to sysprep the machine

Additionally, in the SetupErr.log, you may notice the following error entries:

> \<Date\> \<Time\>, Error SYSPRP Package \<PackageFullName> was installed for a user, but not provisioned for all users. This package will not function properly in the sysprep image.  
> \<Date\> \<Time\>, Error SYSPRP Failed to remove apps for the current user: 0x80073cf2.  
> \<Date\> \<Time\>, Error SYSPRP Exit code of RemoveAllApps thread was 0x3cf2.  
> \<Date\> \<Time\>, Error [0x0f0082] SYSPRP ActionPlatform::LaunchModule: Failure occurred while executing 'SysprepGeneralize' from C:\Windows\System32\AppxSysprep.dll; dwRet = 0x3cf2  
> \<Date\> \<Time\>, Error SYSPRP ActionPlatform::ExecuteAction: Error in executing action; dwRet = 0x3cf2  
> \<Date\> \<Time\>, Error SYSPRP ActionPlatform::ExecuteActionList: Error in execute actions; dwRet = 0x3cf2  
> \<Date\> \<Time\>, Error SYSPRP SysprepSession::Execute: Error in executing actions from C:\Windows\System32\Sysprep\ActionFiles\Generalize.xml; dwRet = 0x3cf2  
> \<Date\> \<Time\>, Error SYSPRP RunPlatformActions:Failed while executing SysprepSession actions; dwRet = 0x3cf2  
> \<Date\> \<Time\>, Error [0x0f0070] SYSPRP RunExternalDlls:An error occurred while running registry sysprep DLLs, halting sysprep execution. dwRet = 0x3cf2  
> \<Date\> \<Time\>, Error [0x0f00a8] SYSPRP WinMain:Hit failure while processing sysprep generalize internal providers; hr = 0x80073cf2

## Cause

Sysprep has an additional provider that's added in Windows to clean `Appx` packages and to generalize the image. The provider works only if the `Appx` package is a per-user package or an all-user provisioned package.

- *Per-user package* means that the `Appx` package is installed for a particular user account and is not available for other users of the computer.
- *All-user package* means that the `Appx` has been provisioned into the image so that all users who use this image can access the app.

If an all-user package that's provisioned into the image was manually deprovisioned from the image but not removed for a particular user, the provider will encounter an error while cleaning out this package during sysprep. The provider will also fail if an all-user package that's provisioned into the image was updated by one of the users on this reference computer.

## Resolution

To resolve this issue, remove the package for the user who's running sysprep, and also remove the provisioning. To do this, follow these steps.

> [!NOTE]
> To prevent Microsoft Store from updating apps, unplug the Internet connection or disable Automatic Updates in Audit mode before you create the image.

1. Run the Import-Module Appx PowerShell cmdlet.
2. Run Import-Module Dism.
3. Run `Get-AppxPackage -AllUsers | Where PublisherId -eq 8wekyb3d8bbwe | Format-List -Property PackageFullName,PackageUserInformation`.

    > [!NOTE]  
    >
    > - In the output of this last cmdlet, check the users for whom the package is showing up as Installed. Delete these user accounts from the reference computer, or log on to the computer by using these user accounts. Then, run the cmdlet in step 4 to remove the `Appx` package.
    > - This command lists all packages that were published by Microsoft and installed by any user of that reference computer. Because the computer is to be sysprepped, we assume that these user profiles no longer require the package.
    > - If you have manually provisioned apps that belong to other publishers, run the following command to list them:  
    > Get-AppxPackage -AllUsers | Format-List -Property PackageFullName,PackageUserInformation

4. Run `Remove-AppxPackage -Package \<packagefullname>`.
5. Remove the provisioning by running the following cmdlet:

    Remove-AppxProvisionedPackage -Online -PackageName \<packagefullname>

If you try to recover from an update issue, you can reprovision the app after you follow these steps.

> [!NOTE]
> The issue does not occur if you are servicing an offline image. In that scenario, the provisioning is automatically cleared for all users. This includes the user who runs the command.

## More information

For more information about how to add and remove apps, see:

- [Sideload Apps with DISM](/previous-versions/windows/it-pro/windows-8.1-and-8/hh852635(v=win.10))
- [Add or Remove Packages Offline Using DISM](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824838(v=win.10))

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
