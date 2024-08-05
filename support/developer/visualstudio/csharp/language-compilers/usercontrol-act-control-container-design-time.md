---
title: Make UserControl act as control
description: Describes how to make a UserControl object act as a control container at design time after you add the UserControl object to a Windows Form.
ms.date: 04/13/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to make a UserControl object act as a control container design-time

This article provides information about how to make a UserControl object act as a control container at design time after you add the UserControl object to a Windows Form.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 813450

## Summary

This article refers to the Microsoft .NET Framework Class Library namespace `System.ComponentModel`.

This step-by-step article describes how to make a UserControl object act as a control container at design-time after you put the UserControl on a Windows Form. There may be situations where you want to drag a control to your UserControl. To do this, the UserControl must act as a control container.

By default, a UserControl object can act as a control container only when you create the control. To make a UserControl host a constituent control after you put the UserControl on a Windows Form, you must change the default designer of the UserControl. To implement design-time services for a component, use the `DesignerAttribute` class of the `System.ComponentModel` namespace. The `DesignerAttribute` comes before the class declaration. Initialize the `DesignerAttribute` by passing the `designerTypeName` and the `designerBaseType` parameters.

`designerTypeName` is the fully qualified name of the designer type that provides design-time services. Pass the combination of the `System.Windows.Forms.Design.ParentControlDesigner` and the `System.Design` for the `designerTypeName` parameter. The `ParentControlDesigner` class extends design-time behavior for a UserControl.

`designerBaseType` is the name of the base class for the designer. The class that is used for the design-time services must implement the IDesigner interface.

## Create the UserControl as a design-time control container

1. Create a new Visual C# Windows Control Library project. To do this, follow these steps:

    1. Start Visual Studio.
    2. On the **File** menu, point to **New**, and then click **Project**.
    3. Under **Project Types**, click **Visual C#**, and then click **Windows Forms Control Library** under **Templates**.

2. Name the project *ContainerUserControl*. By default, *UserControl1.cs* is created.
3. In Solution Explorer, right-click **UserControl1.cs**, and then click **View Code**.
4. Add the following code to the declarations section:

    ```csharp
    using System.ComponentModel.Design;
    ```

5. Apply the `System.ComponentModel.DesignerAttribute` attribute to the control as follows:

    ```csharp
    [Designer("System.Windows.Forms.Design.ParentControlDesigner, System.Design", typeof(IDesigner))]
    public class UserControl1 : System.Windows.Forms.UserControl
    {
        ...
    }
    ```

6. On the **Build** menu, click **Build Solution**.

## Test the UserControl

1. Create a new Visual C# project. To do this, follow these steps:

    1. Start Visual Studio.
    2. On the **File** menu, point to **New**, and then click **Project**.
    3. Under **Project Types**, click **Visual C#**, and then click **Windows Forms Application** under **Templates**. By default, *Form1.cs* is created.

2. Add the **UserControl1** control to the toolbox.

    1. On the **Tools** menu, click **Choose Toolbox Items**.
    2. On the **.NET Framework Components** tab, click **Browse**.
    3. In the **Open File** box, locate the DLL that was built when you created the UserControl control.

3. Drag UserControl1 from the toolbox (under **Windows Forms**) to *Form1.cs*.
4. Drag a Button control from the toolbox to UserControl1.

> [!NOTE]
> The UserControl1 behaves as control container for the Button control.

## References

For more information, see the Microsoft Web site:
[ParentControlDesigner Class](/dotnet/api/system.windows.forms.design.parentcontroldesigner?&view=netframework-4.8&preserve-view=true).
