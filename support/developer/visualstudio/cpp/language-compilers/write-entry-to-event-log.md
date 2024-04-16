---
title: Use C++ to write entries to an event log
description: Describes how to add your own entries to the event log of the operating system by using the Microsoft .NET Framework.
ms.date: 04/22/2020
ms.custom: sap:Language or Compilers\C++
ms.topic: how-to
---
# Write entries to an event log by using Visual C++  

This article describes how to add your own entries to the event log of the operating system by using the Microsoft .NET Framework.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 815661

## Requirements

Visual Studio .NET

## Write entries to an event log

Event logging provides a standard, centralized way for your applications to record important software and hardware events. Windows supplies a standard user interface for viewing the logs: the Event Viewer. By using the common language run-time EventLog component, you can connect to existing event logs easily, on both local and remote computers, and write entries to these logs. You can also read entries from existing logs, and create your own custom event logs. In its simplest form, writing to an event log involves several steps to create a sample application.

To do it, follow these steps:

1. Start Visual Studio .NET.
2. Create a new Visual C++ Managed C++ Application project.
3. Add a reference to *system.dll* by adding the following line to the code:

    ```cpp
    #using <system.dll>
    ```

4. Use the `using` directive on the `System` and `System::Diagnostics` namespaces so that you don't have to qualify declarations from these namespaces later in your code. You can use the following statements before any other declarations:

    ```cpp
    using namespace System;
    using namespace System::Diagnostics;
    ```

5. To write to an event log, you must have several pieces of information:
    - Your message
    - The name of the log to where you want to write (it's created if it doesn't already exist)
    - A string that represents the source of the event

    You can register a particular source with only a single event log. If you want to write messages to more than one log, you must define multiple sources.

    ```cpp
    String^ sSource;
    String^ sLog;
    String^ sEvent;

    sSource = gcnew String("dotNET Sample App1");
    sLog = gcnew String("Application1");
    sEvent = gcnew String("Sample Event1");
    ```

6. Use two static methods of the `EventLog` class to check whether your source exists, and if the source doesn't exist, to create this source that is associated with a particular event log. If the log name that you specify doesn't exist, the name is created automatically when you write your first entry to the log. By default, if you don't supply a log name to the `CreateEventSource` method, the log file is named *Application Log*.

    ```cpp
    if(!EventLog::SourceExists(sSource)) EventLog::CreateEventSource(sSource,sLog);
    ```

7. To write a message to an event log, you can use the static method `EventLog.WriteEntry`. This method has several different overloaded versions. The following sample code shows the simplest method (which takes a source string and your message), and one of the more complex methods (which supports specifying the event ID and event type):

    ```cpp
    EventLog::WriteEntry(sSource,sEvent);
    EventLog::WriteEntry(sSource, sEvent, EventLogEntryType::Warning, 235);
    ```

8. Save your application. Run your application, and then check the application sign in the Event Viewer to see your new events.

## Complete code listing in Visual C++ .NET

```cpp
#include <tchar.h>
#using <system.dll>
#using <mscorlib.dll>

using namespace System;
using namespace System::Diagnostics;

int _tmain()
{
    String^ sSource;
    String^ sLog;
    String^ sEvent;

    sSource = gcnew String("dotNET Sample App1");
    sLog = gcnew String("Application1");
    sEvent = gcnew String("Sample Event1");

     if(!EventLog::SourceExists(sSource))
       EventLog::CreateEventSource(sSource,sLog);

    EventLog::WriteEntry(sSource,sEvent);
    EventLog::WriteEntry(sSource, sEvent,
    EventLogEntryType::Warning, 234);
    return 0;
}
```
