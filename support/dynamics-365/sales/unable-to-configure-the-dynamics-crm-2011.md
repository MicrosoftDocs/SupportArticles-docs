---
title: Unable to configure the Microsoft Dynamics CRM 2011 Client for Outlook
description: This article provides a resolution for the problem that occurs when you try to configure the Dynamics CRM Client for Outlook against Dynamics CRM Online.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 
---
# Unable to Configure the Microsoft Dynamics CRM 2011 Client for Outlook against Dynamics CRM Online

This article helps you resolve the problem that occurs when you try to configure the Dynamics CRM Client for Outlook against Dynamics CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2498892

## Symptoms

When trying to configure the Microsoft Dynamics CRM Client for Microsoft Office Outlook against the Dynamics CRM Online environment, you get the following error:

Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your administrator for more help.

In the Crm50ClientConfig.log, you see errors like the following:

> Error connecting to URL: `https://dev.crm.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.ArgumentNullException: Value cannot be null.  
Parameter name: path1  
Error connecting to URL: `https://dev.crm4.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.ArgumentNullException: Value cannot be null.  
Parameter name: path1  
Error connecting to URL: `https://dev.crm5.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.ArgumentNullException: Value cannot be null.  
Parameter name: path1  
Exception : Value cannot be null.  
Exception : Authentication was canceled.

## Cause

- Cause 1: The issue could be due to having the Windows Live Essentials beta installed.
- Cause 2: The issue could be due to issues with Windows Live Essentials 2011.
- Cause 3: The issue could be due to the install of Windows Live Sign-in Assistant.

## Resolution

1. Option 1: Uninstall the Windows Live Essentials Beta or upgrade to Windows Live Essentials 2011.  
Then try to run the configuration wizard again.
1. Option 2: Run a repair on the Windows Live Essentials 2011.  
Then try to run the configuration wizard again.
1. Option 3: Run a repair on the Windows Live Sign-in Assistant.  
Then try to run the configuration wizard again.
