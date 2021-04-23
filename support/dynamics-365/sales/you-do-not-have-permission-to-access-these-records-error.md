---
title: You do not have permission to access these records error when selecting Track
description: When you select Track in Microsoft Dynamics CRM within Microsoft Dynamics CRM for Outlook, you receive the You do not have permission to access these records error. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# You do not have permission to access these records error when you select Track in Microsoft Dynamics CRM

This article provides a resolution for the **You do not have permission to access these records** error that occurs when selecting **Track** in Microsoft Dynamics CRM within Microsoft Dynamics CRM for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3140750

## Symptoms

When you select **Track** in Microsoft Dynamics CRM within Microsoft Dynamics CRM for Outlook, it fails with the following error:

> You do not have permission to access these records. Contact your Microsoft Dynamics CRM administrator.

## Cause

Your user record in Microsoft Dynamics CRM is missing read access for the Record Creation and Update Rule entity. Microsoft is aware of this issue and plans to provide a fix so this privilege is not required to track emails. In the meantime, you can use the workaround provided in the Resolution section.

## Resolution

Sign in to Microsoft Dynamics CRM as a user with the System Administrator role. Locate the security role assigned to the user. On the **Service Management** tab of the security role, grant Read access for the Record Creation and Update Rule entity.

## More information

If you capture client side CRM tracing, the following information is logged:

> Principal user (Id={GUID}, type=8) is missing prvReadConvertRule privilege (Id=\<GUID>)
2015-08-21T15:27:32.0596285Z
