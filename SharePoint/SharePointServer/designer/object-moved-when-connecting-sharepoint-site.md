---
title: Object moved when connecting to a SharePoint site
description: Resolves a problem in which you can't use SharePoint Designer 2013 to connect to a SharePoint site. When this issue occurs, you receive a The server could not complete your request error message, followed by an Object moved error message.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\SharePoint Designer
  - CSSTroubleshoot
ms.reviewer: shcui, SPspms
appliesto: 
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Object moved error when you connect to a SharePoint site by using SharePoint Designer 2013

_Original KB number:_ &nbsp; 2758431

## Symptoms

When you try to use Microsoft SharePoint Designer 2013 to connect to a SharePoint site, you receive the following error message:

> The server could not complete your request. For more specific information, click the "Details" button.

After you click the **Details** button, you receive the following error message:

> Object moved
>
> Object moved to here

## Cause

This issue occurs because anonymous authentication for the SharePoint web application that hosts the SharePoint site is disabled in Internet Information Services (IIS).

The Windows Communication Foundation (WCF) runtime requires that the security settings of the WCF service match the IIS settings. When anonymous authentication is disabled in IIS, WCF cannot use anonymous binding. Therefore, the WCF runtime throws an exception if there is anonymous binding in WCF.

Web applications use a claims-based authentication method. Therefore, the identity of web application threads is forms-based instead of Windows-based. When a Windows-based user identity is not used and WCF binding is not anonymous, the WCF runtime throws an "Access denied" error. Additionally, a 302 error code is returned to the logon page.

## Resolution

To resolve this problem, enable anonymous authentication for the SharePoint web application in IIS.
