---
title: Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode
description: Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode
manager: dcscontentpm
ms.date: 10/29/2025
ms.topic: troubleshooting
ms.reviewer: msft-jasonparker, stulimat, scottduf
ms.custom:
- pcy:Configuration and Management\Managing Devices with Intune
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---

# Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode

This article provides troubleshooting steps for the most common issues related to User Experience Sync in Windows 365 Frontline shared mode environments.

## Limitations

- Custom data locations can't be excluded from per-user storage
- User installed applications will not persist between different devices
- Disaster recovery or user storage move options are not available
- When an assignment is removed, it deletes all user storage and can't be recovered

## Users receive a warning about a temporary user experience

In certain scenarios, users may receive a temporary user experience (temporary profile). The Cloud Profile agent is the first to notify the user about this temporary experience. After the desktop loads, Windows displays another notification stating, "We can't sign into your account".

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-temp-profile-agent.png" alt-text="Figure 1: Cloud Profile agent temporary user experience warning":::

<sup>**Figure 1:** Cloud Profile agent temporary user experience warning</sup>

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-temp-profile-windows.png" alt-text="Figure 2: Windows can't sign in warning":::

<sup>**Figure 2:** Windows can't sign in warning</sup>

### Possible causes

#### Individual user storage failed to attach to their session

During the Windows sign-in process, users follow one of two flows:

- Create and attach new individual user storage
- Attach their existing individual user storage

Both processes require the Cloud Profile service to attach a disk to the device while the user is signing in. Attachment failures are uncommon but may occur due to:

- The pooled user storage has exceeded the total allocated size
- A Cloud Profile service error

##### Pooled user storage has exceeded the total allocated size

###### Understanding storage allocation

Each provisioning policy defines a pooled user storage limit calculated using the following formula:

**Total pooled storage** = OS disk size × Number of provisioned Cloud PCs

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-user-storage-example.png" alt-text="Figure 3: Storage calculation of pooled user storage based on Cloud PC size and count":::

<sup>**Figure 3:** Storage calculation of pooled user storage based on Cloud PC size and count</sup>

###### Normal storage consumption

Under normal conditions, the pooled user storage is consumed as users create individual user storages. When the storage reaches capacity:

- **Total size** and **Used size** will be equal
- **Available size** will show **0 GB**
- The User Storage tab displays these metrics in the provisioning policy

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-full-storage-limit.png" alt-text="Figure 4: Pooled user storage that is at the policy limit":::

<sup>**Figure 4:** Pooled user storage that is at the policy limit</sup>

###### Exceeded storage conditions

In rare race conditions, when pooled user storage is *near* capacity and multiple users sign in simultaneously, the Cloud Profile service may create additional individual user storages. This results in an **exceeded** condition with the following characteristics:

- **Used size** becomes **greater** than the **Total size**
- **Available size** remains **0 GB**
- A new **Exceeded** property appears, showing the amount that exceeds the policy limit

:::image type="content" source="media/troubleshoot-user-experience-sync/user-experience-sync-exceeded-storage-limit.png" alt-text="Figure 5: Pooled user storage that has exceeded the policy limit":::

<sup>**Figure 5:** Pooled user storage that has exceeded the policy limit</sup>

###### Exceeded tolerance period

When pooled user storage exceeds its limit, the provisioning policy enters a tolerance period to prevent further storage growth. During this period:

- **Duration**: The tolerance period lasts for **7 days** from when the exceeded condition first occurs
- **User impact**: Existing users with individual storage can continue to sign in and access their personalized user experience
- **New user restrictions**: New users attempting to sign in will receive a temporary user experience until storage is freed up
- **Administrator actions**: Manually delete individual user storage or increase the Cloud PC count for the assignment
- **Automatic resolution**: If storage usage drops below the limit during the tolerance period, normal operations resume immediately

After the 7 day tolerance period expires:

- **Service protection**: The service will begin deleting individual user storage starting with the oldest based on the last attach timestamp. The number of individual user storage deleted will be determined by the amount of space required for the policy to be under the policy limit.

> [!NOTE]
> Monitor your storage usage regularly and configure the [Frontline Cloud PC User Experience Sync Storage Limits](/windows-365/enterprise/alerts) alert to avoid reaching the exceeded condition. Consider increasing your storage limit before reaching capacity to ensure uninterrupted user experience.

#### User Experience Sync service error

The User Experience Sync service is responsible for creating and attaching individual user storage. During a service issue, failure, or outage, users may experience a temporary user experience. In these scenarios, open a support case so our support engineers can:

- Determine where in the process the issue occurred
- Identify if the issue is transient or requires service engineering work

## Resolve low or full user storage issues

When individual user storage becomes low or full, users may experience performance issues or be unable to save their work. Use the following solutions to address storage constraints.

- [Free up space in OneDrive](https://support.microsoft.com/en-us/office/save-disk-space-with-onedrive-files-on-demand-for-windows-0e6860d3-d9f3-4971-b321-7092438fb38e)
- Delete user storage (administrative action)

> [!WARNING]
> Deleting user storage permanently removes all user data and settings. Ensure the user has backed up important data before proceeding.

  Administrators can delete user storage from the Windows 365 management portal:

  1. Sign in to the **Microsoft Intune admin center**.
  2. Navigate to **Devices** > **Windows 365** > **Provisioning policies**.
  3. Select the appropriate provisioning policy.
  4. Go to the **User Storage** tab.
  5. Locate the user storage to delete.
  6. Select **Delete** and confirm the action.

## Recover from accidental deletions

If individual user storage is accidentally deleted, follow these recovery steps.

### Open a support case

When user experience data is lost due to accidental deletion:

1. **Document the issue**:
   - User affected and their email address
   - Date and time when the data loss occurred
   - Specific data or settings that were lost
   - Any error messages received

2. **Open a Microsoft support case**:
   - Go to the Microsoft 365 admin center
   - Navigate to **Support** > **New service request**
   - Provide detailed information about the data loss
   - Include the Cloud PC serial number or device ID

3. **Gather diagnostic information**:
   - Event logs from the affected Cloud PC
   - Screenshots of any error messages
   - User storage policy configuration details
