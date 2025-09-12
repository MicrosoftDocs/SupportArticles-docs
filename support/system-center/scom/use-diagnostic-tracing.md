---
title: Use diagnostic tracing
description: Describes the tools that you can use to obtain trace logs in System Center Operations Manager and in System Center Essentials. A Microsoft CSS representative uses these trace logs to perform advanced troubleshooting.
ms.date: 04/15/2024
ms.reviewer: cliveea, v-jomcc
---
# Use diagnostic tracing in System Center Operations Manager and in System Center Essentials

This article describes how to use diagnostic tracing in Microsoft System Center Essentials 2010 and System Center Operations Manager.

_Original product version:_ &nbsp; Microsoft System Center Essentials 2010, Microsoft System Center Operations Manager 2007  
_Original KB number:_ &nbsp; 942864

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry,  see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Introduction

We recommend that you perform diagnostic tracing only in association with a Microsoft Customer Support Services (CSS) representative. We recommend this because the generated traces contain information about the context of a text-based trace message. However, in Microsoft System Center Operations Manager 2007 and in Microsoft System Center Essentials 2007, this trace information is not in a human-readable format. After the traces are converted by a CSS representative, human-readable text is available. However, this text contains only low-level information such as source-code file names, locations, source-code functions, and return codes. This information may be helpful if you have to troubleshoot a complex issue.

In System Center Essentials 2010, System Center Operations Manager 2007 SP1, and later versions, trace message files (TMF) are supplied which allow for conversion of binary trace files to text. However, we strongly recommend that you do diagnostic tracing only when it's required and only with the consultation of a Microsoft representative.

System Center Operations Manager 2007 and System Center Essentials 2007 implement a diagnostic tracing method that differs from earlier versions of Microsoft Operations Manager. This new tracing method creates binary files in which to store tracing information. Because this new tracing method is implemented at the Windows kernel level, it's highly efficient, and it can log tens of thousands of trace messages per second.

This article discusses the tools that are available to start and to stop tracing if you're asked to do this by a Microsoft CSS representative. The article also discusses the new functionality that's provided in System Center Essentials 2010, in System Center Essentials 2007 SP1, in System Center Operations Manager 2007 SP1, and in later versions.

## Tracing tools location

The installation folder for each role, such as the Agent role, the Management Server role, or the Gateway role, contains a folder that's named Tools. The following files are located in the Tools folder:

- StartTracing.cmd
- StopTracing.cmd
- TracelogSM.exe
- TracingGuidsBid.txt
- TracingGuidsUI.txt
- TracingGuidsNative.txt
- TracingReadMe.txt

System Center Essentials 2010, System Center Essentials 2007 SP1, and System Center Operations Manager 2007 SP1 introduce the following additions:

- FormatTracing.cmd
- ViewRealtimeTracing.cmd
- TraceFmtSM.exe
- OpsMgrTraceTMF.cab
- Default.tmf
- System.tmf

## Start tracing

> [!NOTE]
> In System Center Essentials 2010, System Center Operations Manager 2007 SP1, and later versions, tracing is automatically started on both the Agent role and the Management Server role. Tracing will use error output only. Binary trace files are written to the `windows\logs\OpsMgrTrace` folder. Before the tracing level for trace output can be changed, tracing must first be stopped.

To start diagnostic tracing, follow these steps:

1. On the computer on which you want to start tracing, select **Start**, select **Run**, type **cmd**, and then click **OK**.
2. At the command prompt, use the `cd` command to change to the Tools directory.
3. Type `StartTracing LEVEL`, and then press **ENTER**. In this command, replace _LEVEL_ with the tracing level that you want. Use uppercase characters to specify the tracing level. The following levels are available:

   - ERR
   - WRN
   - INF
   - VER

    For example, type `StartTracing WRN`.

When you start tracing, the trace output is written to the following binary files:

- MOMTraceNative.etl
- MOMTraceBID.etl
- MOMTraceUI.etl

For Windows 7, Windows Server 2008, Windows Server 2008 R2, and later versions, the files are located at `windows\logs\OpsMgrTrace`.

## Stop tracing

To stop diagnostic tracing, follow these steps:

1. Select **Start**, select **Run**, type **cmd**, and then click **OK**.
2. At the command prompt, use the `cd` command to change to the Tools directory.
3. Type `StopTracing.cmd`, and then press **ENTER**.

## Convert existing traces to text format

To convert existing trace files to text tracing, you have to stop tracing first by using the `StopTracing.cmd` command.

> [!NOTE]
> Information within the converted traces is of a very low level detail (debug level). Therefore, the converted traces require knowledge of the source code and of the component that is being traced. We recommend that trace conversion be performed only when it's required by a CSS representative.

1. Select **Start**, select **Run**, type **cmd**, and then click **OK**.
2. At the command prompt, use the `cd` command to change to the Tools directory.
3. Type `FormatTracing.cmd`, and then press **ENTER**.

The first time that the `FormatTracing.cmd` command is executed, the trace files that are required to convert traces are extracted to the _SystemDrive\Program Files\System Center Operations Manager\Tools\TMF_ folder. Then, the `FormatTracing.cmd` batch file enumerates each trace file (*.etl) in the `windows\logs\OpsMgrTrace` folder. Then, the TraceFMTSM.exe utility converts the files to text. The text output is written to a file of the same name with the extension .log in the `windows\logs\OpsMgrTrace` folder. A summary (.sum) file is also written to the same location for each file that is converted. This file details each trace message event converted.

## View converted trace files

Trace files that are converted to text by using the `FormatTracing.cmd` batch file can be viewed by using a text editor, such as Notepad.

## Boot time tracing is enabled by default

On a typical management server installation, three trace sessions begin when the HealthService service is started. By default, only error tracing is done. Little information is written to the trace files. The default trace file location and names that are created are as follows:

|Folder|File name|Description|
|---|---|---|
|`windows\logs\OpsMgrTrace`|TracingGuidsBID.etl|Trace output for managed code components|
|`windows\logs\OpsMgrTrace`|TracingGuidsNative.etl|Trace output for native code components|
|`windows\logs\OpsMgrTrace`|TracingGuidsUI.etl|Trace output for managed code user interface (OpsMgr UI)|
  
Each session is enabled with circular tracing and has a maximum file size of 100 megabytes (MB). The typical .etl file size for a newly created .etl file is 16 kilobytes (KB).

> [!NOTE]
> Although an Operations Manager role, such as an Agent role, doesn't contain managed or user interface tracing messages, the three default trace .etl files will be created by default when the HealthService service is started. By default, no trace sessions are started on a user interface only role.

## Disable boot time tracing

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Three trace providers are started automatically on any role that contains the HealthService service. The trace files are written to the `windows\logs\OpsMgrTrace` folder. Typically, the .etl files in this folder will be small, especially for the Agent role. However, for the management server role, if the Operations Manager installation becomes unhealthy, one or more of these files could potentially grow to the maximum configured size of 100 MB each. These files include the following:

- TracingGuidsBid.etl
- TracingGuidsNative.etl
- TracingGuidsUI.etl
- previous .etl files

If you have to disable debug level tracing because of a small boot partition size, you can add a registry value to the computer that is running the Management Server role or the Agent role on which you want to disable tracing. To do this, follow these steps.

> [!NOTE]
> If tracing is disabled, it may affect future troubleshooting of Operations Manager because any low level tracing information will be lost. Future hotfixes, service packs, or product updates may remove the registry entry and enable tracing again. By default, this registry key doesn't exist. Default tracing is enabled if you remove this registry key or change its value to **0**.

1. Select **Start**, select **Run**, type **regedit**, and then click **OK**.
2. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Operations Manager\3.0\`

3. Create a subkey named `Tracing`.
4. In the **Details** pane, create a **REG_DWORD** value named `DisableAutoTracing`.
5. In the **Value data** field, type **1**, and then click **OK**.
6. Exit Registry Editor.

If you execute the `StopTracing.cmd` batch file from the Tools folder, the Operations Manager trace sessions will be stopped. The .etl files in the `windows\logs\OpsMgrTrace` folder can be deleted if they're no longer required to regain disk space.

## Move the default location of trace file output

If an Operations Manager Server role or Agent role is installed on a computer where the boot partition space is limited, you may have to move the default location of trace files (\*.etl). To do this, follow these steps:

1. Create a new folder on a local disk that has sufficient capacity to house the files. Three default trace files at a maximum of 100 MB each and three previously used trace files at a maximum of 100 MB each equals a total potential trace file capacity of 600 MB.

2. Set at least the following NT File System (NTFS) permissions on the folder, SYSTEM = **Full Control**, Administrators = **Full Control**.

3. Locate and open the StartTracing.cmd batch file in the Tools installation folder. Use a text editor, such as Notepad.

4. In the StartTracing.cmd batch file, locate the `SET OpsMgrTracePath` statement. Replace the default value with the path of the new location. Delimit the path with speech marks (") if the path contains a space character.

5. Save the changes to the StartTracing.cmd file.

6. To start tracing to the new folder, run the `StopTracing.cmd` batch file. Then, run the `StartTracing.cmd` batch file. After you run the `StartTracing.cmd` batch file, the following files are written to the new folder:

   - TracingGuidsBid.etl
   - TracingGuidsNative.etl
   - TracingGuidsUI.etl

7. Before you use the `FormatTracing.cmd` command to convert traces to text, you must edit the `FormatTracing.cmd` command to change the `OpsMgrTracePath` variable to point to the new trace file folder.

Future hotfixes, service packs, or product updates may change the files in the Tools folder. This changes the functionality back to the default functionality. We recommend that you check for more changes after you do updates.

## View real time tracing

We recommend that you don't use the `ViewRealTimeTracing.cmd` batch file to view real-time traces in a production environment without advice from Microsoft CSS. Viewing traces in real time, especially when you use Information trace level settings or verbose trace level settings, may severely affect server performance.

The first time that the `ViewRealTimeTracing.cmd` file is executed, the trace files that are required to convert traces are extracted to the _SystemDrive\Program Files\System Center Operations Manager\Tools\TMF_ folder. The `ViewRealTimeTracing.cmd` batch file then enumerates each trace session definition file (Tools\TracingGuids*.txt) in the Tools folder. Then, a separate instance of `TraceFmtSM` is started within a Command Prompt window. Output of trace sessions for managed, native, and UI-managed traces are output to each window.

The `ViewRealTimeTracing.cmd` batch file accepts a single, optional command-line parameter (`-ods`). Supplying this parameter will additionally output trace data to a debugger.

## References

For more information about diagnostic tracing, browse to [Microsoft Learn](/). Then, search **Event tracing for Windows**.
