---
title: Field Service Mobile App Can't Start Due to Missing Files
description: Resolves Dynamics 365 Field Service mobile app launch issues due to missing source records.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 12/12/2024
ms.custom: sap:Mobile application\Application is throwing errors
---
# The Field Service mobile app fails to start due to missing files

This article provides a resolution for an issue where the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview) fails to start.

## Symptoms

When you start using the [new user experience in the Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/do-work-newux), you receive an error message stating that certain files are missing.

## Cause

Some required source records are missing. These records should be created when installing the Field Service app, but in rare cases, they aren't created successfully or are corrupted. It's also possible that a user deleted the records.

## Resolution

### Step 1: Check if the MobileSource table contains data

1. Go to [Power Apps](https://make.powerapps.com/) and open the environment you want to check.

1. Select **Tables**, select the **All** filter, and search for the `MobileSource` (`msdyn_mobilesource`) table.

1. Select the table and verify if it contains the following data in the **Name** column:

   - **/card/bookingListViewItem.yml**
   - **/card/defaultViewItem.yml**
   - **/card/serviceTaskGridItem.yml**
   - **/sitemaps/mobile.yml**

If there's no data in the table, something went wrong with the solution update.

### Step 2: Apply the Field Service solution update again

1. In [Power Apps](https://make.powerapps.com/), open your environment and go to **Solutions**.

1. Search for `fieldservice_anchor` and delete the `FieldService_Anchor` solution.

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments) and select the environment where you deleted the solution.

1. In the environment details, under **Resources**, select **Dynamics 365 apps**.

1. Select **Install app** > **Dynamics 365 for Field Service** > **Next**.

1. Accept the terms of service and select **Install**.

After you install the solution, verify that the table contains the required data using step 1.
