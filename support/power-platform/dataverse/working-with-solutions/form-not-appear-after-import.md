---
title: Form doesn't show in target environment after importing an unmanaged solution
description: Provides a workaround for an issue where a form doesn't appear in the target environment after importing an unmanaged solution.
ms.reviewer: matp
ms.date: 04/17/2025
author: Mattp123
ms.author: nhelgren
ms.custom: sap:Working with Solutions\Solution import - Changes don't take effect
---
# A form doesn't appear in the target environment after importing an unmanaged solution

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

After you import an unmanaged solution, a form included in the solution doesn't appear in the target environment.

## Cause

During the export of unmanaged solutions, some forms that haven't been modified are exported with the attribute `unmodified`=*1* in the `FormXml` node of the *customizations.xml* file located in the solution package. This attribute ensures that the form will be omitted from the import when the same solution is imported into a new environment, even though these forms are part of the solution being exported.

## Workaround

To avoid this issue, the form must have active customizations to be exported without the `unmodified`=*1* attribute. To verify this, extract the exported solution package, search for the `FormXml` node in question within the *customizations.xml* file, and check if the `unmodified` attribute is present.
