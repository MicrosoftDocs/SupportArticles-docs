---
title: Failed to Run PowerShell Script Error
description: Solves an error that occurs when you run the Run PowerShell script action in a desktop flow in Microsoft Power Automate for desktop.
ms.author: iomavrid
author: yiannismavridis
ms.custom: sap:Desktop flows
ms.date: 04/18/2025
---
# "Failed to run PowerShell script" error when running the Run PowerShell script action

This article provides a resolution for an error that occurs when running the [Run PowerShell script](/power-automate/desktop-flows/actions-reference/scripting#runpowershellscript) action in Microsoft Power Automate for desktop.

## Symptoms

During the execution of a desktop flow in Power Automate for desktop, an error occurs when running the **Run PowerShell script** action. This issue might also occur after a recent Windows update.

The error message appears as follows:

```output
Microsoft.Flow.RPA.Desktop.Modules.SDK.ActionException: Failed to run PowerShell script. ---> System.ComponentModel.Win32Exception: The system cannot find the file specified
   at System.Diagnostics.Process.StartWithCreateProcess(ProcessStartInfo startInfo)
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.SystemActions.RunPowershellScript(Variant powershellCode, Variant& scriptStandardOutput, Variant& scriptErrorOutput)
   --- End of inner exception stack trace ---
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.RunPowershellScript.Execute(ActionContext context)
   at Microsoft.Flow.RPA.Desktop.Robin.Engine.Execution.ActionRunner.Run(IActionStatement statement, Dictionary`2 inputArguments, Dictionary`2 outputArguments)
```

## Cause

The **Run PowerShell script** action internally starts an instance of `powershell.exe` and provides the script specified in the action's input as an argument for the process. If the system fails to find `powershell.exe`, you might receive the error message.

The most likely cause of this issue is that the **Path** environment variable doesn't include the directory containing the `powershell.exe` executable. To confirm this is the root cause, follow these steps:

1. Open a Command Prompt (CMD) window.
1. Run `powershell.exe` by typing the command and pressing **Enter**.

If the following message occurs, then the issue lies in the missing path to `powershell.exe` in the **Path** environment variable.

> 'powershell.exe' is not recognized as an internal or external command, operable program or batch file.

## Resolution

To resolve this issue, follow these steps to update the **Path** environment variable to include the directory of the `powershell.exe` executable:

1. Open the Start menu, search for **Environment Variables**, and then select **Edit the system environment variables**.

1. In the **System Properties** window, select **Environment Variables**.

1. Under the **System variables** section, locate and select the **Path** variable, and then select **Edit**.

1. Add the directory path of `powershell.exe` to the list of paths.

   In most cases, the missing path is **C:\WINDOWS\System32\WindowsPowerShell\v1.0\\**.

   To confirm the correct path, open a PowerShell terminal and run the `$PsHome` command.

   Use the displayed path as the value to add to the **Path** variable.

1. Select **OK** to save changes and close all dialogs.
