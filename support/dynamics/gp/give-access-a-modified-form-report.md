---
title: Give access to a modified form or report
description: Describes how to give users access to the modified forms and reports in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/18/2024
---
# How to give users access to a modified form or to a modified report in Microsoft Dynamics GP

This article describes how to give users access to the modified forms and to the modified reports in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 942507

## Introduction

> [!NOTE]
> To give users access to the modified forms and to the modified reports, you have to log on as the sa user or as a user who has access to the Microsoft Dynamics GP security windows.

## Step 1: Grant security permissions to the DEFAULTUSER ID

> [!NOTE]
> The DEFAULTUSER ID is the default ID in the **Alternate/Modified Forms and Reports** window in Microsoft Dynamics GP.

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **Alternate/Modified Forms and Reports** window, select the **Lookup** button in the **ID** field.
3. In the **Alternate/Modified Forms and Reports Lookup** window, select **DEFAULTUSER**, and then select **Select**.
4. In the **Product** field, select the product to which you want to grant security permissions.
5. In the **Type** field, select the type.
6. In the **Alternate/Modified Forms and Reports List** area, expand the folder for which you want to modify the security permissions.
7. Depending on the product that you selected in step 4, use one of the following methods:

    - If you want to grant security permissions to a modified report, select **Microsoft Dynamics GP (Modified)**.
    - If you want to grant security permissions to a window, select the window that is associated with the product that you selected in step 4.

8. Select **Save**.
9. Close the **Alternate/Modified Forms and Reports** window.

### Step 2: Create a new ID, and then grant security permissions to the new ID

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. Use the appropriate method:

    - If you want to grant security permissions to an existing ID, select the ID that you want to grant security to in the **ID** field.
    - If you want to create a new ID, type the ID in the **ID** field, type a description in the **Description** field, and then select **Save**. Then, select the new ID in the **ID** field.
3. In the **Product** field, select the product to which you want to grant security permissions.
4. In the **Type** field, select the type.
5. In the **Alternate/Modified Forms and Reports List** area, expand the folder for which you want to modify the security permissions.
6. Use the appropriate method:
    - If you want to grant security permissions to a modified report, select **Microsoft Dynamics GP (Modified)**.
    - If you want to grant security permissions to a window, select the window that is associated with the product that you selected in step 3.
7. Select **Save**.
8. Close the **Alternate/Modified Forms and Reports** window.

## Step 3: Associate the modified forms and the modified reports with the new ID

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
2. In the User Security Setup window, enter information in the **User** field.
3. In the **Company** field, select the company.
4. In the **Alternate/Modified Forms and Reports ID** field, select the new ID.
5. Select **Save**.
6. Close the User Security Setup window.
