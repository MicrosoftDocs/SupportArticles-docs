---
title: Purchase Requisition "You Are Not Set Up as an Employee" Error
description: Purchase requisition creation fails in Supply Chain Management when the user account isn't linked to an active worker record. Learn how to fix the setup.
ms.reviewer: kamaybac, shubhamshr, sugaur
ms.search.form: PurchReqTable, HcmWorker, SysUserSetup
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase requisitions
ms.date: 08/12/2026
ai-usage: ai-assisted
---

# Purchase requisition creation fails with "You are not set up as an employee"

## Summary

In Microsoft Dynamics 365 Supply Chain Management, a user who tries to create a purchase requisition gets the error "You are not set up as an employee" when their user account isn't linked to an active worker record in Human resources. This article explains why the link is required and how to fix it: create the worker record, confirm active employment in the legal entity, and set the **Person** field on the user account.

## Symptoms

When a user goes to **Procurement and sourcing** > **Purchase requisitions** > **My purchase requisitions** and tries to create a [purchase requisition](/dynamics365/supply-chain/procurement/purchase-requisitions-overview), they receive the following error message:

> You are not set up as an employee. Contact your system administrator.

The user can navigate to the page but can't save a new requisition.

## Cause

Purchase requisitions require the user account to be associated with an active worker record in [Human resources](/dynamics365/human-resources/hr-admin-overview). You make the association through a [party record that has the **Worker** role](/dynamics365/fin-ops-core/dev-itpro/organization-administration/overview-global-address-book#party-roles) in the [global address book](/dynamics365/fin-ops-core/dev-itpro/organization-administration/overview-global-address-book).

The system uses this association to do the following tasks:

- Identify the requester on the requisition.
- Populate the requester's legal entity and department.
- Enforce [purchasing policies](/dynamics365/supply-chain/procurement/purchase-policies) that are based on the requester's organizational hierarchy.

The error occurs in any of the following situations:

- No worker record exists for the person.
- A worker record exists, but it has no active employment line in the current legal entity.
- A worker record exists, but the user account isn't linked to it through the **Person** field.

> [!NOTE]
> The **Worker** role is assigned per legal entity. A user who can create requisitions in one legal entity might still receive this error in another one.

## Solution

To link the user account to an active worker record, complete the following tasks in order.

### Verify that a worker record exists

1. Go to **Human resources** > **Workers** > **Workers**.
1. Search for the employee by name or personnel number.
1. If no record exists, select **New** to create a worker record, and then complete the required fields, including the name and a worker type of **Employee**.

### Verify that the worker has active employment

1. On the **Workers** page, select the worker.
1. On the **Employment** FastTab, confirm that the worker has an employment line that has a start date in the past and either no end date or an end date in the future.
1. If no active employment exists, add one by selecting **Hire new worker** for new employees, or add an employment line for an existing worker.

### Link the user account to the worker

1. Go to **System administration** > **Users** > **Users**.
1. Select the user account that has the issue.
1. On the **User's employee information** FastTab, set the **Person** field to the worker record.
1. Save the record.

> [!NOTE]
> The **Person** field on the user record links the user to a party in the global address book. The system resolves the associated worker record through that party. If the worker record exists but the **Person** field isn't set, the link is missing even though the worker record is present.

### Verify the fix

1. Ask the user to sign out of Dynamics 365 and then sign back in.
1. Ask the user to create a new purchase requisition on the **My purchase requisitions** page.
1. Verify that the error no longer appears.

## Related content

- [Purchase requisition overview](/dynamics365/supply-chain/procurement/purchase-requisitions-overview)
- [Purchase requisition workflow](/dynamics365/supply-chain/procurement/purchase-requisitions-workflow)
- [Create a requisition for consumption](/dynamics365/supply-chain/procurement/tasks/create-requisition-consumption)
- [Global address book overview](/dynamics365/fin-ops-core/dev-itpro/organization-administration/overview-global-address-book)
- [Order taker field not autofilled when creating purchase or sales orders](po-so-order-taker-not-auto-filled.md)
