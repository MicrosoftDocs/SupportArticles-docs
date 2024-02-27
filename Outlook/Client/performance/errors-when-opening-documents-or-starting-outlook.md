---
title: Errors when opening documents or starting Outlook
description: Describes an error message that you may receive when you try to open an Office document or to start Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Outlook 2007
  - Microsoft Office PowerPoint 2007
  - Microsoft Office Excel 2007
  - Microsoft Office Publisher 2007
  - Microsoft Office Access 2007
  - Microsoft Office PowerPoint 2003
  - Microsoft Office Publisher 2003
  - Microsoft Office Access 2003
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 01/30/2024
---
# An out-of-date antivirus program may cause errors when you try to open an Office document or to start Outlook

_Original KB number:_ &nbsp; 835404

## Summary

This article describes an error message that you receive in Microsoft Office that states that an antivirus program is preventing you from opening a file. You may receive this error message for the following reasons:

- There is a compatibility problem between your antivirus program and Office.
- The file that you are trying to open is infected with a virus that your antivirus program was unable to remove.
- The file that you are trying to open has been damaged.

To resolve the first two problems, you have to update your antivirus program. To resolve the third problem, you have to try to recover the file. This article will show you how to do this.

## Symptoms

When you try to open a Microsoft Office file, you may receive the following error message:

> Your Anti-Virus software has blocked the file you were trying to open.
>
> You should ensure your Anti-Virus software is fully up to date and try opening the file again. It is important to note that the blocked file may also contain a virus which your Anti-Virus software has not been able to remove. In this case you should treat the file with caution.

> [!NOTE]
> An antivirus program helps protect your computer from viruses. To avoid viruses, you should never download or open files from sources that you do not trust, visit Web sites that you do not trust, or open e-mail attachments when your antivirus program is disabled.

For more information about computer viruses, see [How to prevent and remove viruses and other malware](https://support.microsoft.com/help/129972/how-to-prevent-and-remove-viruses-and-other-malware).

## Cause

This problem occurs when your antivirus software and its signature files are out of date, when the file that you are trying to open is infected with a virus, or when the file has been damaged.

## Resolution

The resolution to this problem depends on whether your antivirus software and its signature file are out of date, whether your file is infected with a virus, or whether your file has been damaged.

### To check whether your antivirus software and its signature file are out of date

To keep up with new viruses that are created, antivirus program vendors periodically provide an updated virus signature file that you can download from the Internet.

If you are experiencing this problem on a computer on which you have recently installed a new version of antivirus software from a CD, we recommend that you connect to the Internet as soon as possible to download the latest updates that are available from your antivirus software vendor.

[List of antivirus software vendors](https://support.microsoft.com/help/49500)

You may have to purchase a new antivirus program.

For more information about how to use Office programs together with the Norton AntiVirus Office plug-in, see [How to use Office programs with the Norton AntiVirus Office plug-in](https://support.microsoft.com/help/329820).

For Microsoft security antivirus information, visit the following Microsoft Web site:

[https://www.microsoft.com/wdsi](https://www.microsoft.com/wdsi).

### To check whether your file is infected with a virus

If you are experiencing this problem on a computer that has the latest version of your antivirus software, that has up-to-date signature files, and on which you can open all files except this one, it is likely that the file is infected with a virus.

If your file is infected with a virus, you should delete the file from your system. As soon as the file is deleted, you can re-create the file or restore if from a back-up if you have one.

### If the file is damaged

If the file is damaged, the file cannot be handled correctly by either the antivirus software or by the affected Office program. Therefore, to be able to use the file again, you have to try to recover the file. For instructions about how to do this, please see the articles that are listed for the Office program that you were using when this problem occurred.

> [!NOTE]
> Not all programs have file recovery or file repair capabilities.

#### Microsoft Excel

For more information, see [Repair a corrupted workbook](https://support.microsoft.com/office/repair-a-corrupted-workbook-153a45f4-6cab-44b1-93ca-801ddcd4ea53).

#### Microsoft PowerPoint

For more information, see [How to troubleshoot a damaged presentation in PowerPoint](/office/troubleshoot/powerpoint/damaged-presentation).

#### Microsoft Word

For more information, see [How to troubleshoot damaged documents in Word](/office/troubleshoot/word/damaged-documents-in-word).
