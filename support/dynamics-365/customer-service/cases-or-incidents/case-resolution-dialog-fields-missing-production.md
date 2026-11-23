---
title: Case Resolution Dialog Fields Missing in Production Environment
description: Case resolution dialog fields are missing in production but appear in a development or sandbox environment. Find and fix the configuration that causes it.
ms.reviewer: mgandham, nenellim
ai-usage: ai-assisted
ms.date: 09/08/2026
ms.custom: sap:Incident (Case) table\Issue with customizing case resolution, DFM
---

# Case resolution dialog fields are missing in production environment

## Summary

Custom fields or resolution values appear in the case resolution dialog in a development or sandbox environment but are missing in production after you import a solution. This article helps you check the resolve case dialog setting, solution deployment, solution layers, custom resolution values, and security role permissions in Dynamics 365 Customer Service.

## Symptoms

After you import a solution that contains a customized **Case Resolution** form into production, one or more custom fields or resolution values are missing from the case resolution dialog. The fields or values appear as expected in a development or sandbox environment.

## Solution

To resolve the issue, verify the following settings in the production environment.

### Review the Resolve case dialog setting

In **Case Settings** > **Other Settings** > **Service Configuration Settings**, verify that **Resolve case dialog** is set to **Customizable dialog**, as it's in the development or sandbox environment. If the setting is **Standard dialog**, custom fields from the **Case Resolution** form aren't displayed.

### Review whether the customized form is deployed and published

Confirm that the customized **Case Resolution** form is included in the solution that you imported into the production environment. After the import, publish all customizations.

### Compare solution layers

On the **Case Resolution** form, select **Advanced** > **See solution layers**. Compare the active layer in production with the active layer in the development or sandbox environment. A managed or unmanaged solution layer in production can override the expected form customizations. For more information, see [Solution layers](/power-apps/maker/data-platform/solution-layers).

### Verify custom resolution values

If custom resolution values are missing, confirm that each custom value in the **Case** table matches the corresponding value in the **Case Resolution** table. Values that don't match aren't displayed.

### Verify security role permissions

For the **Environment Variable Definition** table, verify that the **CSR Manager** role has **Create**, **Read**, and **Write** permissions and that the **Customer Service Representative** role has **Read** permission. Apply the same permissions to any corresponding custom security roles. For more information, see [Customize the case resolution dialog](/dynamics365/customer-service/administer/modify-case-resolution-dialog#prerequisites).

## Related content

[Resolved or canceled cases reopen unexpectedly](cases-reactivate-reopen-unexpectedly.md)
