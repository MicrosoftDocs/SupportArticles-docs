---
title: Can't import a solution or install an application due to missing privileges
description: Provides a workaround for an issue where solution import or application installation in Power Platform admin center fails due to missing privileges in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 04/17/2025
author: swatimadhukargit
ms.author: swatim
ms.custom: sap:Working with Solutions\Solution import - Other errors
---
# Solution import or application installation failure due to missing privileges

This article provides a workaround for an issue where you can't import a solution or install an application due to missing privileges in Microsoft Power Apps.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When a user tries to import a solution or install an application in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc), an error message like the following one occurs:

> Microsoft.Crm.CrmSecurityException: Principal user (Id=… accessMode=1... (Setup/Stub unlicensed user with filtered privileges from associated roles. Consider assigning License.)), is missing \<Component type\> privilege ...

## Cause

This error occurs for the following reasons:

- The [access mode](/power-apps/developer/data-platform/reference/entities/systemuser#BKMK_AccessMode) of the user performing the import or installation is set to **Administrative** instead of [**Read-Write**](/power-platform/admin/create-users#create-a-read-write-user-account). Users that don't have a valid Power Platform license will have a default access mode of **Administrative**.
- The user doesn't have sufficient privileges to import the solution that includes all the components in the solution.

## Workaround

To work around this issue, use the following methods:

- If the access mode of the user performing the import or installation is **Administrative**, update it to [**Read-Write**](/power-platform/admin/create-users#create-a-read-write-user-account) and [assign the user a valid license](/power-platform/admin/assign-licenses).
- Review the security roles for the user, and check if the user has **Create** and **Update** privileges for all the tables used by the components included in the solution. If not, [assign the user a security role](/power-platform/admin/assign-security-roles) that contains these privileges. The **System Administrator**, **System Customizer**, and **Environment Maker** security roles have these privileges.
