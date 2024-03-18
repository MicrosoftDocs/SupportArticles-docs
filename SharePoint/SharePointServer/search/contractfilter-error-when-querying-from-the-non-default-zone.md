---
title: ContractFilter error when querying from the non-Default zone in a SharePoint Server 2013 or 2016 farm
description: Fixes an issue in which you receive a ContractFilter error when you run a query from the non-Default zone in a SharePoint Server 2013 or 2016 farm.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2016
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# ContractFilter error when querying from the non-default zone in a farm  

## Symptoms  

In a SharePoint Server 2013 or 2016 farm, you receive the following ContractFilter error after you run a query from the non-Default zone:   

```  
An unknown error occurred. ---> System.ServiceModel.ActionNotSupportedException: The message with Action 'http://tempuri.org/ISearchQueryServiceApplication/IsUrlMappingCached' cannot be processed at the receiver, due to a ContractFilter mismatch    

at the EndpointDispatcher. This may be because of either a contract mismatch (mismatched Actions between sender and receiver) or a binding/security mismatch between the sender and the receiver. Check that sender and receiver have the same contract and the same binding (including security requirements, e.g. Message, Transport, None). Server stack trace:  

at System.ServiceModel.Channels.ServiceChannel.ThrowIfFaultUnderstood(Message reply, MessageFault fault, String action, MessageVersion version, FaultConverter faultConverter)  

at System.ServiceModel.Channels.ServiceChannel.HandleReply(ProxyOperationRuntime operation, ProxyRpc& rpc)  

at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs, TimeSpan timeout)  

at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall, ProxyOperationRuntime operation)  

at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message) Exception rethrown  

at [0]:  
```  

This issue usually occurs when a published Search service application (SSA) is consumed by another farm (for example, the application is published by Farm A but consumed by Farm B).   

## Cause  

The servers have incompatible builds. The IsURLMappingCached that's used to convert the URL of your search results is altered between builds. You experience the ContractFilter error if the origin of the query and the search proxy are on two servers that have different URLMapper logic.   

## Resolution  

To fix this issue, make sure that both farms and all servers in the farms have the same build. Make sure that all servers have the same cumulative update installed and that the Psconfig command-line tool can be run successfully.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
