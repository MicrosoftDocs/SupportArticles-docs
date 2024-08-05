---
title: Login failed for user error when running PA TimeSheets or Employee Expense integration
description: Error occurs when you try to run a PA TimeSheets integration or a PA Employee Expense integration by using the Project Accounting destination in Integration Manager for Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# "Login failed for user" error when running a PA TimeSheets or a PA Employee Expense integration via Project Accounting destination

This article provides a resolution for the **Login failed for user** error that occurs when you try to run a PA TimeSheets integration or a PA Employee Expense integration by using the Project Accounting destination in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939648

## Symptoms

When you try to run a PA TimeSheets integration or a PA Employee Expense integration by using the Project Accounting destination in Integration Manager for Microsoft Dynamics GP, you receive the following error message:

> DOC 1 ERROR: Version=10.0.0.0  
Unique MessageId =  
Error Number = -2147467259  
Error Description = Login failed for user ''. The user is not associated with a trusted SQL Server connection.  
Error Source = Microsoft OLE DB Provider for SQL Server

## Cause

This problem occurs if you do not have a domain user name and a domain password set up in the COM+ application in eConnect in Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow these steps:

1. Start Component Services. To do this, select **Start**, select **Settings**, select **Control Panel**, and then select **Component Services**.
2. Expand **Component Services**, expand **Computers**, expand **My Computer**, and then expand **Com+ Applications**.
3. Right-click **eConnect 10 for Microsoft Dynamics GP**, and then select **Properties**.
4. Select the **Identity** tab, and then select the user.
5. Enter the domain administrator user ID and the domain password.
6. Run the integration.
