---
title: The Operations Manager Console is disconnected
description: Fixes an issue in which the Operations Manager console is disconnected when you create a maintenance schedule that has more than 216 target objects.
ms.date: 04/15/2024
---
# Creating a maintenance schedule with more than 216 objects causes the Operations Manager console to disconnect

This article helps you work around an issue in which the Operations Manager console is disconnected when you create a maintenance schedule that has more than 216 target objects.

_Original product version:_ &nbsp; System Center 2016 Operations Manager  
_Original KB number:_ &nbsp; 4464213

## Symptom

When creating a maintenance schedule, selecting more than 216 target objects (which can be any specific entity instances or groups) might result in the Operations console disconnecting with the following error:

> The client has been disconnected from the server. Please call ManagementGroup.Reconnect() to reestablish the connection.

## Workaround

You can use the following alternate option to put large number of objects in maintenance mode using a single maintenance schedule:

1. Create a single group or multiple groups with all the objects you would like to put in maintenance schedule.
2. Create a maintenance schedule with these groups (number of groups should be less than 216).
