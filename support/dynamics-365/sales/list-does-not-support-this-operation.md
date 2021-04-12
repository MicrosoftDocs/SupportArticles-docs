---
title: List doesn't support this operation 
description: Provides a solution to an error that occurs when you use the new server-based SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online.
ms.reviewer: tylerol
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# List does not support this operation error message when using the new server-based SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online

This article provides a solution to an error that occurs when you use the new server-based SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2975782

## Symptoms

When accessing the Documents section of a record that is enabled for document management, a user may receive the following error when viewing the documents grid on a record with the new server-based SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online:

> List does not support this operation

Consider the following scenario:

Document Management has been enabled for the Opportunity entity. Later, the Display Name of the Opportunity entity is changed to Deal. In this scenario, the Display Name for Opportunity is now Deal, but the Name of the SharePoint document library will be listed as Opportunity.

## Cause

It may be the result of a mismatch between the Display Name of the CRM entity and the corresponding Name of the SharePoint document library.

To verify: Check the SharePoint website to see if the Display Name of the CRM entity matches the Name of the SharePoint document library.

Step 1: Check the Display Name of the CRM entity (Example: Opportunity)  

1. In CRM, navigate to the **Settings** page.
2. Select **Customizations** from the **Settings** dropdown in the navigation bar.
3. Select **Customize the System**.
4. In the new window, select **Entities** from the left-hand column.
5. In the list of entities, select the wanted entity (in this example, select **Opportunity**).
6. In the General section, look at the text shown in the Display Name field. It's the name that will be displayed for the CRM entity.

Step 2: Check the SharePoint document library Name (Example: Opportunity)

1. In the SharePoint website used for Document Management, navigate to **Site Contents**.
2. Select the document library that corresponds to the CRM entity mentioned in Step 1 (in this example, select **Opportunity**).
3. Select the **Library** tab in the ribbon at the top of the page. Which will expose additional site actions for the library.
4. Select the **Library Settings** site action.
5. Select the **List name**, **Description**, and **Navigation link** under **General Settings**.
6. Look at the text shown in the Name field. It's the name displayed for the SharePoint document library.

The Display Name shown for the CRM entity in Step 1 must match the Name shown for the SharePoint document library in Step 2. If these fields don't match, this issue could occur.

## Resolution

Edit the Name of the SharePoint document library in Step 2 above (or the Display Name of the corresponding CRM entity in Step 1) so that both the Name of the SharePoint document library and the Display Name of the CRM entity match. This change won't remove any of the existing items in the SharePoint document library. It also won't affect any URLs that reference the SharePoint document library.
