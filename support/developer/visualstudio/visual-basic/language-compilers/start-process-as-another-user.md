---
title: Start a process as another user
description: This article describes how to redirect the input and the output of a child process that receives input from the standard input handle or that sends output to the standard output handle.
ms.date: 10/14/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
ms.topic: how-to
---
# Start a process as another user from Visual Basic

This article describes how to redirect the input and the output of a child process that receives input from the standard input handle or that sends output to the standard output handle.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 285879

## Summary

This article shows you how to programmatically start a process as another user from Microsoft Visual Basic. To do this, you can use the `LogonUser` and `CreateProcessAsUser` Win32 APIs on a computer that is running Windows NT 4.0, or you can use the `CreateProcessWithLogonW` Win32 API on a computer that is running Windows 2000 or later. `CreateProcessWithLogonW` cannot be called from a process under the LocalSystem account.

## More information

This article contains sample Visual Basic code that detects the version of the operating system. It then uses the corresponding APIs to start a process as another user.

### Windows NT 4.0

- To use `LogonUser` and `CreateProcessAsUser`, the calling user account must have certain permissions.

- To use `LogonUser()`, the calling user account must have the following permission:

    Permission Display Name
    `SE_TCB_NAME` Act as part of the operating system

- To use `CreateProcessAsUser()`, the calling user account must have the following two permissions:

  Permission Display Name

  - `SE_ASSIGNPRIMARYTOKEN_NAME` Replace a process level token
  - `SE_INCREASE_QUOTA_NAME` Increase quotas

If the calling user account does not have the permission to "act as part of the operating system," the `LogonUser()` API fails and generates a return value of zero. If you call `Err.LastDllError`, you receive error message 1314. This message means that a required permission is not held by the client. Similarly, if the calling user account does not have the two permissions to "replace a process level token" and to "increase quotas," the `CreateProcessAsUser()` API fails and generates the error message 1314.

If you start an interactive application as another user, you must have access to the interactive window station and desktop that is named *winsta0\default*. If the application is interactive, the caller needs to programmatically add the required permission to *winsta0\default*. After this, the caller can call the `RunAsUser` helper function in the sample Visual Basic code below.

You must give enough permissions to the user account that is specified in `LogonUser()` so that the interactive application can start successfully. The following Knowledge Base article has sample Visual Basic code that you can use to update permissions on a window station and desktop.

## Windows 2000 and Later

The `CreateProcessWithLogonW()` API was introduced in Windows 2000. A call to `CreateProcessWithLogonW()` does not require permissions to be granted for the calling user account, as it does with the LogonUser and `CreateProcessAsUser` APIs.

In the future, use the `CreateProcessWithLogonW()` API. It handles the permissions that are associated with the inherited window station and desktop. In this scenario, the application just calls the `RunAsUser` helper function in the following sample Visual Basic code.

```vbnet
Option Explicit

Private Const CREATE_DEFAULT_ERROR_MODE = &H4000000

Private Const LOGON_WITH_PROFILE = &H1
Private Const LOGON_NETCREDENTIALS_ONLY = &H2

Private Const LOGON32_LOGON_INTERACTIVE = 2
Private Const LOGON32_PROVIDER_DEFAULT = 0

Private Type STARTUPINFO
    cb As Long
    lpReserved As Long ' !!! must be Long for Unicode string
    lpDesktop As Long ' !!! must be Long for Unicode string
    lpTitle As Long ' !!! must be Long for Unicode string
    dwX As Long
    dwY As Long
    dwXSize As Long
    dwYSize As Long
    dwXCountChars As Long
    dwYCountChars As Long
    dwFillAttribute As Long
    dwFlags As Long
    wShowWindow As Integer
    cbReserved2 As Integer
    lpReserved2 As Long
    hStdInput As Long
    hStdOutput As Long
    hStdError As Long
End Type

Private Type PROCESS_INFORMATION
    hProcess As Long
    hThread As Long
    dwProcessId As Long
    dwThreadId As Long
End Type

' LogonUser() requires that the caller has the following permission
' Permission Display Name
' --------------------------------------------------------------------
' SE_TCB_NAME Act as part of the operating system

' CreateProcessAsUser() requires that the caller has the following permissions
' Permission Display Name
' ---------------------------------------------------------------
' SE_ASSIGNPRIMARYTOKEN_NAME Replace a process level token
' SE_INCREASE_QUOTA_NAME Increase quotas

Private Declare Function LogonUser Lib "advapi32.dll" Alias _"LogonUserA" _(ByVal lpszUsername As String, _ByVal lpszDomain As String, _ByVal lpszPassword As String, _ByVal dwLogonType As Long, _ByVal dwLogonProvider As Long, _phToken As Long) As Long

Private Declare Function CreateProcessAsUser Lib "advapi32.dll" _Alias "CreateProcessAsUserA" _(ByVal hToken As Long, _ByVal lpApplicationName As Long, _ByVal lpCommandLine As String, _ByVal lpProcessAttributes As Long, _ByVal lpThreadAttributes As Long, _ByVal bInheritHandles As Long, _ByVal dwCreationFlags As Long, _ByVal lpEnvironment As Long, _ByVal lpCurrentDirectory As String, _lpStartupInfo As STARTUPINFO, _lpProcessInformation As PROCESS_INFORMATION) As Long

' CreateProcessWithLogonW API is available only on Windows 2000 and later.
Private Declare Function CreateProcessWithLogonW Lib "advapi32.dll" _(ByVal lpUsername As String, _ByVal lpDomain As String, _ByVal lpPassword As String, _ByVal dwLogonFlags As Long, _ByVal lpApplicationName As Long, _ByVal lpCommandLine As String, _ByVal dwCreationFlags As Long, _ByVal lpEnvironment As Long, _ByVal lpCurrentDirectory As String, _ByRef lpStartupInfo As STARTUPINFO, _ByRef lpProcessInformation As PROCESS_INFORMATION) As Long

Private Declare Function CloseHandle Lib "kernel32.dll" _(ByVal hObject As Long) As Long

Private Declare Function SetErrorMode Lib "kernel32.dll" _(ByVal uMode As Long) As Long

Private Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type

' Version Checking APIs
Private Declare Function GetVersionExA Lib "kernel32.dll" _(lpVersionInformation As OSVERSIONINFO) As Integer

Private Const VER_PLATFORM_WIN32_NT = &H2

'********************************************************************' RunAsUser for Windows 2000 and Later
'********************************************************************
Public Function W2KRunAsUser(ByVal UserName As String, _ByVal Password As String, _ByVal DomainName As String, _ByVal CommandLine As String, _ByVal CurrentDirectory As String) As Long

    Dim si As STARTUPINFO
    Dim pi As PROCESS_INFORMATION
    Dim wUser As String
    Dim wDomain As String
    Dim wPassword As String
    Dim wCommandLine As String
    Dim wCurrentDir As String

    Dim Result As Long

    si.cb = Len(si)

    wUser = StrConv(UserName + Chr$(0), vbUnicode)
    wDomain = StrConv(DomainName + Chr$(0), vbUnicode)
    wPassword = StrConv(Password + Chr$(0), vbUnicode)
    wCommandLine = StrConv(CommandLine + Chr$(0), vbUnicode)
    wCurrentDir = StrConv(CurrentDirectory + Chr$(0), vbUnicode)

    Result = CreateProcessWithLogonW(wUser, wDomain, wPassword, _LOGON_WITH_PROFILE, 0&, wCommandLine, _CREATE_DEFAULT_ERROR_MODE, 0&, wCurrentDir, si, pi)' CreateProcessWithLogonW() does not
    If Result <> 0 Then
        CloseHandle pi.hThread
        CloseHandle pi.hProcess
        W2KRunAsUser = 0
    Else
        W2KRunAsUser = Err.LastDllError
        MsgBox "CreateProcessWithLogonW() failed with error " & Err.LastDllError, vbExclamation
    End If

End Function

'********************************************************************' RunAsUser for Windows NT 4.0
'********************************************************************
Public Function NT4RunAsUser(ByVal UserName As String, _ByVal Password As String, _ByVal DomainName As String, _ByVal CommandLine As String, _ByVal CurrentDirectory As String) As Long
    Dim Result As Long
    Dim hToken As Long
    Dim si As STARTUPINFO
    Dim pi As PROCESS_INFORMATION

    Result = LogonUser(UserName, DomainName, Password, LOGON32_LOGON_INTERACTIVE, _
    LOGON32_PROVIDER_DEFAULT, hToken)
    If Result = 0 Then
        NT4RunAsUser = Err.LastDllError
        ' LogonUser will fail with 1314 error code, if the user account associated
        ' with the calling security context does not have
        ' "Act as part of the operating system" permission
        MsgBox "LogonUser() failed with error " & Err.LastDllError, vbExclamation
        Exit Function
    End If

    si.cb = Len(si)
    Result = CreateProcessAsUser(hToken, 0&, CommandLine, 0&, 0&, False, _
    CREATE_DEFAULT_ERROR_MODE, _
    0&, CurrentDirectory, si, pi)
    If Result = 0 Then
        NT4RunAsUser = Err.LastDllError
        ' CreateProcessAsUser will fail with 1314 error code, if the user
        ' account associated with the calling security context does not have
        ' the following two permissions
        ' "Replace a process level token"
        ' "Increase Quotoas"
        MsgBox "CreateProcessAsUser() failed with error " & Err.LastDllError, vbExclamation
        CloseHandle hToken
        Exit Function
    End If

    CloseHandle hToken
    CloseHandle pi.hThread
    CloseHandle pi.hProcess
    NT4RunAsUser = 0

End Function

Public Function RunAsUser(ByVal UserName As String, _ByVal Password As String, _ByVal DomainName As String, _ByVal CommandLine As String, _ByVal CurrentDirectory As String) As Long

    Dim w2kOrAbove As Boolean
    Dim osinfo As OSVERSIONINFO
    Dim Result As Long
    Dim uErrorMode As Long

    ' Determine if system is Windows 2000 or later
    osinfo.dwOSVersionInfoSize = Len(osinfo)
    osinfo.szCSDVersion = Space$(128)
    GetVersionExA osinfo
    w2kOrAbove = _
    (osinfo.dwPlatformId = VER_PLATFORM_WIN32_NT And _
    osinfo.dwMajorVersion >= 5)
    If (w2kOrAbove) Then
    Result = W2KRunAsUser(UserName, Password, DomainName, _
    CommandLine, CurrentDirectory)
    Else
    Result = NT4RunAsUser(UserName, Password, DomainName, _
    CommandLine, CurrentDirectory)
    End If
    RunAsUser = Result
End Function
```
