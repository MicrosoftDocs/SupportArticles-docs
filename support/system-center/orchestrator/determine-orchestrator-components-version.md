---
title: Determine the version of Orchestrator components
description: Describes how to determine the version of your current System Center Orchestrator components.
ms.date: 08/04/2020
---
# How to determine the version of System Center Orchestrator components

This article describes how to determine the version of System Center Orchestrator components.

_Original product version:_ &nbsp; Microsoft System Center 2012 Orchestrator  
_Original KB number:_ &nbsp; 2748951

## Determine the version of Runbook Designer and management server

To determine the version of System Center Orchestrator Runbook Designer and the version of the management server that it's connected to, start the Runbook Designer application, connect to the desired management server, and then click **About** on the **Help** menu.

Scroll down inside the Version Information box to see the versions of the various libraries installed on the Runbook Designer.

## Determine the version of runbook servers

To determine the version of System Center Orchestrator runbook servers, start the Runbook Designer application, connect to the desired management server, and then click **Runbook Servers** in the **Connections** pane.

## Determine the version of the database schema

To determine the version of System Center Orchestrator database schema, start the SQL Server Management Studio application from your SQL Server or location where SQL Server Client Tools has been installed, and then connect to the SQL Server Database Engine instance that hosts the System Center Orchestrator database.

Select **New Query** and then execute the following SQL query:

```sql
USE <database> SELECT [DBVersion] FROM VERSION
```

Replace \<*database*> with the name of the Orchestrator database.
