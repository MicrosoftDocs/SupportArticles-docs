---
title: Troubleshoot Task Scheduler Service Startup Failure
description: Helps troubleshoot the failure to start the Task Scheduler service in Windows computers.
ms.date: 04/09/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, mamash, v-lianna
ms.custom:
- sap:system management components\task scheduler
- pcy:WinComm User Experience
---
# Troubleshoot issues with the Task Scheduler service not starting

This article helps troubleshoot the failure to start the Task Scheduler service in Windows computers.

Your scheduled tasks don't run or miss their schedules. When you open Task Scheduler, you receive the following error message:

> The remote computer was not found.

The Task Scheduler service isn't started in the **Services** snap-in (**Services.msc**). When you start the Task Scheduler service, you receive one of the following error messages:

- > The Task Scheduler service on Local Computer started and then stopped. Some services stop automatically if they are not in use by other services or programs.
- > Error 5: Access is denied
- > Error 126: The specified module could not be found

Each error message has different causes and resolutions.

## The Task Scheduler service on Local Computer started and then stopped

This error occurs because the Time Broker service is either stopped or disabled. To resolve the error, enable and then start the service by using one of the following methods.

> [!NOTE]
> The Time Broker service coordinates the execution of background work for WinRT applications. If this service is stopped or disabled, then background work might not be triggered.

### Use the Services snap-in

Select **Start** > **Windows Administrative Tools** > **Services**, and check if the Time Broker service is running. If it isn't running or is in a disabled state, enable it and then start it.

### Use Registry Editor

1. Open Registry Editor, and go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TimeBrokerSvc`.
2. In the right pane, check if the `Start` value is set to `3` by default. If not, modify it to `3`.
3. Restart your computer and check if the Task Scheduler service is running.

If that doesn't resolve the issue and you still can't start the Task Scheduler service, see the [Additional resources](#additional-resources) section.

## Error 5: Access is denied

This error occurs because the NT AUTHORITY\\SYSTEM account doesn't have write permissions on the System event log. The permissions might have been modified by a system administrator with a `CustomSD` registry key for other purposes.

The Task Scheduler service runs under the SYSTEM account. By default, the SYSTEM account has write permissions to the System event log to allow the Task Scheduler service to log events into the System event log.

The security of each log is configured locally through the values in the registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog`

If the System event log permissions are customized, the System log security descriptor is configured through:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\System\CustomSD`

The security descriptor is specified by using Security Descriptor Definition Language (SDDL) syntax. The SDDL should have the SYSTEM account with Read, Write, and Clear permissions in the following context:

`(A;;0xf0007;;;SY)`

The value of SY (SYSTEM account) is 7, which means Read(1)+Write(2)+Clear(4). If not, change it to 7 for it to have the proper permissions on the System event log. Once the SDDL of the SYSTEM account has been corrected, restart the machine and check if the Task Scheduler service is started.
You can also check the SDDL of the System event log by running the following command:

```console
wevtutil get-log "SYSTEM"
```

The default values should look like:

```output
name: SYSTEM
enabled: true
type: Admin
isolation: System
channelAccess: O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x3;;;BO)(A;;0x5;;;SO)(A;;0x1;;;IU)(A;;0x3;;;SU)(A;;0x1;;;S-1-5-3)(A;;0x2;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)
```

For more information about how to modify the event log SDDL, see [Set event log security locally or via Group Policy](../../windows-server/group-policy/set-event-log-security-locally-or-via-group-policy.md).

If that doesn't resolve the issue and you still can't start the Task Scheduler service, see the [Additional resources](#additional-resources) section.

## Error 126: The specified module could not be found

This error occurs because a file related to the Task Scheduler service is missing or can't be found.

In this case, a required system file is missing, or the Task Scheduler service is referring to an invalid file under its registry configuration.

Determine if the service is configured correctly under its registry configuration:

1. Open Registry Editor.
2. Go to the Task Scheduler service location under:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Schedule\Parameters`

3. In right pane, check if the registry value `ServiceDll` has the value data of `%systemroot%\system32\schedsvc.dll`.
4. If it does, check if the **schedsvc.dll** file exists under **%systemroot%\system32**.
5. If the DLL file is missing, [use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e).
6. Once the repair is done, start the Task Scheduler service.

If that doesn't resolve the issue and you still can't start the Task Scheduler service, see the [Additional resources](#additional-resources) section.

## Additional resources

Use the following event logs to view additional information about the service start failure:

- System event logs
- Application event logs
- Task Scheduler event logs under:

  - **Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Windows** > **TaskScheduler** > **Maintenance**
  - **Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Windows** > **TaskScheduler** > **Operational**

## Contact Microsoft Support

If the preceding steps can't resolve the issue, contact Microsoft Support for further assistance.
