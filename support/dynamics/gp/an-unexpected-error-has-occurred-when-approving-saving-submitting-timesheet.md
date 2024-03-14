---
title: An unexpected error has occurred when approving saving or submitting a Timesheet in Project Time and Expense
description: Provides a resolution to solve the unexpected error that occurs when you try to approve, save, or submit a timesheet in Project Time and Expense in Business Portal.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# "An unexpected error has occurred" when approving, saving, or submitting a timesheet in Project Time and Expense

This article provides steps on how to solve the **An unexpected error has occurred** error that occurs when you approve, save, or submit a timesheet in Project Time and Expense in Business Portal.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2860634

## Symptoms

In Business Portal Project Time and Expense you might run into the following issue when approving, saving, or submitting a timesheet:

> An unexpected error has occurred. Please contact your system administrator.

## Cause

Typically this error is caused by:

- A damaged timesheet template. Templates can get damaged if the users do not remove old/closed Projects from the Templates. Once they delete the Template, it should resolve the issue.
- A timesheet or template that use Projects that no longer exist or are assigned to them.
- A security issue due to a Windows Update recently installed.

## Resolution

Review the methods below and test in between each one:

**Method 1:** Template - What you can do is remove the Timecard Template for the user to see if this resolves the issue: (Insert in the employee ID for the XXXX placeholder before running the script in SQL Server Management Studio against the company database.)

```sql
Delete PDK00300 where EMPLOYID='XXXX'
```

```sql
Delete PDK00301 where EMPLOYID='XXXX'
```

**Method 2:** Invalid Projects - This error can also occur if you have Projects that do not exist in the System, but they exist on the users Project Template/Timesheet. Here is a script to verify this:

1. Check for Projects that are in the Timesheet Line that do not exist in GP by executing this script in SQL Server Management Studio against the company database:

    ```sql
    select * from PDK10001 where PAPROJNUMBER not in (select PAPROJNUMBER from PA01201)
    ```

2. Verify the Projects used on Templates exist in GP:

    ```sql
    select * from PDK00301 where PAPROJNUMBER not in (select PAPROJNUMBER from PA01201)
    ```

If you find occurrences in the above select statements these will need to be removed either from the Timesheet (go into PDK and remove the line with the invalid Project) or Delete the Timesheet Template itself. Here are steps you would need to accomplish:

1. If you find results for script #1, you will need to log into PDK Modify that Timesheet and remove the invalid Project.
2. If you find results for script #2, you will need to delete the Template and have the user create a new one. To do this you can run the following deletes:

```sql
Delete PDK00300 where EMPLOYID='XXXX'
```

```sql
Delete PDK00301 where EMPLOYID='XXXX'
```

**Method 3:** Windows Security - Changes to a recent security patch from Windows Updates for .NET Framework may also cause this error. This issue is a currently known issue due to the following security update, and it is being further investigated.

[Description of the security update for the .NET Framework 3.5.1 on Windows 7 Service Pack 1 and Windows Server 2008 R2 Service Pack 1: December 10, 2013](https://support.microsoft.com/topic/description-of-the-security-update-for-the-net-framework-3-5-1-on-windows-7-service-pack-1-and-windows-server-2008-r2-service-pack-1-december-10-2013-27f6ee51-0109-c40e-95ac-569fd34a85f0)

Steps: The *temporary workaround* is to uninstall these security updates for .NET Framework, and BP Time & Expense will work properly again. Below are the steps to uninstall these updates:

1. On the BP server, go to **Programs and Features** in the Control Panel.
2. In the left margin, select **View installed updates**.
3. Review the installed updates and select any updates with KB2894843 or KB2894844 or KB2894847 listed. (f you don't see any of these listed, you can roll back any recently installed updates to determine which one is causing the issue.)

4. With the update selected, then select the **Uninstall** button at the top.
5. Now do an IIS Reset.
6. Test in BP again and the issue should be resolved. (You should not need to reboot the BP server, but could try that if it still doesn't work.)

> [!NOTE]
> This article will be updated as more developments with this issue are found, or you can follow the blog article below on this issue:  
> [UPDATE: An unexpected error has occurred. Please contact your system Administrator](https://community.dynamics.com/blogs/post/?postid=f93a79d0-4d48-4792-bebe-ddf112dccdec)

## More information

Also refer to the below article for other possible reasons for this type of message. The article also makes sure the user is properly configured in GP, PDK, and Business Portal:

[You receive the error messages "You are not authorized to view this page" and "An unexpected error has occurred" when you try to create a new timesheet or expense report in Project Time and Expense for Microsoft Business Portal](https://support.microsoft.com/topic/you-receive-the-error-messages-you-are-not-authorized-to-view-this-page-and-an-unexpected-error-has-occurred-when-you-try-to-create-a-new-timesheet-or-expense-report-in-project-time-and-expense-for-microsoft-business-portal-5fd06a3d-6316-c4c0-a44f-c28004eb7c6c)

The above article was also published externally in this blog:

[An unexpected error has occurred when approving, saving, or submitting a Timesheet in Business Portal](https://community.dynamics.com/blogs/post/?postid=55f74235-199a-413f-9476-265627ab563e)
