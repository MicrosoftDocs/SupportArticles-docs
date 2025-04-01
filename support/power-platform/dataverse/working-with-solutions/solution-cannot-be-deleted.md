---
title: Solution cannot be deleted
description: Provides a solution to an error that occurs when you try to delete a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Solution cannot be deleted due to dependencies from other components in the system error occurs when deleting a solution in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to delete a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345785

## Symptoms

When attempting to delete a solution in Dynamics 365, you receive the following error:

> "Solution [solution name] cannot be deleted due to dependencies from other components in the system. Remove all dependencies to allow for solution deletion."

You may also see a reference to error code 8004f01d.

> [!NOTE]
> If the error dialog doesn't display any dependencies, check the [Solution History](/powerapps/maker/common-data-service/solution-history) which may contain additional error details.

## Cause

This error occurs if you try to delete a solution that is referenced by other components in your Dynamics 365 organization. A solution can't be removed until all dependencies on that solution have been removed.

## Resolution

The error dialog displays the list of dependencies that need to be removed before you can successfully delete the solution. Select the link in the **Required By** column to view the dependent component. Either delete the component if it's no longer needed or modify it to remove any references to the solution you're trying to delete.

## Examples

- **Unmanaged Customizations**

    If you import a solution and then add references to one or more of those components in the default solution, you need to remove those references to successfully delete the solution.

    > [!IMPORTANT]
    > After removing the reference, publish customizations for the changes to take effect.

    Below are a few common examples:

  - **Process (ex. Workflow)**

    If the solution you’re trying to delete includes a custom entity called Widget and you created a workflow process that references the Widget entity, either delete the workflow (if no longer needed) or update the workflow to remove the reference to the Widget entity. For example: If the workflow includes multiple steps and one of the steps creates or updates a Widget record, remove this step from the workflow and save your changes.

  - **Site Map (navigation)**

    If the solution you're trying to delete includes a custom entity called Widget and you modified your Site Map (navigation) to display this custom entity, you need to remove the reference to this entity from your Site Map before you can successfully delete the solution. If this reference was made in the Default Solution, follow these steps:

    1. Navigate to **Settings**, select **Customization**, and select **Customize the System**.
    2. Expand **Entities**.
    3. Locate and select the name of the custom entity.
    4. Remove any checkmarks from the **Areas that display this entity** section.
    5. Select **Save** and then select **Publish**.

        For information about modifying your Site Map, see [Change application navigation using the SiteMap](/dynamics365/customerengagement/on-premises/developer/customize-dev/change-application-navigation-using-sitemap).

  - **System Form**

    If the solution you're trying to delete added a custom field (ex. NewField) to the Contact entity and you modified one of the Contact forms to display this field, you need to remove the reference to this field from your form before you can successfully delete the solution.

  - **View**

    If the solution you're trying to delete added a custom field (ex. NewField) to the Contact entity and you modified one of the Contact views to display this field, you need to remove the reference to this field from the view before you can successfully delete the solution.

- **Parent/Child Solutions**

    It's possible for a solution to depend on other solutions. For example: Assume you installed an ISV package from Contoso that included multiple solutions. Solution A introduces a new custom entity called Widget, Solution B introduces other entities and some modifications to the Widget entity. Solution B is dependent on Solution A. If you try to delete Solution A before deleting Solution B, the solution will fail to be deleted because of the dependencies.
