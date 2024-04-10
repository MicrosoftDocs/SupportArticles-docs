---
title: Build fails when you deploy a component
description: In Visual Studio development environment where .NET Framework 4.5 is installed, the build may fail when deploying the component with a property of type System.Text.Encoding to the form.
ms.date: 05/11/2020
ms.custom: sap:General
---
# Build may fail when you deploy the component with a property of type System.Text.Encoding to the form

This article helps you resolve a problem where the build fails when you deploy the component with a property of type `System.Text.Encoding` to the form.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 2956445

## Symptoms

In Microsoft Visual Studio development environment where .NET Framework 4.5 is installed, the build may fail when you deploy the component with a property of type `System.Text.Encoding` to the form.

It can occur when Visual Studio 2010 or Visual Studio 2012 is running in the environment with .NET Framework 4.5 installed.

It doesn't occur in the environment with .NET Framework 4.5.1 installed or when Visual Studio 2013 is running.

An example of the error message is:

> Invalid ResX file.Type in the data at line 138, position 5, cannot be loaded because it threw the following exception during construction: No data is available for encoding 932.

## Cause

It's because an error occurred during deserializing the property of type `System.Text.Encoding` from the resource file as objects in the build process.

When this error occurs, the build will fail because the object couldn't be loaded in the Windows form designer.

## Status

Microsoft has confirmed that it's a bug. This problem was corrected in .NET Framework 4.5 for Windows 8 and Windows Server 2012.

## Resolution

When you use Windows 8 and Windows Server 2012, contact Microsoft Customer Support Services in the following Knowledge Base article to obtain the hotfix for Framework 4.5 for Windows 8 and Windows Server 2012:  
Hotfix rollup 2848799 is available for the .NET Framework 4.5 on Windows 8 and Windows Server 2012 (2848799)

When you don't use Windows 8 and Windows Server 2012, install .NET Framework 4.5.1.

- [Download Microsoft .NET Framework 4.5.1 (Offline Installer) for Windows Vista SP2, Windows 7 SP1, Windows 8, Windows Server 2008 SP2 Windows Server 2008 R2 SP1 and Windows Server 2012](https://www.microsoft.com/download/details.aspx?id=40779).

- [Download Microsoft .NET Framework 4.5.1 (Web Installer) for Windows Vista SP2, Windows 7 SP1, Windows 8, Windows Server 2008 SP2 Windows Server 2008 R2 SP1 and Windows Server 2012](https://www.microsoft.com/download/details.aspx?id=40773).

.NET Framework 4.5.1 has language packs. Install the corresponding language pack as appropriate.

- [Download Microsoft .NET Framework 4.5.1 Language Pack (Offline Installer) for Windows Vista SP2, Windows 7 SP1, Windows 8, Windows Server 2008 SP2 Windows Server 2008 R2 SP1and Windows Server 2012](https://www.microsoft.com/download/details.aspx?id=40751)

## Steps to reproduce behavior

1. Create a new Windows Form application.
2. Add a user control (`UserControl1`) to your project.
3. Replace the code in the user control class with the following code:

    ```csharp
    public UserControl1()
    {
        InitializeComponent();
        Encoding = Encoding.GetEncoding(932);
    }
    public Encoding Encoding { get; set; }
    ```

4. Build the solution.
5. From the toolbox in the form's Design view, double-click the control described above to place it on the form.
6. Rebuild the solution.
