---
title: Unable to Activate Security Token Service Application - Event ID 8306
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Foundation 2010
---

# Event ID 8306 when you activate Security Token Service Application

## Symptoms  

In SharePoint Foundation 2010, you may experience one or more of the following symptoms:  

- You will see the message "The requested service, `http://localhost:32843/SecurityTokenServiceApplication/securitytoken.svc/actas` could not be activated" in the application event logs of the servers.   
- Users will not be able to log in to SharePoint sites that are using claims authentication.   
- SharePoint internal operations that rely on claims authentication will not function correctly.     

## Cause  

This problem can be caused if one or more of the following conditions are true:  

- The .NET trust level for the secure token service is not set to "Full" in IIS.   
- The application pool for the secure token service is not started or is using invalid credentials.  

## Resolution  

​In order to resolve this problem, you can try one of the following possible solutions:  

- From IIS Manager, click on the SecureTokenServiceApplication. In the "Features View", double click on .NET Trust Levels. Ensure that the trust level is set to "Full"   
- From IIS Manager, ensure that the application pool for SecureTokenServiceApplication is running. By default, the name of the application pool is SecureTokenServiceApplicationPool.  

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
