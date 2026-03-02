---
title: Detected Dataverse dependencies in 'msdynci_customerprofile'
description: Provides a resolution for an issue where Dataverse dependencies in 'msdynci_customerprofile' prevent data unification in Microsoft Dynamics 365 Customer Insights - Data.
ms.date: 03/02/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Unification\Match
---
# Detected Dataverse dependencies in 'msdynci_customerprofile'

This article provides a resolution for an issue where you can't remove a data source, remove a unified field, or change merge policies because of Dataverse dependencies.

## Symptoms

The following error message appears when you attempt to update a unification configuration that removes an attribute containing dependencies.

> Detected DataVerse dependencies in msdynci_customerprofile entity on these attribute(s): \<attribute names\>. Please delete these dependencies and merge again.

## Cause

When you update the data unification configuration in Dynamics 365 Customer Insights - Data, the system checks whether other solution components reference any attributes that you want to remove from the `msdynci_customerprofile` table in Dataverse.

Customer Insights - Data writes unified customer profiles to a virtual table called `msdynci_customerprofile` in your Dataverse environment. Each mapped and merged field from your data sources becomes a column on this table. When others in the organization reference those columns in forms, views, charts, workflows, business rules, or other components, Dataverse prevents you from deleting those columns.

## Resolution

Identify the components that have a dependency, remove them, and then rerun unification.

1. Sign in to [https://make.powerapps.com/](https://make.powerapps.com/) and select your environment.

1. Select **Tables** in the left pane.

1. Search for and open **CustomerProfile** (`msdynci_customerprofile`).

1. Select a column listed in the error message, and then choose **Advanced** > **Show dependencies**.

1. Review the **Dependent components** list to identify which forms, views, workflows, or other components reference that column.

1. For each dependent component, perform the appropriate action:

   | Component type | Action |
   |---|---|
   | **Form** | Open the form in the form designer, remove the column from the form layout, and then save and publish. |
   | **View** | Open the view editor, remove the column from the view's columns and filter criteria, and then save and publish. |
   | **Chart** | Edit the chart and remove references to the column. |
   | **Cloud flow / workflow** | Edit the flow in Power Automate and remove any steps that reference the column. |
   | **Business rule** | Edit the business rule and remove conditions or actions that reference the column. |
   | **Business process flow** | Edit the business process flow and remove any stage fields referencing the column. |

   > [!TIP]
   > If the component belongs to a managed solution you don't own, follow the [managed dependency removal steps](/power-platform/alm/removing-dependencies#actions-to-remove-a-managed-dependency) described earlier in this article.

1. After removing all listed dependencies, return to **Customer Insights - Data** > **Unify** > **Merge** and rerun unification.
