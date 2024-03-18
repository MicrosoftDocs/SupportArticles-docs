---
title: Web sites lose SSL certificate bindings
description: Web sites lose SSL certificate bindings when the certificate doesn't have a unique Friendly name field on servers that are running Office Online Server.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: mgraham
appliesto: 
  - Office Web Apps Server 2013
ms.date: 03/31/2022
---

# Web sites lose SSL certificate bindings on Office Online Server

## Symptoms

Consider the following scenario: 

- You bind web sites in Internet Information Services (IIS) by using an SSL certificate.    
- Office Online Server is running on the server.    
 
In this scenario, when the server is restarted, the certificate become unbound from the web sites. This issue also sometimes occurs randomly. You can see this issue by viewing the bindings in IIS Manager. 

## Cause

This issue occurs because the certificate doesn't have a unique **Friendly name** field. This field is required by the Microsoft Office Online. Therefore, Microsoft Offices Online manager removes the bindings. 

The Friendly name field must be unique within the Trusted Root Certificate Authorities store. If you have multiple certificates that share a Friendly Name field, the farm creation process fails because the **New-OfficeWebAppsFarm** cmdlet can't know which certificates to use. 

## Resolution

To fix this issue, make sure that the certificate has a unique **Friendly name** field. 

## References

[Plan Office Online Server](/officeonlineserver/plan-office-online-server)