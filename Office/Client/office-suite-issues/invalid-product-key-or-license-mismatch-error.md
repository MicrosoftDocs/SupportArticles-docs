---
title: Invalid product key or license mismatch error when you activate Office 2013
description: Describes an Office 2013 activation issue in which you receive an Invalid product key or license mismatch error message.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - SubscriptionAndLicensing\Product Keys related issues
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office Standard 2013
  - Office Professional Plus 2013
  - Windows Server 2012 Datacenter
  - Windows Server 2012 Datacenter
ms.date: 06/06/2024
---

# "Invalid product key or license mismatch" error message when you try to activate Office 2013

## Symptoms

Assume that you try to activate Microsoft Office 2013 by using the Volume Activation Tools wizard on a Windows Server 2012-based computer. Additionally, assume that you use Active Directory-based or Key Management Service-based activation. In this situation, you receive the following error message: 

> Invalid product key or license mismatch. Please confirm this product key is entered correctly and is valid for this application or Windows edition.

## Cause

This issue occurs because you add the Volume Activation Tools role to Windows Server 2012, but you do not install Office 2013 Volume License Pack.

## Resolution

To resolve this issue, install Office 2013 Volume License Pack. To download Office 2013 Volume License Pack, go to the following Microsoft Download Center website: 

[Download Microsoft Office 2013 Volume License Pack now](https://www.microsoft.com/download/details.aspx?id=35584)

This installation starts the Volume Activation Tools wizard and enables you to select the activation type, enter the Office 2013 KMS host key, and activate Office 2013.

## More Information

Windows Server 2012 does not have the files that are required to activate an Office 2013 KMS host key. Microsoft Office Volume License Pack includes these files and enables you to successfully activate a KMS host key.
