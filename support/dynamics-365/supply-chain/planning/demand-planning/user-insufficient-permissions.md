---
title: Import profile job fails due to insufficient rights
description: Provides a resolution for the insufficient field access right error when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/15/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
ms.custom: sap:Master planning\Issues with demand planning
---
# An import profile job fails due to insufficient permissions

This article provides a resolution for the "insufficient field access right" error that occurs when an [import profile job](/dynamics365/supply-chain/demand-planning/import-data#create-an-import-profile-for-importing-directly-from-supply-chain-management) fails in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

The Dynamics 365 Finance and Operations import profile job fails, and the job execution details contain an error mentioning "Export failed due to insufficient field access right for the following fields."

## Resolution

To allow data to be read from custom entities, you must configure their security settings in Dynamics 365 Supply Chain Management. To do so, follow these steps:

1. Go to **System Administration** > **Security** > **Security Configuration**.
2. Open the **Privileges** tab.
3. Select **Create new** from the toolbar.
4. In the dialog, add a name for your new privilege, and then select **OK**.
5. Your new privilege is added to the list and selected. In the middle column, select **Entities**.
6. On the toolbar, select **Add references**.
7. In the dialog, find and select your custom entity. Select the access properties you want to grant and select **OK**.
8. In the middle column, select **Duties**.
9. On the toolbar, select **Add references**.

10. In the dialog, find and select the duty named **View Document entity data for data management** or **Create data management project and details using entity**. Choose the duty based on the level of access you require.

    - The **View Document entity data for data management** duty is commonly associated with entities used in the Data Management Framework in Supply Chain Management. It's typically assigned to the **Data management migration user** role, which is a subordinate role to the **Demand planning app role**.
    - The **Create data management project and details using entity** duty is part of the **Demand planning app role**. The **Demand planning app role** is assigned to **DemandPlanAppUser**, which is a user role often used to integrate the Demand planning service with Supply Chain Management.

11. Select **OK** to add the selected duty to your new privilege.
12. Open the **Unpublished** object tab. On the toolbar, select **Publish all**.

## More information

- [Demand planning import profile troubleshooting guide](import-landing-page.md)
- [Import profile job fails with a "Timeout" error](project-time-out.md)
- [Import profile job fails due to special characters](special-characters.md)
- [Import profile job fails with a "Forbidden" error]( import-profile-fails-with-forbidden-error.md)
- [Import data into Demand planning](/dynamics365/supply-chain/demand-planning/import-data)
- [Security roles and row-level security in Demand planning](/dynamics365/supply-chain/demand-planning/users-access)
