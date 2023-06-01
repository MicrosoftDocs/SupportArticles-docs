---
title: A managed solution cannot overwrite the SLAItem component.
description: Provides a resolution for the issue where importing solution contains only slakpis and no slaitem referring to it.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/01/2023
---
# A managed solution cannot overwrite the SLAItem component

This article provides a resolution for the issue where importing solution contains only slakpis and no slaitem referring to it.

## Symptoms

While attempting to import the SLA solution, sometimes we may get following error message: A managed solution cannot overwrite the SLAItem component '<slaitem>' with Id=<slaid> which has an unmanaged base instance.

## Cause

This issue happens when the import solution contains only slakpis and not the slaitem referring to it.

## Resolution

Method-1:
Modifying the customizations.xml - Unzip the managed solution used to upgrade. 
Open Customizations.xml -> Search for <msdyn_slakpis>, remove all the complete node till </msdyn_slakpis>. Save and zip all the folders within the unzipped folder. This will create a new folder and try to import the solution.

Method-2:
Add SLAs to the solution - On the source org readd all the slas if readd all the slas to the solution.