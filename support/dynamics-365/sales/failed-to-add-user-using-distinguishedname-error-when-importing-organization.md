---
title: Failed to add user using the DistinguishedName error when importing organization
description: You may receive the Failed to add user using the DistinguishedName error when importing an organization in Microsoft Dynamics CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Failed to add user using the DistinguishedName error when importing an organization in Microsoft Dynamics CRM

This article provides a resolution for the issue that you may receive a **Failed to add user using the DistinguishedName" error when importing an organization in Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2714506

## Symptoms

When importing an organization into Microsoft Dynamics CRM, the Deployment Administrator may receive an error when mapping users:

> Failed to add user using the DistinguishedName = CN=\<CName>,OU=\<OU Name>,DC=\<DC Name>,DC=\<Domain>, Account Name = Domain\User System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))

## Cause

The Deployment Administrator performing the import may not have appropriate permissions to the Organizational Unit (OU) where the Microsoft Dynamics CRM Security Groups reside in Active Directory.

## Resolution

Verify the Deployment Administrator has sufficient permissions to the OU where the Microsoft Dynamics CRM Security Groups reside.

## More information

The following error may occur in the import logs: (Default location: %appdata%\Microsoft\MSCRM\Logs)

> Failed to add user using the DistinguishedName = CN=\<CName>,OU=\<OU Name>,DC=\<DC Name>,DC=\<Domain>, Account Name = Domain\User System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))
>
> An error occurred when populating Microsoft CRM user groups. Ensure that CRM user accounts are accessible from the current domain and run the wizard again.System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))
