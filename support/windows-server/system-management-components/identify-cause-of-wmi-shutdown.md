---
title: Identify the cause of unexpected WMI shutdowns
description: Introduces how to identify the source of a Windows Management Instrumentation (WMI) request that shuts down a computer.
ms.date: 07/23/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: gbrag
ms.custom: sap:System Management Components\WMI management and troubleshooting, csstroubleshoot
---
# How to identify the cause of an unexpected WMI shutdown

This article introduces how to identify the source of a Windows Management Instrumentation (WMI) request that causes a computer to shut down.

## Symptoms

A computer is shut down unexpectedly. You find event ID 1074 in the System log. The event indicates that the request comes from the WMIPrvSE process:

```output
Log Name:      System
Source:        User32
Date:          <date and time>
Event ID:      1074
Level:         Information
User:          <User>
Computer:      <FQDN>
Description:
The process C:\Windows\system32\wbem\wmiprvse.exe (<computer name>) has initiated the shutdown of computer <computer name> on behalf of user <user> for the following reason: No title for this reason could be found
 Reason Code: 0x80070015
 Shutdown Type: shutdown
 Comment:
```

## Analysis

WMI can shut down a computer by calling the [Win32Shutdown method of the Win32_OperatingSystem class](/windows/win32/cimwin32prov/win32shutdown-method-in-class-win32-operatingsystem). However, the difficulty lies in identifying the source of this request. A script or an application can be deployed to call this method without including the information about where and when it runs.

To troubleshoot unexpected shutdowns caused by WMI, a WMI trace needs to be collected continuously until the behavior occurs. The trace can be collected by enabling the log from **Applications and Services Logs** > **Microsoft** > **Windows** > **WMI-Activity** > **Trace**. By default, the log isn't visible in Event Viewer. To view this log, enable the **Show Analytic and Debug Logs** option from the **View** menu.

The trace reveals the process ID (PID) and the user from whom the request comes. You'll also need to capture a Process Monitor trace to identify that process.

You can [download Process Monitor](/sysinternals/downloads/procmon).

## Troubleshooting steps

### Preparation

To start the investigation, follow these steps:

1. Create a folder on the *C:* drive, such as *C:\WMI*.
2. Extract the Process Monitor archive file to the folder.
3. Create these two batch files in the folder:

   *StartTrace.bat*:

   ```console
   wevtutil sl Microsoft-Windows-WMI-Activity/Trace /e:true /q
   procmon /Quiet /Minimized /Backingfile %0\..\procmon.pml /LoadConfig %0\..\filter.pmc
   ```

   *StopTrace.bat*:

   ```console
   procmon /Terminate
   wevtutil sl Microsoft-Windows-WMI-Activity/Trace /e:false
   wevtutil epl Microsoft-Windows-WMI-Activity/Trace %0\..\WMI-ActivityLog.evtx /ow:true
   ```

### Create Process Monitor filters

Create a Process Monitor configuration with an event filter to capture only what's needed for this investigation. Follow these steps:

1. Start Process Monitor.
2. Select the **Reset** button in the **Process Monitor Filter** dialog if it shows up.
3. Deselect the third button in the toolbar to stop the automatic capture.
4. Select the **Filter** menu, and then select the **Filter** option.
5. In the **Process Monitor Filter** dialog, select **Operation** **is**, type *Process Create*, and then select **Add**.  
   Also, define another filter by selecting **Operation** **is**, typing *Process Exit*, and then selecting **Add**.  
   
   :::image type="content" source="media/identify-cause-of-wmi-shutdown/filters-added.png" alt-text="Screenshot showing the filters that are added.":::

6. Select **OK** to confirm the filter configuration.
7. Select the **File** menu, select **Export Configuration**, and then save the *C:\WMI\filter.pmc* file.

### Create a scheduled task

Then, create a scheduled task to stop the capture when the reboot occurs. Follow these steps:

1. Open **Task Scheduler**.
2. Right-click the **Task Scheduler Library** node, and then select **Create Task**.
3. Type a name for the task.
4. Select the **Run whether user is logged on or not** option.

   :::image type="content" source="media/identify-cause-of-wmi-shutdown/run-whether-user-is-logged-on-or-not-option.png" alt-text="Screenshot showing the 'Run whether user is logged on or not' option.":::

5. Select the **Triggers** tab.
   1. Select **New**, and then select **On an event** for the **Begin the task** option.
   2. In **Log**, select **System**.
   3. In **Source**, type *User32*.
   4. In **Event ID**, type *1074*.
   5. Select **OK**.

      :::image type="content" source="media/identify-cause-of-wmi-shutdown/edit-trigger-of-task.png" alt-text="Screenshot showing how to edit the trigger of the task.":::

6. Select the **Actions** tab.
   1. Select **New**.
   2. Keep the default for the **Action** option: **Start a program**.
   3. Select **Browse**, and then select the *StopTrace.bat* batch file in the *C:\WMI* folder.
   4. Select **OK**.
7. Select **OK** to confirm the task. When you're asked for credentials, provide a user account that's a member of the **Administrators** group.

### Start the capture

Now you're ready for the capture. From an elevated Command Prompt window, go to the *C:\WMI* folder, and then run *StartTrace.bat*.

> [!NOTE]
> A Process Monitor capture has been started at this point. You'll be able to see the PML file in that folder. Even with a filter defined, the capture is left running for a long time. Multiple PML files will be created, which can consume a lot of this space.
>
> Make sure to monitor the size and number of these PML files. If no unexpected shutdown happens, you may need to stop and restart the trace to clear up old PML files that are no longer needed for the investigation.

When the reboot occurs, the *StopTrace.bat* batch file is called. The Process Monitor trace capture is stopped, and the WMI trace is saved.

### Investigate the trace

After the reboot, follow these steps to conclude the investigation:

1. Go to the *C:\WMI* folder and double-click the *WMI-ActivityLog.evtx* file.
2. Right-click the log name in the left pane and select **Filter Current Log**.

   :::image type="content" source="media/identify-cause-of-wmi-shutdown/filter-opened-event-log.png" alt-text="Screenshot showing the 'Filter Current Log' option.":::

3. Type *11* in the **Includes/Excludes Event IDs** text box.

   :::image type="content" source="media/identify-cause-of-wmi-shutdown/add-event-id-11.png" alt-text="Screenshot showing the 'Includes/Excludes Event IDs' filed in the 'Filter Current Log' window.":::

4. After the filter is applied, the first event at the top should be the one with the shutdown request. If not, select <kbd>Ctrl</kbd>+<kbd>F</kbd>, and then type *shutdown*.

   Here's a sample of the event log:

   ```output
   Log Name:      Microsoft-Windows-WMI-Activity/Trace
   Source:        Microsoft-Windows-WMI-Activity
   Date:          <date and time>
   Event ID:      11
   Level:         Information
   User:          SYSTEM
   Computer:      <FQDN>
   Description:
   CorrelationId = {6BE1F66D-CD17-0003-6718-E26B17CDDA01}; GroupOperationId = 11687; OperationId = 11698; Operation = Start IWbemServices::ExecMethod - root\cimv2 : Win32_OperatingSystem=@::Win32Shutdown; ClientMachine = <computer name>; User = <user>; ClientProcessId = 2712; NamespaceName = 133644697772514501
   ```

   Note the **ClientProcessId**.

5. Double-click the *procmon.pml* file and find the corresponding line with the same PID.

   :::image type="content" source="media/identify-cause-of-wmi-shutdown/find-the-corresponding-process-by-id.png " alt-text="Screenshot showing the procmon.pml file info where two lines with the same PID are selected.":::

   In this example, the shutdown method was called by a PowerShell script.

7. Go to the **Process** tab, and you can find the path of the script in the **Command Line** field.

   :::image type="content" source="media/identify-cause-of-wmi-shutdown/process-information.png" alt-text="Screenshot showing the process information where you can find the script path.":::
### Cleanup

After the investigation is finished, don't forget to reset the Process Monitor configuration:

1. Select the **File** menu, and then select **Backing files**.
2. Select the option **Use virtual memory** option.
3. Select **OK**.
