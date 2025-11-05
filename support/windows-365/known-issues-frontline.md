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

The following items are known issues for Windows 365 Frontline.

## Users may not be able to access Frontline Cloud PCs in shared mode

When Frontline Cloud PCs in shared mode are assigned to an Entra ID Group with more than 10,000 members, some users might not receive access and might not see the Cloud PC cards in the Windows app.

### Solution

Reduce the Entra ID group membership to be fewer than 10,000 users.

## Number of cloud PCs for Frontline Cloud PCs in shared mode cannot be decreased when all Cloud PC provisioning fails

If provisioning fails due to an Autopilot Device Preparation Profile (DPP) (Preview) failure and results in all Cloud PCs showing no successfully provisioned devices, admins will not be able to decrease the number of Cloud PCs in the reprovision assignments option.

### Solution

Perform a reprovisioning action in the provisioning policy.

## Scheduled reprovisioning doesn't recover if Frontline licenses are removed or expire from a tenant and then are added back

If Frontline Cloud PCs are provisioned in shared mode and then licenses expire or are removed from the tenant, the Cloud PCs will be deprovisioned until valid licenses are added. After the licenses are added back, the Cloud PCs will be provisioned according to the configurations defined in the provisioning policy. If you have configured a scheduled reprovisioning for a provisioning policy, the scheduled reprovisioning won't be reactivated. Manual reprovisioning action also fails.

### Solution

To recover full functionality of manual and scheduled reprovisioning after license expiration, remove the provisioning policy assignment and then add it again.
