---
title: How to customize the default local user profile when you prepare an image of Windows
description: Describes how to customize the default local user profile when you prepare an image of Windows XP or Windows Server 2003.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: pleblanc, scottmca, toshikas, clandis, kaushika
ms.custom: sap:setup, csstroubleshoot
---
# How to customize the default local user profile when you prepare an image of Windows

This article discusses how to customize the default local user profile settings when you create an image in Windows.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 959753

## Introduction

This article discusses how to customize the default local user profile settings when you create an image on a computer that is running one of the following operating systems:

- Windows XP
- Windows Server 2003

After you deploy the image, these settings are applied to all new users who log on to the computer.

> [!NOTE]
> This article supersedes all previously published procedures for customizing default local user profiles when you prepare images.

For more information about the steps to customize the default local user profile for Windows Vista or later operating systems, see [How to customize default user profiles in Windows Vista, Windows Server 2008, Windows 7, and in Windows Server 2008 R2](customize-default-local-user-profile.md).

## How to customize the default local user profile in Windows XP or in Windows Server 2003

In Windows XP and in Windows Server 2003, updates that you've installed may change the method that you use to customize the default local user profile. For more information, see the following sections.

### Windows XP Service Pack 2 (SP2)

The default behavior is to automatically copy customizations from the administrator profile to the default user profile. Therefore, no additional steps are required to customize the profile.

### Windows Server 2003 Service Pack 1 (SP1) or Windows Server 2003 SP2

The default behavior is to automatically copy customizations from the administrator profile to the default user profile. Therefore, no additional steps are required to customize the profile. You can disable this functionality by setting a parameter in the Sysprep.inf file. This parameter prevents the Minisetup process from copying customizations from the administrator profile. To do this, set the parameter in the "UNATTENDED" section of the Sysprep.inf file as follows:

```inf
[UNATTENDED]  
UpdateServerProfileDirectory=0
```

### Windows XP Service Pack 3 (SP3) or hotfix 887816 is applied

Hotfix 887816 disables the automatic copying of customizations. Therefore, you must configure a parameter in the Sysprep.inf file to enable the Minisetup process to copy the customizations from the administrator profile. To do this, set the parameter in the "UNATTENDED" section, as follows:

```inf
[UNATTENDED]  
UpdateServerProfileDirectory=1
```

> [!NOTE]
> Windows XP SP3 includes hotfix 887816.

### Windows XP or Windows Server 2003

To use this CopyProfile setting in Windows XP SP2 together with hotfix 887816, in Windows XP SP3, or in Windows Server 2003 SP1, the UpdateServerProfileDirectory setting must be present in the Sysprep.inf file when you run the Sysprep tool. Therefore, when you use automated image build and deployment tools, such as the Microsoft Deployment Toolkit or System Center Configuration Manager, the UpdateServerProfileDirectory setting must be included during the reference image build and capture process.

## References

For more information about how to configure default local user profile settings, visit the following Microsoft website:

[Configuring Default User Settings – Full Update for Windows 7 and Windows Server 2008 R2](/archive/blogs/deploymentguys/configuring-default-user-settings-full-update-for-windows-7-and-windows-server-2008-r2)

## More information

The procedure that is described in this article supersedes all previously published procedures for customizing default local user profiles when you prepare images. This behavior applies to the following operating systems:

- Windows Server 2003
- Windows XP

Previously published procedures relied on a file copy mechanism. These procedures caused information to be left behind in the default user profile that caused the Windows shell to behave incorrectly. This led to problems with application compatibility and with the user experience. Therefore, don't advise customers to copy profiles over the default user profile. This method is no longer supported.

### How to configure the default network profile

Install the version of Windows for which you want to use the profile. Follow the procedures in this article to configure the local default user profile. Restart the computer after you run the Sysprep command. When the operating system finishes the Minisetup/Specialize process, log on as the local administrator. Use the newly configured local default user profile as the source for the default network profile.

### How to configure default user settings for already deployed desktops

Implement the required new or changed settings as a logon script and configure it to run one time.

You can automate the procedure in Knowledge Base article 284193 by using the Reg.exe command. For an alternative solution, see the "Targeted changes to the Default User Registry hive and profile folders" section on the following Microsoft website:

[Configuring Default User Settings – Full Update for Windows 7 and Windows Server 2008 R2](/archive/blogs/deploymentguys/configuring-default-user-settings-full-update-for-windows-7-and-windows-server-2008-r2)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
