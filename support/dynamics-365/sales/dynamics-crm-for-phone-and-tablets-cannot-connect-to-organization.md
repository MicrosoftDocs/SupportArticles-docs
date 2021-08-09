---
title: Dynamics CRM for Phone and Tablets cannot connect to organization
description: Microsoft Dynamics CRM for Phone and Tablets cannot connect to Dynamics CRM organization due to length of TokenLifetime. Provides a resolution.
ms.reviewer: joalva
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM for Phone and Tablets cannot connect to Dynamics CRM organization due to length of TokenLifetime

This article provides a resolution for the issue that Microsoft Dynamics CRM for Phone and Tablets can't connect to Dynamics CRM organization due to length of the `TokenLifetime` property.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2013 Service Pack 1  
_Original KB number:_ &nbsp; 3034570

## Symptoms

When trying to set up a Microsoft Dynamics CRM organization in any of the Microsoft Dynamics CRM mobile client applications, authentication enters a never-ending loop in which the application seems to be trying to perform some authenticate, but does not complete.

## Cause

Larger than default values for the `TokenLifetime` property in AD FS for the Relying Party can cause this authentication loop.

## Resolution

The recommended value of the `TokenLifetime` should be set to the default value of **0**, which means 600 minutes or 10 hours. Using the SSOLifetime option in the federation service instead can prevent the users from having to introduce their credentials too often in these Microsoft Dynamics CRM mobile applications. The default value of SSOLifetime is 480 minutes or 8 hours.

## More information

How to change the SSO `Lifetime` property of the ADFS, see [Set-ADFSProperties](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee892317(v=technet.10)).

How to change the `TokenLifetime` property of the ADFS Relying party through PowerShell, see [Claims-based authentication and security token expiration](/previous-versions/dynamicscrm-2013/crm.6/gg188586(v=crm.6)).
