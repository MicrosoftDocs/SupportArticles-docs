---
title: Vendors Can't Sign In To Vendor Collaboration Portal After Reonboarding
description: Steps to troubleshoot when vendors can't access the Vendor Collaboration Portal (VCP) after reonboarding in Microsoft Dynamics 365 Supply Chain Management.
author: vermayashi
ms.date: 09/15/2025
ms.search.form:  PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac, shriramsiv
ms.search.region: Global
ms.author: vermayashi
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with vendor management
---
# Vendors can't access the Vendor Collaboration Portal (VCP) after reonboarding

This article provides troubleshooting steps to help resolve issues when vendors are unable to access the Vendor Collaboration Portal (VCP) after being reonboarded in Dynamics 365 Supply Chain Management.

## Symptoms

When a vendor attempts to access the Vendor Collaboration Portal (VCP), the following error message occurs:

> The user must have access to at least one vendor.

This error occurs specifically after a vendor has been reonboarded and access was previously working.

## Cause 1: The vendor request isn't in "Request approved" status

**Resolution:**

Make sure the vendor request status is set to **Request approved**.

For details about checking vendor request status, see [Vendor requests](/dynamics365/supply-chain/procurement/vendor-onboarding#vendor-requests).

## Cause 2: The "Vendor collaboration access" permission is set to No during approval

**Resolution:**

If it's set to **Yes**, the vendor user should already have the appropriate roles assigned automatically.

If it's set to **No**, you can manually grant the necessary roles to the vendor user instead of restarting the onboarding process.

> [!NOTE]
> You don't need to restart the onboarding process if this setting was missed. You can assign the vendor roles manually.

For details about setting up vendor collaboration access, see [Approving a vendor request](/dynamics365/supply-chain/procurement/vendor-onboarding#approving-a-vendor-request).

## Cause 3: Required "External roles" aren't assigned to the vendor user

**Resolution:**

Verify that the vendor user's account includes the roles defined for the _Vendor_ type in **External roles** after reonboarding.

For details about setting up vendor collaboration security roles, see [Set up vendor collaboration security roles](/dynamics365/supply-chain/procurement/set-up-maintain-vendor-collaboration#set-up-vendor-collaboration-security-roles).

## Cause 4: Tenant and user mapping out of sync

Tenant and user mapping might be out of sync, especially for portals relying on internal data synchronization mechanisms (for example, Microsoft Support–only tools).

**Resolution:**

If the vendor still can't access the VCP portal, data synchronization might be required.

This step can only be completed by **Microsoft Support advocates**. If you're a customer or partner, contact Microsoft Support to perform the following steps in the Microsoft Volume Licensing Support Portal (MVLSP):

1. Sign in to the **MVLSP** portal.
2. Go to **Quick Tasks** > **View Tenant Mapping**.
3. Select the correct **Purchase Account**.
4. Select **Update MSDN Managers** to refresh the user mapping data.

## Cause 5: Vendor using incorrect credentials

The vendor might still try to sign in using incorrect credentials (not using their assigned **work account**).

**Resolution:**

After completing the previous troubleshooting steps, ask the vendor to sign in again using a **work account**.

For details about vendor onboarding and sign-in steps, see [Vendor onboarding](/dynamics365/supply-chain/procurement/vendor-onboarding).

## Cause 6: User not linked to a vendor contact

**Resolution:**

- Verify that the user record is linked to a person or contact on the **User Information** form in the system.
- Confirm that the person or contact is listed as a contact for the vendor master record.
- If not, link the user to the correct vendor contact so the system can identify which vendor the user should access.

For details, see [Add new vendor collaboration contacts](/dynamics365/supply-chain/procurement/manage-vendor-collaboration-users#add-new-vendor-collaboration-contacts).  

## Cause 7: Vendor collaboration setting inactive on vendor record

**Resolution:**

- Check the vendor master record to ensure that **Vendor collaboration** is set to **Active**.  
- If the setting is **Not active**, update it to **Active** so that vendor users can access the Vendor Collaboration Portal.  

For details, see [Enabling vendor collaboration](/dynamics365/supply-chain/procurement/vendor-collaboration-work-external-vendors#enabling-vendor-collaboration).

> [!TIP]
> If the issue persists, review the vendor collaboration setup and user role assignments to ensure no conflicting configurations exist.
