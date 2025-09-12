---
title: Error 0x6f7 when adding a server to a DAG in Exchange Server
description: Fixes Error 0x6f7 that occurs when you add the first or an additional server to a database availability group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need Help Configuring DAG
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: mnanjund, benwinz, v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
ms.date: 01/24/2024
---
# Operation failed with message: Error 0x6f7 when adding a server to a database availability group in Exchange Server

_Original KB number:_ &nbsp;2032601

## Summary

When you add the first or an additional server to a database availability group (DAG), the error message occurs:

> A Server Side database availability group Administrative Operation failed.  
> Error the Operation failed with message: Error 0x6f7 (The Stub Received Bad Data)

## Cause

Cluster creating process checks all the valid IP addresses on network process and errors occur when invalid entry is found on the network card.

*A search for IP Addresses : __in string IPAddresses[], : IP addresses of the cluster.*

If network cards are found without default gateways on the node, the following error is logged in DAG Task logs:

> Connecting to server 'Server.Contoso.com' via WMI...  
> [Fetching the network adapters and ignoring the ones without default gateways.  
> Server.contoso.com has an address: 192.168.10.2/24 default gateway(s)=====\<none> [invalid] ---Private network  
> Server.Contoso.com has an address: 10.0.1.15/24 default gateway(s)=======\<none> [invalid] ---Public network

## Resolution

Configure one NIC in the cluster with a default gateway. Then configure static routes on the remaining NICs to help communication.

> [!NOTE]
> You should *not* have more than one default gateway on the *server* as per the following:  
> [Plan for high availability and site resilience](/Exchange/high-availability/plan-ha)

## More information

Following error is logged in the DAG Tasks Log:

```console
The operation wasn't successful because an error was encountered. You may find more details in log file "C:\ExchangeSetupLogs\DagTasks\dagtask_<Exchange Server>_add-databaseavailabiltygroupserver.log".
 WriteError! Exception = Microsoft.Exchange.Cluster.Replay.DagTaskOperationFailedException: A server-side database availability group administrative operation failed. Error: The operation failed with message: Error 0x6f7 (The stub received bad data) from cli_RpccCreateCluster ---> Microsoft.Exchange.Rpc.RpcException: Error 0x6f7 (The stub received bad data) from cli_RpccCreateCluster
   at ThrowRpcException(Int32 rpcStatus, String message)
   at Microsoft.Exchange.Rpc.RpcClientBase.ThrowRpcException(Int32 rpcStatus, String routineName)
   at Microsoft.Exchange.Rpc.Cluster.ReplayRpcClient.RpccCreateCluster(String clusterName, String firstNodeName, String[] ipAddresses, UInt32[] rgNetMasks, String& verboseLog)
   at Microsoft.Exchange.Cluster.Replay.ReplayRpcClientWrapper.<>c__DisplayClass1e.<RunCreateCluster>b__1c()
   at Microsoft.Exchange.Cluster.Replay.ReplayRpcClientWrapper.<>c__DisplayClass32.<RunRpcOperationDbName>b__30()
   at Microsoft.Exchange.Data.Storage.Cluster.HaRpcExceptionWrapperBase`2.ClientRetryableOperation(String serverName, RpcClientOperation rpcOperation)
--- End of inner exception stack trace ---
```
