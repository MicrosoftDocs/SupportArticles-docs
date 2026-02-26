---
title: Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode
description: Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode
manager: dcscontentpm
ms.date: 02/12/2026
ms.topic: troubleshooting
ms.reviewer: msft-jasonparker, stulimat, scottduf
ms.custom:
- pcy:WinComm User Experience
- sap:Configuration and Management\Managing Devices with Intune
ms.collection:
- M365-identity-device-management
- tier2
---

# Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode

This article provides troubleshooting steps for the most common issues related to User Experience Sync in Windows 365 Frontline shared mode environments.

## Users receive a warning about a temporary user experience

When a user signs in, Windows might notify them that they've signed in by using a temporary profile instead of the user's regular profile. Windows also displays another notification that states "We can't sign into your account." As a result, the user has a temporary user experience.

> [!NOTE]  
> A temporary profile is a non-persistent Windows user profile that Windows creates when the system can't load or create the user's regular profile. The temporary profile provides basic functionality, but any changes made during the session (such as changes to settings, changes to files, or customizations) are discarded when the user signs out. Users see a notification that they've signed in by using a temporary profile, and their desktop and Start menu use default Windows settings instead of their personalized configuration.

To start troubleshooting this issue, check the status of the user's individual user storage as described in the following sections.

### Individual user storage failed to attach to their session

During the Windows sign-in process, users follow one of two flows:

- Create and attach new individual user storage
- Attach their existing individual user storage

Both processes require the service to attach a disk to the Cloud PC while the user is signing in. Attachment failures are uncommon but might occur when the pooled user storage exceeds the storage limit.

#### Pooled user storage has exceeded the storage limit

User Experience Sync provides a limited amount pooled user storage based on a storage calculation.

##### Understanding pooled storage limits

Each provisioning policy defines a pooled user storage limit calculated using the following formula:

**Total pooled storage** = OS disk size × Number of provisioned Cloud PCs

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-user-storage-example.png" alt-text="Figure 1: Storage calculation of pooled user storage based on Cloud PC size and count":::

<sup>**Figure 1:** Storage calculation of pooled user storage based on Cloud PC size and count</sup>

##### Normal storage consumption

Under normal conditions, the pooled user storage is consumed as users create individual user storages. When the storage reaches capacity:

- **Total size** and **Used size** are equal
- **Available size** shows **0 GB**
- The **User Storage** tab displays these metrics in the provisioning policy

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-full-storage-limit.png" alt-text="Figure 2: Pooled user storage that is at the policy limit":::

<sup>**Figure 2:** Pooled user storage that is at the policy limit</sup>

##### Exceeded storage conditions

When pooled user storage is *near* capacity and multiple users sign in simultaneously, all users sign in successfully and create their individual user storage. This process results in an **exceeded** condition that has the following characteristics:

- **Used size** becomes **greater** than the **Total size**
- **Available size** remains **0 GB**
- A new **Exceeded** property appears, showing the amount that exceeds the policy limit

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-exceeded-storage-limit.png" alt-text="Figure 3: Pooled user storage that has exceeded the policy limit":::

<sup>**Figure 3:** Pooled user storage that has exceeded the policy limit</sup>

##### Exceeded tolerance period

When pooled user storage exceeds its limit, the provisioning policy enters a tolerance period to prevent further storage growth. During this period:

- **Duration**: The tolerance period lasts for **7 days** from when the exceeded condition first occurs.
- **User impact**: Existing users who have individual storage can continue to sign in and access their personalized user experience.
- **New user restrictions**: New users that attempt to sign in receive a temporary user experience until storage is freed up.
- **Administrator actions**: Manually delete individual user storage or increase the Cloud PC count for the assignment.
- **Automatic resolution**: If storage usage drops below the limit during the tolerance period, normal operations resume immediately.

After the seven-day tolerance period expires:

- **Service protection**: The service begins deleting individual user storage starting at the oldest (based on the last attach timestamp). The quantity of individual user storage that's deleted is determined by the amount of space that's required for the policy to be under the policy limit.

> [!NOTE]  
> Monitor your storage usage regularly and configure the [Frontline Cloud PC User Experience Sync Storage Limits](/windows-365/enterprise/alerts) alert to avoid reaching the exceeded condition. Consider increasing your storage limit before reaching capacity to ensure uninterrupted user experience.

## Users experience low or full user storage issues

When individual user storage becomes low or full, users might experience performance issues or be unable to save their work. Use the following solutions to address storage constraints.

- [Free up space in OneDrive](https://support.microsoft.com/office/save-disk-space-with-onedrive-files-on-demand-for-windows-0e6860d3-d9f3-4971-b321-7092438fb38e)
- Review contents of the Downloads folder and delete files and folders that aren't needed
- Manually run [Storage Sense](/windows/configuration/storage/storage-sense?tabs=settings)
- Delete user storage (administrative action)

  > [!WARNING]  
  > Deleting user storage permanently removes all user data and settings. Before you proceed, make sure that the user backed up important data.

  Administrators can follow these steps to delete user storage by using the Windows 365 management portal:

  1. Sign in to the **Microsoft Intune admin center**.
  1. Navigate to **Devices** > **Windows 365** > **Provisioning policies**.
  1. Select the appropriate provisioning policy.
  1. Go to the **User Storage** tab.
  1. Locate the user storage to delete.
  1. Select **Delete** and confirm the action.
