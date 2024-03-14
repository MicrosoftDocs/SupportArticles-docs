---
title: Operation could not be completed error when creating new column
description: Describes an error you may receive in Management Reporter 2012 if the ISO codes are not set up for currencies in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, davidtre, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# "The operation could not be completed due to a problem in the data provider framework" error when creating a new column

This article provides a resolution for the issue that you can't create a new column due to **The operation could not be completed due to a problem in the data provider framework** this error.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2792806

## Symptoms

When you create a new column definition in Management Reporter 2012, you receive the following error message:

> The operation could not be completed due to a problem in the data provider framework.

When you select **OK** to this error message, you receive this error:

> Value cannot be null. Parameter name: source

## Cause

A currency is missing the ISO code in Microsoft Dynamics GP. The error will only occur with the Dynamics GP Data Mart.

## Resolution

You must enter an ISO code for all currencies within Microsoft Dynamics GP in the Currency Setup window. For more information about how to set up currencies in Microsoft Dynamics GP, you will have to contact the Microsoft Dynamics GP Financials support team.

After you have the currencies set up in with the ISO codes, you must reconfigure the Microsoft Dynamics GP Data Mart integration. To do that, follow these steps:

1. Start the MR Configuration Console.
2. Under **ERP Integrations**, select the Dynamics GP Data Mart integration.
3. Select **Remove** to remove the integration.
4. In SQL Management Studio, delete the DDM database.
5. In the MR Configuration Console, select **File** and then select **Configure**.
6. Select **Add Microsoft Dynamics GP Data Mart** and then select **Next**.
7. Enter the required information and complete the wizard.
