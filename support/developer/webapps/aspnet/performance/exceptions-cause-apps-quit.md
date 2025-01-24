---
title: Exceptions cause ASP.NET apps to quit
description: This article describes a problem that occurs when an unhandled exception is thrown in an ASP.NET-based application on a computer that is running the .NET Framework 2.0 or a later version.
ms.date: 04/09/2020
ms.custom: sap:Performance
ms.reviewer: tmarq
---
# Unhandled exceptions cause ASP.NET-based applications to quit unexpectedly in the .NET Framework

This article helps you resolve the problem where unhandled exceptions cause ASP.NET-based applications to quit unexpectedly in the .NET Framework.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 911816

> [!NOTE]
> This article applies to the Microsoft .NET Framework 2.0 and all later versions.

## Symptoms

When an unhandled exception is thrown in a ASP.NET-based application that is built on the .NET Framework 2.0 and later versions, the application unexpectedly quits. When this problem occurs, no exception information that you must have to understanding the issue is logged in the application log.

However, an event message that is similar to the following example may be logged in the System log. Additionally, an event message that is similar to the following example may be logged in the application log.

## Cause

This problem occurs because the default policy for unhandled exceptions has changed in the .NET Framework 2.0 and later versions. By default, the policy for unhandled exceptions is to end the worker process.

In the .NET Framework 1.1 and in the .NET Framework 1.0, unhandled exceptions on managed threads were ignored. Unless you attached a debugger to catch the exception, you wouldn't realize that anything was wrong.

ASP.NET uses the default policy for unhandled exceptions in the .NET Framework 2.0 and later versions. When an unhandled exception is thrown, the ASP.NET-based application unexpectedly quits.

This behavior doesn't apply to exceptions that occur in the context of a request. These kinds of exceptions are still handled and wrapped by an `HttpException` object. Exceptions that occur in the context of a request don't cause the worker process to end. However, unhandled exceptions outside the context of a request, such as exceptions on a timer thread or in a callback function, cause the worker process to end.

## Resolution 1

Modify the source code for the `IHttpModule` object so that it will log exception information to the application log. The information that is logged will include the following:

- The virtual directory path in which the exception occurred
- The exception name
- The message
- The stack trace

To modify the `IHttpModule` object, follow these steps.

> [!NOTE]
> This code will log a message that has the *Event Type of Error* and the *Event Source of ASP.NET 2.0.50727.0* in the application log. To test the module, request an ASP.NET page that uses the `ThreadPool.QueueUserWorkItem` method to call a method that throws an unhandled exception.

1. Put the following code in a file that is named *UnhandledExceptionModule.cs*.

    ```csharp
    using System;
    using System.Diagnostics;
    using System.Globalization;
    using System.IO;
    using System.Runtime.InteropServices;
    using System.Text;
    using System.Threading;
    using System.Web;

    namespace WebMonitor
    {
        public class UnhandledExceptionModule: IHttpModule
        {

            static int _unhandledExceptionCount = 0;
            static string _sourceName = null;
            static object _initLock = new object();
            static bool _initialized = false;

            public void Init(HttpApplication app)
            {

                // Do this one time for each AppDomain.
                if (!_initialized)
                {
                    lock (_initLock)
                    {
                        if (!_initialized)
                        {
                            string webenginePath = Path.Combine(RuntimeEnvironment.GetRuntimeDirectory(),
                            "webengine.dll");

                            if (!File.Exists(webenginePath))
                            {
                                throw new Exception(String.Format(CultureInfo.InvariantCulture,
                                                            "Failed to locate webengine.dll at '{0}'.
                                                            This module requires .NET Framework 2.0.",
                                                                  webenginePath));
                            }

                            FileVersionInfo ver = FileVersionInfo.GetVersionInfo(webenginePath);
                            _sourceName = string.Format(CultureInfo.InvariantCulture,
                             "ASP.NET {0}.{1}.{2}.0",
                                                        ver.FileMajorPart, ver.FileMinorPart,
                                                         ver.FileBuildPart);

                            if (!EventLog.SourceExists(_sourceName))
                            {
                                throw new Exception(String.Format(CultureInfo.InvariantCulture,
                                                            "There is no EventLog source named '{0}'.
                                                            This module requires .NET Framework 2.0.",
                                                                  _sourceName));
                            }

                            AppDomain.CurrentDomain.UnhandledException +=
                            new UnhandledExceptionEventHandler(OnUnhandledException);

                            _initialized = true;
                        }
                    }
                }
            }

            public void Dispose()
            {
            }

            void OnUnhandledException(object o, UnhandledExceptionEventArgs e)
            {
                // Let this occur one time for each AppDomain.
                if (Interlocked.Exchange(ref _unhandledExceptionCount, 1) != 0)
                    return;

                StringBuilder message = new StringBuilder("\r\n\r\nUnhandledException logged by
                UnhandledExceptionModule.dll:\r\n\r\nappId=");

                string appId = (string) AppDomain.CurrentDomain.GetData(".appId");
                if (appId != null)
                {
                    message.Append(appId);
                }

                Exception currentException = null;
                for (currentException = (Exception)e.ExceptionObject; currentException != null;
                currentException = currentException.InnerException)
                {
                    message.AppendFormat("\r\n\r\ntype={0}\r\n\r\nmessage={1}
                    \r\n\r\nstack=\r\n{2}\r\n\r\n",
                                         currentException.GetType().FullName,
                                         currentException.Message,
                                         currentException.StackTrace);
                }

                EventLog Log = new EventLog();
                Log.Source = _sourceName;
                Log.WriteEntry(message.ToString(), EventLogEntryType.Error);
            }
        }
    }
    ```

2. Save the *UnhandledExceptionModule.cs* file to the `C:\Program Files\Microsoft Visual Studio 8\VC` folder.
3. Open the Visual Studio Command Prompt.
4. Type `sn.exe -k key.snk`, and then press **ENTER**.
5. Type `csc /t:library /r:system.web.dll,system.dll /keyfile:key.snk UnhandledExceptionModule.cs`, and then press **ENTER**.
6. Type `gacutil.exe /if UnhandledExceptionModule.dll`, and then press **ENTER**.
7. Type `ngen install UnhandledExceptionModule.dll`, and then press **ENTER**.
8. Type `gacutil /l UnhandledExceptionModule`, and then press **ENTER** to display the strong name for the *UnhandledExceptionModule* file.
9. Add the following code to the *Web.config* file of your ASP.NET-based application.

    ```xml
    <add name="UnhandledExceptionModule"
    type="WebMonitor.UnhandledExceptionModule, <strong name>" />
    ```

## Resolution 2

Change the unhandled exception policy back to the default behavior that occurs in the .NET Framework 1.1 and in the .NET Framework 1.0.

> [!NOTE]
> We do not recommend that you change the default behavior. If you ignore exceptions, the application may leak resources and abandon locks.

To enable this default behavior, add the following code to the *Aspnet.config* file that is located in the following folder:  
`%WINDIR%\Microsoft.NET\Framework\v2.0.50727`

```xml
<configuration>
     <runtime>
         <legacyUnhandledExceptionPolicy enabled="true" />
     </runtime>
</configuration>
```

## Status

This behavior is by design.

## More information

For more information about changes in the .NET Framework 2.0, visit [Breaking Changes in .NET Framework 2.0](/previous-versions/aa570326(v=msdn.10)).
