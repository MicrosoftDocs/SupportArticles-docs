---
title: Cannot add CRM Application Pool account as a user
description: Fixes an issue that occurs in which Microsoft Dynamics CRM 2013 is inaccessible. Provides a resolution.
ms.reviewer: aaronric
ms.topic: troubleshooting
ms.date: 
---
# Cannot add the Microsoft Dynamics CRM Application Pool account as a user in Microsoft Dynamics CRM 2013

This article provides a resolution for the issue that you can't add the Microsoft Dynamics CRM Application Pool account as a user in Microsoft Dynamics CRM 2013.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2968553

## Symptoms

You receive one of the following errors:

> Server is busy  
The record was saved. However, the data could not be displayed because the server is busy. Click Try Again to try to display the data now, or click Cancel to continue to work. If you click Cancel, you can try opening the record later.

> Missing Microsoft Dynamics CRM security role  
Access to Microsoft Dynamics CRM has not yet been fully configured for this user. The user needs at least one security role before you can continue.

When you try to sign in to Microsoft Dynamics CRM, you will see the following error:

> An error has occurred  
Try this action again. If the problems continues, check the check the Microsoft Dynamics CRM Community for solutions or contact your organization's Microsoft Dynamics CRM Administrator. Finally, you can contact Microsoft Support.

## Cause

The action that adds the Microsoft Dynamics CRM Application Pool as a Microsoft Dynamics CRM user is unsupported.

## Resolution

To resolve this issue, you have to change the Microsoft Dynamics CRM application Pool account in IIS on all Microsoft Dynamics CRM servers to a non-CRM user. You have to verify the account meets the requirements in [Change a Microsoft Dynamics CRM service account or AppPool identity](/previous-versions/dynamicscrm-2013/implementation-guide/hh699751(v=crm.6)).
