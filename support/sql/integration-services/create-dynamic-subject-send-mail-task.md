---
title: Create a dynamic subject for the Send Mail task
description: This article discusses how to update the property of an SSIS object at runtime by creating a property expression. Provides some examples to demonstrate this feature.
ms.date: 09/02/2020
ms.custom: sap:Integration Services
ms.reviewer: Craigg, willchen
---
# Create a dynamic subject or message for the Send Mail task in SQL Server Integration Services

This article shows how to update the property of a SQL Server Integration Services (SSIS) object at runtime by creating a property expression.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 906547

## Introduction

You can create an SSIS package by using SQL Server Business Intelligence Development Studio. When you create this package, you can create an expression for a property of the SSIS package to update or to populate the property at runtime. For example, if the SSIS package contains a Send Mail task, you can create an expression for the Subject property and for the `MessageSource` property. You can use the Subject property expression to dynamically update the subject of an e-mail message. You can use the `MessageSource` property expression to dynamically update variables in the e-mail message, such as variables that are populated by a Row Count transformation.

This article discusses how to create a dynamic subject or message for the Send Mail task.

## More information

The following is a sample property expression for the Subject property in a Send Mail task.

```console
"Package>>> " + @[System::PackageName] +" was executed at>>> " + (DT_WSTR, 40) @[System::StartTime] + " by user>>> "
+ @[System::UserName] + " on Machine>>> " + @[System::MachineName]
```

If you use this sample property expression, the subject of an e-mail message is updated dynamically. The subject will include the following information:

- Text information
    In this example, the e-mail message subject includes the `Package>>>` text information.
- System variables  
  The e-mail message includes the following system variables:  
  - `PackageName`  
    The package name.
  - `StartTime`  
    The time that the package was executed.
  - `UserName`  
    The user who executed the package.
  - `MachineName`  
    The name of the computer on which the package was executed.

You can also include more information in the expression, such as a user-defined variable. For example, a Data Flow task can include a Row Count transformation before the Send Mail task. (The Row Count transformation is used to count rows.) The Row Count transformation populates a user-defined variable that is named *@myrowcount*. This variable stores the count information in the data flow.

To specify that an e-mail message be sent only if the row count is smaller than a certain value, modify the control flow by using precedence constraints. To do this, follow these steps:

1. In SQL Server Business Intelligence Development Studio, right-click **Data Flow Task**, and then click **Add Precedence Constraint**.
2. Double-click the precedence constraint that you created.
3. In the **Precedence Constraint Editor** dialog box, click **Expression and Constraint** in
 **Evaluation operation**.
4. In the **Expression** box, type the expression: `@myrowcount < 2`

5. In the **Precedence Constraint Editor** dialog box, click **OK**.

If fewer than two rows are processed in the data flow, an e-mail message is sent.

Additionally, you can use the Send Mail task as part of an error handler. For example, you may want to send an e-mail message to administrators when an SSIS package does not execute. To do this, create an OnError event handler for the package, and then add a Send Mail task to the event handler. Create a subject property expression that captures the time that the package is executed, the start time of the container, or the start time of the event handler from the relevant system variables. For example, create an expression that is similar to the following:

```console
"Error in the task: " + @[System::SourceName] + "with the ID: " + @[System::SourceID]
+ " has failed at: " + (DT_WSTR, 20) @[System::ContainerStartTime] + "."
```

This sample expression uses the following system variables:

- `StartTime`: The time when the package was executed.
- `ContainerStartTime`: The time that the container started.
- `EventHandlerStartTime`: The time that the event handler started.

## References

For more information, see the following topics in *SQL Server Books Online*:

- Using Property Expressions in Packages
- How to: Create a Property Expression
- Advanced Integration Services Expressions
- Precedence Constraints
- Setting Precedence Constraints on Tasks and Containers
- Integration Services Event Handlers
