---
title: Illegal address error when you run employee integration
description: Describes a problem that occurs because HRM Solution Series for Microsoft Dynamics GP is installed. A resolution is provided.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Illegal address" error when you run an employee integration in Integration Manager

This article provides a resolution for the Illegal address error when running an employee integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 944224

## Symptoms

When you run an employee integration in Integration Manager for Microsoft Dynamics GP, you receive the following error messages.

Error message 1

> Illegal address for field 'APR Use AddOn CB' in script 'APR_Employee_MNT_FORM_PRE_Trigger'.

Error message 2

> Illegal address for field 'DA Allow Arrears' in script 'APR_DIA_UPR_Employee_MNT_Deduction_DER_POST'.

## Cause

This problem occurs because HRM Solution Series for Microsoft Dynamics GP is installed.

## Resolution

To resolve this problem, follow these steps:

1. On the **Microsoft Dynamics GP** menu, select **Tools**, select **Customize**, and then select **Customization Status**.
2. Select **HRM Solution Series**, and then select **Disable**.
3. Close the Customization Status window.

When you exit Microsoft Dynamics GP and restart Microsoft Dynamics GP, the HRM Solution Series is enabled.
