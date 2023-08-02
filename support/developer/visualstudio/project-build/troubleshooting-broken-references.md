---
title: Troubleshoot broken references
description: Learn how to troubleshoot broken references that might be caused by something other than your application's inability to find the referred component.
ms.date: 07/01/2022
ms.reviewer: tglee, v-jayaramanp
---
# Troubleshoot broken references

_Applies to:_&nbsp;Visual Studio

If your application attempts to use a broken reference, an exception error is generated. The main reason for the error is the inability to find the referenced component, but there are several scenarios in which a reference is considered broken and they are:

- Project's reference path is incorrect or incomplete.
- Referenced file was deleted.
- Referenced file was renamed.
- Network connection or authentication has failed.
- Referenced COM component isn't installed on the computer.

The next few sections provide resolutions to these scenarios.

> [!NOTE]
> Files in assemblies are referenced with absolute paths in the project file. Therefore, users who work in a multi-developer environment might find that they're missing a referenced assembly in their local environment. To avoid these errors, it's better to add project-to-project references. For more information, see [Assemblies in .NET](/dotnet/standard/assembly/).

## Reference path is incorrect or incomplete

If projects are shared on different computers, some references might not be found when a component is located in a different directory. References are stored under the name of the component file (for example, _MyComponent_). When you add a reference to a project, the folder location of the component file (for example, _C:\MyComponents_) is appended to the **ReferencePath** project property.

When you open a project, Visual Studio looks in the directories on the reference path to try and find these component files. If you open the project on a computer that stores the component in a different directory, such as _D:\MyComponents_, the reference will not be found and an error appears in the **Task List**.

To fix this problem, use one of the following methods:

- Delete the broken reference and then replace it by using the **Add Reference** dialog box.
- Use the **Reference Path** item in the project's property pages. Modify the folders in the list to point to the correct locations. The **Reference Path** property is persisted for each user on each computer. Therefore, modifying your reference path doesn't affect other users of the project.

> [!TIP]
> Project-to-project references don't have these broken reference problems. For this reason, use Project-to-project references instead of file references, if you can.

### Fix a broken project reference

To fix a broken project reference, correct the reference path by following these steps:

1. In **Solution Explorer**, right-click your project node, and then select **Properties**.
   The **Project Designer** appears.
1. If you're using Visual Basic, select the **References** page, and then select **Reference Paths** .
   1. In the **Reference Paths** dialog box, type the path of the folder that contains the item you want to reference in the **Folder** field.
   1. Select **Add Folder**.
1. If you're using C#, select the **Reference Paths** page.
    1. In the **Folder** field, type the path of the folder that contains the item you want to reference.
    1. Select **Add Folder**.

## Referenced file was deleted

Here are two options to fix a broken project reference for a deleted file that no longer exists on your drive:

- Delete the reference.
- If the reference exists in another location on your computer, read it from that location.

## Referenced file was renamed

Here are two options to fix a broken reference for a file that was renamed:

- Delete the reference and then add a reference to the renamed file.
- If the reference exists in another location on your computer, read it from that location.

## Network connection or authentication has failed

There can be many possible causes for inaccessible files. For example, there might be a failed network connection or a failed authentication. Conversely, each cause might have a unique means of recovery. For example, you might have to contact the local administrator to access the required resources. However, deleting the reference and fixing the code that used it is always an option.

## Referenced COM component isn't installed on computer

If a user adds a reference to a COM component and a second user tries to run the code on a computer that doesn't have this component installed, the second user receives a broken reference error. Installing the component on the second computer corrects the error. For more information about how to use references to COM components in your projects, see [COM interoperability in .NET Framework applications](/dotnet/visual-basic/programming-guide/com-interop/com-interoperability-in-net-framework-applications).

## References

- [References Page, Project Designer (Visual Basic)](/visualstudio/ide/reference/references-page-project-designer-visual-basic)
- [What is the .NET Project Designer?](/visualstudio/ide/reference/project-properties-reference)