---
title: ASR Agent or non-component VSS Backup fails
description: This article provides a workaround for the problem in which a non-component VSS Backup, such as ASR Agent, fails for a server that is hosting SQL Server 2008 R2.
ms.date: 09/02/2020
ms.custom: sap:Administration and Management
ms.reviewer: gfourrat
---
# ASR Agent or other non-component VSS Backup fails for a server hosting SQL Server 2008 R2

This article helps you work around the problem in which a non-component VSS Backup, such as ASR Agent, fails for a server that is hosting SQL Server 2008 R2.

_Original product version:_ &nbsp; SQL Server 2008, SQL Server 2008 R2  
_Original KB number:_ &nbsp; 4504103

## Symptoms

Consider the following scenario:

- You are using Microsoft SQL Server 2008 or SQL Server 2008 R2.
- You start a non-component VSS Backup of a volume that is hosting SQL Server files. For example, you use Microsoft Azure Site Recovery Agent.

In this situation, you notice that the VSS Backup fails because of a SQLServerWriter error even though the SQL Server error log reports a successful Backup.

SQLServerWriter reports the following result in the 'vssadmin list writers' output:

> Writer name: 'SqlServerWriter'  
Writer Id: {ID}  
Writer Instance Id: {ID}  
State: [11] Failed  
Last error: Non-retryable error

> [!NOTE]
> The previous state or error is very generic. Therefore, it doesn't provide enough information to let you selectively identify a given scenario. This situation is significant in the context of non-component backups on SQL Server 2008 or R2.

Additionally, a SQLServerWriter trace reports the following:

> [-,0x00c390:0xbb80:0x0eba42eb] sqlwriter.yukon\sqllib\FileName(LineNumber): FrozenDatabase::GetNextPartialInfo: VDI::GetCommand failed with error 0x8077000e  
>
> [-,0x00c390:0xbb80:0x0eba42eb] EXIT  {DatabaseName::GetNextPartialInfo}: hr: 0x8077000e
>
> [-,0x00c390:0xbb80:0x0eba42eb] sqlwriter.yukon\sqlwriter\FileName(LineNumber): CSqlWriter::PickupDifferentialInfo: Database master of server instance CGLONCSQL01 failed to enumerate file information.  hr = 0x8077000e
>
>[-,0x00c390:0xbb80:0x0eba42eb] sqlwriter.yukon\sqlwriter\FileName(LineNumber): CSqlWriter::PickupDifferentialInfo: Throwing HRESULT code 0x8077000e. Previous HRESULT code = 0x8077000e
>
>[-,0x00c390:0xbb80:0x0eba42eb] sqlwriter.yukon\sqlwriter\FileName(LineNumber): CSqlWriter::PickupDifferentialInfo: HRESULT EXCEPTION CAUGHT: hr: 0x8077000e
>
>[-,0x00c390:0xbb80:0x0eba42eb] EXIT  {CSqlWriter::PickupDifferentialInfo}: hr: 0x8077000e
>
>[-,0x00c390:0xbb80:0x0eba42eb] sqlwriter.yukon\sqlwriter\FileName(LineNumber): STDMETHODCALLTYPE CSqlWriter::OnPostSnapshot: Failed to pick up file information from database servers . hr = 0x8077000e
>
>[-,0x00c390:0xbb80:0x0eba42eb] sqlwriter.yukon\sqlwriter\FileName(LineNumber): STDMETHODCALLTYPE CSqlWriter::OnPostSnapshot: Throwing HRESULT code 0x8077000e. Previous HRESULT code = 0x8077000e
>
>[-,0x00c390:0xbb80:0x0eba42eb] sqlwriter.yukon\sqlwriter\FileName(LineNumber): STDMETHODCALLTYPE CSqlWriter::OnPostSnapshot: HRESULT EXCEPTION CAUGHT: hr: 0x8077000e
>
>[-,0x00c390:0xbb80:0x0eba42eb] ENTER {Snapshot::~Snapshot}:

## Workaround

There is no fix for SQL Server 2008 or SQL Server 2008 R2.
This issue was fixed in the initial release (RTM) of SQL Server 2012. Because SQLServerWriter is a shared component, upgrading the shared components with a later major version of SQL Server replaces SQL Server 2008 or SQL Server 2008 R2 SQLServerWriter with a newer version that contains the fix.

In cases in which SQL Server 2008 or SQL Server 2008 R2 is experiencing this issue, we suggest that you install a free edition of a recent SQL Server version, such as SQL Server Express Edition. (See the [More information](#more-information) section for the exact version to use, depending on the version of operating system). To do this, select **Upgrade shared features only**  on the **Select Instance** page of the SQL Server Express installation wizard.

:::image type="content" source="media/asr-agent-vss-backup-fails/sql-server-installation-center.png" alt-text="Screenshot of the Upgrade from SQL Server 2005, SQL Server 2008, SQL Server 2008 R2 or SQL Server 2012 option in the Installation Center window.":::

:::image type="content" source="./media/asr-agent-vss-backup-fails/select-instance.png" alt-text="Screenshot of the Upgrade shared features only option in the Select Instance page." border="false":::

This method upgrades all the shared components to the SQL Server version that is being used. This means that the same SQL Server VSS Writer service that was previously running the 2008 or 2008 R2 version of the writer is now running the more recent SQL Server version from SQL Express. The more recent version is backward compatible.

This method also lets you install SQL Server cumulative updates that are relevant to the upgrade version of SQL Express. For example, you could install SQL Server 2014 or SQL Server 2017 cumulative updates to keep SQLServerWriter updated as required. For more information, see [FIX: Backing up a SQL Server database by using a VSS Backup application may fail after installing SQL Server](https://support.microsoft.com/help/4466108/)

## More information

- SQL Server 2016 and SQL Server 2017 Express Edition [require](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server) Windows Server 2012 or later, or Windows 8 or later.
- If you are using Windows Server 2008 or Windows Server 2008 R2 together with SQL Server 2008 or SQL Server 2008 R2, you can use SQL Server 2014 Service Pack 3 (SP3) Express Edition to upgrade the shared components: [Download Microsoft SQL Server 2014 SP3 Express](https://www.microsoft.com/download/details.aspx?id=57473).

- When you upgrade the shared components, all the sub-components are upgraded in addition to SQLServerWriter. For example: Integration Services, Master Data Services (MDS), SQL Server Management Studio (SSMS), SQL Server Data Tools (SSDT), and SQL Server Books Online are upgraded.

- Another workaround, to upgrade the shared components and to avoid the issue is to install a `dummy` SQL Express instance of a later major version. When you install a later major version of SQL Server instance, it upgrades the shared components as well. You can later disable or uninstall the dummy instance. However, the cleanest approach is to upgrade the shared components.

## References

Learn about the [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md).
