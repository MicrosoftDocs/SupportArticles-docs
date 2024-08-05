---
title: Check if program is running
description: This article describes how to determine if your program is running in the Visual Basic integrated development environment or as a compiled executable file.
ms.date: 10/12/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
ms.topic: how-to
---
# Check If program is running in the IDE or an EXE File

This article describes how to determine if your program is running in the Visual Basic integrated development environment (IDE) or as a compiled executable file.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 177636

## Summary

This article demonstrates how to determine if your program is running in the Visual Basic IDE or as a compiled executable file. You might want to check where your program is running if you need to add debugging information that would not be visible in the compiled version of your program.

## More information

There are two methods you can use to determine if your program is running from the IDE or the EXE.

- Method 1: EXE file name differs from project name

  The App object contains general information about the program, such as the executable file name. If the project name and the compiled version of the project have different file names, then you can use the `App.EXEName` property to determine if the EXE is running or if your project is running in the IDE. If the program is running from the Visual Basic IDE, the `EXEName` property returns the project name. When a program is running from an executable, the `EXEName` property contains the EXE file name.

- Method 2: EXE file name and the project name are the same

  If the project name and the compiled version share the same name, then use the `GetModuleFileName` API function to determine if your program is running from the IDE or from a compiled version. `GetModuleFileName` retrieves the full path and filename for the executable file containing the specified module. If the function returns a path to the Visual Basic file, VB5.EXE, then the program is running in the IDE. Otherwise, the program is running from an executable file.

`GetModuleFileName` requires the following arguments:

- `hModule`: the handle to the module whose filename you want. Use the `hInstance` property of the `APP` object for this parameter.

- `lpFilename`: a pointer to buffer to receive module path. Create a string variable 255 characters long and pass that variable for this parameter.

- `nSize`: the size of buffering characters. Use 255 for this parameter.

The next section illustrates how to create a sample project that implements both of these methods.

## Sample Project

1. Start a new Standard EXE project in Visual Basic. Form1 is created by default.

2. Add two **CommandButtons** to Form1.

3. Copy the following code to the Code window of Form1:

    ```vbnet
    Option Explicit

    Private Declare Function GetModuleFileName Lib "kernel32" _
    Alias "GetModuleFileNameA" _
    (ByVal hModule As Long, _
    ByVal lpFileName As String, _
    ByVal nSize As Long) As Long

    Private Sub Form_Load()'Set the command button names
        Command1.Caption = "Different Project and Executable Names"
        Command2.Caption = "Similar File Names"
    End Sub

    Private Sub Command1_Click()'Click this button if the project name and the compiled file
    'name are different.
        MsgBox VB.App.EXEName
    End Sub

    Private Sub Command2_Click()'Click this button if the project name and the compiled file
    'name are the same.

        Dim strFileName As String
        Dim lngCount As Long

        strFileName = String(255, 0)
        lngCount = GetModuleFileName(App.hInstance, strFileName, 255)
        strFileName = Left(strFileName, lngCount)
            If UCase(Right(strFileName, 7)) <> "VB5.EXE" Then
            MsgBox "Compiled Version"
            Else
            MsgBox "IDE Version"
            End If
    End Sub
    ```

4. Save the project with the *IDEApp* project name.

5. Compile two different executable files from this project. Use the default file name, IDEApp.exe, for the first executable file. For the second executable file, use the file name *EXEApp*. To compile the project, complete the following steps:

    - From the **File** menu, click **Make IDEApp.exe**. The **Make Project** dialog box appears.

    - Use the default file name or type your file name in the File name text box.

    - Click **OK** to create the executable file and to close the **Make project Dialog** box.

6. On the **Run** menu, click **Start** or press the **F5** key to start the program. Click the Different Project and Executable Names button. A message box displays with the message, **IDEApp,** to indicate that the program is running from the IDE. Click the **Similar File Names** button. A message box displays with the message, **IDE Version,** to indicate the program is running from the IDE. Close down the project.

7. Run either executable file and click the **CommandButtons**. A message box is shown indicating the program is running from an executable file.
