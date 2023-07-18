---
title: Form doesn't appear in target environment after import
description: Describes an issue where The form doesn't appear in target environment after importing the unmanaged solution.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 06/18/2021
author: Mattp123
ms.author: nhelgren
---
# Form doesn't appear in target environment after import

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

After importing the unmanaged solution, a form included in the solution doesn't appear in target environment.

## Cause

During export of unmanaged solutions, some forms that aren't modified get exported with the attribute unmodified=1 in the form XML of the customizations.xml file located in the solution package. This attribute is located in the `FormXml` node in the customization.xml file within the solution package. This attribute ensures that, even though these forms are part of the solution being exported, when the same solution is imported in a new environment the form will be omitted from the import.

## Workaround

To avoid this scenario, the form must have active customizations for it to be exported without the unmodified=1 attribute. To verify this, extract the exported solution package and search the customizations.xml file for the `FormXml` node in question and verify the unmodified attribute.
