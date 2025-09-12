---
title: Write CGI applications
description: This article describes how to write CGI applications.
ms.date: 10/26/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
ms.topic: how-to
---
# Write CGI Applications in Visual Basic

This article describes how to write CGI applications.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 239588

## Summary

A Common Gateway Interface (CGI) application can be written in any programming language that can access both the environment variables and STDIN or STDOUT. Because of the powerful text handling capability of the Visual Basic programming language, many Web developers want to write CGI programs in Visual Basic. This article illustrates the techniques for writing CGI applications in Visual Basic, and provides a simple Visual Basic CGI sample.

## More information

> [!NOTE]
> Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

## Retrieving environment variables

To retrieve an environment variable, use the `Environ$` function in Visual Basic as follows:

```vb
VALUE = Environ$(NAME)
```

> [!NOTE]
> NAME is the environment variable that you want to retrieve. Its value is returned in `VALUE`.

## Reading from STDIN and writing to STDOUT

Use the Win32 `ReadFile` function to read from `STDIN` and the `WriteFile` function to write to `STDOUT`. These functions require you to provide a handle to `STDIN` or `STDOUT`. You can use the `GetStdHandle` function to get the handles to `STDIN` or `STDOUT`. In this article, aliasing is used on the `GetStdHandle` function to simplify the function calls. The declarations for these functions are as follows:

```vb
Public Declare Function stdin Lib "kernel32" Alias "GetStdHandle" _
(Optional ByVal Handletype As Long = STD_INPUT_HANDLE) As Long

Public Declare Function stdout Lib "kernel32" Alias "GetStdHandle" _
(Optional ByVal Handletype As Long = STD_OUTPUT_HANDLE) As Long

Public Declare Function ReadFile Lib "kernel32" _
(ByVal hFile As Long, ByVal lpBuffer As Any, ByVal nNumberOfBytesToRead As Long, _
lpNumberOfBytesRead As Long, Optional ByVal lpOverlapped As Long = 0&) As Long

Public Declare Function WriteFile Lib "kernel32" _
(ByVal hFile As Long, ByVal lpBuffer As Any, ByVal nNumberOfBytesToWrite As Long, _
lpNumberOfBytesWritten As Long, Optional ByVal lpOverlapped As Long = 0&) As Long
```

The constants passed to the `GetStdHandle` function are defined as:

```vb
Public Const STD_INPUT_HANDLE = -10&
Public Const STD_OUTPUT_HANDLE = -11&
```

Refer to the MSDN documentation for the definition of each parameter in those functions. In the following sample, a full list of CGI environment variables is made constant. This lists all the constants together on a Ctrl-J. It also eliminates programming errors by providing compiler and IntelliSense validation, yet does not preclude you from entering your own strings.

## Sample code

For simplicity, error trapping is omitted in the following sample (Hello.bas):

```vb
Option Explicit

Public Const STD_INPUT_HANDLE = -10&
Public Const STD_OUTPUT_HANDLE = -11&

Public Const CGI_AUTH_TYPE As String = "AUTH_TYPE"
Public Const CGI_CONTENT_LENGTH As String = "CONTENT_LENGTH"
Public Const CGI_CONTENT_TYPE As String = "CONTENT_TYPE"
Public Const CGI_GATEWAY_INTERFACE As String = "GATEWAY_INTERFACE"
Public Const CGI_HTTP_ACCEPT As String = "HTTP_ACCEPT"
Public Const CGI_HTTP_REFERER As String = "HTTP_REFERER"
Public Const CGI_HTTP_USER_AGENT As String = "HTTP_USER_AGENT"
Public Const CGI_PATH_INFO As String = "PATH_INFO"
Public Const CGI_PATH_TRANSLATED As String = "PATH_TRANSLATED"
Public Const CGI_QUERY_STRING As String = "QUERY_STRING"
Public Const CGI_REMOTE_ADDR As String = "REMOTE_ADDR"
Public Const CGI_REMOTE_HOST As String = "REMOTE_HOST"
Public Const CGI_REMOTE_USER As String = "REMOTE_USER"
Public Const CGI_REQUEST_METHOD As String = "REQUEST_METHOD"
Public Const CGI_SCRIPT_NAME As String = "SCRIPT_NAME"
Public Const CGI_SERVER_NAME As String = "SERVER_NAME"
Public Const CGI_SERVER_PORT As String = "SERVER_PORT"
Public Const CGI_SERVER_PROTOCOL As String = "SERVER_PROTOCOL"
Public Const CGI_SERVER_SOFTWARE As String = "SERVER_SOFTWARE"

Public Declare Function Sleep Lib "kernel32" _
(ByVal dwMilliseconds As Long) As Long

Public Declare Function stdin Lib "kernel32" Alias "GetStdHandle" _
(Optional ByVal Handletype As Long = STD_INPUT_HANDLE) As Long

Public Declare Function stdout Lib "kernel32" Alias "GetStdHandle" _
(Optional ByVal Handletype As Long = STD_OUTPUT_HANDLE) As Long

Public Declare Function ReadFile Lib "kernel32" _
(ByVal hFile As Long, ByVal lpBuffer As Any, ByVal nNumberOfBytesToRead As Long, _
lpNumberOfBytesRead As Long, Optional ByVal lpOverlapped As Long = 0&) As Long

Public Declare Function WriteFile Lib "kernel32" _
(ByVal hFile As Long, ByVal lpBuffer As Any, ByVal nNumberOfBytesToWrite As Long, _
lpNumberOfBytesWritten As Long, Optional ByVal lpOverlapped As Long = 0&) As Long

Sub Main()

    Dim sReadBuffer As String
    Dim sWriteBuffer As String
    Dim lBytesRead As Long
    Dim lBytesWritten As Long
    Dim hStdIn As Long
    Dim hStdOut As Long
    Dim iPos As Integer

    ' sleep for one minute so the debugger can attach and set a break
    ' point on line below
    ' Sleep 60000

    sReadBuffer = String$(CLng(Environ$(CGI_CONTENT_LENGTH)), 0)' Get STDIN handle
    hStdIn = stdin()' Read client's input
    ReadFile hStdIn, sReadBuffer, Len(sReadBuffer), lBytesRead

    ' Find '=' in the name/value pair and parse the buffer
    iPos = InStr(sReadBuffer, "=")
    sReadBuffer = Mid$(sReadBuffer, iPos + 1)' Construct and send response to the client
    sWriteBuffer = "HTTP/1.0 200 OK" & vbCrLf & "Content-Type: text/html" & _
    vbCrLf & vbCrLf & "Hello "
    hStdOut = stdout()
    WriteFile hStdOut, sWriteBuffer, Len(sWriteBuffer) + 1, lBytesWritten
    WriteFile hStdOut, sReadBuffer, Len(sReadBuffer), lBytesWritten

End Sub
```

HTML form to test the CGI (Test.htm)

```html
<HTML>
    <HEAD>
        <TITLE>Testing VB CGI</TITLE>
    </HEAD>
    <BODY>
        <FORM action="/cgi-bin/hello.exe" method="POST">
            <INPUT TYPE="TEXT" NAME="Name"> Name<BR>
            <INPUT TYPE="SUBMIT">
        </FORM>
    </BODY>
</HTML>
```

Steps to build the CGI Hello.exe file:

1. Create a New Project as a standard .exe project.
2. Remove Form from the Project.
3. Add a Module to the Project and name it *HELLO*.
4. Set `Sub Main` as the Startup Object (under Project Properties).
5. Copy the above Visual Basic code and paste it to the Module.
6. Make Hello.exe.

    > [!NOTE]
    >
    > - The sample code demonstrates how to handle an HTTP `POST` request. To handle a GET request, the CGI application needs to retrieve the `QUERY_STRING` environment variable. The `QUERY_STRING` variable contains name/value pairs separated by the & in the format `Name=Joe&Color=Red`. URL encoding is used, all spaces are converted to + , and all special characters such as ! are converted to their HEX ASCII values. In other words, "Hello, World!" string is represented as "Hello,+World%21." Visual Basic CGI applications have to implement all the parsing code.
    >
    > - Because the CGI application is started by the service, it may not be able to access network shares.
    >
    > - Be aware that CGI runs as a service, which communicates with the server. Therefore, visual interface forms, controls, and message boxes are completely meaningless. As a matter of fact, a message box will cause a CGI application to stop responding.
    >
    > - Error handling should be conducted throughout a CGI code in Visual Basic, so that the default error message box is not be displayed. You can either log error messages on the server or write them to the user's browser.
    >
    > - Visual C debuggers can debug applications written in Visual Basic. Therefore, you can use the CGI debugging techniques referenced below. To debug a Visual Basic application with Visual C, choose Compile to Native Code , and then select Create Symbolic Debug Info and No Optimization . When it is completed and the .exe is generated, Visual C can attach to the running CGI application written in Visual Basic.
    >
    > - To test a CGI application, copy it to the IIS virtual directory with Execute permissions.
    >
    > - Be aware that runtime errors or dialog boxes in the Visual Basic code may cause the CGI application to stop responding. If the CGI application stops responding, it can be run in the Visual Studio debugger.

## References

- [RFC 2068, Hypertext Transfer Protocol](http://www.ietf.org/rfc/rfc2068.txt)

- [RFC 1738, Uniform Resource Locators (URL)](http://www.ietf.org/rfc/rfc1738.txt)
