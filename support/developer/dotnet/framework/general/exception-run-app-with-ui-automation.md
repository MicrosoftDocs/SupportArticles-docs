---
title: Exception when running .NET app with UI automation
description: You might see a null reference exception thrown when running an application that contains a .NET calendar control and any UI Automation tool like Inspect.exe. The application may crash when focus goes to the calendar control.
ms.date: 05/08/2020
ms.reviewer: hanxia
---
# Null reference exception when running a .NET app with UI automation

This article helps you resolve the null reference exception that's thrown when you run a .NET application with UI automation.

_Original product version:_ &nbsp; Microsoft .NET Framework  
_Original KB number:_ &nbsp; 2653004

## Symptoms

You may see a null reference exception thrown when running an application that contains a .NET Calendar control and any UI automation tool like Inspect.exe. The application may crash when focus goes to the Calendar control.

## Cause

You may have a subtle issue in your app defined template where the null values in the `AutomationPeer` collection stemmed.

The resources within a theme level dictionary that will be referenced outside need to be named using a `ComponentResourceKey`. In this case, UIAutomation (Inspect.exe) wants to reference this `DataTemplate` and raise the exception.

## Resolution

Set the `DataTamplate` `Key` as follows:

```xml
<DataTemplate x:Key="{ComponentResourceKey TypeInTargetAssembly=CalendarItem, ResourceId=DayTitleTemplate}">
```

Instead of:

```xml
<DataTemplate x:Key="DayTitleTemplate">
```
