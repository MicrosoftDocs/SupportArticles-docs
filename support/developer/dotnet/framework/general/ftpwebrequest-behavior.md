---
title: FtpWebRequest behavior in .NET Framework 4
description: When you use the System.Net.FtpWebRequest class on .Net 4.0 to perform the FTP STOR/RETR command, the class throws an FTP error 5xx. This article provides a resolution for this problem.
ms.date: 05/06/2020
ms.reviewer: pphadke, dshulman
---
# System.Net.FtpWebRequest class behaves differently in .NET Framework 4 vs .NET Framework 3.5

This article helps you fix the FTP error 5xx that occurs when you use the `System.Net.FtpWebRequest` class on Microsoft .NET Framework 4 to perform the FTP `STOR` or `RETR` command.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 2134299

## Symptoms

When you use the `System.Net.FtpWebRequest` class on .NET Framework 4 to perform the FTP `STOR` or `RETR` command, the class throws an FTP error 5xx, for example:

> 501 Syntax error - sender/receiver missing.

However, this class works fine with .NET Framework 3.5 and does not throw the same error.

## Cause

The cause of this issue is due to a behavior change in the `System.Net.FtpWebRequest` class in .NET Framework 4. There has been a change made to the `System.Net.FtpWebRequest` class from .NET Framework 3.5 to .NET Framework 4 to streamline the use of the `CWD` protocol commands. The new implementation of the `System.Net.FtpWebRequest` class prevents the send of extra `CWD` commands before issuing the actual command, which the user requested and instead directly sends the requested command. For fully RFC-compliant FTP servers, this should not be an issue, however for non-fully RFC-compliant servers, you will see these types of errors.

## Resolution

In order to resolve this issue, it is required to force the `System.Net.FtpWebRequest` command to revert back to the old behavior of how it used to work in .NET Framework 2.0 or 3.5 and issue the extra `CWD` command before issuing the actual command.

The following code should be placed before any instance of the `System.Net.FtpWebRequest` class is invoked.

The code below only needs to be called once, since it changes the settings of the entire application domain.

```csharp
private static void SetMethodRequiresCWD ()
{
    Type requestType = typeof (FtpWebRequest);
    FieldInfo methodInfoField = requestType.GetField ("m_MethodInfo", BindingFlags.NonPublic | BindingFlags.Instance);
    Type methodInfoType = methodInfoField.FieldType;
    FieldInfo knownMethodsField = methodInfoType.GetField ("KnownMethodInfo", BindingFlags.Static | BindingFlags.NonPublic);
    Array knownMethodsArray = (Array) knownMethodsField.GetValue (null);
    FieldInfo flagsField = methodInfoType.GetField ("Flags", BindingFlags.NonPublic | BindingFlags.Instance);
    int MustChangeWorkingDirectoryToPath = 0x100;
    foreach (object knownMethod in knownMethodsArray)
    {
        int flags = (int) flagsField.GetValue (knownMethod);
        flags |= MustChangeWorkingDirectoryToPath;
        flagsField.SetValue (knownMethod, flags);
    }
}
```

## FtpWebRequest behavior changes

The behavior of the `System.Net.FtpWebRequest` class has changed in .NET Framework 4 vs .NET Framework 3.5.

In .NET Framework 3.5, a file upload to a server using the `System.Net.FtpWebRequest` class followed a typical exchange of the following FTP commands:

- `USE`
- `PASS`
- `OPTS`  
- `PWD`  
- `CWD`  
- `STOR`

However, in .NET Framework 4, a typical file upload goes through the following command sequence:

- `USER`  
- `PASS`  
- `OPTS`  
- `PWD`
- `STOR`

The difference between the two behaviors is that in the 3.5 version, the upload happens by performing a `CWD` command to change the current directory to the intended directory, followed by the `STOR` command with just the filename.

However, .NET Framework 4 implementation prevents the send of the additional CWD command, and sends the `STOR` command directly to the destination directory with the fully qualified directory structure.

For fully RFC-compliant FTP servers, it would not be an issue, but for others, this behavior may break existing applications from working with .NET Framework 4.

For such server communication, you will see the server respond back with an FTP Error code: 5xx, such as **501 Syntax error - sender/receiver missing** whereas the same code will work for the `System.Net.FtpWebRequest` class when used with the .NET Framework 3.5.
