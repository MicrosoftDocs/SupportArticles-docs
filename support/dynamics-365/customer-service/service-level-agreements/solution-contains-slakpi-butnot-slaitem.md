---
title: A managed solution cannot overwrite the SLAItem component
description: Provides a resolution for the issue that occurs when importing a solution that only contains SLA KPIs and no SLA item referring to it.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/09/2023
---
# "A managed solution cannot overwrite the SLAItem component" error

This article provides a resolution for the issue that occurs when you try to import a solution that only has service-level agreement (SLA) KPIs and no SLA item referring to it.

## Symptoms

When you try to import an SLA solution, you might receive the following error message: 

> A managed solution cannot overwrite the SLAItem component '\<slaitem>' with Id=\<slaid> which has an unmanaged base instance.

## Cause

This issue occurs when the import solution only contains SLA KPIs and no SLA item referring to it.

## Resolution

To solve this issue, unzip the managed solution used to upgrade.

Open the *Customizations.xml* file, search for `<msdyn_slakpis>`, and remove all the complete nodes till `</msdyn_slakpis>`. Save and zip all the folders within the unzipped folder. This action creates a new folder and try to import the solution.