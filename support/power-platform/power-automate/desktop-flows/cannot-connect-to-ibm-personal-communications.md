---
title: Unable to Connect to IBM Personal Communications Session
description: Solves an issue where you can't connect to an IBM Personal Communications session using the Open terminal session action with the HLLAPI provider.
ms.custom: sap:Desktop flows
ms.date: 03/17/2025
ms.author: nimoutzo 
author: NikosMoutzourakis
---
# Can't connect to an IBM Personal Communications session

This article provides a resolution for an issue where you can't connect to an IBM Personal Communications session using the [Open terminal session](/power-automate/desktop-flows/actions-reference/terminalemulation) action with the HLLAPI provider in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate for desktop

## Symptoms

When you try to use the **Open terminal session** action with the HLLAPI provider to connect to the IBM Personal Communications terminal emulator, you might receive the following error message:

```output
Exception of type 'Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Common.TerminalEmulationActionException' was thrown.: Microsoft.PowerPlatform.PowerAutomate.Desktop.Actions.SDK.ActionException: Error communicating with the emulator ---> Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Common.TerminalEmulationActionException: Exception of type 'Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Common.TerminalEmulationActionException' was thrown.
   at Microsoft.Flow.RPA.Desktop.BridgeToHLLAPI.HLLAPIActionsImpl.<>c__DisplayClass16_0.<Open>b__0()
   --- End of inner exception stack trace ---
   at Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Actions.OpenTerminalSession.Execute(ActionContext context)
   at Microsoft.Flow.RPA.Desktop.Robin.Engine.Execution.ActionRunner.Run(IActionStatement statement, Dictionary`2 inputArguments, Dictionary`2 outputArguments)
```

## Desktop flow run modes

- Unattended
- Attended
- Console/Designer

## Cause

The IBM Personal Communications terminal emulator requires access to HLLAPI DLLs for proper operation. However, the HLLAPI implementation in IBM PComm v14 32-bit may produce an error. This issue appears to stem from a problem with their implementation.

## Resolution

To resolve this issue, download and install the [64-bit version of IBM Personal Communications](https://www.ibm.com/docs/en/personal-communications).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
