---
title: Solution import or application installation failure due to missing privilege. 
description: This article provides a workaround for an issue where solution import or installation of an application in Power Platform admin center results in failure due to missing privilege.
ms.reviewer: jdaly
ms.date: 09/20/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution import or installation failure due to missing privilege

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to import a solution or try to perform application installation through the [Power Platform admin center](https://admin.powerplatform.microsoft.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc), you receive an error message like the following one:

> Microsoft.Crm.CrmSecurityException: Principal user (Id=… accessMode=1... (Setup/Stub unlicensed user with filtered privileges from associated roles. Consider assigning License.)), is missing &lt;Component type&gt; privilege ...

## Cause

This error occurs because of the following reasons:

- The [access mode](/power-apps/developer/data-platform/reference/entities/systemuser#BKMK_AccessMode) of the user performing the import is *Administrative* and doesn't have *Read-Write* access to perform the operation. If a user doesn't have a valid Power Platform license, their access mode is administrative.
- The user doesn't have sufficient privileges to import the solution that includes all the components in the solution.

## Workaround

To work around this issue:

- If the access mode of the user trying to import or install is *Administrative*, then update it to *Read-Write* and [assign a valid license](/power-platform/admin/assign-licenses).
- Review the security roles for the user, and check that the user has create and update privileges for all the tables used by the components included in the solution. [Assign a security role](/power-platform/admin/assign-security-roles) to the user that has those privileges. System administrator, system customizer or environment maker security roles have these privileges.