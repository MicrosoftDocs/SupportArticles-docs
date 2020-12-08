---
title: 
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: zhchia, squin, kaushika
---
# "MMC has detected an error in a snap-in and will unload it" error message when you try to launch VAMT 3.0 on a Windows 7 or Windows Server 2008 R2-based computer

_Original product version:_ &nbsp; Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Datacenter, Windows 7 Enterprise, Windows 7 Professional, Windows 7 Ultimate  
_Original KB number:_ &nbsp; 2817142

## Symptoms

On a computer that is running Windows 7 or Windows Server 2008 R2, when you try to launch the Volume Activation Management Tool (VAMT) 3.0, it may fail. Additionally you may receive the following error message:

MMC has detected an error in a snap-in and will unload it

You are then prompted with two options:
1. Report this error to Microsoft, and then shut down MMC.
2. Unload the snap-in and continue running.
If the second option is selected, you may get an error message that is similar to the following:

Unhandled Exception in Managed Code Snap-in
FX:{6FBE5D92-C65A-41DC-AEBF-09D8845F68A1}
Exception has been thrown by the target of an invocation

Exception type: 

System.Reflection.TargetInvocationException

Exception stack trace: 

at System.RuntimeTypeHandle.CreateInstance(RuntimeType type, Boolean publicOnly, Boolean noCheck, Boolean& canBeCached, RuntimeMethodHandle& ctor, Boolean& bNeedSecurityCheck)
at System.RuntimeType.CreateInstanceSlow(Boolean publicOnly, Boolean fillCache)
at System.RuntimeType.CreateInstanceImpl(Boolean publicOnly, Boolean skipVisibilityChecks, Boolean fillCache)
at System.Activator.CreateInstance(Type type, Boolean nonPublic)
at System.RuntimeType.CreateInstanceImpl(BindingFlags bindingAttr, Binder binder, Object[] args, CultureInfo culture, Object[] activationAttributes)
at System.Activator.CreateInstance(Type type, BindingFlags bindingAttr, Binder binder, Object[] args, CultureInfo culture, Object[] activationAttributes)
at System.Activator.CreateInstance(String assemblyName, String typeName, Boolean ignoreCase, BindingFlags bindingAttr, Binder binder, Object[] args, CultureInfo culture, Object[] activationAttributes, Evidence securityInfo, StackCrawlMark& stackMark)
at System.Activator.CreateInstance(String assemblyName, String typeName)
at System.AppDomain.CreateInstance(String assemblyName, String typeName)
at System.AppDomain.CreateInstanceAndUnwrap(String assemblyName, String typeName)
at Microsoft.ManagementConsole.Internal.SnapInClient.CreateSnapIn(String assemblyName, String typeName)
at Microsoft.ManagementConsole.Internal.ClassLibraryServices.Microsoft.ManagementConsole.Internal.IClassLibraryServices.CreateSnapIn(String assemblyName, String typeName)
at Microsoft.ManagementConsole.Internal.IClassLibraryServices.CreateSnapIn(String assemblyName, String typeName)
at Microsoft.ManagementConsole.Executive.SnapInApplication.CreateSnapIn(String snapInAqn)
at Microsoft.ManagementConsole.Executive.SnapInInitializationOperation.CreateSnapIn()
at Microsoft.ManagementConsole.Executive.Operation.OnThreadTransfer(SimpleOperationCallback callback)

## Cause

This problem may occur if you do not have the .NET Framework 3.5.1 feature installed on Windows 7 or Windows Server 2008 R2.

## Resolution

To resolve this problem, you need to install .NET Framework 3.5.1 using the following steps:

On a Windows 7-based computer 
1. Click on Start button and then click Control Panel 
2. Select Programs 
3. Under Programs and Features, select Turn Windows features on or off 
4. Select the check box next to the Microsoft .NET Framework 3.5.1.
5. Click on OK. 
 On a Windows Server 2008 R2-based computer 
1. Open Server Manager .
2. Right click Features and select Add Features 
3. Expand .Net Framework 3.5.1 Features 
4. Select the check box next to the .NET Framework 3.5.1
5. Click on Install. 

## More Information

For more information on Volume Activation Management Tool, click on the following links:

- [Install and Configure VAMT 3.0](https://technet.microsoft.com/library/hh825211.aspx) 
- [VAMT 3.0 Requirements](https://technet.microsoft.com/library/hh824945.aspx) 
- [Installing VAMT 3.0](https://technet.microsoft.com/library/hh825184.aspx) 
- [Configure Client Computers](https://technet.microsoft.com/library/hh825136.aspx) 
