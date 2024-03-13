---
title: How to verify that the tax tables are installed correctly in US Payroll in Microsoft Dynamics GP
description: Provides steps to verify the tax tables are current and have the correct FICA Social Security limit.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to verify that the tax tables are installed correctly in US Payroll in Microsoft Dynamics GP

This article describes how to verify that the tax tables are installed correctly in US Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851031

To verify that the tax tables are installed correctly in US Payroll in Microsoft Dynamics GP, follow these steps:

1. Follow the appropriate step:
   - In Microsoft Dynamics GP 10.0, click **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Payroll Tax**.
   - In Microsoft Dynamics GP 9.0, click **Setup** on the **Tools** menu, click **System** > **Payroll Tax**.
2. Enter the password if you're prompted.
3. Verify that the last tax update is current and that it matches the documentation of the tax install that you completed.

To verify that the social security limit is correct, follow these steps:

1. Follow the appropriate step:
   - In Microsoft Dynamics GP 10.0, click **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Payroll Tax**.
   - In Microsoft Dynamics GP 9.0, click **Setup** on the **Tools** menu, click **System** > **Payroll Tax**.
1. Enter the password if you're prompted.
1. In the **Tax Code** box, type *FICA*, and then click **Filing Status**.
1. In the **Payroll Tax Filing Status** window, click **NA** in the **Filing Status** field, and then click **Tables**. The social security limit is displayed.
