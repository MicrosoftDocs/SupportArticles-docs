---
title: Run Program activity returns error
description: Fixes an issue where you receive the Process creation failed - The system cannot find the file specified error when executing the Run Program activity.
ms.date: 06/26/2024
---
# The Run Program activity returns the Process creation failed error

This article helps you fix an issue where you receive the **Process creation failed on \<computer> - The system cannot find the file specified** error when executing the **Run Program** activity.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2748718

## Symptoms

Executing the **Run Program** activity from System Center Orchestrator results in the activity returning a failed status, and the **Error Summary Text** published data contains the following error:

> Process creation failed on \<computer> - The system cannot find the file specified. (code 2)  

This error will be returned even if the path to the program being executed has been confirmed to be valid on the target computer and the user account configured for the Orchestrator Runbook Service, or directly in the **Security** tab of the **Run Program** activity has been verified as a member of the local Administrators group on the target computer.

## Cause

The Orchestrator Run Program service (orunprogram) on the target computer, used to execute the configured program or command, doesn't have sufficient privilege to create the process in the manner required for the Run Program activity. This is typically a result of the service on the target computer that doesn't use LocalSystem user account to create the process.

## Resolution

The service that creates the process on the target computer, Orchestrator Run Program service (orunprogram), by default is configured to use LocalSystem as the logon credentials. LocalSystem has a special user right that even members of the local Administrators don't have by default, which is **[Act as part of the operating system](/previous-versions/windows/it-pro/windows-2000-server/cc976442(v=technet.10)?redirectedfrom=MSDN)**. This user right allows the user to create a process using the credentials of another user that is required for the **Run Program** activity to succeed.

There are three resolution options available:

### Resolution 1

Stop and delete the Orchestrator Run Program service (orunprogram) from the target computer allowing System Center Orchestrator to reinstall the service automatically using the default LocalSystem user account at next execution of the **Run Program** activity.

Execute the following commands using an elevated Command Prompt on the computer that's the target of the **Run Program** activity to stop and delete the Orchestrator Run Program (orunprogram) service:

```console
sc stop orunprogram
sc delete orunprogram
```

### Resolution 2

Stop the Orchestrator Run Program service (orunprogram) on the target computer and configure the service to use the LocalSystem account to log on, then restart it.

Execute the following commands using an elevated Command Prompt on the computer that is the target of the **Run Program** activity to stop the Orchestrator Run Program service (orunprogram), change the user account to LocalSystem and then restart it:

```console
sc stop orunprogram
sc config orunprogram obj= LocalSystem type= interact type= own
sc start orunprogram
```
