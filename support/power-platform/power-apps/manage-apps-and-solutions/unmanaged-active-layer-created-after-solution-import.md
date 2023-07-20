---
title: There's an active unmanaged layer created after importing a managed solution
description: Describes an issue where there's an active unmanaged layer created after importing a managed solution.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 06/18/2021
author: nhelgren
ms.author: nhelgren
---
# There's an active unmanaged layer created after importing a managed solution

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

After importing a managed solution, there's an active unmanaged layer created.

## Cause

During solution import the system must ensure that there is a fallback form for a table. This requirement is enforced when you create tables or forms. If during import there isn't a fallback form specified for a table, then the import creates an unmanaged active layer for one of the main forms and the unmanaged customization indicates the form as the fallback form. This ensures that users can view a form when they don’t have access to any of the other table forms.

## Workaround

To work around this behavior, make sure there's a fallback form for the table before you export the unmanaged solution as managed for import. More information: [Set the fallback form for a table](/power-apps/maker/model-driven-apps/control-access-forms#set-the-fallback-form-for-a-table)