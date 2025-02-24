---
title: Asset ID Isn't Editable When Number Sequence Is Set To Manual
description: Provides a workaround for editing Asset ID in Microsoft Dynamics 365 Supply Chain Management.
author: sorenbacker2
ms.author: sorenba
ms.date: 02/20/2025
ms.custom: sap:Asset management\Issues with asset management
---
# Asset ID isn't editable when number sequence is set to Manual

This article provides a workaround for allowing the Asset ID to be edited in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms
  
A user [creates a new asset](/dynamics365/supply-chain/asset-management/objects/create-objects-based-on-purchase-orders#select-asset-items) using the **Asset Management** page. The asset is created with an **Asset ID** value that the system generates based on the [number sequence](/dynamics365/supply-chain/asset-management/setup-for-objects/enterprise-asset-management-parameters#the-number-sequences-tab) selected on the **Asset management parameters** page. However, the **Asset ID** value can't be edited later, even though the related number sequence has **Manual** set to *Yes* on the **Number sequences** details page.

## Cause

A user can't edit an existing **Asset ID** because the **Asset ID** is the natural key for the **Assets**. Editing it can cause data corruption and unexpected behavior in case of integrations.

## Workaround

To allow a user to edit the Asset ID on an existing asset despite the risk, extend the EntAssetObjectTable form and change the property of the field. Use Chain of Command in order to change the control property through calling allowEdit() method of the control and passing false as an argument. Create an extension class and extend the form init() method where programmatically allowing edit on the field after the next() call. Find a detailed explanation of the approach here: https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/extensibility/method-wrapping-coc



## More information

[Set up number sequences on an individual basis](/dynamics365/fin-ops-core/fin-ops/organization-administration/tasks/set-up-number-sequences-individual-basis)
