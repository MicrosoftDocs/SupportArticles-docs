---
title: Impersonation in ASP.NET applications
description: This article introduces how to implement impersonation by modifying Web.config and running a particular section of code.
ms.date: 03/26/2020
ms.custom: sap:General Development
ms.reviewer: jallen
ms.topic: how-to
---
# Implement impersonation in an ASP.NET application

This article describes different ways to implement impersonation in an ASP.NET application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306158

## Summary

This article introduces how to implement impersonation by modifying the Web.config file and running a particular section of code.

It refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Web.Security`
- `System.Security.Principal`
- `System.Runtime.InteropServices`

You can use the following code to determine what user the thread is executing as:

```csharp
System.Security.Principal.WindowsIdentity.GetCurrent().Name
```

## Impersonate IIS authenticated account or user

To impersonate the Internet Information Services (IIS) authenticating user on every request for every page in an ASP.NET application, you must include an `<identity>` tag in the Web.config file of this application and set the impersonate attribute to true. For example:

```xml
<identity impersonate="true" />
```

## Impersonate a specific user for all requests of an ASP.NET application

To impersonate a specific user for all the requests on all pages of an ASP.NET application, you can specify the `userName` and `password` attributes in the `<identity>` tag of the Web.config file for that application. For example:

```xml
<identity impersonate="true" userName="accountname" password="password" />
```

> [!NOTE]
> The identity of the process that impersonates a specific user on a thread must have the **Act as part of the operating system** privilege. By default, the Aspnet_wp.exe process runs under a computer account named ASPNET. However, this account doesn't have the required privileges to impersonate a specific user. You receive an error message if you try to impersonate a specific user. This information applies only to the .NET Framework 1.0. This privilege is not required for the .NET Framework 1.1.

To work around this problem, use one of the following methods:

- Grant the **Act as part of the operating system** privilege to the ASPNET account (the least privileged account).

    > [!NOTE]
    > Although you can use this method to work around the problem, Microsoft doesn't recommend this method.

- Change the account that the Aspnet_wp.exe process runs under to the System account in the `<processModel>` configuration section of the Machine.config file.

## Impersonate the authenticating user in code

To impersonate the authenticating user (`User.Identity`) only when you run a particular section of code, you can use the code to follow. This method requires that the authenticating user identity is of type `WindowsIdentity`.

- Visual Basic .NET

    ```vb
    Dim impersonationContext As System.Security.Principal.WindowsImpersonationContext
    Dim currentWindowsIdentity As System.Security.Principal.WindowsIdentity
    currentWindowsIdentity = CType(User.Identity, System.Security.Principal.WindowsIdentity)
    impersonationContext = currentWindowsIdentity.Impersonate()
    'Insert your code that runs under the security context of the authenticating user here.
    impersonationContext.Undo()
    ```

- Visual C# .NET

    ```csharp
    System.Security.Principal.WindowsImpersonationContext impersonationContext;
    impersonationContext = ((System.Security.Principal.WindowsIdentity)User.Identity).Impersonate();
    //Insert your code that runs under the security context of the authenticating user here.
    impersonationContext.Undo();
    ```

## Impersonate a specific user in code

To impersonate a specific user only when you run a particular section of code, use the following code:

**Visual Basic .NET**

```vbscript
<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<script runat=server>
Dim LOGON32_LOGON_INTERACTIVE As Integer = 2
Dim LOGON32_PROVIDER_DEFAULT As Integer = 0
Dim impersonationContext As WindowsImpersonationContext

Declare Function LogonUserA Lib "advapi32.dll" (ByVal lpszUsername As String, _
                        ByVal lpszDomain As String, _
                        ByVal lpszPassword As String, _
                        ByVal dwLogonType As Integer, _
                        ByVal dwLogonProvider As Integer, _
                        ByRef phToken As IntPtr) As Integer

Declare Auto Function DuplicateToken Lib "advapi32.dll" ( _
                        ByVal ExistingTokenHandle As IntPtr, _
                        ByVal ImpersonationLevel As Integer, _
                        ByRef DuplicateTokenHandle As IntPtr) As Integer

Declare Auto Function RevertToSelf Lib "advapi32.dll" () As Long
Declare Auto Function CloseHandle Lib "kernel32.dll" (ByVal handle As IntPtr) As Long

Public Sub Page_Load(ByVal s As Object, ByVal e As EventArgs)
    If impersonateValidUser("username", "domain", "password") Then
         'Insert your code that runs under the security context of a specific user here.
         undoImpersonation()
    Else
         'Your impersonation failed. Therefore, include a fail-safe mechanism here.
    End If
End Sub

Private Function impersonateValidUser(ByVal userName As String, _
ByVal domain As String, ByVal password As String) As Boolean

    Dim tempWindowsIdentity As WindowsIdentity
    Dim token As IntPtr = IntPtr.Zero
    Dim tokenDuplicate As IntPtr = IntPtr.Zero
    impersonateValidUser = False

    If RevertToSelf() Then
        If LogonUserA(userName, domain, password, LOGON32_LOGON_INTERACTIVE,
                    LOGON32_PROVIDER_DEFAULT, token) <> 0 Then
            If DuplicateToken(token, 2, tokenDuplicate) <> 0 Then
                tempWindowsIdentity = New WindowsIdentity(tokenDuplicate)
                impersonationContext = tempWindowsIdentity.Impersonate()
                If Not impersonationContext Is Nothing Then
                    impersonateValidUser = True
                End If
            End If
        End If
    End If
    If Not tokenDuplicate.Equals(IntPtr.Zero) Then
        CloseHandle(tokenDuplicate)
    End If
    If Not token.Equals(IntPtr.Zero) Then
        CloseHandle(token)
    End If
End Function

Private Sub undoImpersonation()
    impersonationContext.Undo()
End Sub
</script>
```

**Visual C# .NET**

```csharp
<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<script runat=server>
public const int LOGON32_LOGON_INTERACTIVE = 2;
public const int LOGON32_PROVIDER_DEFAULT = 0;

WindowsImpersonationContext impersonationContext;

[DllImport("advapi32.dll")]
public static extern int LogonUserA(String lpszUserName,
String lpszDomain,
String lpszPassword,
int dwLogonType,
int dwLogonProvider,
ref IntPtr phToken);
[DllImport("advapi32.dll", CharSet=CharSet.Auto, SetLastError=true)]
public static extern int DuplicateToken(IntPtr hToken,
int impersonationLevel,
ref IntPtr hNewToken);

[DllImport("advapi32.dll", CharSet=CharSet.Auto, SetLastError=true)]
public static extern bool RevertToSelf();

[DllImport("kernel32.dll", CharSet=CharSet.Auto)]
public static extern bool CloseHandle(IntPtr handle);

public void Page_Load(Object s, EventArgs e)
{
    if(impersonateValidUser("username", "domain", "password"))
    {
        //Insert your code that runs under the security context of a specific user here.
        undoImpersonation();
    }
    else
    {
        //Your impersonation failed. Therefore, include a fail-safe mechanism here.
    }
}

private bool impersonateValidUser(String userName, String domain, String password)
{
    WindowsIdentity tempWindowsIdentity;
    IntPtr token = IntPtr.Zero;
    IntPtr tokenDuplicate = IntPtr.Zero;

    if(RevertToSelf())
    {
        if(LogonUserA(userName, domain, password, LOGON32_LOGON_INTERACTIVE,
        LOGON32_PROVIDER_DEFAULT, ref token)!= 0)
        {
            if(DuplicateToken(token, 2, ref tokenDuplicate)!= 0) 
            {
                tempWindowsIdentity = new WindowsIdentity(tokenDuplicate);
                impersonationContext = tempWindowsIdentity.Impersonate();
                if (impersonationContext != null)
                {
                    CloseHandle(token);
                    CloseHandle(tokenDuplicate);
                    return true;
                }
            }
        }
    }
    if(token!= IntPtr.Zero)
        CloseHandle(token);
    if(tokenDuplicate!=IntPtr.Zero)
        CloseHandle(tokenDuplicate);
    return false;
}

private void undoImpersonation()
{
    impersonationContext.Undo();
}
</script>
```

The identity of the process that impersonates a specific user on a thread must have the **Act as part of the operating system** privilege if the Aspnet_wp.exe process is running on a Windows 2000-based computer. The **Act as part of the operating system** privilege isn't required if the Aspnet_wp.exe process is running on a Windows XP-based computer or on a Windows Server 2003-based computer. By default, the Aspnet_wp.exe process runs under a computer account named ASPNET. However, this account doesn't have the required privileges to impersonate a specific user. You receive an error message if you try to impersonate a specific user.

To work around this problem, use one of the following methods:

- Grant the **Act as part of the operating system** privilege to the ASPNET account.

    > [!NOTE]
    > We don't recommend this method to work around the problem.

- Change the account that the Aspnet_wp.exe process runs under to the System account in the `<processModel>` configuration section of the Machine.config file.

## References

[ASP.NET security overview](https://support.microsoft.com/help/306590)
