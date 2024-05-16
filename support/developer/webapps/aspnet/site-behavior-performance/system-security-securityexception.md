---
title: Can't use a virtual directory to host applications
description: Security error occurs when the virtual directory points to a remote share in ASP.NET. This article provides a resolution for this problem.
ms.date: 04/08/2020
ms.custom: sap:Performance
---
# System.Security.SecurityException when the virtual directory points to a remote share in ASP.NET

This article helps you resolve the problem that `System.Security.SecurityException` may be thrown when you use a virtual directory that points to a remote share to host a Microsoft ASP.NET-based application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 320268

## Symptoms

When you use a virtual directory that points to a remote share to host an ASP.NET-based application, you may receive an error message that is similar to one of the following examples:

- Message 1

    > Security Exception Description: The application attempted to perform an operation not allowed by the security policy. To grant this application the required permission please contact your system administrator or change the application's trust level in the configuration file.  
    > Exception Details: System.Security.SecurityException: Security error.  
    > Source Error:  
    > Line 30: private static bool __intialized = false; Line 31: Line 32: public Global_asax() { Line 33: if ((ASP.Global_asax.__intialized == false)) { Line 34: ASP.Global_asax.__intialized = true;

- Message 2

    > Server Error in /ApplicationName Application.  
    > Parser Error Description: An error occurred during the parsing of a resource required to service this request. Please review the following specific parse error details and modify your source file appropriately.  
    > Parser Error Message: Could not load type ApplicationName.Global.  
    > Source Error: Line 1: <%@ Application Codebehind="Global.asax.cs" Inherits="ApplicationName.Global" %> Source File: Path of Application\global.asax Line: 1

## Cause

The `System.Web` namespace doesn't have the `AllowPartiallyTrustedCallersAttribute` applied to it. For more information, visit [patterns & practices](/previous-versions/msp-n-p/ff921345(v=pandp.10)).

Any code that isn't in the **My_Computer_Zone** code group that doesn't have this attribute requires the **FullTrust** user right. So the remote share that holds the Web applications content requires **FullTrust**.

## Resolution

To resolve this behavior, grant the **FullTrust** right to the remote share:

1. On the Web server, open Administrative Tools, and then double-click **Microsoft .NET Framework Configuration**.
2. Expand **Runtime Security Policy**, expand **Machine**, and then expand **Code Groups**.
3. Right-click **All_Code**, and then select **New**.
4. Select **Create a new code group**. Give your code group a relevant name, such as the name of the applications share. Select **Next**.
5. In the **Choose the condition type for this code group** list, select **URL**.
6. In the **URL** box, type the path of the share in the following format:  
    `file:////\\computername\\sharename\*`

    > [!NOTE]
    > Replace *computername* with the name of the computer that is hosting the remote share. Replace *sharename* with the name of the share.

7. Select **Next**. On the next page, select **Use an existing permission set**, and then select **FullTrust**.
8. Select **Next**, and then select **Finish**.
9. Restart Internet Information Services (IIS) to restart the ASP.NET worker process.

If **Microsoft .NET Framework Configuration** isn't displayed under **Administrative Tools**, you can install the .NET Framework Software Development Kit (SDK) to add **Microsoft .NET Framework Configuration**. Instead, you can run the following command to make the change:

```console
Drive :\WINDOWS\Microsoft.NET\Framework\v2.0.50727\caspol.exe -m -ag 1 -url "file:////\\computername\sharename\*" FullTrust -exclusive on
```

For more information about what these arguments do, run the following command:  

```console
caspol.exe -?
```

## Status

This behavior is by design.

## More information

In this configuration, the account under which the ASP.NET worker process runs must have sufficient rights to the remote share. You can set the account under which the worker process runs by using the `<processmodel>` tag in the *Machine.config* file.

### Steps to reproduce the behavior

1. Create a new virtual directory that points to a remote share.
2. Create an application for the virtual directory. Make sure that the user who connects to the share has read access to the remote content.
3. In the `<processmodel>` tag of the *Machine.config* file, change the user to a domain user who has list, read, and execute permissions on the remote share.
4. Create an inline .aspx file, and then put the file in the remote share.
5. Make a request for the page.

## References

For more information about the permissions that the ASPNET account requires to run ASP.NET applications, see [Introduction to ASP.NET Identity](/aspnet/identity/overview/getting-started/introduction-to-aspnet-identity). For more information about ASP.NET security, see [INFO: ASP.NET Security Overview](https://support.microsoft.com/help/306590).
