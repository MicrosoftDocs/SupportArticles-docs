---
title: Adapter for MQSeries 2.0 doesn't retrieves messages
description: This article provides workarounds for the problem where MQSeries Adapter no longer retrieves messages from a clustered MQSeries queue manager when the queue manager fails over to a different cluster node.
ms.date: 08/25/2020
ms.custom: sap:Adapters
ms.reviewer: xuehongg, v-paulsh
---
# The MQSeries Adapter no longer retrieves messages from a clustered MQSeries queue manager when the queue manager fails over to a different cluster node

This article helps you work around the problem where MQSeries Adapter no longer retrieves messages from a clustered MQSeries queue manager when the queue manager fails over to a different cluster node.

_Original product version:_ &nbsp; BizTalk Server 2020, BizTalk Server 2016, BizTalk Server 2013, BizTalk Server 2010, BizTalk Server 2009  
_Original KB number:_ &nbsp; 893059

## Symptoms

You configure the Microsoft BizTalk Server Adapter for MQSeries to receive messages from a clustered MQSeries queue manager. If the queue manager fails over to a different cluster node, the MQSeries Adapter no longer retrieves messages from the clustered queue. When this behavior occurs, the following event is logged in the Application log:

> Event Type: Warning  
Event Source: BizTalk Server 20xx  
Event Category: BizTalk Server 20xx  
Event ID: 5740  
Date: 12/31/2006 Time: 11:12:13 AM  
User: N/A  
Computer:  
Description: The adapter "MQSeries" raised an error message. Details "Error encountered on opening Queue Manager name = MYQMNAME Reason code = 2059.".

> [!NOTE]
> In this log entry, `<20xx>` represents the actual version number, and `<MYQMNAME>` represents the actual Queue Manager name.

## Workaround

To work around this issue, create a scheduled task on both nodes. To do this, follow these steps:

1. On the active node, open **Services.msc**. You should see two MSDTC services listed: One that is local and has no GUID, and one that is clustered and has a GUID.
2. At an elevated command prompt, run the following command:

    ```console
    sc queryex | find /I "Transaction"
    ```

    The command output contains the GUID that you must use for the script in this procedure. The GUID: `Distributed Transaction Coordinator (01234567-89ab-cdef-0123-456789abcdef)`

3. Save the following code to a file, and name the file *Shutdownmqadapter.vbs*. You can save the file to any disk other than the quorum disk.

    > [!NOTE]
    > In this code, the indicated GUID (`01234567-89ab-cdef-0123-456789abcdef`) is a placeholder. Replace this GUID with the actual clustered MSDTC GUID that you noted in step 2.

    ```vbscript
    Option Explicit
    On Error Resume Next
    Dim sComputerName, oWMIService, colRunningServices, oService, colProcessList, objProcess 
    If Wscript.Arguments.Count = 0 Then  
      sComputerName = "."  
      Call ServStat  
      Wscript.Quit
    End If
    Sub ServStat
    Set oWMIService  = GetObject("winmgmts:" _  
      & "{impersonationLevel=impersonate}!\\" & sComputerName& "\root\cimv2")
    Set colRunningServices = oWMIService.ExecQuery _  
      ("Select * from Win32_Service where DisplayName='Distributed Transaction Coordinator (01234567-89ab-cdef-0123-456789abcdef)'")
    For Each oService in colRunningServices  
       'Wscript.Echo oService.DisplayName  & VbTab & oService.State  
       If (oService.State="Stopped") Then
          'Wscript.Echo "Stopped"
          'find the dllhost
           Set colProcessList = oWMIService.ExecQuery ("SELECT * FROM Win32_Process WHERE Name = 'DLLHOST.EXE'")
           For Each objProcess in colProcessList
             If inStr(objProcess.CommandLine, "C691D827-19A0-42E2-B5E8-2892401481F5")>0 Then
                'Wscript.Echo objProcess.ProcessId
                Dim objShell
                Set objShell = CreateObject("WScript.Shell")
                objShell.Run "cmd /k taskkill /F /PID " & objProcess.ProcessId & "& exit"
                WScript.Quit
             End If
           Next  
        End If
    Next
    End Sub
    ```

4. Select **Start**, type *task*, and then select **Task Scheduler** in the results list.
5. In Task Scheduler, select **Action** > **Create Basic Task**.
6. Run through the wizard screens to create a scheduled task that runs the *Shutdownmqagent.vbs* file daily.

> [!NOTE]
> For the 6 step, set the schedule to start at midnight and repeat every 1 minute for 24 hours.  
>
> Earlier BizTalk versions may have a different MQSAgent COM+ GUID. They may have `6D06157A-730B-4CB3-BD11-D48AC6B8A4BB` instead of `C691D827-19A0-42E2-B5E8-2892401481F5`. Therefore, you may have to change the existing script after you upgrade the product.

## More information

Even if the IBM MQ queue manager is running as a clustered resource in a failover cluster role, you should not cluster the MQSAgent COM+ application. This is because DLLHost.exe, which is running the COM+ application, is not cluster-aware. You must have the MQSAgent COM+ application installed and configured individually on both nodes.  
To ensure high availability, make sure that you use both the clustered IBM MQ queue manager resource and the clustered MSDTC resource in the same cluster role together with the monitoring script from the [Workaround](#workaround) section.

## Applies to

- BizTalk Server 2020 Enterprise
- BizTalk Server 2016 Enterprise
- BizTalk Server 2013 R2 Enterprise
- BizTalk Server 2013 Enterprise
- BizTalk Server Enterprise 2010
- BizTalk Server 2009 Enterprise
