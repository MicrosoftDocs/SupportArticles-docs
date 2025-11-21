---
title: Troubleshoot Failures When Submitting a Prospective Vendor Registration Request
description: Learn how to fix errors when you submit a Prospective Vendor Registration Request (PVRR). Identify causes such as duplicate vendors or missing contact info.
ms.reviewer: sugaur
ms.date: 11/10/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---

# Troubleshoot failures when submitting a Prospective Vendor Registration Request

This article provides troubleshooting guidance for failures that occur when you submit a Prospective Vendor Registration Request (PVRR).

## Symptoms

You experience one or more of the following symptoms:

- You can't submit a PVRR in Microsoft Dynamics 365 Finance and Operations.
- The _Vendor Registration Wizard_ doesn't finish or progress.

## Cause 1: The vendor already exists

A PVRR submission might fail if the vendor already exists in the system. In this situation, the submission creates duplicate records.

### Solution

To avoid duplicate records:

1. Go to **Vendor collaboration > All contacts**.

1. Find the correct vendor contact.

1. To link the existing vendor without creating a new PVRR, select **Provision vendor user**.

   :::image type="content" source="./media/unable-to-submit-pvrr/provision-vendor-user.png" alt-text="The vendor contact page that has the provision vendor user button highlighted.":::

## Cause 2: Missing vendor contact information

A PVRR submission might fail if the vendor contact information is missing in the **Vendor collaboration** > **All contacts** screen.

### Solution

To add the required vendor contact info:

1. Go to **System administration** > **Users**, and delete the existing user record that's associated with the vendor.

   :::image type="content" source="./media/unable-to-submit-pvrr/delete-vendor.png" alt-text="The users page that has the delete button highlighted.":::

1. Re-invite the vendor by selecting **Procurement and Sourcing** > **Vendor collaboration requests** > **Prospective vendor request registration**.

   :::image type="content" source="./media/unable-to-submit-pvrr/invite-user.png" alt-text="The Prospective vendor request registration page that has the Invite user button highlighted.":::

This process creates both the user and vendor contacts.

## Cause 3: Incorrect user provisioning steps

A PVRR submission might fail if the user provisioning steps aren't followed correctly.

### Solution

Follow your configured vendor request approval process (automatic or manual). For more details, see: [Onboard vendors](/dynamics365/supply-chain/procurement/vendor-onboarding)
