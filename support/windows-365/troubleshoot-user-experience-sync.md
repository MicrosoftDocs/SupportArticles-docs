---
title: Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode
description: Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode
manager: dcscontentpm
ms.date: 10/29/2025
ms.topic: troubleshooting
ms.reviewer: japarker,satulim
ms.custom:
- pcy:Configuration and Management\Managing Devices with Intune
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---

# Troubleshoot User Experience Sync for Windows 365 Frontline in shared mode

This article provides troubleshooting steps for the most common issues related to User Experience Sync in Windows 365 Frontline shared mode environments.

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

#### Cloud Profile service error

The Cloud Profile service is responsible for creating and attaching individual user storage disks. During a service issue, failure, or outage, users may experience a temporary user experience. In these scenarios, open a support case so our support engineers can:

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

If user data or settings are accidentally deleted, follow these recovery steps.

### Open a support case

When user experience data is lost due to system issues or accidental deletion:

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

<!--## Common issues and solutions

### Issue: User experience fails to load from user storage

**Symptoms**: User receives a temporary profile despite having existing user storage.

**Solution**: Verify that the Cloud Profile disk is properly attached by running the following PowerShell command:

```powershell
Get-Volume
```

**Expected output**:

```powershell
DriveLetter FriendlyName                FileSystemType DriveType HealthStatus OperationalStatus SizeRemaining      Size
----------- ------------                -------------- --------- ------------ ----------------- -------------      ----
            Recovery                    NTFS           Fixed     Healthy      OK                    433.82 MB    450 MB
C           Windows                     NTFS           Fixed     Healthy      OK                     95.62 GB 127.45 GB
            Cloud Profile - [Username]  NTFS           Fixed     Healthy      OK                      3.89 GB   3.98 GB
```

If the Cloud Profile disk is missing:

1. Restart the Cloud PC
2. If the issue persists, check the Windows Event Logs for Cloud Profile service errors
3. Contact support if the disk consistently fails to attach

### Issue: Pooled user storage space exhausted

**Symptoms**:

- Users receive temporary profiles
- Storage tab shows **0 GB** available or **Exceeded** status

**Solutions**:

1. **Review and clean up unused user storage**:
   - Identify inactive users and delete their storage
   - Archive old user data before deletion
   
2. **Increase storage capacity**:
   - Add more Cloud PCs to the provisioning policy to increase total pooled storage
   - Consider upgrading to larger OS disk sizes for new Cloud PCs
   
3. **Monitor storage usage**:
   - Set up regular monitoring of the User Storage tab
   - Establish alerts when storage usage reaches 80% capacity

### Issue: Slow user experience loading

**Symptoms**: Extended sign-in times or sluggish profile loading.

**Solutions**:

1. **Check network connectivity** between the Cloud PC and Azure storage
2. **Review user storage size** - consider increasing individual storage limits
3. **Analyze Storage Sense configuration** to ensure it's not interfering during sign-in
4. **Monitor service health** in the Microsoft 365 service health dashboard
-->