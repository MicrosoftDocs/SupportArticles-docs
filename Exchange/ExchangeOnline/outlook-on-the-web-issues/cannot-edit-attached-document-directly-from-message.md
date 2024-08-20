---
title: Can't edit an Office document directly from an email message
description: Provides a workaround for an issue in which a Microsoft 365 user can't edit an Office document that's attached to an email message directly in Outlook Web App.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: laurieh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Microsoft 365 users can't edit an Office document directly from an email message in Outlook Web App

_Original KB number:_ &nbsp; 3003659

## Problem

A Microsoft 365 user cannot edit a Microsoft Office document that's attached to an email message directly in Outlook Web App. The **Edit a copy** option is missing when the user opens the attachment directly from the email message.

## Cause

This problem occurs if the user has an earlier version of Office installed. The document collaboration experience in Outlook Web App for Microsoft 365 supports the ability to view and edit attachments only for Microsoft Office 2010 and later versions.

## Workaround

To work around this problem if you have the 2007 Microsoft Office system or an earlier version of Office installed, follow these steps:

- Download the attachment.
- Edit the file locally.
- Reattach the file to the email message.

## More information

The document collaboration experience provides **View only** support for the following:

- Any 2007 Office system or Microsoft Office 2003 file
- The following Office file types:
  - Word: `.docm`, `.dotm`, `.dotx`, `.dot`, `.mht`, `.mhtml`, `.htm`, `.html`, `.odt`, `.rtf`, `.txt`, `.xml`, `.wps`, `.wpd`
  - Excel: `xlsm`, `xltx`, `.xltm`, `.xlam`, `.xlm`, `.xla`, `.xlt`, `.xml`, `.xll`, `.xlw`, `.ods`, `.prn`, `.txt`, `.csv`, `.mdb`, `.mde`, `.accdb`, `.accde`, `.dbc`, `.igy`, `.dqy`, `.rqy`, `.oqy`, `.cub`, `.uxdc`, `.dbf`, `.slk`, `.dif`, `.xlk`, `.bak`, `.xlb`
  - PowerPoint: `pptm`, `.potm`, `.ppam`, `.potx`, `.ppsm`, `.pot`, `.htm`, `.html`, `.mht`, `.mhtml`, `.txt`, `.rtf`, `.wpd`, `.wps`, `.ppa`, `.odp`, `.thmx`
- PDF files
- picture files

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
