---
title: Empty VM list in WAP tenant portal
description: Discusses that you see an empty VM list in Windows Azure Pack tenant portal even though VMs are available and displayed in System Center Virtual Machine Manager. Provides a resolution.
ms.date: 04/29/2020
---
# Empty VM list in WAP tenant portal although VMs are listed in VMM

This article fixes an issue in which you see an empty virtual machine list in Windows Azure Pack tenant portal.

_Original product version:_ &nbsp; System Center 2016 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 4033452

## Symptoms

When a tenant logs into the Windows Azure Pack (WAP) tenant portal and navigates to **Virtual Machines**, no virtual machines (VMs) appear in the list. This issue occurs even though VMs are available in the cloud and the VM list appears as expected in System Center Virtual Machine Manager (SCVMM).

This issue occurs when the following conditions are true:

- At least one of the VMs in the affected cloud is located on a VMWare host.
- At least one of the VMWare VMs has a snapshot.

When this issue occurs, you see the following error:

- The following events are logged in the `Microsoft-WindowsAzurePack-MgmtSvc-TenantSite` operational event log:

  > Log Name:      Microsoft-WindowsAzurePack-MgmtSvc-TenantSite/Operational  
  > Source:        Microsoft-WindowsAzurePack-MgmtSvc-TenantSite  
  > Date:          DATE  
  > Event ID:      221  
  > Task Category: (2)  
  > Level:         Error  
  > Keywords:      None  
  > User:          IIS APPPOOL\USER  
  > Computer:      COMPUTER  
  > Description:  
  > Failed to load list of Virtual Machines for SubscriptionId: '\<SUBSCRIPTION GUID>', Exception: 'DataServiceClientException: Error processing response stream. Server failed with following message:  
  > Unable to construct the property LastRestoredCheckpointId from the object returned from the cmdlet. Cause: Unable to convert from .NET Framework type System.String, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089 to type System.Nullable\`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089.  
  > \<Exception>  
  > \<Type>DataServiceClientException\</Type>  
  > \<Message>Error processing response stream. Server failed with following message: Unable to construct the property LastRestoredCheckpointId from the object returned from the cmdlet. Cause: Unable to convert from .NET Framework type System.String, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089 to type System.Nullable\`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089.\</Message>  
  > \<StackTrace>\<![CDATA[  
  > at System.Data.Services.Client.Materialization.ODataReaderEntityMaterializer.ODataFeedOrEntryReader.TryRead()  
  > at System.Data.Services.Client.Materialization.ODataReaderEntityMaterializer.ODataFeedOrEntryReader.TryStartReadFeedOrEntry()  
  > at System.Data.Services.Client.Materialization.ODataReaderEntityMaterializer.ODataFeedOrEntryReader.TryReadEntry(MaterializerEntry& entry)  
  > at System.Data.Services.Client.Materialization.ODataReaderEntityMaterializer.ODataFeedOrEntryReader.\<LazyReadEntries>d__0.MoveNext()  
  > at System.Data.Services.Client.Materialization.ODataReaderEntityMaterializer.ODataFeedOrEntryReader.Read()  
  > at System.Data.Services.Client.Materialization.ODataEntityMaterializer.ReadImplementation()  
  > at System.Data.Services.Client.MaterializeAtom.MoveNextInternal()  
  > at System.Data.Services.Client.MaterializeAtom.MoveNext()  
  > at System.Linq.Enumerable.\<CastIterator>d__94\`1.MoveNext()  
  > at System.Linq.Enumerable.WhereSelectEnumerableIterator\`2.MoveNext()  
  > at System.Collections.Generic.List\`1..ctor(IEnumerable\`1 collection)  
  > at System.Linq.Enumerable.ToList[TSource](IEnumerable\`1 source)  
  > at System.Threading.Tasks.TaskHelpersExtensions.<>c__DisplayClass2f\`2.\<Then>b__2e(Task\`1 t)  
  > at System.Threading.Tasks.TaskHelpersExtensions.<>c__DisplayClass35\`2.\<ThenImpl>b__34(Task innerTask)  
  > --- End of stack trace from previous location where exception was thrown ---  
  > at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)  
  > at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)  
  > at Microsoft.WindowsAzure.Server.VM.TenantExtension.Controllers.VMController.<>c__DisplayClass154.\<\<ListVMsInternalAsync>b__14d>d__159.MoveNext()]]>\</StackTrace>  
  > \<InnerException>  
  > \<Type>ODataErrorException\</Type>  
  > \<Message>An error was read from the payload. See the 'Error' property for more details.\</Message>  
  > \<StackTrace>\<![CDATA[  
  > at Microsoft.Data.OData.Atom.BufferingXmlReader.ReadNextAndCheckForInStreamError()  
  > at Microsoft.Data.OData.Atom.BufferingXmlReader.ReadInternal(Boolean ignoreInStreamErrors)  
  > at Microsoft.Data.OData.Atom.BufferingXmlReader.Read()  
  > at Microsoft.Data.OData.Atom.ODataAtomReader.ReadAtEntryEndImplementation()  
  > at Microsoft.Data.OData.ODataReaderCore.ReadImplementation()  
  > at Microsoft.Data.OData.ODataReaderCore.InterceptException[T](Func\`1 action)  
  > at System.Data.Services.Client.Materialization.ODataReaderEntityMaterializer.ODataFeedOrEntryReader.TryRead()]]>\</StackTrace>  
  > \</InnerException>

## Cause

This issue is caused by a bug that is not scheduled to be fixed.

The VMWare VM has an associated snapshot (called a *checkpoint* in Hyper-V), and Virtual Machine Manager stores its ID in the `VirtualMachineDB` database together with extra information. This extra information is appended to the GUID that is stored in the `LastRestoredCheckpointID` column in the `tbl_WLC_VmInstance` table.

To check whether you have an affected VM, run the following query:

```sql
select LastRestoredCheckpointID FROM tbl_wlc_vminstance where LEN(LastRestoredCheckpointID) > 36
```

The result is shown in the following format:

> GUID*snapshot-401

For example, the result is shown as:

> 94EC7414-5BC5-5ABE-D1FB-66F4EBB7ECAD*snapshot-401

## Resolution

To resolve this issue, remove the extra string from the `LastRestoredCheckpointID` value of the affected VMs. To do this, run the following query to remove the extra string from all `LastRestoredCheckpointIDs` instances:

```sql
update tbl_wlc_vminstance set lastrestoredcheckpointid = SUBSTRING(lastrestoredcheckpointid,1,36) where len(LastRestoredCheckpointID) > 36
```

Alternatively, you can update the string for a single VM by running the following query:

```sql
update tbl_wlc_vminstance set lastrestoredcheckpointid = SUBSTRING(lastrestoredcheckpointid,1,36) where len(LastRestoredCheckpointID) > 35 AND ComputerName = '<COMPUTERNAME>'
```

> [!NOTE]
> In this query, \<*COMPUTERNAME*> represents the actual name of the VM that you're trying to change.

Running these queries fixes the issue temporarily. However, the bad values will be re-created by SCVMM. To prevent this from occurring without manual intervention, you can add the following trigger to the `tbl_wlc_vminstance` table so that it automatically removes the offending data each time a row is inserted or updated.

> [!IMPORTANT]
> You have to run the first query to wipe all bad values from the database first because this trigger affects only newly inserted or updated rows in the database.

```sql
CREATE TRIGGER dbo.tr_Remove_Broken_LastRestoredCheckpointID
   ON  dbo.tbl_wlc_vminstance
   AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    update tbl_WLC_VmInstance set LastRestoredCheckpointID =
SUBSTRING(LastRestoredCheckpointID,1,36) where len(LastRestoredCheckpointID) > 36
    and VMInstanceId in (select VMInstanceId from inserted)
END
GO
```

## More Information

For more information about VMWare VMs in VM clouds, see the following article:

[Requirements for using VM Clouds](/previous-versions/azure/windows-server-azure-pack/dn457804(v=technet.10)?redirectedfrom=MSDN)

For more information about third-party extensions for Windows Azure Pack, see the following website:

- [VConnect for Windows Azure Pack](http://www.cloudassert.com/Solutions/VConnect)

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
