---
title: Build error MC6017 when you define a class
description: This article provides resolutions to solve the build error MC6017 when you try to define a class that derives from a XAML-generated class.
ms.date: 05/06/2020
ms.reviewer: shimada, davean
---
# Build error MC6017 when you define a class that derives from a XAML-generated class

This article helps you resolve the problem where the build error MC6017 occurs when you define a class that derives from an Extensible Application Markup Language (XAML) generated class.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 957231

## Symptoms

You have a Windows Presentation Foundation (WPF) application. You have a class such as a `UserControl` defined by using XAML. You derive a class from the `UserControl`. For example:

- Base class:

    ```xaml
    <UserControl x:Class="WpfControlLibrary1.UserControlInXaml"
        xmlns="https://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="https://schemas.microsoft.com/winfx/2006/xaml"
        Height="300" Width="300">
        <Grid>
            <StackPanel>
                <Button>Test</Button>
            </StackPanel>
        </Grid>
    </UserControl>
    ```

- Deriving class:

    ```xaml
    <y:UserControlInXaml x:Class="WpfApplication1.UserControlFromXaml"
        xmlns="https://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="https://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:y="clr-namespace:WpfControlLibrary1;assembly=WpfControlLibrary1"
        Height="300" Width="300">
        <Grid>
            <CheckBox Height="16" Margin="8,30,0,0" Name="checkBox1"
            VerticalAlignment="Top" HorizontalAlignment="Left" Width="120">CheckBox</CheckBox>
        </Grid>
    </y:UserControlInXaml>
    ```

In this situation, you will receive the following error message:

> xyz cannot be the root of a XAML file because it was defined using XAML error.

## Cause

Currently deriving a XAML-generated class from another XAML-generated class isn't supported.

## Resolution

Define your base class all in code without using XAML.

Your derived class isn't instantiated in the designer when you are designing it, which means that any calls made to your base class from the constructor aren't called. Furthermore, if you try to initialize your base class's content in its constructor, you will find that `Content` member is still set to null.

This results in that your base class's content does not show up in the designer when you are designing your deriving class, even though it does at runtime.

One way to work around is to add code similar to the one below in your base class:

```csharp
public class UserControlInCode : UserControl
{
    protected override void OnContentChanged (object oldContent, object newContent)
    {
        base.OnContentChanged (oldContent, newContent);
        StackPanel panel = new StackPanel ();
        Button button = new Button ();
        button.Content = "Test";
        panel.Children.Add (button);
        ((IAddChild) newContent).AddChild (panel);
    }
}
```

This way, you wait until your base class sets `Content` member.
