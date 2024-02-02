---
title: Import of solution fails due to missing components
description: Import of solution fails due to missing components. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Import of solution fails due to missing components

This article provides a resolution for **The import of the solution [solution name] failed** error that may occur when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4346030

## Symptoms

When attempting to import a solution in Microsoft Dynamics 365, the import fails with the following message:

> The import of the solution [solution name] failed. The following components are missing in your system and are not included in the solution. Import the managed solutions that contain these components ([name of missing solution] ([solution version])) and then try importing the solution again.

You may also see a reference to error code **8004801d**.

## Cause

This error occurs if you are trying to import a solution that depends on other components that are not in your Microsoft Dynamics 365 organization.

Example: You have a development environment where you created a solution (Solution A) that contains a custom entity (Widget). You created another solution (Solution B) that depends on a component in Solution A (ex. added a new field to the Widget entity). If you try to import Solution B into another organization (for example, your production organization) that does not already have Solution A installed, you would encounter this error.

## Resolution

Review the missing component details shown in the import dialog. If there are other solutions listed that are not already imported in the organization where you are trying to import this solution, import those solutions first before trying to import this solution.

Example: Continuing with the example from the Cause section above, you might see that the list of missing components shows one or more rows where the Managed Solution column references Solution A. This indicates you would need to import the mentioned version of Solution A before you will be able to successfully import Solution B.

## More information

If the error message refers to a Microsoft solution, refer to the following list of solutions and where they can be found if they are not installed in the target organization:

[LinkedIn Sales Navigator for Dynamics 365](https://appsource.microsoft.com/product/dynamics-365/mscrm.5ba43194-adc5-4c13-b40d-af04f549d5da)

Solution names:

- LinkedInSalesNavigatorControlsForUnifiedClient
- LinkedIn
- msdyn_LinkedInSalesNavigatorAnchor

  > [!NOTE]
  > If you want to uninstall these solutions, they need to be uninstalled in the order of the above list.
