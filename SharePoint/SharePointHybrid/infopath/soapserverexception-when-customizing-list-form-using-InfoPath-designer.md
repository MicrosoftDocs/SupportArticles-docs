---
title: SoapServerException error when customizing list form (SPO and SP-onprem) using InfoPath designer
description: Describes how to add a button to a Word document and assign its Click event at run-time
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Lists and Libraries\List Designs
  - CSSTroubleshoot
appliesto: 
  - Microsoft InfoPath 2013
ms.date: 12/17/2023
---

# SoapServerException error when customizing list form (SPO and SP-onprem) using InfoPath designer

## Symptoms

When you click on the "customize InfoPath" option in a Sharepoint list, you receive the following error:

> SOAP response indicates that an error occurred on the server: Exception of type &#8216;Microsoft.SharePoint.SoapServer.SoapServerException&#8216; was thrown. [detail][errorstring xmlns=&#8220;https://schemas.microsoft.com/sharepoint/soap/&#8221;] List does not exist. The page you selected contains a list that does not exist. It may have been deleted by another user. [/errorstring][errorcode xmlns=&#8220;https://schemas.microsoft.com/sharepoint/soap/&#8221;]0x82000006[/errorcode][/detail]

## Cause

This is a known issue on Windows 10 related to the update listed in KB [4489886](https://support.microsoft.com/en-us/help/4489886/windows-10-update-kb4489886), and is documented under the section "Known issues in this update".

## Workarounds

### Workaround 1

1. Go to **List setting**.
2. Select **Form setting**.
3. Select **Customize** in InfoPath.

### Workaround 2

You can open InfoPath, choose "Customize SharePoint List" from the startup options, and provide the URL of their list to open it in InfoPath directly.

## More information

Microsoft is researching this problem and will post more information when it becomes available. We recommend this workaround as a temporary resolution.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
