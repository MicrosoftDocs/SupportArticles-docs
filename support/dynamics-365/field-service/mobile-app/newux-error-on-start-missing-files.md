---
title: Error on start due to missing files in the solution
description: Helps resolve Dynamics 365 Field Service mobile app launch issues.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 11/15/2024
ms.custom: sap:Mobile application
---

# Error on start due to missing files in the solution

## Symptoms

An error occurs when starting the [new mobile app experience](/dynamics365/field-service/mobile/do-work-newux) stating that certain files are missing.

## Cause

Some required source records are missing. These records should be created when installing the solution, but in rare cases, they don't get created successfully or get corrupted. It is also possible that a user deleted the records.

## Resolution

### Step 1: Check if the mobilesource table contains data

1. Go to [Power Apps](https://make.powerapps.com/) and open the environment to check.

1. Select **Tables**, choose the **All** filter and search for the table `MobileSource (msdyn_mobilesource)`.

1. Select the table and verify if the table contains the following data in the **Name** column:

   - /card/bookingListViewItem.yml
   - /card/defaultViewItem.yml
   - /card/serviceTaskGridItem.yml
   - /sitemaps/mobile.yml

If there's no data in the table, something went wrong with the solution update.

### Step 2: Apply the Field Service solution update again

1. In [Power Apps](https://make.powerapps.com/), open your environment and go to **Solutions**.

1. Search for `fieldservice_anchor` and delete the `FieldService_Anchor` solution.

1. Go to [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments) and select the environment in which you deleted the solution.

1. In the environment details, under **Resources**, select **Dynamics 365 apps**.

1. Select **Install app**, choose **Dynamics 365 for Field Service**, and select **Next**.

1. Accept the terms of service and select **Install**.

After installing the solution, [verify that the table now contains the required data](#step-1-check-if-the-mobilesource-table-contains-data).
