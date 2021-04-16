---
title: Solution update fails with an error 
description: This article provides two resolutions for the problem that occurs when you install an update to a solution when the installed solution has same ID value for multiple LocLabels.
ms.reviewer: kenakamu, chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Solution update fails with an error "Found more than one RibbonDiff entity"

This article helps you resolve the problem that occurs when you install an update to a solution when the installed solution has same ID value for multiple LocLabels.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2503029

## Symptoms

Solution update fails with an error **Found more than one RibbonDiff entity**, when the installed solution has the same ID value for multiple LocLabels.

## Cause

During the import of an updated solution, CRM tries to find the LocLabel node to update with the new customization. When there are multiple LocLabel nodes with same ID, CRM doesn't identify which one to update, and fails.

## Resolution

- Resolution 1

  Update the customization.xml file to have an empty RibbonDiff or one that doesn't have the LocLabel ID. Once updated, you are able to install the correct Solution again that would have the Ribbon customizations.

- Resolution 2

  If the solution is managed, you are able to uninstall the solution to delete the existing Ribbon definition. Then reimport the managed solution with correct Ribbon.

  > [!NOTE]
  > Uninstalling a managed solution will delete any entities, fields, ect that the solution installed which would include the data in those areas as well.
