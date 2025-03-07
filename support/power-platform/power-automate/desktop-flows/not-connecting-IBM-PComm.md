---
title: Unable to Connect to IBM PComm Session
description: This article addresses the issue of being unable to connect to an IBM PComm session using the Open Terminal Session action with the HLLAPI provider.
ms.custom: sap:Desktop flows
ms.date: 03/07/2025
ms.author: nimoutzo 
author: nimoutzo
---
# Unable to Connect to IBM PComm Session

This article addresses the issue of being unable to connect to an IBM PComm session using the Open Terminal Session action with the HLLAPI provider.

## Symptoms

When attempting to use the Open Terminal Session action with the HLLAPI provider to connect to the IBM PComm terminal emulator, the following error is encountered:
```Exception of type 'Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Common.TerminalEmulationActionException' was thrown.: Microsoft.PowerPlatform.PowerAutomate.Desktop.Actions.SDK.ActionException: Error communicating with the emulator ---> Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Common.TerminalEmulationActionException: Exception of type 'Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Common.TerminalEmulationActionException' was thrown.
   at Microsoft.Flow.RPA.Desktop.BridgeToHLLAPI.HLLAPIActionsImpl.<>c__DisplayClass16_0.<Open>b__0()
   --- End of inner exception stack trace ---
   at Microsoft.Flow.RPA.Desktop.Modules.TerminalEmulation.Actions.OpenTerminalSession.Execute(ActionContext context)
   at Microsoft.Flow.RPA.Desktop.Robin.Engine.Execution.ActionRunner.Run(IActionStatement statement, Dictionary`2 inputArguments, Dictionary`2 outputArguments)
```

## Applicable Versions
All PAD versions

## Modes

- Unattended
- Attended
- Console/Designer

## Root Cause
The terminal emulator requires access to HLLAPI DLLs, which are not supported.

## Workaround
To resolve this issue, download and install the 64-bit version of IBM PComm.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
