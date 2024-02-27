---
title: Cannot open Word Documents or Excel Spreadsheets
description: Describes an issue that occurs when you try to open a Microsoft Word document or an Excel spreadsheet from Outlook and receive an error message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans, gregmans, akeeler
appliesto: 
  - Outlook 2019
  - Excel 2019
  - Word 2019
  - PowerPoint 2019
  - Outlook 2016
  - Excel 2016
  - Word 2016
  - PowerPoint 2016
  - Outlook 2013
  - Microsoft Outlook 2013 Service Pack 1
  - Outlook for Microsoft 365
  - Word 2013
  - Word for Microsoft 365
  - Excel 2013
  - Excel for Microsoft 365
  - PowerPoint 2013
  - PowerPoint for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Cannot open Word documents or Excel spreadsheets from an external source in Outlook

_Original KB number:_ &nbsp; 3020607

## Symptoms

You receive one of the following errors when you try to open a Microsoft Word document or Microsoft Excel spreadsheet from an external source:

> Word experienced an error trying to open the file. Try the following suggestions:
>
> - Check the file permissions for the document or drive.
> - Make sure there is sufficient free memory and disk space.
> - Open the file with the Text Recovery converter.  
> (C:\Users\...\test.docx)

> Microsoft Excel cannot open or save any more documents because there is not enough available memory or disk space.
>
> - To make more memory available, close workbooks or programs you no longer need.
> - To free disk space, delete files you no longer need from the disk you are saving to.

> [!NOTE]
> This error can also occur in Microsoft PowerPoint.

## Cause

This issue occurs if all the following conditions are true:

- The Windows Firewall service is not running.
- You are using Outlook on a Windows 8-based, Windows 8.1-based, or Windows Server 2012-based computer.

## Resolution

To resolve this issue, start the Windows Firewall service. To do this, follow these steps:

1. Press the Windows logo key+R (to open the Run dialog box).
2. Type *services.msc*, and then select **OK**.
3. In the **Services** window, right-click **Windows Firewall**, and then select **Start**.

:::image type="content" source="media/cannot-open-word-documents-or-excel-spreadsheets/firewall-service.png" alt-text="Screenshot of the Windows Firewall service.":::

## More information

If you are unable to preview an Office file attachment in the Microsoft Outlook reading pane, see [Can't preview Office documents in Outlook if Windows Firewall Service is disabled](https://support.microsoft.com/help/2912722).
