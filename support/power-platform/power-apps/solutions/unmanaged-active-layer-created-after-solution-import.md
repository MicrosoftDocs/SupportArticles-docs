---
title: An active unmanaged layer is created after importing a managed solution
description: Provides a workaround for an issue where an active unmanaged layer is created after importing a managed solution.
ms.reviewer: matp
ms.date: 07/26/2023
author: nhelgren
ms.author: nhelgren
---
# An active unmanaged layer is created after you import a managed solution

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

After you import a managed solution, an active unmanaged layer is created.

## Cause

During solution import, the system must ensure that there's a fallback form for a table. This requirement is enforced when you create tables or forms. If no fallback form is specified for a table during import, the system creates an unmanaged active layer for one of the main forms, and the unmanaged customization indicates the form as the fallback form. This ensures that users can view a form when they don't have access to any other table forms.

## Workaround

To work around this issue, make sure that the table has a fallback form before you export the unmanaged solution as managed for import. For more information, see [Set the fallback form for a table](/power-apps/maker/model-driven-apps/control-access-forms#set-the-fallback-form-for-a-table).
