---
title: Check OneDrive site eligibility for increased storage
description: Check if your storage is eligible to be increased to greater than 5 TB.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
ms.date: 11/04/2024
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 136478
  - CI 148890
  - CI 149065
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
  - OneDrive for Business
---

# Check OneDrive site eligibility for increased storage

If you need more Microsoft OneDrive storage than the default 5 TB, contact a Microsoft 365 administrator in your organization to check whether you're eligible for an increased storage limit. You must already have filled 90% of the 5 TB storage before the administrator can request to increase the limit for you.  

Admins can request Microsoft to increase the default storage space up to 25 TB per user, although a lower per-user quota can be set at their discretion. They can use the following steps to run a diagnostic to verify a user's eligibility and then request the increase.

> [!NOTE]
> This diagnostic isn't available for the GCC High and DoD environments, Microsoft 365 operated by 21Vianet, and Microsoft Education customers.

1. Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 admin center.

    > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Storage Limited to 5TB](https://aka.ms/PillarOneDriveStorageLimited)

1. In the **Run diagnostics** section, type or paste the User Principle Name (UPN) of the user whose OneDrive storage limit needs to be increased, and then select **Run Tests**.

    :::image type="content" source="media/check-storage-increase-eligibility/storage-limited.png" alt-text="Screenshot of the Need Help window says we understand you want to increase OneDrive storage beyond 5 TB.":::

1. If the tests detect that the user's OneDrive site can be upgraded to exceed the 5 TB quota, select **Update Settings** for the diagnostic to process the increase.

    :::image type="content" source="media/check-storage-increase-eligibility/not-configured.png" alt-text="Screenshot of the Need Help window says your tenant is not configured to increase a user's OneDrive quota beyond 5 TB.":::

1. After the user's OneDrive storage limit is increased, you can [set a different limit for the user's storage space](/onedrive/change-user-storage) from the Microsoft 365 admin center or SharePoint Online Management Shell.

> [!NOTE]  
> - Users who reach at least 90 percent of their 25 TB capacity of OneDrive storage will be provided additional cloud storage in the form of a 25 TB SharePoint team site. For more information and assistance, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=869559).
> - The maximum amount of OneDrive storage provided to any single Education user with OneDrive for Business Plan 2 is 25 TB. Pooled storage limits still apply at the tenant level.

## References

For more information about the storage that’s available for Microsoft 365 subscriptions, see the [OneDrive service description](https://go.microsoft.com/fwlink/?linkid=826071).
