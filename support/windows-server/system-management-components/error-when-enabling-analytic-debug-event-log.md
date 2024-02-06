---
title: Fail to enable analytic or debug event log
description: Fixes an error (The requested operation cannot be performed over an enabled direct channel. The channel must first be disabled before performing the requested operation) that occurs when you enable analytic or debug event log
ms.date: 12/07/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:microsoft-management-console-mmc, csstroubleshoot
---
# Error when enabling analytic or debug event log: The requested operation cannot be performed over an enabled direct channel. The channel must first be disabled before performing the requested operation

This article helps to fix an error that occurs when you enable analytic or debug event log.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2488055

## Symptoms

You may receive the following error when you attempt to enable or change the properties of an analytic or debug event login Event Viewer:

> Query Error  
> One or more logs in the query have errors.  
> The requested operation cannot be performed over an enabled direct channel. The channel must first be disabled before performing the requested operation.

:::image type="content" source="media/error-when-enabling-analytic-debug-event-log/error-message-dialog-box.png" alt-text="Screenshot of the Query Error window which shows One or more logs in the query have errors.":::

When attempting changes with the Wevtutil tool, you may receive the following error:

> The channel fails to activate.  
> Failed to save configuration or activate log \<log name>.  
> The requested operation cannot be performed over an enabled direct channel. The channel must first be disabled before performing the requested operation.

You must first select **View**, **Show Analytic and Debug Logs** in Event Viewer to make analytic and debug logs visible in Event Viewer. For example, the **WMI-Activity** log (full name **Microsoft-Windows-WMI-Activity/Trace**) is located in **Applications and Services Logs\Microsoft\Windows\WMI-Activity\Trace**.

## Cause

For analytic and debug logs, Event Viewer doesn't allow events to be queried or viewed if the log is both enabled and has **Overwrite events as needed (oldest events first)** configured.

This isn't the case for administrative and operational logs such as System, Application and Security logs, which can be viewed when **Overwrite events as needed (oldest events first)** is configured.

Analytic and debug logs by default are configured for **Do not overwrite events (Clear logs manually)**. For circular logging where old events are discarded when the maximum log size is reached, you would enable **Overwrite events as needed (oldest events first)**.

Logging is taking place even though this error is displayed. The error only means you can't view the events that are currently being logged.

## Resolution

You can view an analytic or debug log while it's enabled as long as you don't set **Overwrite events as needed** in Event Viewer, which in Wevtutil is configured using `/retention:false` or `/rt:false`.
If you set **Overwrite events as needed** (`/retention:false`) because you need circular logging, you must first disable that log before you can view the events.
For example, to use the Wevtutil tool to enable the WMI-Activity log, set Overwrite events as needed and change the size to 150 MB (default is 1024 KB), you can run the following command:

```console
wevtutil set-log "Microsoft-Windows-WMI-Activity/Trace" /enabled:false
wevtutil set-log "Microsoft-Windows-WMI-Activity/Trace" /enabled:true /quiet:true /retention:false /maxsize:153600
```

After the issue has reproduced, disable the log and export it for review.

```console
wevtutil set-log "Microsoft-Windows-WMI-Activity/Trace" /enabled:false
wevtutil export-log "Microsoft-Windows-WMI-Activity/Trace" %temp%\%computername%_WMI-Activity.evtx
```
