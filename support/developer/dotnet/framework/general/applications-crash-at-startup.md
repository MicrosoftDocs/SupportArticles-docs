---
title: .NET applications crash at startup
description: Event ID 5000 occurs when a user starts a .NET application. This article provides a resolution for this problem
ms.date: 05/06/2020
---
# .NET applications may crash at startup for specific users if the user.config file is corrupt

This article helps you resolve the crash problem when a user starts a .NET application.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 956762

## Symptoms

A user starts a .NET application. However, the application crashes at startup if the *user.config* file is corrupt. The application works fine for other users on the same machine, but for one user, the application crashes with an error entry in the event log like this:

> Event Type: Error  
> Event Source: .NET Runtime 2.0 Error Reporting  
> Event Category: None  
> Event ID: 5000  
> Date: DateTime  
> Time: DateTime  
> User: N/A  
> Computer: <application_name>  
> Description:  
> EventType clr20r3, P1 <app_name>.exe, P2 4.0.5.0, P3 4880b494, P4 system.configuration, P5 2.0.0.0, P6 461ef187, P7 2cc, P8 1c, P9 ioibmurhynrxkw0zxkyrvfn0boyyufow, P10 NIL.

## Cause

The *user.config* file may be corrupted. This file is generally found in the folder:  
`...\Documents and Settings\<user>\Local Settings\Application Data\<application_name>\...\user.config`

## Resolution

You can delete the *user.config* file and let the application recreate it.

## More information

For more information, see [Application Settings Architecture](/dotnet/desktop/winforms/advanced/application-settings-architecture).
