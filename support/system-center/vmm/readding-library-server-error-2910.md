---
title: Error 2910 re-adding a library server
description: Fixes an issue in which you receive error 2910 when re-adding a library server to System Center 2012 Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Error 2910 re-adding a library server to System Center 2012 Virtual Machine Manager

This article fixes an issue in which you receive error 2910 when re-adding a library server to System Center 2012 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2679682

## Symptoms

When you remove a library server from System Center 2012 Virtual Machine Manager and then immediately add it back as a library server, you may receive the following error:

> Error 2910  
> VMM does not have appropriate permissions to access the resource NO_PARAM on the NO_PARAM server

## Cause

The agent removal process is still in the process of creating a failure for the new install job.

## Resolution

To resolve this issue, wait a few seconds and then retry the installation again. If it continues to fail, restart the library server to stop any agent process that may be preventing the installation, then try the installation again.
