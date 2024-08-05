---
title: ThreadAbortException occurs if you use Response.End
description: This article provides resolutions for ThreadAbortException error that occurs if you use Response.End, Response.Redirect, or Server.Transfer.
ms.date: 12/11/2020
ms.custom: sap:General Development
---
# ThreadAbortException occurs if you use Response.End, Response.Redirect, or Server.Transfer

This article helps you resolve the ThreadAbortException error that occurs if you use `Response.End`, `Response.Redirect`, or `Server.Transfer`.

_Original product version:_ &nbsp; ASP.NET on .NET Framework 4.5.2, ASP.NET on .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 312629

## Symptoms

If you use the `Response.End`, `Response.Redirect`, or `Server.Transfer` method, a ThreadAbortException exception occurs. You can use a `try-catch` statement to catch this exception.

## Cause

The `Response.End` method ends the page execution and shifts the execution to the Application_EndRequest event in the application's event pipeline. The line of code that follows `Response.End` is not executed.

This problem occurs in the `Response.Redirect` and `Server.Transfer` methods because both methods call Response.End internally.

## Resolution

To work around this problem, use one of the following methods:

- For `Response.End` , call the `HttpContext.Current.ApplicationInstance.CompleteRequest` method instead of `Response.End` to bypass the code execution to the `Application_EndRequest` event.
- For `Response.Redirect`, use an overload, Response.Redirect(String url, bool endResponse) that passes false for the endResponse parameter to suppress the internal call to `Response.End`. For example:

    ```aspx-csharp
     Response.Redirect ("nextpage.aspx", false);
    ```

    If you use this workaround, the code that follows `Response.Redirect` is executed.
- For `Server.Transfer`, use the `Server.Execute` method instead.

Although ASP.NET handles this exception, you can use the `try-catch` statement to catch this exception. For example:

```csharp
try
{
    Response.Redirect("nextpage.aspx");
}
catch (Exception ex)
{
    Response.Write (ex.Message);
}
```

Add a breakpoint on the `Response.Write` line, and notice that this breakpoint is hit. When you examine the exception, notice that the ThreadAbortException exception occurs.
