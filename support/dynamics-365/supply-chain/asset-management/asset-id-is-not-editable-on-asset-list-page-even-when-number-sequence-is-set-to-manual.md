<!-- TOC location: Learn / Troubleshoot / Microsoft Dynamics 365 / Dynamics 365 Supply Chain Management / Asset Management -->

# Asset ID is not editable on Asset list page even when Number sequence is set to Manual

## Symptoms  
  
A user uses the **Asset Management** page to create a new asset. The asset is created with an **Asset ID** value that the system generates based on the number sequence selected on the **Asset Management parameters** page. Later, the user wishes to edit the **Asset ID** value. However, this isn't possible even though the related number sequence has **Manual** set to *Yes* on the **Number sequences** details page.

## Cause

A user can't just edit an existing **Asset ID** because the **Asset ID** is the natural key for the **Assets**. We don't allow this to be edited as it can cause data corruption and unexpected behavior in the case of integrations.

## Resolution

If you, regardless of the risk of data corruption, want to be able to edit the **Asset ID** anyway, you can extend the `init()` method on **EntAssetObjectTable** form, and allow edit on the field.

This change will allow a user to edit the **Asset ID** on an existing asset.
