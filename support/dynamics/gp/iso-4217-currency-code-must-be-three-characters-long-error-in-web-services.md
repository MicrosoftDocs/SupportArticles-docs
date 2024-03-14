---
title: ISO 4217 Currency Code must be three characters long error in Web Services
description: Describes a problem that causes a SOAP exception. The problem occurs because a duplicate ISO currency code was set up in Microsoft Dynamics GP. Provides steps to resolve the problem.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "An ISO 4217 Currency Code must be three characters long" error when you use Web Services

This article provides a resolution for the issue that you may receive the error **An ISO 4217 Currency Code must be three characters long** when using Web Services for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 924546

## Symptoms

When you use Web Services for Microsoft Dynamics GP, a SOAP exception may occur. If you select **Details** to view the Exception Management console, you find the following error message:

> An ISO 4217 Currency Code must be three characters long; your value is

## Cause

This problem occurs because a duplicate ISO currency code was set up in Microsoft Dynamics GP. Although you can create duplicate ISO currency codes in Microsoft Dynamics GP, Web Services for Microsoft Dynamics GP requires a unique ISO currency code for each currency in Microsoft Dynamics GP. Therefore, if you have duplicate ISO currency codes in Microsoft Dynamics GP, you cannot perform any operation that refers to currency when you use Web Services for Microsoft Dynamics GP.

## Resolution

To resolve this problem, change the duplicate ISO currency code in Microsoft Dynamics GP.

1. Sign in to Microsoft Dynamics GP as a user who has administrator rights.
2. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Currency**.
3. In the Currency Setup window, select the **Lookup** button on the **Currency ID** field.
4. In the Currencies window, select the currency ID that has a duplicate ISO currency code, and then select **Select**.
5. In the Currency Setup window, type three characters in the **ISO Currency** box to create a new currency code.
6. Select **Save**.
