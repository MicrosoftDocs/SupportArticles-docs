---
title: Order Taker Not Auto-Filled When Creating Purchase or Sales Orders
description: Troubleshoot issues that prevent automatic field population when creating a purchase or sales order in Dynamics 365 Supply Chain Management.
author: vermayashi
ms.date: 09/12/2025
ms.search.form: PurchTable, PurchTablePart, PurchCreateOrder, SalesTable, SalesCreateOrder
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: vermayashi
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with Purchase order or sales order auto-fill
ms.topic: troubleshooting-problem-resolution

#customer intent: As a developer or system administrator, I want to fix an issue that prevents the order taker field from being autofilled when I create a purchase or sales order. This feature enables me to avoid having to complete field manually.
---

# Order taker field not autofilled when creating purchase or sales orders

When you [create a purchase order](/dynamics365/supply-chain/procurement/tasks/create-purchase-order) (PO) or sales order (SO) in Microsoft Dynamics 365 Supply Chain Management, the *order taker* (referred to as the **Orderer** in a PO and the **Sales orderer** in an SO) might not automatically populate when you expect it to. This article provides guidance for troubleshooting the required configurations to enable autofill.

## Symptoms

The **Orderer** or **Sales orderer** field is blank when you create a PO or SO. You expect the field to be autofilled in the order form.

## Cause

The **Orderer** or **Sales orderer** field is autofilled only if the current user account is associated with a **Party ID** property that has the [**Worker** role](/dynamics365/fin-ops-core/dev-itpro/organization-administration/overview-global-address-book#party-roles) in the current legal entity.

> [!NOTE]
> If a user has multiple Party IDs, only the ID that's set to **Worker** in the current legal entity enables autofill.

## Solution

To enable autofill, associate the user account with a Party ID that has the Worker role set in the current legal entity.

### Step 1: Verify the issue

In the target legal entity, create a PO or SO, and then verify that the **Orderer** or **Sales orderer** field isn't autofilled.

### Step 2: Check the party record

1. Navigate to **Organization administration** > **Global address book**.
1. Search for and open the relevant person or party record.
1. In the record, check the **Roles** section (or role-specific pages) to verify that this Party ID record has the Worker role assigned for the current legal entity.
1. If the Worker role isn't assigned to the Party ID, go to [step 3](#step-3-associate-the-party-id-with-the-worker-role). Otherwise, go to [step 4](#step-4-associate-the-user-account-with-the-party-record).

### Step 3: Associate the Party ID with the Worker role

1. Navigate to **Human resources** > **Workers** > **Workers**.
1. Select **New** to create a worker record.
1. Enter the hire date and any required details.

This step creates or associates the Party ID with the Worker role in the current legal entity.

### Step 4: Associate the user account with the party record

1. Go to **System administration** > **Users** > **Users**.
1. Open the relevant user account.
1. In the **Person** (or **Contact**) field, link the user account to the party record that has the Worker role assigned for the current legal entity. If the **Person** field is locked because of a previous association, use the **Maintain versions** option to remove the existing relation. Then, assign the correct worker-linked party.

### Step 5: Validate the fix

1. Save the user record
1. Create a PO or SO, and verify that the **Orderer** or **Sales orderer** field is autofilled.

If the issue persists after you verify the Worker role association, try the following steps:

1. Check for duplicate **Party ID** properties that might be causing conflicts.
1. Investigate potential customizations or extensions that could override the default behavior.
1. Capture a trace for further analysis, if it's necessary. This trace can help identify any underlying issues that might require technical support.

## Related content
  
- [Global address book overview](/dynamics365/fin-ops-core/dev-itpro/organization-administration/overview-global-address-book)
- [Party and global address book](/dynamics365/fin-ops-core/dev-itpro/data-entities/dual-write/party-gab)
- [Create new users](/dynamics365/fin-ops-core/fin-ops/sysadmin/create-new-users)
