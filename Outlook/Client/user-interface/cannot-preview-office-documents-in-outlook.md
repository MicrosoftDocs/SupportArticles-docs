---
title: Cannot preview Office documents in Outlook
description: Fixes an issue in which you can't preview an Office file attachment in the Outlook reading pane. This issue occurs in Outlook 2013 if the Windows Firewall service is disabled.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Email attachments not visible
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: vivekst, akeeler
appliesto: 
  - Outlook 2019
  - Word 2019
  - Word 2019
  - Excel 2019
  - PowerPoint 2019
  - Outlook 2016
  - Excel 2016
  - Word 2016
  - PowerPoint 2016
  - Outlook 2013
  - PowerPoint 2013
  - Excel 2013
  - Word 2013
  - Outlook for Microsoft 365
  - Word for Microsoft 365
  - Excel for Microsoft 365
  - PowerPoint for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Can't preview Office documents in Outlook if Windows Firewall Service is disabled

_Original KB number:_ &nbsp; 2912722

## Symptoms

When you try to preview an Office file attachment in the Microsoft Outlook reading pane, you receive the following error message:

> This file cannot be previewed because of an error with the following previewer

:::image type="content" source="media/cannot-preview-office-documents-in-outlook/error.png" alt-text="Screenshot of Excel previewer error message.":::

## Cause

This problem occurs if both of the following conditions are true.

- Windows Firewall service is not running.
- You're using Outlook on a Windows 10, Windows 8.1, Windows 8, or Windows Server 2012-based computer.

## Resolution

To resolve this issue, start the Windows Firewall service:

1. Press the Windows key+R (to open the **Run** dialog box).
2. Type *services.msc*, and then select **OK**.
3. In the **Services** window, right-click **Windows Firewall**, and then select **Properties**.
4. Make sure that the **Startup type** is set to **Automatic**, and then select **OK**.
5. Right-click Windows Firewall, and then select **Start**.

## More information

The Previewer feature in Outlook uses the Protected View feature (also known as a *sandbox*). This feature was introduced in Microsoft Office 2010. In Windows 10, Windows 8.1, Windows 8, and Windows Server 2012, the Protected View feature has been improved in conjunction with the AppContainer feature. This provides stronger process isolation, and it also blocks network access from the sandbox.

For more information about the Protected View feature, see [Overview of security in Office 2013](/previous-versions/office/office-2013-resource-kit/cc179050(v=office.15)).
