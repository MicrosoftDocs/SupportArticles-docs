---
title: Error when you print a report in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you print a report in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you print a report in Microsoft Dynamics GP: "Undefined Symbol"

This article provides a solution to an error that occurs when you print a report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862263

## Symptoms

When you print a report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, the following error message is printed on the report:

> Undefined Symbol

## Cause

This problem can have any of the following causes:

### Cause 1

This problem occurs if the following conditions are true:

- You put a field in a footer or in the report body.
- You change the field type to a type other than data.
- You use the report field in a calculated field, and then you remove the report field.
- You do not change the calculated field.

See [Resolution 1](#resolution-1) in the [Resolution](#resolution) section.

### Cause 2

This problem occurs if the following conditions are true:

- You set up a calculated field that uses another calculated field in an expression.
- You delete the first calculated field.

See [Resolution 2](#resolution-2) in the [Resolution](#resolution) section.

### Cause 3

This problem occurs if the following conditions are true:

- You set up a sorting method that has one or more fields.
- You create additional headers or footers that use these fields to break on.
- You remove these fields from the sorting method.

See [Resolution 3](#resolution-3) in the [Resolution](#resolution) section.

### Cause 4

This problem occurs if the following conditions are true:

- You have a restriction, a sort, or a field on a report.
- The file from which the restriction, the sort, or the field came has been removed.

See [Resolution 4](#resolution-4) in the [Resolution](#resolution) section.

### Cause 5

This problem occurs if you have an invalid relationship that is defined between tables. See [Resolution 5](#resolution-5) in the [Resolution](#resolution) section.

## Resolution

Use the corresponding resolution according to the cause.

### Resolution 1

To resolve this problem, change the calculated field after you remove the report field.

### Resolution 2

To resolve this problem, do not delete the first calculated field.

### Resolution 3

To resolve this problem, do not remove these fields from the sorting method.

### Resolution 4

To resolve this problem, remove any restrictions, any sorts, or any fields that came from a file that has been removed.

### Resolution 5

To resolve this problem, determine whether there is an invalid relationship between tables. To do this, follow these steps:

1. Create a new report.
2. Add one table relationship pair to the report, add fields from the linked tables, and then perform a test print of the new report.
3. Repeat step 2 until you receive the error message that is mentioned in the [Symptoms](#symptoms) section.
4. When you receive the error message, review and then correct the last relationship definition that you added.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
