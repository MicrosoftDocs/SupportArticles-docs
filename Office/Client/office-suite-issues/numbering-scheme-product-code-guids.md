---
title: Description of the numbering scheme for product code GUIDs in Office 2013
description: Describes how to read the product GUIDs in the Windows registry to determine information about the Office 2013 suite, programs, or utilities that you are using.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: doakm
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office Standard 2013
  - Office Professional 2013
  - Office Professional Plus 2013
  - Office Home and Business 2013Office Home and Student 2013
  - Access 2013
  - Excel 2013
  - Word 2013
  - InfoPath 2013
  - OneNote 2013
  - Outlook 2013
  - PowerPoint 2013
  - Project Professional 2013
  - Visio Standard 2013
  - Visio Professional 2013
  - Publisher 2013
  - SharePoint Designer 2013
  - Project 2013 Standard
  - Project Server 2013
  - SharePoint Server 2013
ms.date: 03/31/2022
---

# Description of the numbering scheme for product code GUIDs in Office 2013

## Summary

This article describes how to read the product GUIDs in the Windows registry to determine information about the Microsoft Office 2013 suite, programs, or utilities that you are using. GUIDs contain information about the release type, the release version, and the language of an Office 2013 suite or program. 

**Note** GUIDs are created only when a user installs a Windows Installer (MSI) version of the Office 2013 suite or of an Office 2013 program. GUIDs are not created when a user installs a Click-to-Run version of the Office 2013 suite or of an Office 2013 program.

## More Information

When you install the Office 2013 suite or one of the stand-alone Office 2013 programs, one or more product codes, or GUIDs, are created in the following registry subkey:

**`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`**

If you install a 32-bit version of Office 2013 on a 64-bit version of Windows, the GUIDs are created in the following registry subkey:

**`HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall`**

Each GUID uses the following format: 

{BRMMmmmm-PPPP-LLLL-p000-D000000FF1CE}

The following table describes the characters of the GUID. 

|Characters|Definition|Hexadecimal values|
|--|--|--|
|B|Release version|0-9, A-F|
|R|Release type|0-9, A-F|
|MM|Major version|0-9|
|mmmm|Minor version|0-9|
|PPPP|Product ID|0-9, A-F|
|LLLL|Language identifier|0-9, A-F|
|p|0 for x86, 1 for x64|0-1|
|000|Reserved for future use, currently 0|0|
|D|1 for debug, 0 for ship|0-1|
|000000FF1CE|Office Family ID|0-9|

To view the GUIDs for the Office 2013 suites and programs that are installed on a computer, follow these steps: 

1. Click **Start** > **Run**, type `regedit`, and then click **OK**.
2. Locate the following subkey:

   **`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`**

   The names of the GUIDs start with a brace ({ ). Therefore, GUIDs are the first items that are listed under **Uninstall**.

Each GUID data pane contains multiple values, including the values that are described in the following table.

|Value name|Description|
|--|--|
|DisplayName|The product name that appears in the **Add or Remove Programs** dialog box|
|InstallDate|The date that the product was installed|
|Product ID|The product ID|
|InstallSource|The installation source|
|RegCompany|The registered company|
|RegOwner|The registered user name|

### Release version

The release version values specify the level of the release, such as a beta version or a release to manufacturing (RTM) version. The following table contains more information about the release version values. 

  |Value name|Release|
  |--|--|
  |0|Any release before Beta 1|
  |1|Beta 1|
  |2|Beta 2|
  |3|Release Candidate 0 (RC0)|
  |4|Release Candidate 1 (RC1)/OEM Preview release|
  |5-8|Reserved values|
  |9|RTM. This is the first version that is shipped (the initial release).|
  |A|Service Pack 1 (SP1). This value is not used if the product code is not changed after the RTM version|
  |B|Service Pack 2 (SP2). This value is not used if the product code is not changed after the RTM version|
  |C|Service Pack 3 (SP3). This value is not used if the product code is not changed after the RTM version|
  |D-F|Reserved values|

### Release type

The release type specifies the audience for a 2013 Office suite, such as enterprise or retail. The following table contains more information about the 2013 Office suite release types. 

|Value|Release type|
|--|--|
|0|Volume license|
|1|Retail/OEM|
|2|Trial|
|5|Download|

### Product ID

The product ID is the version of the Office 2013 suite or program, such as Office Professional 2013 or Office Standard 2013. The following table contains more information about the Office 2013 product IDs.

Product ID|SKU|
|--|--|
|0011|Microsoft Office Professional Plus 2013|
|0012|Microsoft Office Standard 2013|
|0013|Microsoft Office Home and Business 2013|
|0014|Microsoft Office Professional 2013|
|0015|Microsoft Access 2013|
|0016|Microsoft Excel 2013|
|0017|Microsoft SharePoint Designer 2013|
|0018|Microsoft PowerPoint 2013|
|0019|Microsoft Publisher 2013|
|001A|Microsoft Outlook 2013|
|001B|Microsoft Word 2013|
|001C|Microsoft Access Runtime 2013|
|001F|Microsoft Office Proofing Tools Kit Compilation 2013|
|002F|Microsoft Office Home and Student 2013|
|003A|Microsoft Project Standard 2013|
|003B|Microsoft Project Professional 2013|
|0044|Microsoft InfoPath 2013|
|0051|Microsoft Visio Professional 2013|
|0053|Microsoft Visio Standard 2013|
|00A1|Microsoft OneNote 2013|
|00BA|Microsoft Office SharePoint Workspace 2013|
|110D|Microsoft Office SharePoint Server 2013|
|110F|Microsoft Project Server 2013|
|012B|Microsoft Lync 2013|

### Language identifier

The language identifier (LCID) varies from language to language. Because the LCID is stored in the GUID in a hexadecimal format, you may have to convert the LCID value to a decimal value to determine the language. For example, a hexadecimal value of 0409 converts to a decimal value of 1033. This value represents English. 

For more information about language identifiers in Office 2013 suites and programs, go to the following Microsoft website: [Language identifiers and OptionState Id values in Office 2013](https://technet.microsoft.com/library/cc179219.aspx )

### Sample GUID

Assume that the first 16 digits of a GUID are "91150000-0011-0407." This example GUID was created by the initial release version (9) of a Retail or OEM edition (1), version 15.0000, of Microsoft Office Professional Plus 2013 (0011). The language of the product is German. In this case, the hexadecimal value 0407 converts to the decimal value 1031. This value represents German.