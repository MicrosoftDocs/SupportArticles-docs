---
title: Adding references to a managed C++ project
description: Describes how to add references to a managed Visual C++ project.
ms.date: 04/13/2020
ms.reviewer: jianges, jroth
ms.topic: how-to
ms.custom: sap:Language or Compilers\C++
---
# Add references to a managed Visual C++ project  

This article provides information about how to add references to a managed Visual C++ project.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 310674

## Summary

This article describes the process of adding a reference to another assembly in a Visual C++ project. In other languages, such as Visual C#, you can add a reference through the **Add Reference** dialog box. This dialog box is not available to managed C++ applications. There are several tips that make using references in a managed C++ application easier.

## Microsoft .NET references

.NET references point to shared assemblies. For example, the assembly *System.Windows.Forms.dll* is a standard assembly for accessing the Windows Forms classes. In order to use this assembly in a managed C++ application, you simply have to reference it with a `#using` preprocessor directive, as shown here:

```cpp
#using <System.Windows.Forms.dll>
```

## COM references

Use of a Component Object Model (COM) object in a managed C++ application involves a design decision. One option is to use unmanaged COM code inside of a managed class. For example, you could decide to use the traditional `#import` solution. This can be a good option for cases where there are problems using COM Interop.

The second option is to use interop assemblies that wrap the COM object. This is the only method available to other languages like C#, and Visual Basic .NET. To create an interop assembly for a COM object, use the TLBIMP.exe tool. For example, use the following steps to automate Internet Explorer from a managed application:

1. Open a command prompt.
2. Navigate to the *Windows System* folder.
3. Type the following command:

    ```console
    tlbimp shdocvw.dll /out:Interop.shdocvw.dll
    ```

4. Move *Interop.shdocvw.dll* to your project folder.

This creates an interop assembly for the COM objects in *Shdocvw.dll*. The resulting file, *Interop.shdocvw.dll*, can be used with a `#using` directive. It can then be treated as a managed component. For instructions on automatically copying this dynamic link library (DLL) to the output folder, see the [Using post-build events](#using-post-build-events) section of this article.

> [!NOTE]
> The environment variables for Visual C++ must be set in order for TLBIMP.exe to be recognized. If they are not set, you will first have to run `./VC7/BIN/VCVARS32.bat` in Visual Studio .NET or `./VC/BIN/VCVARS32.bat` in Visual Studio and Visual C++ Express Edition.

## Project references

Project references are references to assemblies created by other projects. Again, the `#using` directive is used to reference these assemblies. However, because these assemblies are not shared, you must take measures to ensure that the compiler can find them. There are two methods for doing this:

- Copy the assembly to the project folder.
- Change the project settings to look for the assembly:

1. Open the project's **Property Pages** dialog box.
2. Click the **C/C++** folder.

    > [!NOTE]
    > In Visual C++, expand **Configuration Properties**, and then expand **C/C++**.

3. Click the **General property** page.
4. Modify the **Resolve #using References** property to point to the folder that contains the target assembly.

## Using post-build events

Private assemblies must reside in the same folder as the executable that is using them. When you add a reference in Visual C#, in Visual Basic .NET, or in Visual Basic, it is automatically copied to the output folder. In a managed C++ application, this step can be automated through the use of `post-build` events. For example, consider a scenario in which you have an assembly named *MYLIB.dll* in the project folder of your managed C++ application named *TestApp*. The following steps will set up a `post-build` event that will copy this DLL to the output folder of the *TestApp* project.

1. Open the Managed C++ project's **Property Pages** dialog box.
2. Click the **Build Events** folder.

    > [!NOTE]
    > In Visual C++, expand **Configuration Properties**, and then expand **Build Events**.

3. Click the **Post-Build Event property** page.
4. Modify the **Command Line** property to the following command:

    ```console
    copy $(<ProjectDir>)mylib.dll $(<TargetDir>)  
    ```

## Using Visual C++ .NET or Visual C++

By using Visual C++ .NET or Visual C++, you can add a reference by means of the **Add Reference** dialog box. To add a project reference, follow these steps:

1. In Solution Explorer, select the project.
2. On the **Project** menu, click **Add References**.

    > [!NOTE]
    > In Visual C++, click **References** on the **Project** menu, and then click **Add New Reference**.

3. In the **Add References** dialog box, click the tab that corresponds with the category that you want to add a reference to.

    > [!NOTE]
    > In Visual C++, click the **Browse** tab in the **Add References** dialog box.

4. Click **Browse**, locate the component that you want on your local drive, and then click **OK**. The component is added to the **Selected Components** field.

    > [!NOTE]
    > In Visual C++, locate the component that you want on your local drive.

5. To add the selected reference to the current tab, click **Add**.

    > [!NOTE]
    > In Visual C++, click **OK** to close the dialog box and add the component in the **References** list box on the **Properties Page** dialog box of the project.
