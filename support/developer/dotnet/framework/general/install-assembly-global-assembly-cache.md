---
title: Install an assembly in global assembly cache
description: Describes how to install an assembly .dll file in the Microsoft .NET Framework global assembly cache.
ms.date: 05/06/2020
ms.topic: how-to
---
# Install an assembly in the .NET Framework global assembly cache

This article describes how to install an assembly .dll file in the Microsoft .NET Framework global assembly cache, and create an assembly that has a strong name by using Visual Studio.

_Original product version:_ &nbsp; .NET Framework, Visual Studio  
_Original KB number:_ &nbsp; 910355

## Summary

To install an assembly .dll file in the .NET Framework global assembly cache, you can use the .NET Framework SDK Global Assembly Cache tool. You can also use the Global Assembly Cache tool to verify that the assembly is installed in the global assembly cache. To accomplish this task, you may have Administrator rights to the computer where the shared assembly is installed. What's more, you must install the .NET Framework SDK.

For a Visual C# .NET version of this article, see [How to install an assembly into the Global Assembly Cache in Visual C#](https://support.microsoft.com/help/815808).

## Global assembly cache

The .NET Framework global assembly cache is a code cache. The global assembly cache is automatically installed on each computer that has the .NET Framework common language runtime installed. Any application that is installed on the computer can access the global assembly cache. The global assembly cache stores assemblies that are designated to be shared by several applications on the computer. Component assemblies are typically stored in the `C:\WINNT\Assembly` folder.

> [!NOTE]
> Only install an assembly in the global assembly cache when you need to share the assembly. Unless sharing an assembly is explicitly required, we recommend you keep assembly dependencies private and that you locate the assembly in the application directory. Additionally, you don't have to install an assembly in the global assembly cache to make the assembly available to Microsoft Component Object Model (COM) interop or to un-managed code.

## An assembly

An assembly is a fundamental part of programming with the .NET Framework. An assembly is a reusable, self-describing building block of a .NET Framework common language runtime application.

An assembly contains one or more code components that the common language runtime executes. All types and all resources in the same assembly form an individual version of the unit. The assembly manifest describes the version dependencies that you specify for any dependent assemblies. By using an assembly, you can specify version rules between different software components, and you can have those rules enforced at run time. An assembly supports side-by-side execution. WHich enables multiple versions to run at the same time.

## Strong-name signing

An assembly must have a strong name to be installed in the global assembly cache. A strong name is a globally unique identity that can't be spoofed by someone else. By using a strong name, you prevent components that have the same name from conflicting with each other or from being used incorrectly by a calling application. Assembly signing associates a strong name together with an assembly. Assembly signing is also named strong-name signing. A strong name consists of the following information:

- The simple text name of the assembly
- The version number of the assembly
- The culture information about the assembly, if this information is provided
- A public key and private key pair

This information is stored in a key file. The key file is either a Personal Information Exchange (.pfx) file or a certificate from the current user's Microsoft Windows certificate store.

You can sign an assembly by using the options on the **Signing** tab of the **Project Designer** in Visual Studio. In Visual Studio, the key file must be stored in the project folder on the local computer. Visual Studio supports only the following file formats:

- Personal Information Exchange (.pfx) files
- Strong name key (.snk) files

## Requirements

You might meet the following requirements before you install an assembly in the global assembly cache:

- You must have Administrator rights to the computer where the shared assembly is installed.
- You must install the .NET Framework SDK.

This article assumes that you're familiar with the following topics:

- General familiarity with shared assemblies in .NET.
- General familiarity with the use of tools at a command prompt.

## Install an assembly in the global assembly cache

This method is based on how to create an assembly by using Visual Studio. To create an assembly that can be shared by multiple applications, the shared assembly must have a strong name. Additionally, the shared assembly must be deployed in the global assembly cache.

To create a small Visual C# assembly that has a strong name and to install the compiled .dll file in the global assembly cache, follow these steps:

1. Create a new Visual C# Class Library project that is named *GACDemo*. To do it, follow these steps:

    1. Start Visual Studio.
    2. On the **File** menu, select **New Project**.
    3. In the **Templates** list, select **Class Library**.
    4. In the **Name** box, type *GACDemo*, and then select **OK**.
    5. To save the project, press CTRL+SHIFT+S.
    6. In the **Location** box, type `C:\DemoProjects`.
    7. Clear the **Create directory for solution** check box, and then select **Save**.

2. Generate a strong name, and then associate the strong name key file together with the assembly. To do it, follow these steps:

    1. On the **Project** menu, select **GACDemo Properties**.
    2. On the **Signing** tab, select the **Sign the assembly** check box.
    3. Under **Choose a strong name key file**, select **\<New>**.
    4. In the **Create Strong Name Key** dialog box, select the **Protect my key file with a password** check box.
    5. In the **Key file name** box, type *GACDemo*.
    6. In the **Enter password** box, type the password that you want to use.
    7. In the **Confirm password** box, type the same password, and then select **OK**.

        > [!NOTE]
        > We recommend you always use a password when you create a key file. A new key file that is protected by a password is always created in the .pfx file format.

    8. To compile the project, press CTRL+SHIFT+B.

        > [!NOTE]  
        > No additional code is required to install a .dll file in the global assembly cache.

3. Install the .dll file that you created in step 2 in the global assembly cache by using the Global Assembly Cache tool. To do it, follow these steps:

    1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
    2. Change the current working directory to the directory where the .NET Framework SDK is installed.
    3. At a command prompt, type the `gacutil -I "C:\DemoProjects\GACDemo\bin\Release\GACDemo.dll"` command, and then press ENTER.

## Verify the assembly is installed in the global assembly cache

You can use the Global Assembly Cache tool to verify the assembly is installed in the global assembly cache. To do it, follow these steps:

1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
2. Change the current working directory to the directory where the .NET Framework SDK is installed.
3. To display the installation information about the GACDemo assembly, use the Global Assembly Cache tool. To do it, type the `gacutil -l GACDemo` command at a command prompt, and then press ENTER.

    > [!NOTE]
    > The installation information about the GACDemo assembly is displayed.

## References

- [Assemblies Overview](/previous-versions/dotnet/netframework-1.1/k3677y81(v=vs.71))

- [Global Assembly Cache](/previous-versions/dotnet/netframework-1.1/yf1d93sz(v=vs.71))

- [Global Assembly Cache Tool (Gacutil.exe)](/previous-versions/dotnet/netframework-1.1/ex0ss12c(v=vs.71))
