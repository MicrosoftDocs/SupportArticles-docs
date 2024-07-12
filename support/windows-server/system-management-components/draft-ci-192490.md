# Title

This article introduces how to identify the source of a Windows Management Instrumentation \(WMI\) request that shuts down a computer.

## Symptom

A computer is shut down unexpectedly. You found the event 1074 in the System log. The event indicates that the request comes from a WMIPrvSE process:

```output
Log Name:      System
Source:        User32
Date:          7/2/2024 10:45:50 AM
Event ID:      1074
Level:         Information
User:          CONTOSO\administrator
Computer:      W19SRV.contoso.com
Description:
The process C:\Windows\system32\wbem\wmiprvse.exe (W19SRV) has initiated the shutdown of computer W19SRV on behalf of user CONTOSO\Administrator for the following reason: No title for this reason could be found
 Reason Code: 0x80070015
 Shutdown Type: shutdown
 Comment:
```

## Analysis

WMI can shut down a computer by calling the Win32Shutdown method of the Win32_OperatingSystem class. However, the difficulty lies in identifying the source of this request. A script or an application can be deployed to call this method without including the information of where and when it runs.

To troubleshoot unexpected shutdowns caused by WMI, a WMI trace needs to be collected continuously until the behavior occurs. The trace can be collected by enabling the log `Application and Services Logs / Microsoft / Windows / WMI-Activity / Trace` (The log is not visible by default in Event Viewer). To view this log, enable the option **View** -> **Show Analytic and Debug Logs**.

The trace will reveal the Process ID and the user where the request comes from, so you will also need to capture a Process Monitor trace to identify that process.

You can download Process Monitor from this link: [Process Monitor](https://learn.microsoft.com/sysinternals/downloads/procmon)

## Steps for troubleshooting

To start the investigation follow these steps:

1. Create a folder on the C: drive, such as C:\WMI
2. Extract the Process Monitor archive file there
3. Create these two batch files in the folder

StartTrace.bat:

```console
wevtutil sl Microsoft-Windows-WMI-Activity/Trace /e:true /q
procmon /Quiet /Minimized /Backingfile %0\..\procmon.pml /LoadConfig %0\..\filter.pmc
```

Stop trace.bat:

```console
procmon /Terminate
wevtutil sl Microsoft-Windows-WMI-Activity/Trace /e:false
wevtutil epl Microsoft-Windows-WMI-Activity/Trace %0\..\WMI-ActivityLog.evtx /ow:true
```

You will also need to create a Process Monitor configuration with an event filter to only capture what is needed for this investigation, these are the steps:

1. Start Process Monitor
2. Click on the Reset button at the Process Monitor Filter dialog box, if it shows up
3. Click on the third button in the toolbar to stop the automatic capture
4. Click on the Filter menu then select the Filter option
5. In the filter definition select Operation is Process Create then click Add

Also define another filter for Operation is Process Exit then click Add

1. Click OK to confirm the filter configuration
2. Click on the File menu then Export Configuration, save the file C:\WMI\filter.pmc

Then you will have create a scheduled task to stop the capture when the reboot occurs, these are the steps:

1. Open Task Scheduler
2. Right click on the Task Scheduler Library node then Create Task
3. Give the task a name
4. Select "Run whether or not user is logged on"
5. In the Triggers tab click on New then select "On an event"
   In Log select System
   In Source type User32
   in Event ID type 1074 Click OK
6. In Actions click New
   Keep the default action "Start a program"
   Click on Browse then select the StopTrace.bat batch file in the C:\WMI folder
   Click OK
7. Click OK to confirm the task, you will be asked for the credentials, the user has to be a member of the Administrators group.

Now you are ready for the capture, from an elevated Command Prompt go to the C:\WMI folder and execute StartTrace.bat

Please notice that a Process Monitor capture has been started at this point, you will be able to see the PML file in that folder. Even with a filter defined, the capture is left running for long time, multiple PML files will be created that can consume a lot of this space.

Make sure to monitor the size and number of these PML files. If the unexpected shutdown doesn't happen, you may want to stop and restart the trace to clear out older PML files that are no longer needed for the investigation.

When the reboot occurs the StopTrace.bat batch files will be called, the Process Monitor trace capture will be stopped and the WMI trace will be saved.

After the reboot, follow these steps to conclude the investigation:

1. Go to the folder C:\WMI and double click on the file WMI-ActivityLog.evtx
2. Right click on the log name in the left pane then click on Filter Current Log
3. Type 11 in the Event ID text box
4. Once the filter is applied the first event on the top should be the one with the shutdown request.
   If not, press CTRL-F and type shutdown

   This is how the event looks like:

   ```output
   Log Name:      Microsoft-Windows-WMI-Activity/Trace
   Source:        Microsoft-Windows-WMI-Activity
   Date:          7/3/2024 10:43:02 AM
   Event ID:      11
   Level:         Information
   User:          SYSTEM
   Computer:      W19SRV.contoso.com
   Description:
   CorrelationId = {6BE1F66D-CD17-0003-6718-E26B17CDDA01}; GroupOperationId = 11687; OperationId = 11698; Operation = Start IWbemServices::ExecMethod - root\cimv2 : Win32_OperatingSystem=@::Win32Shutdown; ClientMachine = W19SRV; User = CONTOSO\Administrator; ClientProcessId = 2712; NamespaceName = 133644697772514501
   ```

   Note the Client Process ID

5. Now double click on the procmon.pml file and find the corresponding line with the same PID
6. In this example the shutdown method was called by a PowerShell script

Go to the Process tab and in the Command Line field you will be able to find the path of the script

Once the investigation is finished don’t forget to reset the Process Monitor configuration:

1. Click on the File menu then Backing files
2. Select the option Use virtual memory
3. Click OK
