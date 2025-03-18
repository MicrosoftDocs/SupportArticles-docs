---
title: Cannot Uninstall Solution error when removing solutions
description: You may receive an error that states Cannot Uninstall Solution when you try to delete a solution in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# "Cannot Uninstall Solution" error occurs in Microsoft Dynamics 365

This article provides a resolution for the issue that you may receive an error **Cannot Uninstall Solution** when trying to remove a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4346631

## Symptoms

When attempting to delete a solution in Microsoft Dynamics 365, you encounter the following error:

> Cannot Uninstall Solution
>
> This solution cannot be uninstalled because the [Component Type] with id [Component Id](Solution A) is required by the [Solution B] solution. Uninstall the [Solution B] solution and try again

In the error message above, Solution A and Solution B are placeholder values. Solution A would be the name of the solution you are trying to delete. Solution B would be the name of a solution that depends on one or more components in the solution you are trying to delete.

If you select the **Download Log File** button, you see a reference to error code **-2147159995** or **-2147160032**.

## Cause

This error can occur if you have another managed solution that depends on one or more components in the managed solution you are trying to delete.

Example: Solution A includes a component such as a custom security role. You imported Solution A in your development environment. You created another solution (Solution B) in your development environment and as part of that solution you modify the security role introduced by Solution A. You then exported solution B as a managed solution. In your production environment, you imported Solution A and then Solution B. If you then try to delete Solution A, you will get this error because Solution B depends on a component in the solution you are trying to delete.

## Resolution

Scenario 1: Other solution is no longer needed

If the other solution mentioned in the error message is no longer needed, delete that solution first and then try again.

In the example in the Cause section, deleting Solution B would allow you to successfully delete Solution A.

Scenario 2: Other solution is needed

If the other solution mentioned in the error message is still needed and cannot be removed, the solution would need to be updated to remove the dependencies to the solution you are trying to delete. If you created this solution, you can follow the steps below to remove the dependency and deploy it as an upgrade. The steps below are the steps you would follow in the example scenario described in the Cause section.

1. In the source environment where Solution B was created, update Solution B to remove the reference to the custom security role:

    1. Access the source environment as a user with the System Administrator or System Customizer security role.
    2. Navigate to **Settings** and then select **Solutions**.
    3. Open the other solution mentioned in the error message (Solution B).
    4. In the **Version** field, increase the version number.
    5. On the left side of the page, locate the component and then remove it. In the example provided, you would select Security Roles, select the custom security role, and then select **Remove**.
    6. Select **Save** and then select **Publish All Customizations**.

2. Select **Export Solution** and choose to export the solution as **Managed**.
3. In the target environment (the organization where you encountered the error), import the updated solution (Solution B):

    1. Access the target environment as a user with the System Administrator or System Customizer security role.
    2. Navigate to **Settings** and then select **Solutions**.
    3. Select **Import** and browse to the updated solution file you exported.
    4. Select **Next**. You will see a notice that **This solution package contains an update for a solution that is already installed**.
    5. Select **Next** and select the **Stage for upgrade** checkbox.
    6. Select **Import**.
    7. After the import completes, select **Apply Solution Upgrade**.

       > [!NOTE]
       > If you closed the import dialog without selecting **Apply Solution Upgrade**, you can select the solution in the Solutions list and then select **Apply Solution Upgrade**.

4. Now that the dependency has been removed from Solution B, try to delete solution A again.
