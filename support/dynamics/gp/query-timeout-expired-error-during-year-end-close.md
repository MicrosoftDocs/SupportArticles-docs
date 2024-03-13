---
title: Query timeout expired error during year-end close
description: When you do a year-end close in Microsoft Dynamics GP, you may receive an error message that states Query timeout expired. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Query timeout expired" error during year-end close in Microsoft Dynamics GP

This article provides a resolution for the error **Query timeout expired** that may occur when you try to do a year-end close in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4502278

## Symptoms

After selecting Close year in the year-end closing window (for step 11 of KB888003) for General Ledger in Microsoft Dynamics GP, the progress bar starts to fill up, but then you suddenly get this error message:

> Query timeout expired

## Cause

The **Query timeout expired** message is indicating that GP did not receive a response from a SQL query within the time allotted by GP. By default, GP will wait 300 seconds (5 minutes). That limit is implemented so that GP is not hung up indefinitely when waiting for a response to a SQL query (for example if there is damaged data preventing the action from completing or a SQL query that creates a continuous loop). 300 seconds is normally plenty of time to complete a single query, but in some cases the data being queried can branch out and cause the query to run much longer than expected. This is especially the case during Step 3 of the Year-End Closing routine, which is when currency translation occurs. That process is very data intensive and often requires more than 5 minutes to complete.

## Resolution

There is a quick fix to add a tag ro your Dex.ini file:

1. Path out to the **Dex**. **ini** file in the **Data** folder in the Microsoft Dynamics GP code folder and right-click on it and open it with Notepad. The default location is usually:  

   C:\Program Files (x86)\Microsoft Dynamics\GP\Data\

2. Add this tag line to the end of the file and then close the file and save your changes. Restart Microsoft Dynamics GP.

    `SQLQueryTimeout=0`

> [!NOTE]
> There are two other settings that may also be useful to add as well that can help with similar errors with reports, etc:
>
> SQLRprtsTimeout=0
>
> SQLProcsTimeout=0
