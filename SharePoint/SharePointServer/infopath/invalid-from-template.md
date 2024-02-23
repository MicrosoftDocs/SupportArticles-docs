---
title: (Invalid form template) error when running design checker on a form
description: Describes the issue in which you receive an error message when you add a combo box control or a drop-down list box control to a form InfoPath Designer 2010. Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Foundation 2010
  - SharePoint Server 2010
  - InfoPath Designer 2010
ms.reviewer: jbooze, fselkirk
ms.date: 12/17/2023
---
# (Invalid form template) error message when you run the InfoPath Designer 2010 design checker on a form

_Original KB number:_ &nbsp; 982250

## Symptoms

Consider the following scenario in Microsoft InfoPath Designer 2010:

- You create a new form.
- You add a data connection to a data source.
- You add a combo box control or a drop-down list box control.
- The control is bound to the data connection.
- You add a new view to the form.
- You remove the data connection.
- You run the form through the InfoPath Designer 2010 design checker against a Microsoft SharePoint Server 2010 or a Microsoft SharePoint Foundation 2010 site.

In this scenario, you receive the following error message:

> Invalid form template.

## Workaround

To work around this issue, do one of the following:

- In the combo box control or in the drop-down list box control, remove the binding to the data connection.
- Remove the combo box control or the drop-down List box control from the form.
