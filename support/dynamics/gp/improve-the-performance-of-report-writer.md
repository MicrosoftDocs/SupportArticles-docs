---
title: Improve the performance of Report Writer
description: Describes how to improve the performance of a user-defined Report Writer function by setting the table to remain open when a report is being generated.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to improve the performance of user-defined Report Writer functions in Microsoft Dynamics GP 9.0 or in Microsoft Great Plains

This article describes how to improve the performance of user-defined Report Writer functions in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 920830

## Introduction

In Microsoft Dynamics GP, you can add the prefix "RW_" to a function to create a user-defined Report Writer function. However, when you use a user-defined Report Writer function in a report, you may experience a decrease in performance when you run the report. It decrease in performance is more likely to occur if the following conditions are true:

- The user-defined Report Writer function is used in the body of the report.
- The user-defined Report Writer function opens a table that isn't directly attached to the report.

A decrease in performance occurs because the table is opened and then closed for each record that is displayed in the body of the report. To improve the performance of the user-defined Report Writer function, set the table to be opened only one time. Then, set the table to remain open until the report has finished running. To do it, follow these steps:

## More information

1. In the same dictionary in which the function is located, create a form that has no windows. Attach the appropriate table or tables to this form. To attach a table to the form, use the **Options** command in the **Form Definition** window.

    > [!NOTE]
    > Make sure that each table is set to open during the Form Open operation.

2. Create a form procedure that is named **Close**, and then add the following script to this procedure.

    ```vb
    close form <form_name>
    ```

3. Add the following FORM_PRE script to this procedure.

    ```vb
    call background Close of form <form_name>
    ```

4. Add the following entries to the start of the function.

    ```vb
    if not isopen(form <form_name>) then
    open form <form_name> 
    end if
    ```

When you run the function, the following actions occur:

- The function opens the form. This form automatically closes when the report has finished running.
- The form opens the attached tables during the Form Open operation. These tables remain open when the form is being generated. So Dexterity in Microsoft Dynamics GP can access these tables more quickly.
- If the form closes before the report has finished running, the function automatically reopens the form.

> [!NOTE]
> In Microsoft Dynamics GP, reports run in the background on a First In First Out (FIFO) basis. So if a request for background processing is submitted when a report is running, this request isn't processed until the report has finished running.
