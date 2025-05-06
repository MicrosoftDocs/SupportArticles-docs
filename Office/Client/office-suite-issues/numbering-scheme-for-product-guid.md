---
title: Numbering scheme for product code GUIDs
description: Describes the numbering scheme for product code GUIDs in Office 2016.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\AdvancedConfiguration\OfficeDeploymentTool
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office 2016
ms.date: 06/06/2024
---

# Description of the numbering scheme for product code GUIDs in Office 2016

For a description of the numbering scheme for product code GUIDs in Office 2013, see [Description of the numbering scheme for product code GUIDs in Office 2013](https://support.microsoft.com/help/2786054).

## Summary

This article describes how to read the product GUIDs in the Windows registry to determine information about the Microsoft Office 2016 suite, programs, or utilities that you're using. GUIDs contain information about the release type, the release build, and the language of an Office 2016 suite or program.

> [!NOTE]
> GUIDs are created only when a user installs a Windows Installer (MSI) version of the Office 2016 suite or of an Office 2016 program. GUIDs are not created when a user installs a Click-to-Run version of the Office 2016 suite or of an Office 2016 program.

## More Information

When you install the Office 2016 suite or one of the stand-alone Office 2016 programs, one or more product code GUIDs are created in the following registry subkey:

`HKEY_LOCAL_MACHINE \Software\Microsoft\Windows\CurrentVersion\Uninstall`

If you install a 32-bit version of Office 2016 on a 64-bit version of Windows, the GUIDs are created in the following registry subkey:

`HKEY_LOCAL_MACHINE \Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall`

Each GUID uses the following format:

{BRMMmmmm-PPPP-LLLL-p000-D000000FF1CE}

The following table describes the characters of the GUID.

|Characters| Definition| Hexadecimal values |
|---|---|---|
|B|Release build|0-9, A-F |
|R|Release type|0-9, A-F |
|MM|Major version|0-9 |
|mmmm|Minor version|0-9 |
|PPPP|Product ID|0-9, A-F |
|LLLL|Language identifier|0-9, A-F |
|p|0 for x86, 1 for x64|0-1 |
|000|Reserved for future use, currently 0|0 |
|D|1 for debug, 0 for ship|0-1 |
|000000FF1CE|Office Family ID|0-9 |

To view the GUIDs for the Office 2016 suites and programs that are installed on a computer, follow these steps:

1. Select **Start**, select **Run**, type regedit, and then select **OK**.
2. Locate the following registry subkey:

   `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`

The names of the GUIDs start with a brace (\{). Therefore, GUIDs are the first items that are listed under Uninstall.

|Value name| Description |
|---|---|
|DisplayName|The product name that appears in the Add or Remove Programs dialog box |
|InstallDate|The date on which the product was installed |
|Product ID|The product ID |
|InstallSource|The installation source |
|RegCompany|The registered company |
|RegOwner|The registered user name |

### Release build

The release build values specify the level of the release, such as a beta build or a release-to-manufacturing (RTM) build. The following table contains more information about the release build values.

|Value name| Release |
|--|---|
|0|Any release before Beta 1 |
|1|Beta 1 |
|2|Beta 2 |
|3|Release Candidate 0 (RC0) |
|4|Release Candidate 1 (RC1)/OEM Preview release |
|5-8|Reserved values |
|9|RTM. This value is the first build that's shipped (the initial release). |
|A|Service Pack 1 (SP1). This value isn't used if the product code isn't changed after the RTM build. |
|B|Service Pack 2 (SP2). This value isn't used if the product code isn't changed after the RTM build. |
|C|Service Pack 3 (SP3). This value isn't used if the product code isn't changed after the RTM build. |
|D-F|Reserved values |

### Release type

The release type specifies the audience for a 2016 Office suite, such as enterprise or retail. The following table contains more information about the 2016 Office suite release types.  

|Value| Release type |
|---|---|
|0|Volume license |
|1|Retail/OEM |
|2|Trial |
|5|Download |

### Product ID

The product ID is the version of the Office 2016 suite or program, such as Office Professional 2016 or Office Standard 2016. The following table contains more information about the Office 2016 product IDs.

|Product ID| SKU |
|---|---|
|0011|Microsoft Office Professional Plus 2016 |
|0012|Microsoft Office Standard 2016 |
|0015|Microsoft Access 2016 |
|0016|Microsoft Excel 2016 |
|0018|Microsoft PowerPoint 2016 |
|0019|Microsoft Publisher 2016 |
|001A|Microsoft Outlook 2016 |
|001B|Microsoft Word 2016 |
|001F|Microsoft Office Proofing Tools Kit Compilation 2016 |
|003A|Microsoft Project Standard 2016 |
|003B|Microsoft Project Professional 2016 |
|0051|Microsoft Visio Professional 2016 |
|0053|Microsoft Visio Standard 2016 |
|00A1|Microsoft OneNote 2016 |
|00BA|Microsoft Office OneDrive for Business 2016 |
|110D|Microsoft Office SharePoint Server 2016 |
|012B|Microsoft Skype for Business 2016 |

### Language identifier

The language identifier (LCID) varies from language to language. Because the LCID is stored in the GUID in a hexadecimal format, you need to convert the LCID value to a decimal value to determine the language. For example, a hexadecimal value of 0409 converts to a decimal value of 1033. This value represents English.

For more information about language identifiers in Office 2016 suites and programs, see [Language identifiers and Option State ID values in Office 2016](https://technet.microsoft.com/library/cc179219.aspx).

### Sample GUID

Assume that the first 16 digits of a GUID are "90160000-0011-0407." This example GUID was created by the initial release build (9) of a Retail or OEM edition (1), build 16.0000, of Microsoft Office Professional Plus 2016 (0011). The language of the product is German. In this case, the hexadecimal value 0407 converts to the decimal value 1031. This value represents German.
