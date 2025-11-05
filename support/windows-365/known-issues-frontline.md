---
title: Known issues for Windows 365 Frontline
description: Learn about known issues for Windows 365 Frontline
manager: dcscontentpm
ms.date: 10/29/2025
ms.topic: troubleshooting
ms.reviewer: japarker, satulim, scottduf
ms.custom:
- pcy:Onboarding issues
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---

# Known issues: Windows 365 Frontline

This article describes known issues and their solutions for Windows 365 Frontline.

## Issue 1: Users cannot access Frontline Cloud PCs in shared mode

**Problem:** When Frontline Cloud PCs in shared mode are assigned to an Entra ID Group with more than 10,000 members, some users might not receive access and won't see the Cloud PC cards in the Windows app.

**Solution:** Reduce the Entra ID group membership to fewer than 10,000 users.

## Issue 2: Cannot decrease Cloud PC count when all provisioning fails

**Problem:** If provisioning fails due to an Autopilot Device Preparation Profile (DPP) failure and all Cloud PCs show no successfully provisioned devices, admins cannot decrease the number of Cloud PCs in the reprovision assignments option.

**Solution:** Perform a reprovisioning action in the provisioning policy.

## Issue 3: Scheduled reprovisioning doesn't recover after license changes

**Problem:** If Frontline Cloud PCs are provisioned in shared mode and licenses expire or are removed from the tenant, the Cloud PCs will be deprovisioned until valid licenses are added back. After licenses are restored, Cloud PCs provision according to the policy configurations, but scheduled reprovisioning won't reactivate and manual reprovisioning also fails.

**Solution:** To restore full functionality of manual and scheduled reprovisioning after license expiration:

1. Remove the provisioning policy assignment
2. Add the assignment back again

## Issue 4: Cannot decrease Cloud PC count due to pool user storage limits

**Problem:** The number of Cloud PCs for Frontline Cloud PCs in shared mode can't be decreased when it would cause the pooled user storage limit to be exceeded.

**Solution:** Delete individual user storage to be under the new limit. The new limit can be determined by multiplying the new Cloud PC count by the OS disk size in GB.
