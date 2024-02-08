---
title: PowerShell issue when RemoteSigned is not set
description: This article provides workarounds for the problem that occurs when machine policy of the domain controller is not set to RemoteSigned by GPO for SQL Server.
ms.date: 09/25/2020
ms.custom: Fix
ms.reviewer: desalg, daleche
---
# SQL Server PowerShell issue when RemoteSigned is not set in Domain controller for SQL Server

This article helps you resolve the problem that occurs when machine policy of the domain controller is not set to RemoteSigned by GPO for SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2995870

## Symptoms

When you open SQL Server PowerShell console of Microsoft SQL Server 2012 or Microsoft SQL Server 2014 and machine policy of the domain controller is not set to RemoteSigned by Group Policy Object (GPO), you may receive the following error message:

> set-executionpolicy : Windows PowerShell updated your execution policy successfully, but the setting is overridden by a policy defined at a more specific scope. Due to the override, your shell will retain its current effective execution policy of Unrestricted. Type *Get-ExecutionPolicy -List* to view your execution policy settings.  
For more information, see  
"Get-Help Set-ExecutionPolicy".  
At line:1 char:1  
\+ set-executionpolicy RemoteSigned -scope process -Force

Additionally, `syspolicy_purge_history` job fails in the third step if the domain controller is not set to **RemoteSigned** by GPO, and you may receive the following error message:

> Executed as user: AJ\devARsqlagt. A job step received an error at line 1 in a PowerShell script. The corresponding line is 'set-executionpolicy RemoteSigned -scope process -Force'. Correct the script and reschedule the job. The error information returned by PowerShell is: 'Security error. '. Process Exit Code -1. The step failed.

## Cause

This issue occurs because the machine policy is not set to **RemoteSigned** by GPO and it is pushed to the member servers. For example, if the execution policy for the domain controller setup is as follows:

```console
Scope -                   ExecutionPolicy
--------------------------------------------------------------
MachinePolicy -           Unrestricted
UserPolicy -              Undefined
Process -                 RemoteSigned
CurrentUser -             Undefined
LocalMachine -            RemoteSigned
```

MachinePolicy takes precedence over all other policies.

Group Policy is pushed from the domain controller to the member servers that are associated for that Group Policy. This sets the `MachinePolicy` to **Unrestricted** mode and SQL Server PowerShell tries to run with `RemoteSigned` execution policy. Therefore, a conflicting situation occurs and the `syspolicy_purge_history` job fails. The same job runs successfully in SQL Server regardless of machine policy in domain controller.

## Workaround

As a security measure, SQL Server 2012 starts SQL PowerShell in RemoteSigned policy. This causes the job to fail and the previous issue occurs.

Unrestricted  is definitely not recommended from a security perspective because it means No restrictions. That is the reason when you start from SQL 2012, PowerShell scripts run successfully when MachinePolicy is set as RemoteSigned in Domain Controller.

To work around this issue, use one of the following methods:

- Do not set the Machine policy of domain controller by GPO. If it is undefined, that means the next level policy (for example, UserPolicy, then Process, then CurrentUser, and at last LocalMachine) will take precedence.

- Create a new Organizational Unit (OU) in Active Directory Users and Computers and link this OU with your Group Policy. Then enable it for RemoteSigned policy. To do this, follow these steps:

  1. Go to **Active Directory Users and Computers**.
  2. Right-click your **Domain** -> **New** -> **Organizational Unit** to create a new Organizational Unit.
  3. Type *gpmc.msc* in Run, and then right-click **Group Policy Object** -> **New** to create a new **GPO**.
  4. Right-click the newly created **GPO** -> **Edit**. It will open a new window.
  5. Go to **Computer Configuration** -> **Policies** -> **Administrative Templates** -> **Windows components** -> **Windows PowerShell** -> double-click **Turn on Script Execution**.
  6. Set the **Execution Policy** to Allow local scripts and remote signed scripts.
  7. Click **Apply**, and then click **OK**.
  8. Go to **Active Directory Users and Computers**, and then click **Computers**. You find a list of computers for the domain. Right-click the computer(s) that you want move in the newly created organizational unit. In this manner, you can move a single or a group of computers to an organizational unit.
  9. Go to **Group Policy Management**, right-click newly created **Organizational Unit**, click **Link an Existing GPO**, select the newly created **GPO**, and then click **OK**.
  10. Update the policy on Domain controller and on the client computer by running this command in PowerShell.

        ```powershell
        gpupdate /force
        ```

  11. Verify the machine policy for Organizational Unit and client component, it should be RemoteSigned.

## References

[About Execution Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies)
