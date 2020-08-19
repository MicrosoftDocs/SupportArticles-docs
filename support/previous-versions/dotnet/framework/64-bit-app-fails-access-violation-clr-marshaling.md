---
title: 64-bit applications fail with access violation
description: This article describes a problem that a 64-bit managed application fails with an access violation during CLR marshaling.
ms.date: 06/17/2020
ms.prod-support-area-path: 
ms.reviewer: gaurap
---
# PRB: 64-bit managed application fails with an access violation during CLR marshaling

This article helps you resolve a problem that a 64-bit managed application fails with an access violation during common language runtime (CLR) marshaling.

_Original product version:_ &nbsp; .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2615130

## Symptoms

You have a .NET managed application running as a 64-bit process on 64-bit Microsoft Windows XP Service Pack (SP) 3 or 64-bit Windows Server 2003 SP2. The application may crash with an access violation during CLR marshaling. The stack traces and failing function resemble the following information:

> 0:000> knL  
> \# Child-SP RetAddr Call Site  
> 00 00000000`0042c900 00000642`74ee8998  System_ni!DomainNeutralILStubClass.IL_STUB(System.Guid ByRef, IntPtr, Int32, IntPtr, Int32, IntPtr ByRef)+0xff  
> 01 00000000`0042ca40 00000642`74ee8c30 System_ni!System.Runtime.InteropServices.StandardOleMarshalObject.GetStdMarshaller(System.Guid ByRef, Int32, Int32)+0xe8  
> 02 00000000`0042caf0 00000642`7f602322  
> System_ni!System.Runtime.InteropServices.StandardOleMarshalObject.Microsoft.Win32.UnsafeNativeMethods.IMarshal.MarshalInterface(System.Object, System.Guid ByRef, IntPtr, Int32, IntPtr, Int32)+0x6
>
> ...[Snip]

## Cause

It's a known bug in 64-bit CLR marshaling where it tries to write to a readonly location causing an Access Violation.

## Resolution

To resolve this problem, contact Microsoft Customer Support Services to obtain the hotfix. For a complete list of Microsoft Customer Support Services telephone numbers and information about support costs, visit [Microsoft Support](https://support.microsoft.com/contactus/?ws=support).
