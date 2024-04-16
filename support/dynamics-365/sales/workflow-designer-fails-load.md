---
title: Workflow designer fails to load
description: Workflow designer fails to load after entity form customization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Selecting Set Properties in the Workflow designer fails after entity form customization

This article provides a solution to an issue where selecting **Set Properties** in the Workflow designer fails after entity form customization.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4523940

## Symptoms

After customizing the main form of a CDS entity that is used in a Workflow, selecting **Set Properties** on one of this entity's steps(for example, Create, Update and so on) results in the associated window failing to load.

## Cause

The Workflow designer applies the Dynamics form infrastructure to load the UI that is observed when working with entity steps. An example is a workflow that has an update step. When **Set Properties** is invoked, the form that loads is the default main form for that entity. If this main form has been customized and that customization results in an invalid form for any reason, it will result in this issue.

One thing to note is that as opposed to the form designer that displays only the fields that are present on the form, the Workflow designer loads an entity form in its entirety with all of the fields present.

## Resolution

There are a few workarounds listed below to unblock this scenario:

1. If the form customization is known(for example, an IFrame control on the entity's main form that points to an invalid URL), fixing it and then saving and publishing the form will rectify the problem.
2. Removing the customization from the form if not required is another option.
3. If the exact customization is unknown, the following approach should help you.
   - Create a new main form for the relevant entity(for example, if the Workflow is on the Account entity, which would be a new main form for Account).
   - Remove all fields from this new main form except any required fields and set it as the default main form.
   - The Workflow designer should now load the **Set Properties** window successfully.
   - At this point, you can add back the fields you require to the form one at a time to try and identify which field might be causing this error.
