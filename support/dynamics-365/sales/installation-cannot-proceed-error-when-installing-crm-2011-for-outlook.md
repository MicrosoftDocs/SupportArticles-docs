---
title: Installation cannot proceed error during installation
description: Either a minimum supported version of Microsoft Outlook is not installed, or 64-bit Microsoft Office is installed. This error may occur when you try to install the Microsoft Dynamics CRM 2011 for Microsoft Office Outlook client. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Installation cannot proceed error when installing Microsoft Dynamics CRM 2011 for Microsoft Office Outlook client

This article provides a resolution for the issue that you may receive an **Installation cannot proceed** error that occurs when you install the Microsoft Dynamics CRM 2011 for Microsoft Office Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2511706

## Symptoms

When you try to install the Microsoft Dynamics CRM 2011 for Microsoft Office Outlook client, you receive the following error message even though the correct version of Microsoft Office is installed and it is not 64 bit:

> Installation cannot proceed: either a minimum supported version of Microsoft Outlook is not installed, or 64 bit Microsoft Office is installed

## Cause

This issue can occur if Microsoft Office was installed using the Click-to-Run option available from the Internet. The Click-to-Run version of Office is not supported by Microsoft Dynamics CRM 2011. Click-to-Run installs a version of Office using virtualization technology. More information on Click-to-Run can be found in the following article:

[Office 2010 Click-to-Run compatibility with add-ins](/office365/troubleshoot/administration/click-to-run-compatibility-with-add-in)

## Resolution

Use the steps from the following article to use an MSI-based installation of Microsoft Office:

[Office 2010 Click-to-Run: Switch to using an MSI-based Office edition](https://support.microsoft.com/office/office-2010-click-to-run-switch-to-using-an-msi-based-office-edition-458fd7e5-f306-4d8c-a56f-0ce3a4e35e96)

## More information

Microsoft Dynamics CRM for Microsoft Office Outlook Client is supported on the following versions of Office:

- Microsoft Office 2010 (32-bit or 64-bit versions)
- Microsoft Office 2007 (32-bit versions)
- Microsoft Office 2003 SP3 (32-bit versions)

How to determine which version of Office Outlook is installed using Office 2010:

1. In Outlook, select **File**.
2. Then select **Help**.
3. Then select the **About Microsoft Outlook** section on the right-hand pane. You will find which version of Outlook is installed.

Also reference the Outlook article [Office 2010 Click-to-Run compatibility with add-ins](/office365/troubleshoot/administration/click-to-run-compatibility-with-add-in).
