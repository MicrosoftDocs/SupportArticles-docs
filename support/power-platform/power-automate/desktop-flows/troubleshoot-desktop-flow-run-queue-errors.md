---
title:       Troubleshoot desktop flow run queue-based errors
description: Troubleshoots desktop flows that failed to run due to error codes such as "NoCandidateMachine" or the error details "No machine able to run the desktop flow has been found".
author:      rpapostolis # GitHub alias
ms.author:   appapaio # Microsoft alias
ms.subservice: power-automate-desktop-flows
ms.date:     10/15/2023
---

# Troubleshoot desktop flow run queue errors

This article provides background and potential resolution to the issues related to machine run queue-based errors encountered during desktop flow runs.

## Symptoms

Your desktop flow may have failed to run with the error code "NoCandidateMachine" or the error details "No machine able to run the desktop flow has been found".

## Cause

When there are no available machines, Power Automate will create a queue that holds the desktop flows waiting to be run. Once a machine is available, the next desktop flow run will be selected based on priority and time of request. If no machine is available after six hours since the time it was requested, the desktop flow will time out and fail with a "NoCandidateMachine" error.

As mentioned by the error message, this error means that the orchestrator was not able to find an available machine to run the desktop flow. This error occurs before the execution of the desktop flow starts. It happens when the desktop flow has been in the queue for more than the timeout limit (6 hours), which can happen for several reasons. 

> Power Automate automatically scales the number of concurrent desktop flow runs to the supported maximum. The machine run queue follows a first-in, first-out approach, which means the first run received is the next one executed. If all available machines have reached their maximum concurrent sessions and can't execute the next run in the queue, the queue is blocked until a machine becomes available to run the next run in the queue. 


## Resolution

This error code usually comes with a sub-error code. Here are resolutions for the most commons:

- **SessionExistsForTheUserWhenUnattended**- this means that you are trying to run an unattended desktop flow on a target machine where the user used in the desktop flow’s connection is logged in. The session needs to be signed out (a locked session will lead to this error). Check that you are not logged in with the same user on the machine.
- **NoUnlockedActiveSessionForAttended**- the most common way to get this error is when you try to run an attended desktop flow on a target machine that is locked or with no user signed in. You can also get this error when the Windows user you're currently logged in with on the target machine doesn't match the user you entered in your connection. Attended desktop flows can only execute if the machine is unlocked on a session where the current user matches the one from the desktop flow connection.:
   - Check that the credentials used in your connection and make sure they are the ones used in the unlocked session. You can verify your identity by typing "whoami" in any command prompt.
      - Verify that you are hitting the right machine. You can do this by opening the machine runtime application and selecting "View machine in portal" to verify that it brings you to the machine you are targeting in your run.
         - Verify that the account that is running the Power Automate service (UIFlowService) has Remote Desktop permissions on the machine. By default, the Power Automate service runs as "NT SERVICE\UIFlowService", so if you haven't changed this, please verify that "NT SERVICE\UIFlowService" is in the Remote Desktop Users group. You can do this by going to start > run, typing "lusrmgr.msc", clicking "Groups", double clicking the "Remote Desktop Users" group and verifying the account is included. If it is not included, please include it (this requires administrator permissions), and reboot the machine.
         
- **UIFlowAlreadyRunning**- this arise when running an unattended desktop flow. This failure occurs when the limit number of active sessions on the machine is reached or when trying to open a session for a user who is already logged in.

In case the sub-error code is not provided, a few checks will be needed.

- __**The machine or all machines in the machine group are offline.**__ Start up the machine and make sure Power Automate Desktop is properly installed and able to communicate with the internet.

- __**The machine group is empty.**__ Make sure that your machine group contains at least one machine before assigning it a desktop flow run.

- __**The machine or all machines in the machine group are continuously busy.**__ Machines did not pick up the desktop flow in time. It is likely due to the fact the allocated machine resources are not sufficiently scaling to meet the workflow demand. Adding more machines would help distribute the workload.

- __**The machine cannot be reached because of network (including proxy or firewall) issues.**__ Please work with your IT admin to make sure that your machines are reachable as expected.

- __**The issue is transient.**__ Changing the retry policy in actions’ settings might help.

- __**The machine or all machines in the machine group are not able to connect with the desktop flow.**__ Make sure you are not trying to run an unattended flow on a group where all machines are logged in or trying to run an attended flow on a group where all machines are signed out.

- __**The machine is no longer usable.**__ Add a new machine, then update the desktop flow connections in your cloud flows to use the new machine.

In the event you have a backup of desktop flows in your run queue due to one of the above reasons, you can bulk cancel your desktop flow runs by canceling the parent cloud flow run using the __**Cancel parent flow run**__ action on the Desktop flow runs page. Once your machine issue has been resolved, you can re-launch those cloud flows.


