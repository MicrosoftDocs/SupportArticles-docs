---
title: Unhandled exception running a task against an agent
description: Describes an unhandled exception error that occurs when you run a task against an agent in the System Center Essentials 2010 console.
ms.date: 08/18/2020
ms.prod-support-area-path: 
---
# Unhandled exception in the System Center Essentials 2010 console when running a task against an agent

This article describes an unhandled exception error that occurs when you run a task against an agent in the System Center Essentials 2010 console.

_Original product version:_ &nbsp; Microsoft System Center Essentials 2010  
_Original KB number:_ &nbsp; 2815144

## Symptoms

When running a task against an agent in the System Center Essentials 2010 console, you may receive an error similar to the following example:

> Unhandled exception has occurred in your application. If you click Continue, the application will ignore this error and attempt to continue. If you click Quit, the application will close immediately.
>
> Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED)).

When you select **Continue**, the task completes.

## Cause

This issue is known to occur if Internet Explorer 9 is installed on System Center Essentials Server.

## Workaround

This error can be safely ignored. To work around the issue, click **Continue** when you receive the error and the task will complete successfully.
