---
title: Availability and description of AD FS 2.0
description: Describes Active Directory Federation Services 2.0.
ms.date: 01/15/2025
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, bbrekkan
ms.custom:
- sap:windows security technologies\active directory federation services (ad fs) non-azure-o365 issues
- pcy:WinComm Directory Services
---
# Availability and description of Active Directory Federation Services 2.0

This article provides availability and description of Active Directory Federation Services 2.0.

_Original KB number:_ &nbsp; 974408

## Introduction

Active Directory Federation Services (AD FS) 2.0 helps IT enable users to collaborate across organizational boundaries and easily access applications on-premises and in the cloud. And, AD FS helps maintain application security. Through a claims-based infrastructure, IT can enable a single sign-on experience for end-users to applications. Such a claims-based infrastructure does not require a separate account or password, whether applications are located in partner organizations or hosted in the cloud.

## System requirements

To implement AD FS 2.0, the computer must run one of the following Windows operating systems:

- Windows Server 2008 R2 (64-bit):
  - Datacenter Edition
  - Enterprise Edition
  - Standard Edition
  - Embedded Solution Edition
  - Small Business Solutions Edition
  - Small Business Solutions EM Edition
  - Small Businesses Server Standard Edition
  - Small Businesses Server Premium Edition
  - Solutions Premium Edition
  - Solutions Edition
  - Solutions EM Edition
  - Foundation Server Edition
  - Small Businesses Edition
  - Essential Additional Edition
  - Essential Additional Svc Edition
  - Essential Management Edition
  - Essential Management Svc Edition

- Windows Server 2008 together with Service Pack 2 (32-bit or 64-bit):
  - Datacenter Edition
  - Datacenter without Hyper-V Edition
  - Enterprise Edition
  - Enterprise without Hyper-V Edition
  - Standard Edition
  - Medium Business Management Edition
  - Medium Business Messaging Edition
  - Medium Business Security Edition
  - Small Business Server Premium Edition
  - Small Business Server Standard Edition
  - Small Business Server Prime Edition
  - Small Businesses Edition
  - Small Businesses Edition without Hyper-V

To install AD FS 2.0, the following software and hotfixes must be installed. If they are not installed when AD FS 2.0 is installed, the AD FS 2.0 Setup program installs them automatically.

- The Microsoft .NET Framework 3.5 together with Service Pack 1
    > [!NOTE]
    > This software is automatically installed only when the computer is running Windows Server 2008 R2.
- Windows PowerShell
- Internet Information Services (IIS) 7
- Windows Identity Foundation (WIF)
- Software updates and hotfixes

  - Windows Server 2008 R2

    The following hotfix must be installed on computers that are running Windows Server 2008 R2:  
      [981002](https://support.microsoft.com/help/981002) A hotfix rollup is available for Windows Communication Foundation in the .NET Framework 3.5 Service Pack 1 for Windows 7 and Windows Server 2008 R2  

  - Windows Server 2008

    The following software updates and hotfixes must be installed on computers that are running Windows Server 2008 SP2:

    [973917](https://support.microsoft.com/help/973917) Description of the update that implements Extended Protection for Authentication in Internet Information Services (IIS)  

## Supported languages

AD FS 2.0 is supported in the following languages:

- Chinese (Simplified)
- Chinese (Traditional)
- Czech
- Dutch
- English
- French
- German
- Hungarian
- Italian
- Japanese
- Korean
- Polish
- Portuguese (Brazil)
- Portuguese (Iberian)
- Russian
- Spanish
- Swedish
- Turkish

## Download information

The following files are available for download from the Microsoft Download Center:

|Package name| Supported Windows operating system| Platform| Download file size|
|---|---|---|---|
|AdfsSetup.exe|Windows Server 2008 R2|x64|24.04 MB|
|AdfsSetup.exe|Windows Server 2008 SP2|x64|42.64 MB|
|AdfsSetup.exe|Windows Server 2008 SP2|x86|38.66 MB|
  
For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

## More information about Active Directory Federation Services 2.0

For more information about technical details and white papers, see [Active Directory Federation Services 2.0 Overview](https://go.microsoft.com/fwlink/?linkid=190555).

## Upgrade information for Windows operating systems

If you have AD FS 2.0 deployed on a computer that is running Windows Server 2008, AD FS 2.0 is automatically uninstalled when you upgrade your Windows operating system to Windows Server 2008 R2. You have to install the AD FS 2.0 installation package for Windows Server 2008 R2 after you upgrade the Windows operating system.

If you want to preserve the previous configuration data on the federation server and restore the data after you reinstall AD FS 2.0, follow the steps in the [Before you upgrade Windows](#before-you-upgrade-windows) and [After you upgrade Windows](#after-you-upgrade-windows) sections.

### Before you upgrade Windows

Copy the AD FS service configuration file to a file server on the network before you upgrade the operating system. And, note the service account that the AD FS 2.0 Windows Service uses. To do this, follow these steps:

1. Locate the following AD FS 2.0 installation folder:  
    %system drive%\\Program Files\\Active Directory Federation Service 2.0

2. Copy the following configuration file to a safe backup location:  
    Microsoft.IdentityServer.Servicehost.exe.config

3. Click **Start**, click **Run**, type _services.msc_, and then click **OK**.
4. Right-click **AD FS 2.0 Windows Service**, and then click **Properties**.
5. On the **Log On** tab, note the service account that is used for the AD FS 2.0 Windows Service.

### After you upgrade Windows

Reinstall AD FS 2.0, set a registry setting to restore the previous configuration, restore the service account, and start the appropriate services. To do this, follow these steps.

> [!NOTE]
> After you finish these steps, the previous installation of AD FS 2.0 that was present on this federation server before the upgrade is restored.

1. Reinstall AD FS 2.0.
2. Copy the following configuration file that you saved in step 2 of the [Before you upgrade Windows](#before-you-upgrade-windows) section:  
    Microsoft.IdentityServer.Servicehost.exe.config
3. Locate the following AD FS 2.0 installation folder, and then copy the file that is mentioned in step 2 to this location:  
    %system drive%\\Program Files\\Active Directory Federation Service 2.0
4. Click **Start**, click **Run**, type _regedit_, and then click **OK**.
5. Locate and then click the following registry subkey:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\adfssrv`

6. On the **Edit** menu, point to **New**, and then click **String Value**.
7. Type _InitialConfigurationCompleted_, and then press ENTER.
8. Right-click **InitialConfigurationCompleted**, and then click **Modify**.
9. In the **Value data** box, type _TRUE_, and then click **OK**.
10. On the **File** menu, click **Exit** to exit Registry Editor.
11. Click **Start**, click **Run**, type _services.msc_, and then click **OK**.
12. If you use Windows Internal Database as the AD FS 2.0 configuration database, follow these steps. Otherwise, bypass step 12, and go to step 13.

    1. Right-click **Windows Internal Database (MICROSOFT##SSEE)**, and then click **Properties**.
    2. On the **General** tab, if the **Service status** field does not display **Started**, click **Start** to start the Windows Internal Database service.
    3. Click **OK**.
13. Right-click **AD FS 2.0 Windows Service**, and then click **Properties**.
14. On the **Log On** tab, provide the original backed-up service account name and the password that is used for the AD FS 2.0 Windows Service.
15. On the **General** tab, select **Automatic** in the **Startup type** box.
16. If the **Service status** field doesn’t display **Started**, click **Start** to start the AD FS 2.0 Windows Service.
17. Click **OK**.

## Privacy statement information

AD FS 2.0 is covered by the following Windows Server privacy statement:

[Windows 7 Privacy Statement](https://privacy.microsoft.com/windows-7-privacy-statement)

## Technical revisions

The following table lists significant technical revisions to this article. The revision number and the last review date in this article might indicate minor editorial revisions or structural revisions to this article that are not included in the table.

| Date| Revision |
|---|---|
|May 5, 2010|Original publication date|
  
