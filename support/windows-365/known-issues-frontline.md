---
title: Known issues for Windows 365 Frontline
description: Learn about known issues for Windows 365 Frontline
manager: dcscontentpm
ms.date: 10/29/2025
ms.topic: troubleshooting
ms.reviewer: msft-jasonparker, stulimat, scottduf
ms.custom:
- pcy:Onboarding issues
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---

# Known issues: Windows 365 Frontline

This article describes known issues and their solutions for Windows 365 Frontline Cloud PCs. These issues are being tracked and will be resolved in future updates.

## Issue 1: Users can't access Frontline Cloud PCs in shared mode

**Problem:** When Frontline Cloud PCs in shared mode are assigned to a Microsoft Entra ID group with more than 10,000 members, some users might not receive access and won't see the Cloud PC cards in the Windows app client.

**Solution:** Reduce the Microsoft Entra ID group membership to fewer than 10,000 users.

## Issue 2: Can't decrease Cloud PC count when all Cloud PCs fail provisioning

**Problem:** If provisioning fails due to a Windows Autopilot Device Preparation Profile (DPP) failure and all Cloud PCs show no successfully provisioned devices, administrators can't decrease the number of Cloud PCs in the assignment configuration.

**Solution:** Perform a reprovisioning action in the provisioning policy:

   1. Navigate to **Microsoft Intune admin center** > **Devices** > **Windows 365**
   2. Select **Provisioning policies**
   3. Choose the affected provisioning policy
   4. Select **Reprovision** to reset the deployment state
   5. After reprovisioning completes, you can adjust the Cloud PC count as needed

## Issue 3: Scheduled reprovisioning doesn't recover after license changes

**Problem:** When Frontline Cloud PCs are provisioned in shared mode and licenses expire or are removed from the tenant, the Cloud PCs are deprovisioned until valid licenses are restored. After licenses are added back, Cloud PCs provision according to the policy configurations, but both scheduled reprovisioning and manual reprovisioning functionality remain disabled.

**Solution:** To restore full reprovisioning functionality after license expiration:

   1. **Remove the provisioning policy assignment:**
      - Navigate to the affected provisioning policy
      - Go to the **Assignments** tab
      - Remove all group assignments

   2. **Re-add the assignment:**
      - Wait 5-10 minutes for the removal to process
      - Add the group assignments back to the policy
      - Verify that reprovisioning options are now available

## Issue 4: Can't decrease Cloud PC count due to pooled user storage limits

**Problem:** The number of Cloud PCs for Frontline Cloud PCs in shared mode can't be decreased when it would cause the pooled user storage limit to be exceeded.

**Solution:** Delete individual user storage to be under the new limit. The new limit can be determined by multiplying the new Cloud PC count by the OS disk size in GB.

## Issue 5: Autopilot Device Preparation (DPP) initially shows as failed if timeout limit is reached

**Problem:** Once you create the provisioning policy and you receive the error code `DevicePreparationProfileTimeout`, then the time-out limit has been reached and the Cloud PCs are provisioned without applying the Autopilot Device Preparation successfully.

**Solution:** Continue to wait as the Autopilot Device Preparation will continue to install in the background after the initial timeout period.

## Issue 6: Cloud PC serial numbers don't show immediately in Windows Autopilot Device Preparation deployment status

**Problem**: When monitoring the status of the Autopilot Device Preparation profile immediately after provisioning, the Cloud PC serial numbers are not available.

**Solution**: Cloud PC serial numbers can take up to 30 minutes.
