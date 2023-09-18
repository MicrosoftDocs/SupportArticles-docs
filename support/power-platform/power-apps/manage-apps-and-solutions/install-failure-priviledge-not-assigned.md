---
title: Solution import or installation failure due to priviledge not assigned. 
description: This article provides a workaround for an issue where where solution imports or installation of application from Power Platform admin center failure due to not having priviledge to the user.
ms.reviewer: jdaly
ms.date: 09/20/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution import or installation failure due to priviledge not assigned

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to perform solution import through Maker portal or try to perform application installation through Power Platform admin center you will receive an error message like the following one:

> Microsoft.Crm.CrmSecurityException: Principal user (Id=… accessMode=1... (Setup/Stub unlicensed user with filtered privileges from associated roles. Consider assigning License.)), is missing <Component type> privilege ...

## Cause

This issue surface because of one of the following reasons:

- The reasoon for getting this error during solution import is that the access mode of the user performing import is admin and does not have the full access to perform the operation. This could also happen because the user does not have a license, and without a license by default admin mode is given to it. It may also happen that the user does not have access to all the components in the solutions.
- The reason for getting this error during application installation in Power Platform admin center is that the installation initiates without having a check for access mode and fails later in the dataverse platform.

## Workaround

To work around this issue:

- Assign license to the admin user to have access in full mode.
- Review user access mode and assign the right access.
- Review the security role of your user, and check which permission, system user, system customizer, etc. If custom permission is given, review the environment maker permission.
