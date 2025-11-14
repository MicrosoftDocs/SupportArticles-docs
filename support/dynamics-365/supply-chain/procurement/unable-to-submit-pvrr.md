---
title: Unable to Submit Prospective Vendor Registration Request
description: Provides steps to resolve issues when submitting a Prospective Vendor Registration Request (PVRR) in Dynamics 365 Finance and Operations.
ms.reviewer: sugaur
ms.date: 11/10/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---

# Troubleshooting: Unable to Submit Prospective Vendor Registration Request

## Symptoms
- Users cannot submit a **Prospective Vendor Registration Request (PVRR)** in Dynamics 365 Finance and Operations.
- The Vendor Registration Wizard does not complete or fails to progress.

## Possible Causes
- The vendor already exists in the system, causing duplication.
- Missing vendor contact information in **Vendor collaboration > All contacts**.
- Incorrect user provisioning steps.

## Resolution

### 1. Vendor Already Exists
To avoid duplicate records:

1. Navigate to **Vendor collaboration > All contacts**.
2. Find the correct vendor contact.
3. Select **Provision vendor user** to link the existing vendor without creating a new PVRR.

   ![Provision vendor user](https://github.com/user-attachments/assets/578d30d4-4c77-4a86-85d6-e639360dfd4f)

### 2. Vendor Contact Does Not Exist
If no vendor contact is found:

1. Go to **System administration > Users** and delete the existing user record.
2. Re-invite the vendor via **Procurement and Sourcing > Vendor collaboration requests > Prospective vendor request registration**.
3. This process creates both the user and vendor contact.


   ![Invite vendor](https://github.com/user-attachments/assets/f4239479-e861-4467-8317-2cb31777b112)  
   ![New vendor contact](https://github.com/user-attachments/assets/f7f2e07f-c017-47fb-a63a-9fc03d2cb0d3)

### 3. After Recreating the Vendor
Follow your configured vendor request approval process (automatic or manual).

For more details, see:  
[Onboard Vendors - Supply Chain Management | Dynamics 365 | Microsoft Learn](https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/vendor-onboarding)
