---
title: Database's user-defined function isn't displayed
description: Provides a workaround for an issue in which the Expression Builder doesn't display a database's user-defined functions in the Functions node of Expression Elements.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- CI 114797
- CSSTroubleshoot
ms.reviewer: wouterst, tputt, jenl
appliesto:
- Access 365
- Access 2019
- Access 2016
- Access 2013
- Access 2010
- Access 2007
search.appverid: MET150
---
# Expression Builder doesn't display database's user-defined functions in the Functions node

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

This article provides a workaround for an issue in which the Expression Builder doesn't display a database's user-defined functions in the Functions node of Expression Elements.

_Original KB number:_ &nbsp; 981241

## Symptoms

Consider the following scenario:

- You open a Microsoft Access database in Disabled mode.
- You open the Expression Builder in a context that enables user-defined functions.
- In the Expression Builder's **Expression Elements** tree view, you expand the **Functions** node.

In this scenario, the database's Microsoft Visual Basic for Applications (VBA) project is not listed under the **Functions** node.

## Cause

This is by design. This issue occurs because, when the database is opened in Disabled mode, VBA cannot enumerate any of the arguments that are defined for user-defined functions. To enumerate these arguments, VBA must be able to compile the type libraries of the modules that contain the user-defined functions. When the database is in Disabled mode, VBA cannot compile these modules. Therefore, the Expression Builder cannot display the user-defined functions for the database.

## Workaround

To work around this issue, you must open the database in Enabled mode.
