---
title: How to capture debug stream in Azure Automation runbooks
description: Provides information about how to capture debug stream data by using Azure Automation runbooks.
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.service: automation
ms.author: genli
author: genli
ms.reviewer: genli
---
# How to capture debug stream in Azure Automation runbooks

This article provides information about how to capture debug stream data by using Azure Automation runbooks.

_Original product version:_ &nbsp; Azure Automation  
_Original KB number:_ &nbsp; 4022768

By default Azure Automation does not capture any debug stream data.  Only output, error and warning data are captured as well as verbose data if the runbook is configured to capture it.

In order to capture debug stream data we have to perform two actions in our runbooks:

1. Set the variable **$GLOBAL:DebugPreference="Continue"** which tells PowerShell to continue whenever a debug message is encountered.  The $GLOBAL: portion tells PowerShell to do this in the global scope rather than whatever local scope the script is in at the time the statement is executed.
2. Redirect the debug stream that we don't capture to a stream that we do capture such as output. This is done by setting PowerShell redirection against the statement to be executed.  For more information on PowerShell redirection, see [About Redirection](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7).

## Examples

Given the following runbook:

```powershell
Write-Output "This is an output message." 
Write-Debug "This is a debug message."
```

If this runbook were to be executed as it is, the output pane for the runbook job in Azure Automation would display the following:

> This is an output message.

Given the following runbook:

```powershell
Write-Output "This is an output message." 
$GLOBAL:DebugPreference="Continue" 
Write-Debug "This is a debug message." 5>&1
```

If this runbook were to be executed, the output pane would now display the following:

> This is an output message.  
This is a debug message.

This occurs because the statement $GLOBAL:DebugPreference="Continue" tells PowerShell to display debug messages and then continue and the addition of 5>&1 to the end of any statement, which tells PowerShell to redirect stream 5 (debug) to stream 1 (output).
