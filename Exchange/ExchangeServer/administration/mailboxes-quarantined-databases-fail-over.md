---
title: Mailboxes are quarantined and databases fail over
description: Describes an issue in Exchange Server 2013 where mailboxes are quarantined and databases are dismounted unexpectedly. This problem occurs if .NET Framework 4.6 is installed. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: dpaul, cmcgurk, v-six
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Database or Server Failed Over Unexpectedly
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
ms.date: 01/24/2024
---
# Mailboxes are quarantined and databases fail over unexpectedly in Exchange Server 2013

_Original KB number:_ &nbsp; 3095369

## Symptoms

In an Exchange Server 2013 environment, mailboxes are quarantined unexpectedly and the database is dismounted. Or, if the server is a member of a database availability group, it fails over to another member server. Additionally, the following events are written in the Application log:

```console
ID: 1014
Level: Warning
Source: MSExchangeIS
Machine: exchangeserver.contoso.com
Message: The mailbox with mailboxguid "3d488bd9-cfe0-493e-907a-2aa299885f45" has been quarantined. Access to this mailbox will be restricted to administrative logons for 1.00:00:00 since the last report.

ID: 1002
Level: Error
Source: MSExchangeIS
Machine: exchangeserver.contoso.com
Message: Unhandled exception (System.Threading.LockRecursionException: Recursive read lock acquisitions not allowed in this mode.
at System.Threading.ReaderWriterLockSlim.TryEnterReadLockCore(TimeoutTracker timeout)
at System.Threading.ReaderWriterLockSlim.TryEnterReadLock(TimeoutTracker timeout)
at Microsoft.Exchange.Server.Storage.Common.LockManager.NamedLockObject.TryGetLock(LockType lockType, TimeSpan timeout, ILockStatistics lockStats)
at Microsoft.Exchange.Server.Storage.Common.LockManager.GetNamedLockImpl(NamedLockObject lockObject, LockType lockType, TimeSpan timeout, ILockStatistics lockStats)
at Microsoft.Exchange.Server.Storage.StoreCommonServices.Context.StartMailboxComponentReadOperation(LockableMailboxComponent component)
at Microsoft.Exchange.Server.Storage.StoreCommonServices.ReplidGuidMap.GetGuidFromReplid(Context context, UInt16 replid)
at Microsoft.Exchange.Protocols.MAPI.RcaTypeHelpers.StoreIdToExchangeId(StoreId storeId, Mailbox mailbox)
at Microsoft.Exchange.Server.Storage.MapiDisp.RopHandlerBase.OpenFolder(IServerObject serverObject, StoreId folderId, OpenMode openMode, OpenFolderResultFactory resultFactory)
at Microsoft.Exchange.RpcClientAccess.Parser.RopOpenFolder.InternalExecute(IServerObject serverObject, IRopHandler ropHandler, ArraySegment`1 outputBuffer)
at Microsoft.Exchange.RpcClientAccess.Parser.InputOutputRop.Execute(IConnectionInformation connection, IRopDriver ropDriver, ServerObjectHandleTable handleTable, ArraySegment`1 outputBuffer)
at Microsoft.Exchange.RpcClientAccess.Parser.RopDriver.ExecuteRops(List`1 inputArraySegmentList, ServerObjectHandleTable serverObjectHandleTable, ArraySegment`1 outputBuffer, Int32 outputIndex, Int32 maxOutputSize, Boolean isOutputBufferMaxSize, Int32& outputSize, AuxiliaryData auxiliaryData, Boolean isFake, Byte[]& fakeOut)
at Microsoft.Exchange.RpcClientAccess.Parser.RopDriver.Execute(IList`1 inputBufferArray, ArraySegment`1 outputBuffer, Int32& outputSize, AuxiliaryData auxiliaryData, Boolean isFake, Byte[]& fakeOut)
at Microsoft.Exchange.Server.Storage.MapiDisp.MapiRpc.<>c__DisplayClass9.<DoRpc>b__6(MapiContext operationContext, MapiSession& session, Boolean& deregisterSession, AuxiliaryData auxiliaryData)
at Microsoft.Exchange.Server.Storage.MapiDisp.MapiRpc.Execute(IExecutionDiagnostics executionDiagnostics, MapiContext outerContext, String functionName, Boolean isRpc, IntPtr& contextHandle, Boolean tryLockSession, String userDn, IList`1 dataIn, Int32 sizeInMegabytes, ArraySegment`1 auxIn, ArraySegment`1 auxOut, Int32& sizeAuxOut, ExecuteDelegate executeDelegate)
at Microsoft.Exchange.Server.Storage.MapiDisp.MapiRpc.DoRpc(IExecutionDiagnostics executionDiagnostics, IntPtr& contextHandle, IList`1 ropInArraySegments, ArraySegment`1 ropOut, Int32& sizeRopOut, Boolean internalAccessPrivileges, ArraySegment`1 auxIn, ArraySegment`1 auxOut, Int32& sizeAuxOut, Boolean fakeRequest, Byte[]& fakeOut)
at Microsoft.Exchange.Server.Storage.MapiDisp.PoolRpcServer.EcDoRpc(MapiExecutionDiagnostics executionDiagnostics, IntPtr& sessionHandle, UInt32 flags, UInt32 maximumResponseSize, ArraySegment`1 request, ArraySegment`1 auxiliaryIn, IPoolSessionDoRpcCompletion completion)
at Microsoft.Exchange.Server.Storage.MapiDisp.PoolRpcServer.EcPoolSessionDoRpc_Unwrapped(MapiExecutionDiagnostics executionDiagnostics, IntPtr contextHandle, UInt32 sessionHandle, UInt32 flags, UInt32 maximumResponseSize, ArraySegment`1 request, ArraySegment`1 auxiliaryIn, IPoolSessionDoRpcCompletion completion)
at Microsoft.Exchange.Server.Storage.MapiDisp.PoolRpcServer.<>c__DisplayClassf.<EcPoolSessionDoRpc>b__c()
at Microsoft.Exchange.Common.IL.ILUtil.DoTryFilterCatch[T](TryDelegate tryDelegate, GenericFilterDelegate filterDelegate, GenericCatchDelegate catchDelegate, T state)).

ID: 1013
Level: Error
Source: MSExchangeIS
Machine: exchangeserver.contoso.com
Message: The mailbox with mailboxguid "a5ec8237-d1b3-4ffb-9bca-9047258cfd87" caused crash or resource outage on database (GUID="daf144bc-eafb-46dc-a290-d375898a5829")

ID: 126
Level: Error
Source: ExchangeStoreDB
Machine: exchangeserver.contoso.com
Message: At '8/24/2015 8:37:03 PM' the Exchange store database 'DAG2-DB2048' copy on this server encountered an error that caused the database to be dismounted. For more detail about the failure, consult the Event log on the server for other "ExchangeStoreDb" or "msexchangerepl" events. A successful failover restored service.
```

## Cause

This issue occurs if .NET Framework 4.6 is installed on the server. In an Exchange Server 2013 environment, this version of the .NET Framework isn't supported.

## Resolution

To resolve this issue, uninstall the update for .NET Framework 4.6 from the server.

## Determine whether .NET Framework 4.6 is installed

To determine whether you have .NET Framework 4.6 installed on your computer, check for the following:

- In Windows Server 2008 Service Pack 2 (SP2) or Windows Server 2008 R2 SP1, .NET Framework 4.6 is installed as a product under **Programs and Features** in Control Panel.
- In Windows Server 2012, Update for Microsoft Windows (KB3045562) is displayed under **Installed Updates** in Control Panel.
- In Windows Server 2012 R2, Update for Microsoft Windows (KB3045563) is displayed under **Installed Updates** in Control Panel.

You can also use the following PowerShell script to determine whether .NET Framework 4.5, 4.5.1, 4.5.2, or 4.6 is installed:

```powershell
$Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $Server)
$RegKey= $Reg.OpenSubKey("SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full")
[int]$NetVersionKey= $RegKey.GetValue("Release")

if($NetVersionKey -ge 381029)
{
    "4.6 or later"
    return
}
switch ($NetVersionKey)
{
    {($_ -ge 378389) -and ($_ -lt 378675)} {"4.5"}
    {($_ -ge 378675) -and ($_ -lt 379893)} {"4.5.1"}
    {$_ -ge 379893} {"4.5.2"}
    default {"Unable to Determine"}
}
```
