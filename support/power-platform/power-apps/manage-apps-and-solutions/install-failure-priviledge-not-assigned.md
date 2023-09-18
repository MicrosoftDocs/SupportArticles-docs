---
title: Solution import or application installation failure due to missing privilege. 
description: This article provides a workaround for an issue where solution import or installation of application in Power Platform admin center results in failure due to missing privilege.
ms.reviewer: jdaly
ms.date: 09/20/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution import or installation failure due to missing privilege

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to perform solution import or try to perform application installation through Power Platform admin, you receive an error message like the following one:

> Microsoft.Crm.CrmSecurityException: Principal user (Id=… accessMode=1... (Setup/Stub unlicensed user with filtered privileges from associated roles. Consider assigning License.)), is missing &lt;Component type&gt; privilege ...

## Cause

This issue surface because of one of the following reasons:

- The [access mode](/power-apps/developer/data-platform/user-team-entities#users) of the user performing import is Administrative and doesn't have Read-Write access to perform the operation. The issue could happen because the user doesn't have a valid power platform license, and without a license the user's access mode is administrative.
- The user doesn't have sufficient privilege to import the solution that includes all the components in the solution.

## Workaround

To work around this issue:

- If the access mode of the user trying to import or install is Administrative, then update it to Read-Write and assign a valid license.
- Review the security roles for the user, and check that the user has sufficient privilege to create or update all the components included in the solution. Recommendation is to use system administrator, system customizer or environment maker roles to provide sufficient privilege.