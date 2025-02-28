---
title: Asset ID Isn't Editable When Number Sequence Is Set to Manual
description: Provides a workaround for editing the Asset ID in Microsoft Dynamics 365 Supply Chain Management.
author: sorenbacker2
ms.author: sorenba
ms.date: 02/28/2025
ms.custom: sap:Asset management\Issues with asset management
---
# Asset ID isn't editable when the number sequence is set to Manual

This article provides a workaround that allows the Asset ID to be edited in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

A user [creates a new asset](/dynamics365/supply-chain/asset-management/objects/create-objects-based-on-purchase-orders#select-asset-items) using the **Asset Management** page. The asset is created with an **Asset ID** value that the system generates based on the [number sequence](/dynamics365/supply-chain/asset-management/setup-for-objects/enterprise-asset-management-parameters#the-number-sequences-tab) selected on the **Asset management parameters** page. However, the **Asset ID** value can't be edited later, even though the related number sequence is set to **Manual** on the **Number sequences** details page.

## Cause

This behavior is by design. A user can't edit an existing **Asset ID** because the **Asset ID** is the natural key for the asset. Editing it can cause data corruption and unexpected behavior in case of integrations.

## Workaround

To allow a user to edit the **Asset ID** on an existing asset despite the risk of data corruption, a developer needs to extend the `EntAssetObjectTable` form and change the property of the field.

1. Use Chain of Command (CoC) to change the control property by calling the `allowEdit()` method of the control and passing `false` as an argument.

1. Create an extension class and extend the  `init()` form method to programmatically allow the field to be edited after the `next()` call.

For a detailed explanation of the approach, see [Class extension - Method wrapping and Chain of Command](/dynamics365/fin-ops-core/dev-itpro/extensibility/method-wrapping-coc).

## More information

[Set up number sequences on an individual basis](/dynamics365/fin-ops-core/fin-ops/organization-administration/tasks/set-up-number-sequences-individual-basis)
