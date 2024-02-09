---
title: Can't validate or run a workflow in WCF
description: This article provides resolutions for the problem where you cannot validate or run a workflow in Windows Workflow Foundation that was created by using System.Activities.ActivityBuilder if it contains Visual Basic expressions.
ms.date: 12/11/2020
---
# You cannot validate or run a workflow in Windows Workflow Foundation that was created by using System.Activities.ActivityBuilder if it contains Visual Basic expressions

This article helps you resolve the problem where you cannot validate or run a workflow in Windows Workflow Foundation (WCF) that was created by using `System.Activities.ActivityBuilder` if it contains Visual Basic expressions.

_Original product version:_ &nbsp; Windows Workflow Foundation  
_Original KB number:_ &nbsp; 2018455

## Symptoms

When you validate or execute a workflow that was created by using `System.Activities.ActivityBuilder` in a Microsoft WCF application, the following exception is thrown:

> Unhandled Exception: System.Activities.InvalidWorkflowException: The following errors were encountered while processing
the workflow tree:  
'DynamicActivity': The private implementation of activity '1: DynamicActivity' has the following validation error:   Compiler error(s) encountered processing expression "variable1.Name".  
'variable1' is not declared. It may be inaccessible due to its protection level.

## Cause

This issue occurs because `System.Activities.ActivityBuilder` does not include `VisualBasic.Settings` attribute on the root element of the XAML file when you save a workflow, as shown in the following example:

```xaml
 <Activity x:Class="CustomActivity" xmlns="http://schemas.microsoft.com/netfx/2009/xaml/activities" xmlns:w="clr-namespace:WorkflowConsoleApplication1;assembly=WorkflowConsoleApplication1" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">  
     <Sequence>  
         <Sequence.Variables>  
         <Variable x:TypeArguments="w:MyCustomType" Name="variable1" />  
         </Sequence.Variables>  
         <WriteLine Text="[variable1.Name]" />  
     </Sequence>  
 </Activity> 
```

This attribute is required for Visual Basic expressions to resolve the types that are used in the expression to the corresponding assemblies.

## Resolution

To resolve this issue, manually add the following two attributes to the root element of the XAML file.

```xaml
 xmlns:mva="clr-namespace:Microsoft.VisualBasic.Activities;assembly=System.Activities"  
 mva:VisualBasic.Settings="Assembly references and imported namespaces for internal implementation"
```

After you add these two attributes, the workflow that is shown in the "Symptoms" section appears as follows:

```xaml
 <Activity x:Class="CustomActivity" xmlns="http://schemas.microsoft.com/netfx/2009/xaml/activities" xmlns:w="clr-namespace:WorkflowConsoleApplication1;assembly=WorkflowConsoleApplication1" xmlns:x=http://schemas.microsoft.com/winfx/2006/xaml xmlns:mva="clr-namespace:Microsoft.VisualBasic.Activities;assembly=System.Activities" mva:VisualBasic.Settings="Assembly references and imported namespaces for internal implementation">
    <Sequence>
        <Sequence.Variables>
            <Variable x:TypeArguments="w:MyCustomType" Name="variable1" />
        </Sequence.Variables>
        <WriteLine Text="[variable1.Name]" />
    </Sequence>
</Activity>
```

Additionally, you can also create a programmatic workaround. To do this, add the following code after you set `builder.Implementation`, as shown in the following sample code:

```vbnet
VisualBasic.SetSettingsForImplementation(builder, new VisualBasicSettings()
{
    ImportReferences =
    {
        new VisualBasicImportReference
        {
           Assembly = "ConsoleApplication1",
           Import = "ConsoleApplication1",
        },
    }
});
```
