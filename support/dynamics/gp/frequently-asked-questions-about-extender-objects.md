---
title: Frequently asked questions about the Extender objects
description: Provides information about the frequently asked questions about the Extender objects in Microsoft Dynamics GP.
ms.reviewer: kvogel
ms.date: 04/22/2021
---
# Frequently asked questions about the Extender objects in Microsoft Dynamics GP

This article contains answers to frequently asked questions about the Extender objects in Microsoft Dynamics GP. Additionally, this article describes how the Extender objects can be used.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937244

**Q1:** What is the Inquiries object?

**A1:** The Inquiries object lets you view Extender data that you enter in a different Microsoft Dynamics GP window. For example, if you create an Extender window in the Item Maintenance window, you can create an Extender Inquiries window to view the data for an item in the Sales Transaction Entry window.

**Q2:** What is the Lookups object? How is the Lookups object used?

**A2:** The Lookups object lets you create a custom lookup that is used in an Extender window when you set a field type to **Lookup**. When you select the expansion button for that field, you can select the custom lookup, or you can select a lookup from the predefined list.

**Q3:** What is the Extender Macros object? How is the Extender Macros object different from a Microsoft Dynamics GP macro?

**A3:** An Extender Macros object is a shortcut that you can use to run a Microsoft Dynamics GP macro. You still have to record the macro in Microsoft Dynamics GP. But the Extender Macros object runs the macro. If you do not use an Extender Macros object, you have to use the following step to run a macro:

- On the **Tools** menu, select **Macro**, and then select **Play**.

When you use an Extender Macros object, you can use one of the following options:

- Create a keyboard shortcut that you can use to run the macro.
- Configure the macro to run when a window is opened.
- Configure the macro to run when you enter a field or when you exit a field.

**Q4:** What is the Notes object? How is the Notes object different from Microsoft Dynamics GP notes?

**A4:** The Extender Notes object lets you add multiple notes. Microsoft Dynamics GP notes lets you add only one note. When you add Extender Notes, each note has a date/time stamp.

> [!NOTE]
> Microsoft Dynamics GP notes can be added to a report. However, Extender Notes cannot be added to a report.

**Q5:** What is the Notes Inquiries object?

**A5:** The Notes Inquiries object resembles the Inquiries object. The Notes Inquiries object lets you view Extender Notes that you create in a different Microsoft Dynamics GP window. For example, if you create an Extender Notes object in the Customer Maintenance window, you can create an Extender Note Inquiries window to view those notes in the Sales Transaction Entry window for the customer.

**Q6:** What is the Views object?

**A6:** An Extender Views object lets you create a combined view that contains Microsoft Dynamics GP tables and Extender windows. For more information about how to create an Extender Views object, see [How to create a Microsoft Great Plains Extender view](https://support.microsoft.com/topic/how-to-create-a-microsoft-great-plains-extender-view-d570cf89-3d26-9c1b-b3b2-46fd9d0975b1).
