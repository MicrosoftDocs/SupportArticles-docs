---
title: The record could not be deleted
description: Provides a solution to an error that occurs when attempting to delete a solution in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# "The record could not be deleted because of an association" error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when attempting to delete a solution in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4459159

## Symptoms

When attempting to delete a solution in Dynamics 365, you receive the following error:

> "The record could not be deleted because of an association
The record cannot be deleted because it is associated with another record."

## Cause

This error can occur if you're trying to delete a solution that contains a component that is still used by another component.

Example: If the solution includes an image web resource and that image is used by a Theme, you would meet this error when trying to delete that solution.

## Resolution

Before attempting to delete the solution, remove any references from the included components to components in other solutions.

In the example from the [Cause](#cause) section, you would need to follow these steps:

1. Access the Dynamics 365 web application as a user with the System Administrator or System Customizer security role.
2. Navigate to **Settings**, **Customizations**, and **Themes**.
3. Open the theme that uses the image web resource as the logo.
4. Use the **Logo** lookup field to remove the reference to the image web resource that is part of the solution you're trying to delete and save the changes.
5. Try to delete the solution again.
