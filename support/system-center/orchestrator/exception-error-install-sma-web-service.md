---
title: Exception error installing SMA Web Service
description: Describes an error occurs when you install the Service Management Automation Web Service feature in System Center Orchestrator.
ms.date: 06/26/2024
ms.reviewer: jfanjoy
---
# Exception has been thrown by the target of an invocation error installing Service Management Automation Web Service

This article helps you fix an issue in which you receive the **Exception has been thrown by the target of an invocation** error message when you install the Service Management Automation Web Service feature in System Center Orchestrator.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2931627

## Symptoms

When you try to run the **Generate Tenant Key** action of installing the Service Management Automation Web Service feature in System Center Orchestrator, an exception of type `System.Reflection.TargetInvocationException` with the **Exception has been thrown by the target of an invocation** error message is returned.

The installation log shows an inner exception of type `System.InvalidOperationException` with the **This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms** error message.

> Calling custom action WebServiceCustomActions!WebServiceCustomActions.CustomActions.GenerateTenantKey  
> WebServiceCustomActions: Generate Tenant Key  
> Exception thrown by custom action:  
> System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.InvalidOperationException: This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms.  
> at System.Security.Cryptography.RijndaelManaged..ctor()  
> --- End of inner exception stack trace ---  
> at System.RuntimeMethodHandle.InvokeMethod(Object target, Object arguments, Signature sig, Boolean constructor)  
> at System.Reflection.RuntimeConstructorInfo.Invoke(BindingFlags invokeAttr, Binder binder, Object parameters, CultureInfo culture)  
> at System.Security.Cryptography.CryptoConfig.CreateFromName(String name, Object args)  
> at System.Security.Cryptography.SymmetricAlgorithm.Create(String algName)  
> at WebServiceCustomActions.CustomActions.GenerateKey(Session session, String connectionString)  
> at WebServiceCustomActions.CustomActions.GenerateTenantKey(Session session)  
> --- End of inner exception stack trace ---  
> at System.RuntimeMethodHandle.InvokeMethod(Object target, Object arguments, Signature sig, Boolean constructor)  
> at System.Reflection.RuntimeMethodInfo.UnsafeInvokeInternal(Object obj, Object parameters, Object arguments)  
> at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object parameters, CultureInfo culture)  
> at Microsoft.Deployment.WindowsInstaller.CustomActionProxy.InvokeCustomAction(Int32 sessionHandle, String entryPoint, IntPtr remotingDelegatePtr)  
> CustomAction GenerateTenantKey returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)  

## Cause

This issue occurs because the encryption algorithm that's used by Service Management Automation in Orchestrator isn't Federal Information Processing Standards (FIPS) compliant. However, the Windows security option **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing** is enabled in Group Policy and requires the usage of FIPS compliant encryption algorithms.

## Resolution

To resolve the issue, disable the Windows security option **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing**, and then restart the installation.

## More information

For more information about the Windows security option **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing**, see [System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing](/previous-versions/windows/it-pro/windows-server-2003/cc780081(v=ws.10)?redirectedfrom=MSDN).
