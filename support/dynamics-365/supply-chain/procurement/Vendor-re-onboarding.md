---
title: Vendors can't sign in to the Vendor Collaboration Portal after re-onboarding
description: Steps to troubleshoot when vendors can't access the Vendor Collaboration Portal (VCP) after re-onboarding in Dynamics 365 Supply Chain Management.
author: vermayashi
ms.date: 09/02/2025
ms.search.form:  PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: vermayashi
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with vendor management
---

# Vendor unable to access Vendor Collaboration Portal (VCP) after re-onboarding

## Symptom
Vendor attempts to access the Vendor Collaboration Portal (VCP) but encounters the error:

>The user must have access to at least one vendor.

Occurs specifically after a vendor has been re-onboarded and access was previously working.

## Cause
This issue can occur if:
- The vendor request may not actually be in **Request approved** status.
- The **Vendor collaboration access** permission may have been set to **No** during approval.
- Required **External roles** might not have been assigned to the vendor user.
- Tenant and user mapping may be out of sync, especially for portals relying on internal data sync mechanisms (e.g., Microsoft Support–only tools).
- The vendor may still be attempting to log in with incorrect credentials (not using their assigned **work account**).

## Resolution
Follow these steps to resolve the issue:

### Step 1: Verify vendor request status
Make sure the vendor request status is set to **Request approved**.

For details about checking vendor request status, see [Vendor requests](https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/vendor-onboarding#vendor-requests).

### Step 2: Check vendor collaboration access
Verify whether the **Vendor collaboration access** permission was set to **Yes** during the vendor request approval.

- If it was set to **Yes**, the vendor user should already have the appropriate roles assigned automatically.
- If it was set to **No**, you can manually grant the necessary roles to the vendor user instead of restarting the onboarding process.

> [!NOTE]
> You don’t need to start the onboarding process over if this setting was missed. You can assign the vendor roles manually.

For details about setting up vendor collaboration access, see [Approving a vendor request](https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/vendor-onboarding#approving-a-vendor-request).

### Step 3: Confirm external roles
Verify that the vendor user’s account includes the roles defined for the _Vendor_ type in **External roles** after re-onboarding.
For details about setting up vendor collaboration security roles, see [Set up vendor collaboration security roles](https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/set-up-maintain-vendor-collaboration#set-up-vendor-collaboration-security-roles).

### Step 4: Perform data synchronization
If the vendor still can't access the VCP portal, data synchronization might be required.

This step can only be completed by **Microsoft Support advocates**. If you're a customer or partner, contact Microsoft Support to perform the following steps in the Microsoft Volume Licensing Support Portal (MVLSP):
1. Sign in to the **MVLSP** portal.
2. Go to **Quick Tasks > View Tenant Mapping**.
3. Select the correct **Purchase Account**.
4. Select **Update MSDN Managers** to refresh the user mapping data.

### Step 5: Ask the vendor to retry login
After completing the previous steps, ask the vendor to sign in again using a **work account**.

For details about vendor onboarding and login steps, see [Vendor onboarding](https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/vendor-onboarding).

> [!TIP]
> If the issue persists, review the vendor collaboration setup and user role assignments to ensure no conflicting configurations exist.

