---
title: StackOverflowException in DataGridView
description: This article discusses that you receive a StackOverflowException error in the DataGridView control on a Tablet PC. Provides a resolution.
ms.date: 05/12/2020
ms.reviewer: tanyaso, davean, amymcel, danru, valerieg, daleche
---
# StackOverflowException in DataGridView control on Tablet PC

This article helps you avoid the stack overflow exception when you access a DataGridView control on Tablet PC.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 3046509

## Symptoms

When a user first accesses a `System.Windows.Forms.DataGridView` control that has many rows on a Tablet PC, the control crashes and generates a stack overflow exception.

This problem occurs if the first user action is to access the last row or another row near the bottom of the control after the application starts. For example, after the application starts and the form that has the
Windows Forms DataGridView control is displayed, the user scrolls to the last row of the control and selects that row.

If the first user action is to access rows that aren't far from the top of the Windows Forms DataGridView control, the stack overflow doesn't occur.

The following is an example call stack that is generated after a crash:

> System.Windows.Forms.dll!System.Windows.Forms.DataGridViewRow.DataGridViewRowAccessibleObject.Bounds.get()  
> \<repeat>  
> System.Windows.Forms.dll!System.Windows.Forms.DataGridViewRow.DataGridViewRowAccessibleObject.Bounds.get()  
> System.Windows.Forms.dll!System.Windows.Forms.DataGridViewRow.DataGridViewRowAccessibleObject.Bounds.get()  
> System.Windows.Forms.dll!System.Windows.Forms.DataGridViewCell.DataGridViewCellAccessibleObject.GetAccessibleObjectBounds(System.Windows.Forms.AccessibleObject parentAccObject)  
> System.Windows.Forms.dll!System.Windows.Forms.DataGridViewCell.DataGridViewCellAccessibleObject.Bounds.get()  
> System.Windows.Forms.dll!System.Windows.Forms.AccessibleObject.Accessibility.IAccessible.accLocation(int pxLeft, int pyTop, int pcxWidth, int pcyHeight, object childID)  
> System.Windows.Forms.dll!System.Windows.Forms.InternalAccessibleObject.System.Windows.Forms.UnsafeNativeMethods.IAccessibleInternal.accLocation(int l, int t, int w, int h, object childID)  
> [Native to Managed Transition]  
> oleacc.dll!AccWrap_LocationEtcFix::accLocation(long *,long *,long *,long *,struct tagVARIANT)  
> tiptsf.dll!CARET::UpdateMSAAEditFieldState()  
> tiptsf.dll!CARET::UpdateEditFieldState(struct HWND__ *,unsigned int,unsigned int)  
> tiptsf.dll!CARET::_ProcessCaretEvents()  
> tiptsf.dll!CARET::ProcessCaretEvents()  
> user32.dll!___ClientCallWinEventProc@4-()  
> ntdll.dll!_KiUserCallbackDispatcher@12-()

## Cause

When a user accesses the Windows Forms DataGridView control the first time, the Tablet PC input panel component queries the bounds of the `AccessibleObject` class that corresponds to the first child of the Windows Forms DataGridView control. Typically, the first child is the topmost row of the control. However, if the user scrolls down to the bottom of the control, the topmost row is no longer visible.

In this situation, the Windows Forms DataGridView control tries to return the first visible row. In order to find the first visible row, the control's `AccessibleObject` class recursively enumerates all rows until it reaches the visible row. Depending on the resources that are available to the process, the program can crash while it searches for the next row.

## Resolution

To avoid the stack overflow exception, developers can initialize the `AccessibleObject` class as soon as the Windows Forms DataGridView control is populated. For example, you can use the following code to set the focus for the control:

```csharp
dataGridView1.Focus();
```  

When you run this command, the following sequence of events occurs:

- The Tablet PC input panel component is initialized.
- The Tablet PC input panel component tracks all actions that are associated with the control.
- The Tablet PC input panel component queries the bounds of the selected row instead of the first visible row.

## More information

This is an implementation flow in the Windows Forms DataGridView control's Microsoft Active Accessibility support.
