---
title: OneDrive site is read-only because storage quota was exceeded
description: Discusses errors that you experience when your OneDrive site is set to read-only status and provides resolution options for administrators.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OneDrive for Business\OneDrive Site\Quota/Storage
  - CI 11802
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - OneDrive for work or school
  - SharePoint Online
search.appverid: MET150
ms.date: 05/27/2026
---

# OneDrive site is read-only because storage quota was exceeded

> [!NOTE]
> This article applies to an individual user's OneDrive for work or school storage quota. It's separate from an organization-wide SharePoint storage pool issue. If the tenant storage pool is exhausted, admins should troubleshoot tenant storage separately in the SharePoint admin center. For more information, see [SharePoint Online out of storage space](../../administration/out-of-storage.md).

## Summary

This article helps administrators resolve the issue where a user's OneDrive site is placed into a **read-only state** after exceeding its storage quota. Affected users see messages on the site such as `This site has exceeded its maximum file storage limit` or `Unable to create new file. Site quota is full.` and can't upload or modify files until the storage issue is resolved.

## Symptoms

When a user exceeds their storage quota, the user’s OneDrive site is placed into a **read-only** state. Users and admins may observe one or more of the following symptoms:

- A banner or warning message on the OneDrive site states `This site has exceeded its maximum file storage limit. To free up space, delete files you don’t need and empty the recycle bin.`
- Attempts to upload or add new files to OneDrive fail, with an error such as `Unable to create new file. Site quota is full.`
- The OneDrive interface indicates the user is over their storage allotment, for example showing `You’ve exceeded your storage by 2 GB.` in the storage settings or notifications.

In this state, the user can't add new content or modify existing files on their OneDrive. The site is locked to being **read-only** until the storage issue is resolved.

## Cause

OneDrive enforces per-user storage quotas based on each user’s license entitlements. If a user’s OneDrive usage goes beyond the amount of storage included with their Microsoft 365 license, the system automatically restricts the OneDrive site to read-only mode. This behavior ensures that user storage remains aligned with the licensed quota.

This can occur when:

- The user’s OneDrive content exceeds the quota currently applied to the user.  
- The user’s OneDrive quota was previously set higher than the user’s licensed entitlement.  
- The user’s license was changed to a plan with a lower OneDrive storage entitlement.  
- The tenant default OneDrive storage setting was reduced, and the user’s OneDrive usage is now above the new limit.  

When the effective OneDrive storage limit is lower than the user’s current storage usage, the OneDrive site becomes read-only until the quota or usage issue is resolved.  

## Resolution

To restore write access, a Microsoft 365 administrator must bring the user’s OneDrive storage usage below the effective quota for that user, or increase the user’s available OneDrive storage if the user’s license allows it.  

1. Review the user’s OneDrive storage usage and quota.

   In the **Microsoft 365 admin center**, go to:

  **Users** > **Active users** > select the affected user > **OneDrive** tab.

Review the user’s current storage usage and configured storage limit. Admins can also review a specific user’s OneDrive storage by using the SharePoint admin center or SharePoint Online PowerShell.

1. Increase the OneDrive quota, if the license supports it.

If the [user’s license supports additional OneDrive storage](/office365/servicedescriptions/onedrive-for-business-service-description#storage-limits), increase the user’s OneDrive storage limit.

In the **Microsoft 365 admin center**, go to:

**Users** > **Active users** > select the user > **OneDrive** tab > **Storage used** > **Edit**.

```powershell
Set-SPOSite -Identity <OneDriveSiteUrl> ` 
  -StorageQuota <QuotaInMB> ` 
  -StorageQuotaWarningLevel <WarningLevelInMB> 
```

For detailed steps and quota values, see [Change a specific user’s OneDrive storage space](/sharepoint/change-user-storage).  

1. Assign a license with more OneDrive storage, if needed.

If the user’s current license doesn't support the required OneDrive storage amount, assign a license that includes the needed storage entitlement. Then update the user’s OneDrive quota as needed.

For detailed licensing steps, see [Assign or unassign licenses for users in the Microsoft 365 admin center](/microsoft-365/admin/manage/assign-licenses-to-users).  

1. Reduce the user’s OneDrive storage usage.

If the user’s quota can't be increased, the user must reduce their OneDrive storage usage below the current quota.

Have the user delete or move unnecessary files, and then empty the OneDrive recycle bin to reclaim storage. Deleted files might continue to count against storage until they're permanently removed from the recycle bin.

1. Verify access

After the quota is increased or storage usage is reduced, allow time for SharePoint Online to reevaluate the OneDrive site. Then confirm that the user can upload and edit files again.
