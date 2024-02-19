---
title: Create and manage Central Store
description: Describes how to create a Central Store on a domain controller to store and replicate registry-based policies for Windows.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# How to create and manage the Central Store for Group Policy Administrative Templates in Windows

This article describes how to use the new .admx and .adml files to create and administer registry-based policy settings in Windows. This article also explains how the Central Store is used to store and to replicate Windows-based policy files in a domain environment.

_Applies to:_ &nbsp; Windows 11, Windows 10 - all editions, Windows Server 2019, Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 3087759

## Links to download the Administrative Templates files based on the operating system version

- [Administrative Templates (.admx) for Windows 11 2022 Update (22H2) - v3.0](https://www.microsoft.com/download/details.aspx?id=105390)
- [Administrative Templates (.admx) for Windows 11 2022 Update (22H2)](https://www.microsoft.com/download/details.aspx?id=104593)
- [Administrative Templates (.admx) for Windows 11 October 2021 Update (21H2)](https://www.microsoft.com/download/details.aspx?id=103507)
- [Administrative Templates (.admx) for Windows 10 2022 Update (22H2)](https://www.microsoft.com/download/details.aspx?id=104677) 
- [Administrative Templates (.admx) for Windows 10 November 2021 Update (21H2) - v2.0](https://www.microsoft.com/download/details.aspx?id=104042)
- [Administrative Templates (.admx) for Windows 10 November 2021 Update (21H2)](https://www.microsoft.com/download/details.aspx?id=103667)
- [Administrative Templates (.admx) for Windows 10 May 2021 Update (21H1)](https://www.microsoft.com/download/details.aspx?id=103124)
- [Administrative Templates (.admx) for Windows 10 October 2020 Update (20H2) - v2.0](https://www.microsoft.com/download/details.aspx?id=103060)
- [Administrative Templates (.admx) for Windows 10 May 2020 Update (2004)](https://www.microsoft.com/download/details.aspx?id=101445)
- [Administrative Templates (.admx) for Windows 10 November 2019 Update (1909)](https://www.microsoft.com/download/details.aspx?id=100591)
- [Administrative Templates (.admx) for Windows 10 May 2019 Update (1903)](https://www.microsoft.com/download/details.aspx?id=58495)
- [Administrative Templates (.admx) for Windows 10 October 2018 Update (1809)](https://www.microsoft.com/download/details.aspx?id=57576)
- [Administrative Templates (.admx) for Windows 10, version 1803 (April 2018 Update)](https://www.microsoft.com/download/details.aspx?id=56880)
- [Administrative Templates (.admx) for Windows 10, version 1709 (Fall Creators Update)](https://www.microsoft.com/download/details.aspx?id=56121)  
- [Administrative Templates (.admx) for Windows 10, version 1703 (Creators Update)](https://www.microsoft.com/download/details.aspx?id=55080)
- [Administrative Templates (.admx) for Windows 10, version 1607 and Windows Server 2016](https://www.microsoft.com/download/details.aspx?id=53430)
- [Administrative Templates (.admx) for Windows 10 and Windows 10, version 1511](https://www.microsoft.com/download/details.aspx?id=48257)
- [Administrative Templates (.admx) for Windows 8.1 Update and Windows Server 2012 R2 Update](https://www.microsoft.com/download/details.aspx?id=43413)
- [Administrative Templates (.admx) for Windows 8.1 and Windows Server 2012 R2](https://www.microsoft.com/download/details.aspx?id=41193)

To view ADMX spreadsheets of the new settings that are available in later operating system versions, see the following spreadsheets:

- [Group Policy Settings Reference Spreadsheet for Windows 10 November 2021 Update (21H2)](https://www.microsoft.com/download/details.aspx?id=103668)
- [Group Policy Settings Reference Spreadsheet for Windows 11 October 2021 Update (21H2)](https://www.microsoft.com/download/details.aspx?id=103506)

## Overview

Administrative Templates files are divided into .admx files and language-specific .adml files for use by Group Policy administrators. The changes that are implemented in these files let administrators configure the same set of policies by using two languages. Administrators can configure policies by using the language-specific .adml files and the language-neutral .admx files.

## Administrative Templates file storage

Windows uses a Central Store to store Administrative Templates files. The ADM folder is not created in a Group Policy Object (GPO) as it is done in earlier versions of Windows. Therefore, Windows domain controllers do not store or replicate redundant copies of .adm files.

## The Central Store

To take advantage of the benefits of .admx files, you must create a Central Store in the sysvol folder on a Windows domain controller. The Central Store is a file location that is checked by the Group Policy tools by default. The Group Policy tools use all .admx files that are in the Central Store. The files that are in the Central Store are replicated to all domain controllers in the domain.

We suggest keeping a repository of any ADMX/L files that you have for applications that you may want to use. For example, operating system extensions like Microsoft Desktop optimization Pack (MDOP), Microsoft Office, and also third-party applications that offer Group Policy support.

To create a Central Store for .admx and .adml files, create a new folder named PolicyDefinitions in the following location (for example) on the domain controller:

`\\contoso.com\SYSVOL\contoso.com\policies\PolicyDefinitions`

When you already have such a folder that has a previously built Central Store, use a new folder describing the current version such as:

`\\contoso.com\SYSVOL\contoso.com\policies\PolicyDefinitions-1803`

Copy all files from the PolicyDefinitions folder on a source computer to the new PolicyDefinitions folder on the domain controller. The source location can be either of the following ones:

- The `C:\Windows\PolicyDefinitions` folder on a Windows 8.1-based or Windows 10-based client computer
- The `C:\Program Files (x86)\Microsoft Group Policy\<version-specific>\PolicyDefinitions` folder, if you have downloaded any of the Administrative Templates separately from the links above.

The PolicyDefinitions folder on the Windows domain controller stores all .admx files and .adml files for all languages that are enabled on the client computer.

The .adml files are stored in a language-specific folder. For example, English (United States).adml files are stored in a folder that is named *en-US*. Korean .adml files are stored in a folder that is named *ko_KR*, and so on.

If .adml files for additional languages are required, you must copy the folder that contains the .adml files for that language to the Central Store. When you have copied all .admx and .adml files, the PolicyDefinitions folder on the domain controller should contain the .admx files and one or more folders that contain language-specific .adml files.

> [!NOTE]
> When you copy the .admx and .adml files from a Windows 8.1-based or Windows 10-based computer, verify that the most recent updates to these files are installed. Also, make sure that the most recent Administrative Templates files are replicated. This advice also applies to service packs, as applicable.

When the operating system collection is completed, merge any OS extension or application ADMX/ADML files into the new PolicyDefinitions folder.

When this is finished, rename the current PolicyDefinitions folder to reflect that it's the previous version, such as PolicyDefinitions-1709. Then, rename the new folder (such as PolicyDefinitions-1803) to the production name.

We suggest this approach as you can revert to the old folder in case you experience a severe problem with the new set of files. When you don't experience any problems with the new set of files, you can move the older PolicyDefinitions folder to an archive location outside sysvol folder.

## Group Policy administration

Windows 8.1 and Windows 10 do not include Administrative Templates that have an .adm extension. We recommend that you use computers that are running Windows 8.1 or later versions of Windows to perform Group Policy administration.

## Updating the Administrative Templates files

In Group Policy for Windows Vista and later version of Windows, if you change Administrative Templates policy settings on local computers, sysvol folder isn't automatically updated to include the new .admx or .adml files. This behavior is implemented to reduce network load and disk storage requirements, and to prevent conflicts between .admx and .adml files when changes are made to Administrative Templates policy settings across different locations.

To ensure that any local updates are reflected in sysvol folder, you must manually copy the updated .admx or .adml files from the PolicyDefinitions file on the local computer to the Sysvol\PolicyDefinitions folder on the appropriate domain controller.

The following update enables you to configure the Local Group Policy editor to use Local .admx files instead of the Central Store:

[An update is available to enable the use of Local ADMX files for Group Policy Editor](https://support.microsoft.com/help/2917033).

You can also use this setting to:

- Test a newly built folder as `C:\Windows\PolicyDefinitions` on an Administrative Workstation against your Domain Policies, before you copy it to the Central Store on sysvol folder.
- Use older PolicyDefinitions folder to edit policy settings that don't have an ADMX file in the latest build of your Central Store. One common example would be policies that have settings for older versions of Microsoft Office that are still in the Group Policies. Microsoft Office has a separate set of ADMX/L files for each release.

### Known Issues

- Issue 1

  After you copy the Windows 10 .admx templates to the sysvol folder Central Store and overwrite all existing .admx and .adml files, select the **Policies** node under **Computer Configuration** or **User Configuration**. In this situation, you may receive the following error message:

  > Namespace 'Microsoft.Policies.Sensors.WindowsLocationProvider' is already defined as the target namespace for another file in the store.  
  > File  
  > \\\\<forest.root>\SysVol\<forest.root>\Policies\PolicyDefinitions\Microsoft-Windows-Geolocation-WLPAdm.admx, line 5, column 110

  > [!NOTE]
  > In the path in this message, **<forest.root>** represents the domain name.

  To resolve this problem, see ["'Microsoft.Policies.Sensors.WindowsLocationProvider' is already defined" error when you edit a policy in Windows](https://support.microsoft.com/help/3077013).

- Issue 2

  Updated ADMX/L files for Windows 10 version 1803 contain only SearchOCR.ADML. It is not compatible with an older release of SearchOCR.ADMX that you still have in the Central Store. For more information about the problem, see ["Resource '$(string ID=Win7Only)' referenced in attribute displayName could not be found" error when you open gpedit.msc in Windows](https://support.microsoft.com/help/4292332).
  
  Both issues can be avoided by building a pristine PolicyDefinitions folder from a base OS release folder as described above.
