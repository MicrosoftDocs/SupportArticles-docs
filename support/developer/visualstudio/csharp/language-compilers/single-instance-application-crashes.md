---
title: Single instance application crashes
description: This article provides a resolution to solve the problem that single instance application crashes. This problem occurs if the application uses the WindowsFormsApplicationBase.
ms.date: 04/27/2020
ms.custom: sap:Language or Compilers\C#
ms.reviewer: rachanr
---
# Single instance application crashes

This article helps you resolve the problem where single instance application crashes if the application uses `WindowsFormsApplicationBase`.

_Original product version:_ &nbsp; Visual C#, Visual Basic.NET  
_Original KB number:_ &nbsp; 2834636

## Symptoms

You have a single instance Visual Basic.NET application or a C# application that uses the `WindowsFormsApplicationBase` class to make the application single instance and you are running the application as in an environment with IP Virtualization turned on. The application may crash. if a debugger is attached to the application, you will notice that the exception is `CantStartSingleInstanceException`.

## Cause

This is because the `Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase` type is not designed to run in an environment with IP Virtualization turned on.

## Resolution

To work around this issue, you can use a named `mutex` or enumerate all the processes and see if a previous instance of the application is running and activate it.

## Sample code that uses a named mutex

> [!NOTE]
> If you are using a named `mutex` to limit your application to a single instance, a malicious user can create this `mutex` before you do and prevent your application from starting. To prevent this situation, create a randomly named `mutex` and store the name so that it can only be obtained by an authorized user. Alternatively, you can use a file for this purpose. To limit your application to one instance per user, create a locked file in the user's profile directory.

- Visual C# code

    ```cs
    [STAThread]
    public static void Main()
    {
        bool prevInstance;
        _ = new System.Threading.Mutex(true, "Application Name", out prevInstance);
        if (prevInstance == false)
        {
            MessageBox.Show("There is another instance running");
            return;
        }
        Application.Run(new Form1());
    }
    ```

- Visual Basic .NET code

    ```vb
    Public mutex As System.Threading.Mutex
    Public Sub main()
        Dim prevInstance As Boolean
        mutex = New System.Threading.Mutex(True, "Application Name", prevInstance)
        If (prevInstance = False) Then
            MessageBox.Show("There is another instance running")
            Return
        End If
        Application.Run(New Form1())
    End Sub
    ```

## Sample code that enumerates processes to see if a previous instance is running and activates it

- Visual C# code

    ```cs
    [DllImport ("user32.dll")]
    private static extern int ShowWindow (IntPtr hWnd, int nCmdShow);
    [DllImport ("user32.dll")]
    private static extern int SetForegroundWindow (IntPtr hWnd);
    [DllImport ("user32.dll")]
    private static extern int IsIconic (IntPtr hWnd);
    private const int SW_RESTORE = 9;

    /// <summary>
    /// The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main ()
    {
        var processes = System.Diagnostics.Process.GetProcessesByName ("WindowsFormsApplication1");
        foreach (System.Diagnostics.Process p in processes)
        {
            //Is this the current process?
            if (System.Diagnostics.Process.GetCurrentProcess ().Id == p.Id)
                continue;
            //if the other process is running, we need to activate it and...
            if (null != p.MainWindowHandle)
            {
                if (IsIconic (p.MainWindowHandle) != 0)
                {
                    ShowWindow (p.MainWindowHandle, SW_RESTORE);
                }
                SetForegroundWindow (p.MainWindowHandle);
            }
            //...exit this instance.
            return;
        }
        Application.EnableVisualStyles ();
        Application.SetCompatibleTextRenderingDefault (false);
        Application.Run (new Form1 ());
    }
    ```

- Visual Basic .NET code

    ```vb
    <DllImport("user32.dll")> _
    Private Function ShowWindow(hWnd As IntPtr, nCmdShow As Integer) As Integer
    End Function
    <DllImport("user32.dll")> _
    Private Function SetForegroundWindow(hWnd As IntPtr) As Integer
    End Function
    <DllImport("user32.dll")> _
    Private Function IsIconic(hWnd As IntPtr) As Integer
    End Function
    Private Const SW_RESTORE As Integer = 9

    ''' <summary>
    ''' The main entry point for the application.
    ''' </summary>
    <STAThread> _
    Public Sub Main()
        Dim processes = System.Diagnostics.Process.GetProcessesByName("WindowsApplication1")
        For Each p As System.Diagnostics.Process In processes

        'Is this the current process?
        If System.Diagnostics.Process.GetCurrentProcess().Id = p.Id Then
            Continue For
        End If
        'if the other process is running, we need to activate it and...
        If p.MainWindowHandle = Nothing Then
        If IsIconic(p.MainWindowHandle) <> 0 Then
            ShowWindow(p.MainWindowHandle, SW_RESTORE)
        End If

            SetForegroundWindow(p.MainWindowHandle)
        End If
        '...exit this instance.
        Return
        Next

        Application.EnableVisualStyles()
        Application.SetCompatibleTextRenderingDefault(False)
        Application.Run(New Form1())
    End Sub
    ```

## More information

For more information, see [Ensuring that only a single instance of a .NET application is running](http://covingtoninnovations.com/mc/SingleInstance.html).
