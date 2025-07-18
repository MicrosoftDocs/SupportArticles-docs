---
title: Hide the drop-down arrow on a combo box
description: Describes the detailed steps to hide the drop-down arrow on a combo box until the combo box is selected.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# How to hide the combo box drop-down arrow on a form in Access

_Original KB number:_ &nbsp; 325233

> [!NOTE]
> Requires knowledge of the user interface on single-user computers.This article applies to a Microsoft Access database (.mdb and .accdb) and to a Microsoft Access project (.adp).

This article demonstrates a method that you can use to hide the drop-down arrow on a combo box until the combo box is selected.

## Steps to hide the drop-down arrow on a combo box

To hide the drop-down arrow on a combo box when the combo box is not selected, follow these steps:

1. Start Access.
2. On the **Help** menu, point to **Sample Databases**, and then click **Northwind Sample Access Database**.
3. Open the Orders form in **Design** view.
4. Add a rectangle control to the form. Size and move the rectangle control so that it completely covers the drop-down arrow on the EmployeeID combo box.
5. Set the `BackColor` property of the rectangle to match the `BackColor` property of the section.
6. Set the `BackStyle` property to **Normal**.
7. Set the `BorderStyle` to **Transparent**.
8. View the form in **Form** view.

Notice that you can see the drop-down arrow on the EmployeeID combo box only when the combo box is selected.

## References

For more information about BackColor, BackStyle, or BorderStyle properties, click **Microsoft Access Help** on the **Help**menu, type BackColor, BackStyle, BorderStyle, or Windows color scheme in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.
