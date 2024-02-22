---
title: Error when importing or exporting files
description: Describes an issue that occurs if certain translator files or certain database converters are not available because they were not installed during Setup. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: skipb
appliesto: 
  - Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# Microsoft Outlook cannot start the required translator error when you import or export files in Outlook

_Original KB number:_ &nbsp; 829985

## Symptoms

When you try to import or to export files in Microsoft Office Outlook 2003, you receive the following message:

> Microsoft Office Outlook cannot start the required translator. This feature is not currently installed. Would you like to install it now?

Additionally, when you insert the Outlook 2003 CD-ROM or the Office 2003 CD-ROM, you may receive the following error message:

> Error 1311. Source file not found C:/MSOCACHE/All Users

When you try to import or to export files in the 2007 Microsoft Office system, you may receive one of the following error messages:

> Error 1334. The file '\<filename>.SAM_1033' cannot be installed because the file cannot be found in cabinet file 'OutlkLR.CAB'. This could indicate a network error, an error reading from the CD-ROM, or a problem with this package.

> The file 'C:\MSOCache\All Users\\{\<GUID>}\' is not a valid installation package for the product \<Microsoft Office product name> (\<language>) 2007. Try to find the installation package 'OutlookMUI.msi' in a folder from which you can install \<Microsoft Office product name> MUI (\<language>) 2007.

> Error 1706. Setup cannot find the required files. Check your connection to the network, or CD-ROM drive. For other potential solutions to this problem, see C:\DOCUME~1\<username>\LOCALS~1\Temp\Setup0000043c\SETUP.CHM.

## Cause

This issue occurs if certain translator files or certain database converters are not available because they were not installed during Setup. Converters in Outlook are installed on demand. Additionally, the local install source folder (Msocache) may be damaged or missing.

This issue also applies to third-party personal information management (PIM) files and to file types that use Open Database Connectivity (ODBC).

## Resolution for Outlook 2003

Select **Yes** when you receive the message that is mentioned in the Symptoms section of this article. After you select **Yes**, Microsoft Windows Installer starts and then installs the database converters and translator files for the file that you want to import or to export.

If this resolution does not resolve the issue, run the Microsoft Office Setup program and install the filters directly. To do this, follow these steps:

1. Exit Outlook 2003.
2. Remove the Msocache folder.
3. Select **Start**, and then select **Control Panel**.
4. Select **Add or Remove Programs**.
5. In the **Currently installed programs** list, select **Microsoft Office 2003**, and then select **Change**.
6. In the **Microsoft Office 2003 Setup** dialog box, select **Add or Remove Features** under the **Maintenance Mode Options** area, and then select **Next**.
7. Under the **Custom Setup** area, select the **Choose advanced customization of applications** check box, and then select **Next**.
8. Under the **Choose update options for applications and tools** area, expand **Microsoft Office Outlook**.
9. Select the down arrow next to **Importers and Exporters**, and then select either the **Run from My Computer** option or the **Run all from My Computer** option.
10. In the **Microsoft Office 2003 Setup** dialog box, select **Update**.

## Resolution for Microsoft Office Outlook 2007 and Outlook 2010

Insert the CD or DVD media when you are prompted. If you installed Outlook from a network share, make sure that the share is accessible from your workstation.

After you provide the setup files, the setup process will complete successfully. Additionally, any missing or corrupted files in the \MSOCache folder will be replaced.

If the same error occurs in the future, delete the \MSOCache folder, and then run the Outlook setup process again. When you run Setup again, make sure that you select the **Repair** option in the **Change your installation** window.

## PIM formats

The following PIM program data files can be imported to Outlook 2007 and Outlook 2010:

- Microsoft Excel
- Microsoft Access
- Comma Separated Values (CSV) Windows
- Comma Separated Values (CSV) DOS
- Tab Separated Values (TSV) Windows
- Tab Separated Values (TSV) DOS
- ACT! 3.x, ACT! 4.0, and ACT! 2000
- Organizer 4.x and Organizer 5.x
- Personal Address Book

The following PIM program data files can be imported to Outlook 2003:

- Microsoft Excel
- Microsoft Access
- Comma Separated Values (CSV) Windows
- Comma Separated Values (CSV) DOS
- Tab Separated Values (TSV) Windows
- Tab Separated Values (TSV) DOS
- Schedule + 7.x and Schedule + SC2 ACT! 3.x,
- ACT! 3.x, ACT! 4.0, and ACT! 2000
- Organizer 4.x and Organizer 5.x
- Personal Address Book

The following PIM formats can be exported from Outlook 2003, Outlook 2007, and Outlook 2010:

- Microsoft Excel
- Microsoft Access
- Comma Separated Values (CSV) Windows
- Comma Separated Values (CSV) DOS
- Tab Separated Values (TSV) Windows
- Tab Separated Values (TSV) DOS

## Mail client - Import mail account settings

You can import your mail account settings from the following programs:

- Microsoft Outlook Express 4.x, Microsoft Outlook Express 5.x, and Microsoft Outlook Express 6.x
- Eudora Pro and Light 2.x, Eudora Pro and Light 3.x, Eudora Pro and Light 4.x, and Eudora Pro and Light 5.x
- Microsoft Outlook 97, Microsoft Outlook 98, Microsoft Outlook 2000, and Microsoft Outlook 2002

> [!NOTE]
> Outlook mail accounts import automatically when you first start the program.

## Mail client - Import mail and addresses

You can import your e-mail mail messages and your addresses from the following programs:

- Outlook Express 4.x, Outlook Express 5.x, and Outlook Express 6.x
- Eudora Pro and Light 2.x, Eudora Pro and Light 3.x, Eudora Pro and Light 4.x, and Eudora Pro and Light 5.x
- Outlook 97, Outlook 98, Outlook 2000, and Outlook 2002

> [!NOTE]
> Outlook e-mail messages and addresses are imported automatically when you first start the program.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
