---
title: Unable to Submit Prospective Vendor Registration Request
description: Describes a workaround for troubleshooting unable to submit Prospective Vendor Registration Request
ms.reviewer: sugaur
ms.date: 11/10/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---


# Troubleshooting: Unable to Submit Prospective Vendor Registration Request

## Symptoms
- Users are unable to submit a **Prospective Vendor Registration Request (PVRR)** in Dynamics 365 Finance and Operations.
- The Vendor Registration Wizard fails to complete or does not progress as expected.

## Possible Causes
- The vendor already exists in the system, leading to duplication issues.
- Missing vendor contact information in **Vendor collaboration > All contacts**.
- Incorrect user provisioning steps.

## Resolution Steps

### 1. If the Vendor Already Exists
To resolve the issue of duplicate records:

1. Go to **Vendor collaboration > All contacts**.
2. Locate the appropriate vendor contact.
3. Click **Provision vendor user** to link the existing vendor to the system without creating a new PVRR.  
   This will ensure no duplicate records are created.

   ![Provision vendor user](https://github.com/user-attachments/assets/578d30d4-4c77-4a86-85d6-e639360dfd4f)

### 2. If the Vendor Contact Does Not Exist
If no vendor contact is found, follow these steps to recreate the user and vendor contact:

1. Go to **System administration > Users**, then delete the existing user record.
2. Re-invite the vendor by navigating to **Procurement and Sourcing > Vendor collaboration requests > Prospective vendor request registration**.
3. This will trigger the creation of both the user and vendor contact.

   ![Invite vendor](https://github.com/user-attachments/assets/f4239479-e861-4467-8317-2cb31777b112)  
   ![New vendor contact](https://github.com/user-attachments/assets/f7f2e07f-c017-47fb-a63a-9fc03d2cb0d3)

### 3. After Recreating the Vendor
Once the vendor has been successfully recreated, follow your configured vendor request approval process, whether automatic or manual.

For additional guidance, refer to the official documentation:  
[Onboard Vendors - Supply Chain Management | Dynamics 365 | Microsoft Learn](https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/vendor-onboarding)

