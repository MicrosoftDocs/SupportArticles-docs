---
title: Troubleshoot desktop flow run queue-based errors
description: Provides solutions to desktop flow queue-based error codes like NoCandidateMachine or No machine able to run the desktop flow has been found.
author: rpapostolis # GitHub alias
ms.author: appapaio # Microsoft alias
ms.reviewer: befrey, lulubran
ms.custom: sap:Desktop flows\Power Automate for desktop errors
ms.date: 11/15/2023
---
# Troubleshoot desktop flow run queue errors

This article provides background and potential solutions to queue-based errors encountered during desktop flow runs.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5004537

## Symptoms

Your desktop flow might fail to run with the error code `NoCandidateMachine` or the error details "No machine able to run the desktop flow has been found."

You might also receive one of these common sub-error codes:

- `SessionExistsForTheUserWhenUnattended`
- `NoUnlockedActiveSessionForAttended`
- `UIFlowAlreadyRunning`

## Cause

When no machines are available, Power Automate creates a queue to hold the desktop flows waiting to be run. Once a machine is available, the next desktop flow run will be selected to run based on [priority](/power-automate/desktop-flows/monitor-desktop-flow-queues#setting-a-priority) and request time. If no machine is available after six hours since the time it was requested, the desktop flow will time out and fail with a `NoCandidateMachine` error code.

As mentioned in the error message, this error means that the orchestrator can't find an available machine to run the desktop flow. This error occurs before the execution of the desktop flow starts.

> [!IMPORTANT]
> Power Automate automatically scales the number of concurrent desktop flow runs to the supported maximum value. The machine run queue follows a first-in, first-out approach, which means the first run received is the next one to be executed. If all available machines have reached their maximum concurrent sessions and can't execute the next run in the queue, the queue is blocked until a machine becomes available to run the next run in the queue.

## Resolution

Try these steps to resolve errors with the following sub-error codes.

#### SessionExistsForTheUserWhenUnattended

This occurs when you try to run an unattended desktop flow on a target machine where the user used in the desktop flow connection is logged in.

##### Resolution

To resolve the issue, sign out of the session (a locked session will lead to this error), and check that you aren't logged in with the same user on the machine.

#### NoUnlockedActiveSessionForAttended

This error usually occurs when you try to run an attended desktop flow on a target machine that is locked or has no user signed in. You can also get this error when the Windows user you're currently logged in on the target machine doesn't match the user you entered in your connection. Attended desktop flows can only execute if the machine is unlocked on a session where the current user matches the one in the desktop flow connection.

##### Resolution

To resolve the issue,

- Check the credentials used in your connection and make sure they're the ones used in the unlocked session. You can verify your identity by typing `whoami` in any command prompt.
- Verify that you're targeting the right machine. To do so, open the machine runtime application and select **View machine in portal** to verify that it brings you to the machine you're targeting in your run.
- Verify that the account that runs the Power Automate service (UIFlowService) has Remote Desktop permissions on the machine. By default, the Power Automate service runs as `NT SERVICE\UIFlowService`. If you didn't change this, verify that `NT SERVICE\UIFlowService` is in the **Remote Desktop Users** group. To do so, go to **Start** > **Run**, type *usrmgr.msc*, select **Groups**, double-click the **Remote Desktop Users** group and verify the account is included. If it's not included, include it (this requires administrator permissions) and restart the machine.

#### UIFlowAlreadyRunning

When a desktop flow is already running on the machine, this error might occur in one of the following situations:

- You run an attended or unattended desktop flow, and the number of active sessions on the machine has reached its limit.
- You try to open a session for a user who is already logged in.

##### Resolution

To resolve the issue, either wait for the flows that are already running to complete or [cancel their parent cloud flow run](/power-automate/desktop-flows/monitor-desktop-flow-queues#cancel-parent-flow-run).

### Other error codes

For information on other error codes that might occur when running desktop flows and steps to mitigate, see [Error code occurs when running an attended or unattended desktop flow](troubleshoot-errors-running-attended-or-unattended-desktop-flows.md).

## More information

If the sub-error code isn't provided, check if:

- The machine or all machines in the machine group are offline.

  Start the machine and make sure the Power Automate Desktop is properly installed and can communicate with the internet.

- The machine group is empty.

  Make sure that your machine group contains at least one machine before assigning it a desktop flow run.

- The machine or all machines in the machine group are continuously busy.

  If machines don't pick up the desktop flow in time, it's likely because the allocated machine resources don't scale sufficiently to meet the workflow demand. Adding more machines could help distribute the workload.

- The machine can't be reached because of network (including proxy or firewall) issues.
  
  Work with your IT administrator to make sure that your machines are reachable.

- The issue is transient.
  
  Try changing the [retry policy](/azure/logic-apps/logic-apps-exception-handling?tabs=consumption#retry-policies) in actions' settings.

- The machine or all machines in the machine group aren't able to connect with the desktop flow.
  
  Make sure one of the following is met:

  - You aren't trying to run an unattended flow on a group where all machines are logged in.
  - You aren't trying to run an attended flow on a group where all machines are signed out.

- The machine is no longer usable.
  
  Add a new machine, then update the desktop flow connections in your cloud flows to use the new machine.

If you have a backup of desktop flows in your run queue due to one of the above reasons, you can bulk cancel your desktop flow runs by [canceling the parent cloud flow run](/power-automate/desktop-flows/monitor-desktop-flow-queues#cancel-parent-flow-run) using the **Cancel parent flow run** action on the Desktop flow runs page. Once your machine issue is resolved, you can restart those cloud flows.
