---
title: You cannot delete this form because it is the only fallback form
description: Provides a workaround for the error - You cannot delete this form because it is the only fallback form of type main that occurs during solution upgrade or uninstallation.
ms.reviewer: matp
ms.date: 07/26/2023
author: nhelgren
ms.author: nhelgren
---
# "You cannot delete this form because it is the only fallback form" error when updating or uninstalling a solution 

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

You receive the following error message when updating or uninstalling a solution:

> Microsoft.Crm.CrmException: You cannot delete this form because it is the only fallback form of type main for the 'table' table. Each table must have at least one fallback form for each form type

## Cause

This error occurs when a solution upgrade or uninstallation tries to delete the last remaining form for a table. This behavior is by design. Each table must be able to display a form for a valid user. Therefore, at least one form must be designated as a fallback form that can be used by users whose security roles aren't explicitly assigned any forms.

## Workaround

To work around this issue, create a temporary form configured as the fallback form for the table, and then try to upgrade or uninstall again. For more information, see [Set the fallback form for a table](/power-apps/maker/model-driven-apps/control-access-forms#set-the-fallback-form-for-a-table).
