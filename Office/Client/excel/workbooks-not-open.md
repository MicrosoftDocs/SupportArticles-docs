---
title: Workbooks may not open after MS16-088 is installed
description: Discusses an issue that prevents Excel workbooks from opening after users install security update MS16-088. This issue occurs because of a change that was made in Excel to enhance security.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: lauraho
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2016
  - Excel 2013
  - Excel 2010
ms.date: 03/31/2022
---

# Excel workbooks may not open after MS16-088 is installed

## Symptoms

The Microsoft Excel team has made a change in the behavior of certain file types to increase security. This change is included in the [July 2016 security updates (MS16-088)](https://support.microsoft.com/help/3170008). 

Previously, when you tried to open an HTML or XLA/XLAM file from an untrusted location, Excel opened the workbook without using Protected View security. After the security updates are installed, Excel no longer opens the workbook because these files are incompatible with Protected View. There is no warning or other indication that the file was not opened. 

## Resolution

To resolve this issue, install the latest update for your version of Microsoft Office.

### Microsoft 365 subscription (Click-to-Run)

Install the latest updates (this includes Current Channel, First Release Deferred Channel, and Deferred Channel).

For more information about how to obtain the latest Office updates, see the following TechNet topic:

[Overview of the update process for Microsoft 365 Apps for enterprise](https://technet.microsoft.com/library/dn761709.aspx)

### Windows Installer version (MSI)

See the following Microsoft Knowledge Base article for your version of Office to download the update from the Microsoft Download Center:

- Office 2016
[https://support.microsoft.com/kb/3115438 ](https://support.microsoft.com/help/3115438)   
- Office 2013
[https://support.microsoft.com/kb/3115455 ](https://support.microsoft.com/help/3115455)   
- Office 2010
[https://support.microsoft.com/kb/3115476 ](https://support.microsoft.com/help/3115476)   

> [!NOTE]
> These updates will also be published to Windows Update and Windows Server Update Services (WSUS) in mid-August. These services provide files that are updated automatically, based on the Windows Update settings for the computer.

## More Information

### Protected View

After you install the latest Office update, Excel will open workbooks in Protected View to provide an additional layer of security. If you trust the source of the workbook, you can then enable editing. The behavior of .xla and .xlam files will remain the same.

### Other methods

To open files directly without using Protected View, use one of the following methods.

#### Unblock access for individual files

To unblock access for individual files that you know are safe, follow these steps:

1. Right-click the file, and then select **Properties**.
1. On the **General** tab, select **Unblock**.
1. Click **OK**.

#### Trusted Locations

To use the existing Trusted Locations capabilities of Excel 2016, Excel 2013, and Excel 2010, follow these steps:


1. Access the Trusted Locations feature. To do this, select **File** > **Options** > **Trust Center** > **Trust Center Settings** > **Trusted Locations**.   
2. Save the HTML file to a trusted location on the local computer. (Excel provides a set of default trust locations.) If there is no trusted local folder location listed, select **Add new location**, and add the location in the **Trusted Location** dialog box.   

The following guidelines apply to the Trusted Locations feature:

- If the HTML document is in a trusted location, the Knowledge Base fix is not applied (that is, the unsafe HTML file is not blocked).   
- To help prevent Internet Explorer from tagging files as untrusted, add the source website from which you download the files as a trusted sites in the browser. To do this, select **Tools** > **Internet Options** > **Security** > **Trusted sites**.   
- Using Trusted Locations can unblock you. However, it also creates some risks. This is because files of any file type that are listed in Trusted Locations are fully trusted. An attacker who can add files to the trusted location can easily exploit users who open such documents. Therefore, you should be especially cautious when you specify a custom folder as a trusted location.   

> [!NOTE]
> In case your HTML contains one or more input tags you may see `File is corrupt` error. We are working on getting a full resolution in future updates. 

### Additional information

Click the following links for version-specific information about the Trusted Locations feature and Protected View settings.

**Office 2016**

Office Trusted Locations:
[https://technet.microsoft.com/library/cc179039(v=office.16).aspx](https://technet.microsoft.com/library/cc179039%28v=office.16%29.aspx)

Protected View settings:
[https://technet.microsoft.com/library/ee857087(v=office.16).aspx](https://technet.microsoft.com/library/ee857087%28v=office.16%29.aspx)

**Office 2013**

Office Trusted Locations:
[https://technet.microsoft.com/library/cc179039(v=office.15).aspx](https://technet.microsoft.com/library/cc179039%28v=office.15%29.aspx)

Protected View settings:
[https://technet.microsoft.com/library/ee857087(v=office.15).aspx](https://technet.microsoft.com/library/ee857087%28v=office.15%29.aspx)

**Office 2010**

Office Trusted Locations:
[https://technet.microsoft.com/library/cc179039(v=office.14).aspx](https://technet.microsoft.com/library/cc179039(v=office.14).aspx)

Protected View settings:
[https://technet.microsoft.com/library/ee857087(v=office.14).aspx](https://technet.microsoft.com/library/ee857087(v=office.14).aspx)
