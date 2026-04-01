---
title: Fix Data Unification Failures Due to Dataverse Dependencies
description: Resolve Dataverse dependency conflicts in msdynci_customerprofile that prevent data unification in Customer Insights - Data. Follow these steps to remove blocking components.
ms.date: 03/31/2026
ms.reviewer: sstabbert, v-wendysmith, v-shaywood
ms.custom: sap:Data Unification
---
# "Detected DataVerse dependencies in msdynci_customerprofile" error message

## Summary

This article provides a resolution for an issue that prevents you from removing a data source or a unified field, or prevents you from changing merge policies in [Dynamics 365 Customer Insights - Data](/dynamics365/customer-insights/data/overview). This issue occurs because of Dataverse dependencies on the `msdynci_customerprofile` table.

## Symptoms

When you try to [update a unification configuration](/dynamics365/customer-insights/data/data-unification-update) to remove one or more attributes, you receive the following error message:

> Detected DataVerse dependencies in msdynci_customerprofile entity on these attribute(s): \<AttributeNames\>. Please delete these dependencies and merge again.

## Cause

Customer Insights - Data writes unified customer profiles to a virtual table that's known as `msdynci_customerprofile` in your Dataverse environment. Each mapped and merged field from your [data sources](/dynamics365/customer-insights/data/data-sources) becomes a column of this table.

When you [update the data unification configuration](/dynamics365/customer-insights/data/data-unification-update), the system checks whether other solution components, such as forms, views, charts, workflows, and business rules, reference any attributes that you're removing. If dependencies exist, Dataverse blocks the deletion.

## Solution

Identify the dependent components, remove the dependencies, and then rerun unification:

1. Sign in to [Power Apps](https://make.powerapps.com/), and select your environment.

1. In the left pane, select **Tables**.

1. Search for and open **CustomerProfile** (`msdynci_customerprofile`).

1. Select the column that's listed in the error message, and then select **Advanced** > **Show dependencies**. For more information, see [View dependencies for a component in Power Apps](/power-apps/maker/data-platform/view-component-dependencies).

1. Review the **Dependent components** list to identify which forms, views, workflows, or other components reference that column.

1. For each dependent component, take the appropriate action:

   - **Form**: Open the form in the form designer, remove the column from the form layout, and then save and publish.
   - **View**: Open the view editor, remove the column from the view's columns and filter criteria, and then save and publish.
   - **Chart**: Edit the chart, and remove references to the column.
   - **Cloud flow / workflow**: Edit the flow in Microsoft Power Automate, and remove any steps that reference the column.
   - **Business rule**: Edit the business rule, and remove conditions or actions that reference the column.
   - **Business process flow**: Edit the business process flow, and remove any stage fields that reference the column.

   > [!NOTE]
   > If the component belongs to a managed solution that you don't own, follow the steps in [Actions to remove a managed dependency](/power-platform/alm/removing-dependencies#actions-to-remove-a-managed-dependency).

1. After you remove all listed dependencies, return to **Customer Insights - Data** > **Unify** > **Merge**, and rerun unification.

## Related content

- [Data unification overview](/dynamics365/customer-insights/data/data-unification)
- [Removing dependencies overview](/power-platform/alm/removing-dependencies)
