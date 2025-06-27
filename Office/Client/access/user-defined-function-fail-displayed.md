---
title: Database's user-defined function isn't displayed
description: Provides a workaround for an issue in which the Expression Builder doesn't display a database's user-defined functions in the Functions node of Expression Elements.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: wouterst, tputt, jenl
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# Expression Builder doesn't display database's user-defined functions in the Functions node

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

To work around this issue, you can [trust the database](https://support.microsoft.com/office/828ce4e9-1f38-4f4b-89c4-81bb0fcda8a4#__toc330299901) and stop Disabled mode as follows:

- Use the Message Bar: Select **Enable Content** on the Message Bar. When you choose this option, you may need to repeat the procedure if the database changes. 
- Trust the database permanently: Place the database in a trusted location (a folder on a drive or network that you mark as trusted). When you choose this option, you no longer see the Message Bar, and you never have to enable the database content as long as the database remains in the trusted location.
