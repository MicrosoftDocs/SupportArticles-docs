---
title: Import failing because of insufficient permissions
description: Provides a way to add permissions to the Demand planning app user.
author: fistamos
ms.date: 02/29/2024
ms.topic: troubleshooting
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---

# Import failing because of insufficient permissions

## Symptoms

The **Dynamics 365 Finance and Operations job execution** contains an error mentioning an **Export failed due to insufficient field access right for the following fields:**.

## Resolution

To allow data to be read from custom entities, you must configure their security settings in **Dynamics 365 Supply Chain Management**. To do so, follow these steps:

1. Go to **System Administration** > **Security** > **Security Configuration**.
2. Open the **Privileges** tab.
3. Select **Create new** from the toolbar.
4. In the dialog, add a Name for your new privilege, and then select OK.
5. Your new privilege is added to the list and selected. In the middle column, select **Entities**.
6. On the toolbar, select **Add references**.
7. In the dialog, find and select your custom entity. Select the access properties you want to grant and then select OK.
8. In the middle column, select **Duties**.
9. On the toolbar, select **Add references**.
10. In the dialog, find and select the duty named **View Document** entity data for data management or **Create data management** project and details using entity. Choose the duty based on the level of access you require.
-    **View Document** entity data for data management is commonly associated with entities used in the **Data Management Framework** in **Supply Chain Management**. It's typically assigned to the role **Data management migration user**, which is a subordinate role to **Demand planning app role**.
-    Create data management project and details using entity is part of the Demand planning app role role. Demand planning app role is assigned to **DemandPlanAppUser**, which is a user role often employed for integrating the **Demand planning service** with **Supply Chain Management**.
11. Select OK to add the selected duty to your new privilege.
12. Open the **Unpublished** objects tab. On the toolbar, select **Publish all**.
