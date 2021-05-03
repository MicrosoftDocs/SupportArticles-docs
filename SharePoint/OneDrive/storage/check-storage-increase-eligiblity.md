---
title: Check OneDrive site storage eligibility for storage beyond 5 TB
description: Check if a specific user's storage is eligible to be increased to greater than 5TB.
author: prbalusu
ms.author: v-matham
manager: dcscontentpm
localization_priority: Normal
ms.date: 02/01/2021
audience: Admin
ms.topic: article
ms.service: one-drive
ms.custom: 
- CSSTroubleshoot
- CI 136478
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online
- OneDrive for Business
---

# Check OneDrive site storage eligibility for storage beyond 5 TB

## Summary

If users fill their personal quota of 5 TB of OneDrive storage to at least 90 percent capacity, the site administrator can verify that a user’s OneDrive site storage is eligible for increased storage capacity beyond 5 TB without having to first contact Microsoft Support.  

**Note:** Users must contact their Microsoft 365 administrator to request a storage size increase.

Admins can request that Microsoft increase the default storage space up to 25 TB per user, although a lower per-user quota can be set at the admin’s discretion.

## More information

To verify that the storage level has reached at least 90 percent capacity, follow these steps:

1. Go to [https://admin.microsoft.com](https://admin.microsoft.com).

1. In the left pane, select **Support**, and then select **New Service Request**.
   
   **Note:** This enables the **Need Help?** pane on the right side of the screen.

1. In the **Briefly describe your issue** area, enter **OneDrive Storage limited to 5TB**, and then press Enter.

1. In the **Run diagnostic** section, type or paste the User Principle Name (UPN) for the user, and then select **Run Tests**.

:::image type="content" source="media/check-storage-increase-eligibility/storage-limited.png" alt-text="Need Help window says We understand you want to increase OneDrive storage beyond 5TB.":::

1. If the tests detect that OneDrive sites can be upgraded to exceed the 5 TB quota, you can enable the site to use more than 5 TB by selecting **Update Settings**.

:::image type="content" source="media/check-storage-increase-eligibility/not-configured.png" alt-text="Need Help window says Your tenant is not configured to increase a user's OneDrive quota beyond 5TB.":::

1. After OneDrive is set to be able to use more than 5 TB, you can set the storage space from the Microsoft Admin Center or SharePoint Online Management Shell. For more information, see [Change a specific user's OneDrive storage space](/onedrive/change-user-storage).  

> [!NOTE]  
> Users who reach at least 90 percent of their 25 TB capacity of OneDrive storage will be provided  additional cloud storage in the form of a 25 TB SharePoint team site. For more information and assistance, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=869559).

## References

For more information about the storage that’s available for Microsoft 365 subscriptions, see the [OneDrive service description](https://go.microsoft.com/fwlink/?linkid=826071).
