---
title: Troubleshoot Failures When Submitting a Prospective Vendor Registration Request
description: Learn how to fix errors when submitting a Prospective Vendor Registration Request (PVRR). Identify causes like duplicate vendors or missing contact info.
ms.reviewer: sugaur
ms.date: 11/10/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---

# Troubleshoot failures when submitting a Prospective Vendor Registration Request

This article provides troubleshooting guidance for failures that might occur when submitting a Prospective Vendor Registration Request (PVRR).

## Symptoms

You might experience one or more of the following symptoms:

- You can't submit a _Prospective Vendor Registration Request (PVRR)_ in Dynamics 365 Finance and Operations.
- The _Vendor Registration Wizard_ doesn't complete or fails to progress.

## Cause 1: The vendor already exists

A PVRR can fail to submit if the vendor already exists in the system, causing duplication.

### Solution

To avoid duplicate records:

1. Go to **Vendor collaboration > All contacts**.

1. Find the correct vendor contact.

1. Select **Provision vendor user** to link the existing vendor without creating a new PVRR.

   :::image type="content" source="./media/unable-to-submit-pvrr/provision-vendor-user.png" alt-text="The vendor contact page with the provision vendor user button highlighted.":::

## Cause 2: Missing vendor contact information

A PVRR can fail to submit if the vendor contact information is missing in **Vendor collaboration > All contacts**.

### Solution

To add the required vendor contact info:

1. Go to **System administration > Users** and delete the existing user record associated with the vendor.

   :::image type="content" source="./media/unable-to-submit-pvrr/delete-vendor.png" alt-text="The users page with the delete button highlighted.":::

1. Re-invite the vendor via **Procurement and Sourcing > Vendor collaboration requests > Prospective vendor request registration**.

   :::image type="content" source="./media/unable-to-submit-pvrr/invite-user.png" alt-text="The Prospective vendor request registration page with the Invite user button highlighted.":::

This process creates both the user and vendor contact.

## Cause 3: Incorrect user provisioning steps

A PVRR can fail to submit if the user provisioning steps aren't followed correctly.

### Solution

Follow your configured vendor request approval process (automatic or manual). For more details, see: [Onboard vendors](/dynamics365/supply-chain/procurement/vendor-onboarding)
