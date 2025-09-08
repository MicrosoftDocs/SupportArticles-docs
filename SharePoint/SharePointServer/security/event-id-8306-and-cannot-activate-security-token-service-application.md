---
title: Unable to Activate Security Token Service Application - Event ID 8306
description: Fixes some issues in SharePoint Foundation 2010. For example, users can't sign in to SharePoint sites that are using claims authentication.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Administration\Timer Service and jobs
  - CSSTroubleshoot
appliesto: 
  - SharePoint Foundation 2010
ms.date: 12/17/2023
---

# Event ID 8306 when you activate Security Token Service Application

## Symptoms

In SharePoint Foundation 2010, you may experience one or more of the following symptoms:  

- You see the message "The requested service, `http://localhost:32843/SecurityTokenServiceApplication/securitytoken.svc/actas` could not be activated" in the application event logs of the servers.
- Users can't sign in to SharePoint sites that are using claims authentication.
- SharePoint internal operations that rely on claims authentication don't function correctly.

## Cause  

This problem occurs if one or more of the following conditions are true:  

- The .NET trust level for the secure token service isn't set to "Full" in IIS.
- The application pool for the secure token service isn't started or is using invalid credentials.  

## Resolution  

To resolve this problem, try one of the following solutions:  

- From IIS Manager, select the SecureTokenServiceApplication. In the "Features View", double-click .NET Trust Levels. Ensure that the trust level is set to **Full**.
- From IIS Manager, ensure that the application pool for SecureTokenServiceApplication is running. By default, the name of the application pool is SecureTokenServiceApplicationPool.  

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
