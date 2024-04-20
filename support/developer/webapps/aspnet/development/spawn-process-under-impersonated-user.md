---
title: Spawn process under impersonated user
description: This article describes how to spawn a process that runs under the context of the impersonated user.
ms.date: 08/07/2020
ms.custom: sap:Development
ms.reviewer: earlb
ms.topic: how-to
---
# Spawn a process that runs under the context of the impersonated user in Microsoft ASP.NET

This article describes how to spawn a process that runs under the context of the impersonated user.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 889251

## Introduction

This step-by-step article describes how to spawn a process that runs under the context of the impersonated user in ASP.NET pages. To spawn a process that runs under the context of the impersonated user, you cannot use the `System.Diagnostics.Process.Start` method. This is because in ASP.NET, impersonation is performed at the thread level and not at the process level. Therefore, any process that you spawn from ASP.NET will run under the context of the ASP.NET worker process and not under the impersonated context.

## Description of the technique

To work around this issue, you must make platform invoke (P/Invoke) calls to the following Win32 APIs:

- The `CreateProcessAsUser` function creates a process under the identity of the security token that is specified in one of the parameters. However, the call to the `CreateProcessAsUser` function requires a primary token. Therefore, you must convert the impersonated token to a primary token.

- The `DuplicateTokenEx` function converts an impersonated token to a primary token. The call to the `CreateProcessAsUser` function uses this primary token.

> [!NOTE]
> For the call to the `CreateProcessAsUser` function to work, the following security user rights must be assigned to the impersonated user:
>
> - On a computer that is running Windows, assign the **Replace a process level token** user right and the **Increase quotas** user right to the impersonated user.
> - On a computer that is running Windows Server or Windows XP, assign the **Replace a process level token** user right to the impersonated user.

## Steps to spawn a process

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. To spawn a process that runs under the context of the impersonated user, follow these steps:

1. In **Visual Studio .NET**, create a new Visual C# ASP.NET Web application, and then name the application *Q889251*.
2. Open the *WebForm1.aspx* file in **code view**.
3. In the *WebForm1.aspx* file, add the following statements to the using block of code.

    ```csharp
    using System.Runtime.InteropServices;
    using System.Security.Principal;
    ```

4. Locate the line of code that looks similar to the following line of code.

    ```csharp
    public class WebForm1 : System.Web.UI.Page
    ```

5. After the line of code that is identified in step 4, add the following code.

    ```csharp
    [StructLayout(LayoutKind.Sequential)]
    public struct STARTUPINFO
    {
        public int cb;
        public String lpReserved;
        public String lpDesktop;
        public String lpTitle;
        public uint dwX;
        public uint dwY;
        public uint dwXSize;
        public uint dwYSize;
        public uint dwXCountChars;
        public uint dwYCountChars;
        public uint dwFillAttribute;
        public uint dwFlags;
        public short wShowWindow;
        public short cbReserved2;
        public IntPtr lpReserved2;
        public IntPtr hStdInput;
        public IntPtr hStdOutput;
        public IntPtr hStdError;
    }
    [StructLayout(LayoutKind.Sequential)]
    public struct PROCESS_INFORMATION
    {
        public IntPtr hProcess;
        public IntPtr hThread;
        public uint dwProcessId;
        public uint dwThreadId;
    }
    [StructLayout(LayoutKind.Sequential)]
    public struct SECURITY_ATTRIBUTES
    {
        public int Length;
        public IntPtr lpSecurityDescriptor;
        public bool bInheritHandle;
    }
    [DllImport("kernel32.dll", EntryPoint="CloseHandle", SetLastError=true, CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
    public extern static bool CloseHandle(IntPtr handle);
    [DllImport("advapi32.dll", EntryPoint="CreateProcessAsUser", SetLastError=true, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
    public extern static bool CreateProcessAsUser(IntPtr hToken, String lpApplicationName, String lpCommandLine, ref SECURITY_ATTRIBUTES lpProcessAttributes, ref SECURITY_ATTRIBUTES lpThreadAttributes, bool bInheritHandle, int dwCreationFlags, IntPtr lpEnvironment, String lpCurrentDirectory, ref STARTUPINFO lpStartupInfo, out PROCESS_INFORMATION lpProcessInformation);
    [DllImport("advapi32.dll", EntryPoint="DuplicateTokenEx")]
    public extern static bool DuplicateTokenEx(IntPtr ExistingTokenHandle, uint dwDesiredAccess, ref SECURITY_ATTRIBUTES lpThreadAttributes, int TokenType, int ImpersonationLevel, ref IntPtr DuplicateTokenHandle);
    ```

6. In **Solution Explorer**, right-click **WebForm1.aspx**, and then click **Open**. The Web form opens in **design view**.
7. On the **View** menu, click **HTML Source**.
8. Replace all the existing code in the **HTML Source** window with the following code.

    ```html
    <%@ Page language="c#" Codebehind="WebForm1.aspx.cs" AutoEventWireup="false" Inherits="Q889251.WebForm1" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
    <HTML>
       <HEAD>
          <title>WebForm1</title>
          <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
          <meta name="CODE_LANGUAGE" Content="C#">
          <meta name="vs_defaultClientScript" content="JavaScript">
          <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
       </HEAD>
       <body>
          <form id="Form1" method="post" runat="server">
             <P>&nbsp;</P>
             <P>
                Enter Path of process to be run (with relevant parameters)
                <asp:TextBox id="TextBox1" runat="server"></asp:TextBox>
             </P>
             <P>
                <asp:Button id="Button1" runat="server" Text="CreateProcess"></asp:Button>
             </P>
             <P>
                <asp:Label id="Label1" runat="server">Status:</asp:Label>
             </P>
             <P>
                <asp:Label id="Label2" runat="server">Impersonated Identity:</asp:Label>
             </P>
          </form>
       </body>
    </HTML>
    ```

9. On the **View** menu, click **Design**.
10. Double-click **CreateProcess**. The `Button1_Click` method is inserted into the code, and the code appears in the content pane.
11. Replace the existing `Button1_Click` method with the following code.

    ```csharp
    private void Button1_Click(object sender, System.EventArgs e)
    {
        IntPtr Token = new IntPtr(0);
        IntPtr DupedToken = new IntPtr(0);
        bool ret;
        Label2.Text+=WindowsIdentity.GetCurrent().Name.ToString();
        SECURITY_ATTRIBUTES sa = new SECURITY_ATTRIBUTES();
        sa.bInheritHandle = false;
        sa.Length = Marshal.SizeOf(sa);
        sa.lpSecurityDescriptor = (IntPtr)0;
        Token = WindowsIdentity.GetCurrent().Token;
        const uint GENERIC_ALL = 0x10000000;
        const int SecurityImpersonation = 2;
        const int TokenType = 1;
        ret = DuplicateTokenEx(Token, GENERIC_ALL, ref sa, SecurityImpersonation, TokenType, ref DupedToken);
        if (ret == false)
        {
            Label1.Text +="DuplicateTokenEx failed with " + Marshal.GetLastWin32Error();
        }
        else
        {
            Label1.Text+= "DuplicateTokenEx SUCCESS";
            STARTUPINFO si = new STARTUPINFO();
            si.cb = Marshal.SizeOf(si);
            si.lpDesktop = "";
            string commandLinePath;
            commandLinePath = TextBox1.Text;
            PROCESS_INFORMATION pi = new PROCESS_INFORMATION();
            ret = CreateProcessAsUser(DupedToken,null,commandLinePath, ref sa, ref sa, false, 0, (IntPtr)0, "c:\\", ref si, out pi);
            if (ret == false)
            {
                Label1.Text +="CreateProcessAsUser failed with " + Marshal.GetLastWin32Error();
            }
            else
            {
                Label1.Text +="CreateProcessAsUser SUCCESS. The child PID is" + pi.dwProcessId;
                CloseHandle(pi.hProcess);
                CloseHandle(pi.hThread);
            }
            ret = CloseHandle(DupedToken);
            if (ret == false)
            {
                Label1.Text+=Marshal.GetLastWin32Error();
            }
            else
            {
                Label1.Text+="CloseHandle SUCCESS";
            }
        }
    }
    ```

12. On the **Build** menu, click **Build Solution**.
13. On the **Debug** menu, click **Start**.
14. In the **WebForm1** page, type the path of a process that you want to start. For example, type `SystemDriver \Windows\Notepad.exe`.
15. Click **CreateProcess**.

## References

- [Implement impersonation in an ASP.NET application](implement-impersonation.md)

- [HOW TO: Create a Local Web Server ASP.NET Application](https://support.microsoft.com/help/321748)
