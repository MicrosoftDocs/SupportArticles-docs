---
title: Issue while running the action 'Run PowerShell script'
description: Resolves an error that occurs in the action 'Run PowerShell script', when you run a desktop flow in Microsoft Power Automate for desktop.
ms.author: yiannismavridis
ms.reviewer: 
ms.custom: sap:Desktop flows
ms.date: 04/03/2025

---
# Issue while running the action 'Run PowerShell script'

This article provides a resolution for an error that occurs in the action 'Run PowerShell script', when you run a desktop flow in Microsoft Power Automate for desktop.

## Symptoms

During a flow run, an error occurs while running the action 'Run PowerShell script'. This can also occur due to a Windows update.

## Detection

The error message contains the following:

```
Microsoft.Flow.RPA.Desktop.Modules.SDK.ActionException: Failed to run PowerShell script. ---> System.ComponentModel.Win32Exception: The system cannot find the file specified
   at System.Diagnostics.Process.StartWithCreateProcess(ProcessStartInfo startInfo)
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.SystemActions.RunPowershellScript(Variant powershellCode, Variant& scriptStandardOutput, Variant& scriptErrorOutput)
   --- End of inner exception stack trace ---
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.RunPowershellScript.Execute(ActionContext context)
   at Microsoft.Flow.RPA.Desktop.Robin.Engine.Execution.ActionRunner.Run(IActionStatement statement, Dictionary`2 inputArguments, Dictionary`2 outputArguments)
```

## Cause

The `Run Powershell script` action internally starts an instance of `powershell.exe` while also providing the specified script of the action's input as an argument to the process.

If the system is not able to find `powershell.exe`, it will throw the mentioned runtime error to the user.

The most probable cause for this is the PATH environment variable not including the folder of the `powershell.exe` executable.

To ensure that this is the cause for this problem, users can launch a Command Prompt (CMD) window and try to launch `powershell.exe` from there. If the message 
`'powershell.exe' is not recognized as an internal or external command, operable program or batch file.` 
is shown as a result, this is the root cause of the error.

## Resolution

Edit the `PATH` environment variable and add the missing path, the folder of the executable `powershell.exe`.

On most occasions, the missing path will be `"C:\WINDOWS\System32\WindowsPowerShell\v1.0\"` but to get the actual path, you could launch a PowerShell terminal and run `$PsHome`.

