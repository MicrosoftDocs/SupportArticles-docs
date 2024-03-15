---
title: Can't view deleted items in the Service Manager console
description: Describes an issue in which you can't view deleted items in the System Center Service Manager console and receive SQL Server error 8623 in the event log.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# You can't view deleted items in the System Center Service Manager console

This article helps you fix an issue in which you can't view deleted items in the Service Manager console and receive SQL Server error 8623 in the event log.

_Original product version:_ &nbsp; System Center Service Manager, version 1807, System Center Service Manager, version 1801, System Center 2016 Service Manager  
_Original KB number:_ &nbsp; 4480420

## Symptom

In the System Center Service Manager console, when you select **Administration** > **Deleted Items**, you receive the following error message:

> Message: An error occurred while loading the items.  
> Microsoft.EnterpriseManagement.UI.ViewFramework.AdvancedListSupportException: The Full adapter threw an exception. See the FullUpdate property to see the exception.  
   at Microsoft.EnterpriseManagement.UI.ViewFramework.AdvancedListSupportAdapter.DoAction(DataQueryBase query, IList\`1 dataSources, IDictionary\`2 parameters, IList\`1 inputs, String outputCollectionName)  
   at Microsoft.EnterpriseManagement.UI.DataModel.QueryQueue.StartExecuteQuery(Object sender, ConsoleJobEventArgs e)  
   at Microsoft.EnterpriseManagement.ServiceManager.UI.Console.ConsoleJobExceptionHandler.ExecuteJob(IComponent component, EventHandler\`1 job, Object sender, ConsoleJobEventArgs args)  

Additionally, the following SQL Server error is recorded in the event log:

> \- Msg 8623, Level 16, State 1, Line 3  
> The query processor ran out of internal resources and could not produce a query plan. This is a rare event and only expected for extremely complex queries or queries that reference a very large number of tables or partitions. Please simplify the query. If you believe you have received this message in error, contact Customer Support Services for more information.

## Cause

When you open the **Deleted Items** view, an SQL query that contains many **UNION ALL** statements is executed. This issue occurs if there are more than 600 class types that are derived from **Configuration Items**.

To verify this situation, run the following SQL query and check the number of rows that are returned in the result:

ViewsDerivedFromConfigurationItem.sql

```sql
--Views derived from Configuration Item
 use ServiceManager
 go
 select v.name
 from sys.all_columns c
 inner join sys.all_views v on c.object_id=v.object_id
 where c.name like 'ObjectStatus_4AE3E5FE_BC03_1336_0A45_80BF58DEE57B'
 order by 1
```

## Resolution 1

Back up the databases, and then run the following PowerShell scripts in a management server to simulate the **Deleted Items** view.

> [!NOTE]
> RemoveDeletedItem.ps1 removes only one deleted item. RestoreDeletedItems.ps1 restores multiple items at the same time.

### RemoveDeletedItem.ps1

```powershell
#Import-Module SMlets
$sqlInstance=(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\System Center\2010\Common\Database").DatabaseServerName
$smDbName=(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\System Center\2010\Common\Database").DatabaseName
#-------------------------------------------------
$SqlQuery="--Objects in DeletedItems view 
create table #ResultTable_DeletedItems (Name nvarchar(max) null, Class nvarchar(max) null, Path  nvarchar(max) null, TypeName nvarchar(256) null, FullName nvarchar(max) null, BaseManagedEntityId uniqueidentifier not null)
declare @viewName sysname, @sql nvarchar(max),@ParmDefinition nvarchar(max),@retval bigint
declare c cursor read_only forward_only for
select v.name
from sys.all_columns c
inner join sys.all_views v on c.object_id=v.object_id
where c.name like 'ObjectStatus_4AE3E5FE_BC03_1336_0A45_80BF58DEE57B'
order by 1
open c
while 1=1
begin
fetch c into @viewName
if @@FETCH_STATUS<>0 break
set @sql='
insert #ResultTable_DeletedItems
select mtv.DisplayName as Name, LTValue as Class, Path, mt.TypeName, bme.FullName, bme.BaseManagedEntityId
from ' + @viewName + ' mtv inner join BaseManagedEntity bme on mtv.BaseManagedEntityId=bme.BaseManagedEntityId inner join ManagedType mt on bme.BaseManagedTypeId=mt.ManagedTypeId 
inner join LocalizedText lt on mt.ManagedTypeId=lt.LTStringId and LanguageCode=''ENU'' and LTStringType=1
where mtv.ObjectStatus_4AE3E5FE_BC03_1336_0A45_80BF58DEE57B = ''47101E64-237F-12C8-E3F5-EC5A665412FB''
'
exec sp_executesql @sql
end
close c
deallocate c
select * from  #ResultTable_DeletedItems
drop table #ResultTable_DeletedItems"
$cnt=0
Write-Host "Please wait while Deleted Items are listed. $(Get-Date)"
"************************************************"
$ConnectionString="Server=$sqlInstance;Database=$smDbName;Integrated Security=True"
$SqlConnection = new-object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = $ConnectionString
$SqlCommand = $SqlConnection.CreateCommand()
$SqlCommand.CommandText = $SqlQuery
$dt = New-Object System.Data.DataTable
$da = New-Object System.Data.SqlClient.SqlDataAdapter  -ArgumentList $SqlCommand
[void]$da.fill($dt)
$rows=$dt.Rows
#-------------------------------------------------

$selectedDeletedItem= ($rows | Out-GridView  -Title 'Select a single Deleted Item to REMOVE' -OutputMode Single)

if ($selectedDeletedItem)
{
    $Confirm = Read-Host "Deleted configuration items that are removed lose all history and relationships. Do you want to remove the selected configuration item? Type YES to confirm."
    if ($Confirm -ne "YES") {Write-Host "Exiting..."; exit}

    $itemRestored= Get-SCSMObject -Id $selectedDeletedItem.BaseManagedEntityId
    $itemRestored | Remove-SCSMObject -Force

    Write-Host "Selected item below has been REMOVED:"
    $selectedDeletedItem
}
else
{
    Write-Host "No item selected to remove."
}
```

### RestoreDeletedItems.ps1

```powershell
#Import-Module SMlets
$sqlInstance=(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\System Center\2010\Common\Database").DatabaseServerName 
$smDbName=(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\System Center\2010\Common\Database").DatabaseName
#-------------------------------------------------
$SqlQuery="--Objects in DeletedItems view 
create table #ResultTable_DeletedItems (Name nvarchar(max) null, Class nvarchar(max) null, Path  nvarchar(max) null, TypeName nvarchar(256) null, FullName nvarchar(max) null, BaseManagedEntityId uniqueidentifier not null)
declare @viewName sysname, @sql nvarchar(max),@ParmDefinition nvarchar(max),@retval bigint
declare c cursor read_only forward_only for
select v.name
from sys.all_columns c
inner join sys.all_views v on c.object_id=v.object_id
where c.name like 'ObjectStatus_4AE3E5FE_BC03_1336_0A45_80BF58DEE57B'
order by 1
open c
while 1=1
begin
fetch c into @viewName
if @@FETCH_STATUS<>0 break
set @sql='
insert #ResultTable_DeletedItems
select mtv.DisplayName as Name, LTValue as Class, Path, mt.TypeName, bme.FullName, bme.BaseManagedEntityId
from ' + @viewName + ' mtv inner join BaseManagedEntity bme on mtv.BaseManagedEntityId=bme.BaseManagedEntityId inner join ManagedType mt on bme.BaseManagedTypeId=mt.ManagedTypeId 
inner join LocalizedText lt on mt.ManagedTypeId=lt.LTStringId and LanguageCode=''ENU'' and LTStringType=1
where mtv.ObjectStatus_4AE3E5FE_BC03_1336_0A45_80BF58DEE57B = ''47101E64-237F-12C8-E3F5-EC5A665412FB''
'
exec sp_executesql @sql
end
close c
deallocate c
select * from  #ResultTable_DeletedItems
drop table #ResultTable_DeletedItems"
$cnt=0
Write-Host "Please wait while Deleted Items are listed. $(Get-Date)"
"************************************************"
$ConnectionString="Server=$sqlInstance;Database=$smDbName;Integrated Security=True"
$SqlConnection = new-object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = $ConnectionString
$SqlCommand = $SqlConnection.CreateCommand()
$SqlCommand.CommandText = $SqlQuery
$dt = New-Object System.Data.DataTable
$da = New-Object System.Data.SqlClient.SqlDataAdapter  -ArgumentList $SqlCommand
[void]$da.fill($dt)
$rows=$dt.Rows
#-------------------------------------------------

$selectedDeletedItems= ($rows | Out-GridView  -Title 'Select Deleted Item(s) to RESTORE' -passthru )

if ($selectedDeletedItems)
{

    $Confirm = Read-Host "This will restore the selected configuration items. Do you want to continue? Type Y to confirm." 
    if ($Confirm -ne "Y") {Write-Host "Exiting..."; exit}

    $Active = Get-SCSMEnumeration System.ConfigItem.ObjectStatusEnum.Active$

    foreach($selectedDeletedItem in $selectedDeletedItems)
    {
        $itemRestored= Get-SCSMObject -Id $selectedDeletedItem.BaseManagedEntityId
        $itemRestored | set-scsmobject -property ObjectStatus -value $Active  
    }
    Write-Host "Selected item(s) below has been restored:"
    $selectedDeletedItems
}
else
{
    Write-Host "No item selected to restore."
}
```

## Resolution 2

Create special console views by following these steps:

1. Create a new console view inside the **Configuration Items** wunderbar.
2. Look for a specific class type other than **Configuration Items**, for example **Windows Computer**. You can refer to the **Class** column that's returned by RestoreDeletedItems.ps1 for available class types.
3. Change criteria to **[Configuration Item].Object Status equals Pending Delete**.
4. In the **Display** section, select at least the **Name** and **Path** columns. You can also select other columns that are specific to the class type.
5. Remove or restore the listed deleted items.

## Resolution 3

Delete unused management packs to reduce the total number of derived class types.

> [!IMPORTANT]
> Be careful when you delete management packs. We recommend that you create a backup and that you test in a test environment before you do this in the production environment.

To find the number of derived class types that each management pack contains, run the following SQL query:

```sql
-- Order the management packs by the number of derived configuration items class types
select MP.MPName, count(1) as TotalConfigurationItemClassTypes from ManagedType MT
inner join ManagementPack as MP on MT.ManagementPackId = MP.ManagementPackId
where ManagedTypeTableName in (select TABLE_NAME from INFORMATION_SCHEMA.columns where column_name like '%AssetStatus_B6E7674B_684A_040D_30B8_D1B42CCB3BC6%'
) and ManagedTypeTableName is not null
group by MP.MPName
order by count(1) desc
```

## More information

When you remove computer objects, don't remove computer objects of the management servers. Otherwise Service Manager workflows will stop working, and you'll have to restore the Service Manager database to a previous backup.
