---
title: Operation must use an updateable query error when running integration
description: Describes how to resolve the updateable query error message in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Operation must use an updateable query" error when you run an integration in Integration Manager

This article provides a resolution for the issue that you can't run an integration in Integration Manager for Microsoft Dynamics GP due to the **Operation must use an updateable query** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968361

## Symptoms

When you run an integration in Integration Manager for Microsoft Dynamics GP, you receive the following error message:

> Operation must use an updateable query.

## Cause

This issue occurs when you have insufficient Windows permissions to read and to write to the location where the Integration database or the source files are stored.

## Resolution

You must have the Modify permission for the location of Integration Manager and the source files. This lets you edit, create, and delete the existing files.

To resolve this issue, follow these steps:

1. Right-click the folder where the Integration database and the source files are located, and then select **Properties**.
2. Select the **Security** tab.
3. Under **Group or user names**, select the user or the group that is experiencing the issue.
4. Under **Permissions forUser Name**, make sure that the **Modify** check box is selected in the **Allow** column.
5. Select **OK** to save the changes.
