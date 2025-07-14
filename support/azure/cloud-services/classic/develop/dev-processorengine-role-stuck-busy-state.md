---
title: ProcessorEngine role is stuck in Busy state
description: Provide information about troubleshooting issues in which the ProcessorEngine role is stuck in Busy state when deploying cloud service application to Azure.
ms.date: 09/26/2022
ms.reviewer: 
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# ProcessorEngine role is stuck in Busy state stating: Preparing to start role... System is initializing

This article provides information about troubleshooting issues in which the ProcessorEngine role is stuck in Busy state when deploying cloud service application to Azure.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464894

> [!NOTE]
> Refer to the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the fourth scenario of the lab. Make sure you have followed the lab setup instructions for **Super Convertor** application as per [this](https://github.com/prchanda/superconvertor), to recreate the problem.

## Symptoms

When deploying the cloud service application to Azure, you find that **ProcessorEngine** role is stuck in **Busy** state and never comes out of it. The Azure portal blade shows a message:

> Preparing to start role... System is initializing.

## Troubleshoot steps

If a role is stuck in **Busy** state, it indicates that there is something wrong with the application that is keeping the role instance from running. Check your application code to see if the [StatusCheck](/previous-versions/azure/reference/ee758135(v=azure.100)?redirectedfrom=MSDN) event is handled and as per [Microsoft Azure Role Architecture](/archive/blogs/kwill/windows-azure-role-architecture)
**WaHostBootstrapper** process is responsible for:

1. Read the role configuration and start up all of the appropriate tasks and processes to configure and run the role.
2. Monitor all of its child processes.
3. Raise the StatusCheck event on the role host process.

The best place to start the troubleshooting is to remote connect to the instance using RDP and inspect **WaHostBootstrapper.log** file present under the path `C:\Resources`. Upon checking the folder, you might find that there is only one log file that means that **WaHostBootstrapper** has only tried to start one time and it isn't recycling due to an error. See what's inside the **WaHostBootstrapper.log** file:

```output
[00003604:00002604, 2018/08/13, 03:08:21.214, ERROR] <- WapXmlReadRoleModel=0x1 [00003604:00002604, 2018/08/13, 03:08:21.979, ERROR] <- WapXmlReadContainerId=0x1 [00003604:00002604, 2018/08/13, 03:08:22.026, ERROR] <- WapGetVirtualAccountName=0x1 [00003604:00002604, 2018/08/13, 03:08:22.026, ERROR] <- WapGetAppCmdPath=0x1 [00003604:00002604, 2018/08/13, 03:08:22.026, ERROR] <- WapSetDefaultEnvironment=0x1 [00003604:00002604, 2018/08/13, 03:08:22.014, ERROR] <- WapGetAppHostConfigPath=0x1 [00003604:00002604, 2018/08/13, 03:08:22.045, ERROR] <- GetDebugger=0x1 [00003604:00002604, 2018/08/13, 03:08:22.092, ERROR] <- GetStartupTaskDebugger=0x1 [00003604:00002604, 2018/08/13, 03:08:22.389, ERROR] <- WapGetEnvironmentVariable=0x800700cb **[00003604:00002604, 2018/08/13, 03:08:22.405, WARN ] Executing Startup Task type=0 rolemodule=(null) cmd="E:\approot\.\startup.cmd"[00003604:00002604, 2018/08/13, 03:08:22.405, WARN ] Executing "E:\approot\.\startup.cmd" .**
```

From the above log, it looks like the process is stuck while running a startup script named `startup.cmd` present under `E:\approot` directory. If comparing the timestamp of the last entry (**2018/08/13, 03:08:22.405**) with that of current system time (**2018/08/13, 04:16:13.132**), you might see that the host bootstrapper process has been trying to run the startup script for more than an hour. An interesting point to be noted is that, **Startup Task type=0**, which means it is a simple startup task that causes the system to wait for the task to exit before continuing execution. Refer [this](/azure/cloud-services/cloud-services-startup-tasks) link to know more about startup task type.

Microsoft Azure Bootstrapper event viewer log shows the same piece of information:

:::image type="content" source="media/scenario-4-processorengine-role-stuck-busy-state/event-viewer-log.png" alt-text="Screenshot of the event viewer log.":::

Hence the next step is to check the functionality of this startup script. the script is running an executable 'setup.exe', which takes a command line 'configuration.xml'. The output of the script processing is logged in 'StartupLog.txt' file created under RoleTemp directory.

```output
REM If WINWORD.EXE and EXCEL.EXE exists, then required office binaries are already installed.
IF "%ComputeEmulatorRunning%" == "true" (
GOTO Finish
)ELSE (
IF EXIST "D:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE" (
ECHO Startup has already configured and installed required word processing binaries. Exiting. >> "%TEMP%\StartupLog.txt" 2>&1
GOTO Finish
)
IF EXIST "D:\Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE" (
ECHO Startup has already configured and installed required excel processing binaries. Exiting. >> "%TEMP%\StartupLog.txt" 2>&1
GOTO Finish
)
REM Run your real exe task
ECHO Running setup.exe >> "%TEMP%\StartupLog.txt" 2>&1
start /wait %~dp0setup.exe /configure %~dp0configuration.xml >> %TEMP%\StartupLog.txt 2>>&1
ECHO Creating Desktop directory >> "%TEMP%\StartupLog.txt" 2>&1
MKDIR "D:\Windows\System32\config\systemprofile\Desktop"
IF %ERRORLEVEL% EQU 0 (
REM The application installed without error.
ECHO The application installed without error. > "%RoleRoot%\Success.txt"
) ELSE (
REM An error occurred. Log the error and exit with the error code.
DATE /T >> "%TEMP%\StartupLog.txt" 2>&1
TIME /T >> "%TEMP%\StartupLog.txt" 2>&1
ECHO An error occurred running the setup. Errorlevel = %ERRORLEVEL%. >> "%TEMP%\StartupLog.txt" 2>&1
EXIT %ERRORLEVEL%
)
)
:Finish
REM Exit normally.
EXIT /B 0
```

Navigate to the path `C:\Resources\temp\{Deployment ID}.ProcessorEngine\RoleTemp` and analyze the log file 'StartupLog.txt'. Basically it says - "**Running setup.exe", which means the script has not completed execution of setup.exe, it's still running. While running the executable from command prompt, you might find that 'configuration.xml' is missing from `E:\approot` location and hence it was leading to startup task failure. That's the root cause of the problem.

In Visual Studio, the **Copy to Output Directory** property for your startup batch file or any other dependent files should be set to **Copy Always** to be sure that your startup batch file is properly deployed to your project on Azure (**approot\bin** for Web roles, and **approot**  for worker roles). However in this case **Copy to Output Directory** was set to **Do not copy** for 'configuration.xml' file.

:::image type="content" source="media/scenario-4-processorengine-role-stuck-busy-state/configurationxml-file.png" alt-text="Screenshot shows the configuration.xml file properties.":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
