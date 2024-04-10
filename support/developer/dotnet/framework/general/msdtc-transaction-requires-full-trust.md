---
title: MSDTC transaction requires Full Trust
description: This article describes a behavior in which an MSDTC transaction requires Full Trust and can't run in a sandboxed solution.
ms.date: 05/11/2020
ms.reviewer: jcarley; amymcel
---
# MSDTC transaction requires Full Trust and can't run in a sandboxed solution

This article helps you resolve the problem where a Microsoft Distributed Transaction Coordinator (MSDTC) transaction requires Full Trust and can't run in a sandboxed solution.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 2998281

## Symptoms

Assume that you're running an application in sandbox mode (or simply running an application without .NET Full Trust). When you try operations within `System.Transactions` that require access to a distributed transaction coordinator (typically MSDTC), you meet the following exception:

> System.Security.SecurityException: Request failed.

The server stack trace is as follows:

> at System.ServiceModel.Transactions.OleTxTransactionFormatter.WriteTransaction(Transaction transaction, Message message)  
> at System.ServiceModel.Channels.TransactionChannel`1.WriteTransactionToMessage(Message message, TransactionFlowOption txFlowOption)  
> at System.ServiceModel.Channels.TransactionChannel`1.WriteTransactionDataToMessage(Message message, MessageDirection direction)  
> at System.ServiceModel.Channels.TransactionDuplexChannelGeneric`1.Send(Message message, TimeSpan timeout)  
> at System.ServiceModel.Dispatcher.DuplexChannelBinder.Request(Message message, TimeSpan timeout)  
> at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs, TimeSpan timeout)  
> at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs)  
> at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall, ProxyOperationRuntime operation)
at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message)

## Cause

This behavior is by design. Certain operations within `System.Transactions` require Full Trust because they require access to privileged services. Without Full Trust, these operations can't be run. The following operations currently require it:

- All of the methods on the `TransactionInterop` class
- All variations of the `Transaction.EnlistDurable` method
- `Transaction.EnlistPromotableSinglePhase`
- `Transaction.PromoteAndEnlistDurable`
- Access to the `TransactionManager.DistributedTransactionStarted` event
- Access to the `TransactionManager.HostCurrentCallback` property
- Usage of `TransactionManager.Reenlist` and `TransactionManager.RecoveryComplete`
- Usage of the `TransactionScope` class when an `EnterpriseServicesInteropOption` is specified

## Workaround

To work around this behavior, run the application with Full Trust, or create a Global Assembly Cache (GAC) assembly proxy that accepts partially trusted callers, and then call this assembly from the sandboxed application.

## References

[AllowPartiallyTrustedCallersAttribute Class](/dotnet/api/system.security.allowpartiallytrustedcallersattribute)
