---
title: Orchestrator runbooks, folders, or statistics aren't displayed or updated
description: Fixes an issue in which Orchestrator runbooks, folders, or statistics aren't displayed or updated in the System Center Orchestration console.
ms.date: 08/04/2020
---
# Orchestrator runbooks, folders, or statistics aren't displayed or updated in the Orchestration console

This article helps you fix an issue in which Orchestrator runbooks, folders, or statistics aren't displayed or updated in the System Center Orchestrator Orchestration console.

_Original product version:_ &nbsp; Microsoft System Center 2012 Orchestrator  
_Original KB number:_ &nbsp; 2738490

## Symptoms

You may experience one of the following problems while using the System Center Orchestrator Orchestration console or when accessing System Center Orchestrator data using the web service:

- New runbooks or folders that have been created using the Runbook Designer aren't displayed even though the user has the appropriate permissions to see them.

- Summary pages have incorrect results for all statistics.

## Cause

System Center Orchestrator uses a series of scheduled tasks executed by Microsoft SQL Server Service Broker timer conversations. One or more of these conversations is being ended without a new conversation being established.

## Resolution

This problem is resolved in System Center 2012 Service Pack 1.
