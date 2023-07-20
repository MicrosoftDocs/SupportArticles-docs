---
title: You cannot delete this form because it is the only fallback form
description: Describes an issue where the message You cannot delete this form because it is the only fallback form of type main is displayed during solution upgrade or uninstall.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 06/18/2021
author: nhelgren
ms.author: nhelgren
---
# You cannot delete this form because it is the only fallback form

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

You receive this message during solution upgrade or uninstall. 
   Microsoft.Crm.CrmException: You cannot delete this form because it is the only fallback form of type main for the 'table' table. Each table must have at least one fallback form for each form type

## Cause

This error occurs when a solution upgrade or uninstall attempts to delete the last remaining form for a table. This behavior is by design. Each table must be able to display a form for any valid user. Therefore, at least one form must be designated as a fallback form. A fallback form is available to users whose security roles do not have any forms explicitly assigned to them.

## Workaround

To work around this issue, create a temporary form configured as the fallback form for the table, and then try the upgrade or uninstall again. More information: [Set the fallback form for a table](/power-apps/maker/model-driven-apps/control-access-forms#set-the-fallback-form-for-a-table)