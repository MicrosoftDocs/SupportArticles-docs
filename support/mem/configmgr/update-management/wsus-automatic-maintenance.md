---
title: Manual and automatic WSUS database maintenance
description: Describes steps and scripts to perform the maintenance of the Windows Server Update Services (WSUS) database manually or automatically.
author: danschuh
ms.author: daschuh
ms.date: 10/17/2024
ms.custom: sap:Software Update Management (SUM)\WSUS Database Maintenance
---
# Maintain the Windows Server Update Services (WSUS) database manually or automatically

Routine maintenance of the WSUS database (SUSDB) is important to ensure the application's health and optimal performance. This article describes concise steps and scripts to maintain SUSDB manually or automatically.

For more information, see [The complete guide to WSUS and Configuration Manager SUP maintenance](wsus-maintenance-guide.md).

## How long does the maintenance take?

The maintenance duration might vary depending on the machine's resources, including CPU, memory, and disk capacity. Factors affecting the maintenance duration include the time since the last maintenance, the number of selected products and classifications, and the volume of updates that need to be cleaned up.

In a small environment, with minimal products and classifications and recent maintenance on SUSDB, the automatic scripts with the `RA` option might take less than one minute to run. However, in some cases, it might take several days to complete. If it takes longer than expected and you can't complete the maintenance successfully, you need to create a new SUSDB.

## Query to obtain the update count

An excessive number of superseded, declined, and obsolete updates often cause poor health of SUSDB. To obtain the update count, run the following SQL query. If the counts in the last three columns of the query result exceed a few hundred, maintenance should be performed.

```sql
use SUSDB;

DECLARE @numberOfMatch INT
DECLARE @tmpTable TABLE (
    name VARCHAR(25)
)
INSERT INTO @tmpTable
EXEC spGetObsoleteUpdatesToCleanup
SELECT @numberOfMatch = @@ROWCOUNT
select
(Select count (*) from vwMinimalUpdate ) 'Total Updates',
(Select count (*) from vwMinimalUpdate where declined=0) as 'Live Updates',
(Select count (*) from vwMinimalUpdate where IsSuperseded =1) as 'Superseded',
(Select count (*) from vwMinimalUpdate where IsSuperseded =1 and declined=0) as 'Superseded but not declined',
(Select count (*) from vwMinimalUpdate where declined=1) as 'Declined',
(Select count (*) from vwMinimalUpdate where IsSuperseded =1 and declined=1) 'Superseded & Declined',
(select Count(*)  From @tmpTable ) 'Obsolete Updates Needed to be cleaned'
```

## Maintain the WSUS database (SUSDB) manually

> [!IMPORTANT]
>
> - Run the steps on each WSUS server in the hierarchy. When performing a cleanup and removing items from WSUS servers, start at the lowest level of the hierarchy.
> - Ensure that any scheduled synchronizations are disabled, either in Configuration Manager (if used) or on standalone WSUS servers.

The following steps can resolve many issues with scanning and synchronization. If there are a large number of declined updates, you might need to repeat steps 9 through 12 multiple times. After each run, execute the [SQL query](#query-to-obtain-the-update-count) to confirm that the update count is decreasing. Steps 8 and 9 might result in errors each time, which is expected. Therefore, you need to repeat steps 9 through 12 multiple times. Some steps (especially step 9) might take several hours to complete.

1. Run the SQL script described in [Slow performance of the spDeleteUpdate procedure](spdeleteupdate-slow-performance.md).
2. Shrink the SUSDB files.
3. Shrink the SUSDB database.
4. Reindex and update statistics on SUSDB.

    1. To reindex SUSDB, run the following SQL script:

        ```sql
        EXEC sp_MSforeachtable @command1="SET QUOTED_IDENTIFIER ON;ALTER INDEX ALL ON ? REBUILD;"
        ```

    2. To update statistics, run the following SQL script:

        ```sql
        Exec sp_msforeachtable "UPDATE STATISTICS ? WITH FULLSCAN, COLUMNS" 
        ```

5. Perform a cleanup of the synchronization history.

    > [!NOTE]
    > If there are a large number of synchronizations, the WSUS console may crash.

    ```sql
    USE SUSDB 
    GO 
    DELETE FROM tbEventInstance WHERE EventNamespaceID = '2' AND EVENTID IN ('381', '382', '384', '386', '387', '389')
    ```

6. Perform a cleanup of superseded updates older than 30 days or according to your specific configuration.

    > [!NOTE]
    >
    > - The value of `30` in the first line indicates the number of days between today and the release date, during which superseded updates shouldn't be marked as declined.
    > - In Configuration Manager, this value should align with the [supersedence rules](/mem/configmgr/sum/plan-design/plan-for-software-updates#BKMK_SupersedenceRules) configured in the software update point (SUP) component properties.
    > - On standalone WSUS servers, specify the number of days you want to retain superseded updates. For instance, set the value to `60` instead of `30` to keep two months of superseded updates. Any updates older than this period will be marked as declined and subsequently cleaned up.

    ```sql
    DECLARE @thresholdDays INT = 30   -- Specify the number of days between today and the release date during which superseded updates should not be marked as declined. If Configuration Manager is being used with WSUS, this value should match the configuration of supersedence rules in the software update point (SUP) component properties.
    DECLARE @testRun BIT = 0          -- Set this value to 1 to test without declining anything. 
    -- There shouldn't be any need to modify anything after this line.
    DECLARE @uid UNIQUEIDENTIFIER
    DECLARE @title NVARCHAR(500)
    DECLARE @date DATETIME
    DECLARE @userName NVARCHAR(100) = SYSTEM_USER 
    DECLARE @count INT = 0 
    DECLARE DU CURSOR FOR
           SELECT MU.UpdateID, U.DefaultTitle, U.CreationDate FROM vwMinimalUpdate MU 
           JOIN PUBLIC_VIEWS.vUpdate U ON MU.UpdateID = U.UpdateId
           WHERE MU.IsSuperseded = 1 AND MU.Declined = 0 AND MU.IsLatestRevision = 1
           AND MU.CreationDate < DATEADD(dd,-@thresholdDays,GETDATE())
           ORDER BY MU.CreationDate 
    PRINT 'Declining superseded updates older than ' + CONVERT(NVARCHAR(5), @thresholdDays) + ' days.' + CHAR(10) 
    OPEN DU
    FETCH NEXT FROM DU INTO @uid, @title, @date
    WHILE (@@FETCH_STATUS > - 1)
    BEGIN  
           SET @count = @count + 1
           PRINT 'Declining update ' + CONVERT(NVARCHAR(50), @uid) + ' (Creation Date ' + CONVERT(NVARCHAR(50), @date) + ') - ' + @title + ' ...'
           IF @testRun = 0
                  EXEC spDeclineUpdate @updateID = @uid, @adminName = @userName, @failIfReplica = 1 
           FETCH NEXT FROM DU INTO @uid, @title, @date
    END 
    CLOSE DU
    DEALLOCATE DU 
    PRINT CHAR(10) + 'Attempted to decline ' + CONVERT(NVARCHAR(10), @count) + ' updates.'
    ```

7. Perform a cleanup of obsolete updates.

    ```sql
    DECLARE @var1 INT
    DECLARE @msg nvarchar(100)
    CREATE TABLE #results (Col1 INT)
            INSERT INTO #results(Col1) EXEC spGetObsoleteUpdatesToCleanup
    DECLARE WC Cursor
            FOR
            SELECT Col1 FROM #results
    OPEN WC
            FETCH NEXT FROM WC
            INTO @var1
            WHILE (@@FETCH_STATUS > -1)
            BEGIN SET @msg = 'Deleting' + CONVERT(varchar(10), @var1)
            RAISERROR(@msg,0,1) WITH NOWAIT EXEC spDeleteUpdate @localUpdateID=@var1
            FETCH NEXT FROM WC INTO @var1 END        
    CLOSE WC
            DEALLOCATE WC
            
            DROP TABLE #results
    ```

8. From an elevated Windows PowerShell prompt, run the following script to initiate the WSUS Cleanup wizard:

    ```powershell
    [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null
    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer();
    $cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope;
    $cleanupScope.DeclineSupersededUpdates = $true
    $cleanupScope.DeclineExpiredUpdates = $true
    $cleanupScope.CleanupObsoleteUpdates = $true
    $cleanupScope.CompressUpdates = $true
    $cleanupScope.CleanupObsoleteComputers = $true
    $cleanupScope.CleanupUnneededContentFiles = $true
    $cleanupManager = $wsus.GetCleanupManager();
    $cleanupManager.PerformCleanup($cleanupScope); 
    ```

9. From an elevated Windows PowerShell prompt, run the following script to perform a cleanup of declined updates:

    ```powershell
    [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer();
    $wsus.GetUpdates() | Where {$_.IsDeclined -eq $true} | ForEach-Object {$wsus.DeleteUpdate($_.Id.UpdateId.ToString()); Write-Host $_.Title removed } 
    ```

10. Shrink the SUSDB files.
11. Shrink the SUSDB database.
12. Reindex and update statistics on SUSDB.

    1. To reindex SUSDB, run the following SQL script:

        ```sql
        EXEC sp_MSforeachtable @command1="SET QUOTED_IDENTIFIER ON;ALTER INDEX ALL ON ? REBUILD;"
        ```

    2. To update statistics, run the following SQL script:

        ```sql
        Exec sp_msforeachtable "UPDATE STATISTICS ? WITH FULLSCAN, COLUMNS" 
        ```

## Maintain the WSUS database (SUSDB) automatically

The following PowerShell script replicates the manual steps. When the script is executed, a *SUSDB-Maintenance.log* file will be created and opened.

> [!IMPORTANT]
> Ensure that any scheduled synchronizations are disabled, either in Configuration Manager (if used) or on standalone WSUS servers.

```powershell
<# SUSDB-Maintenance

Requirements
* WID must be local.
* Remote connections to SQL are now supported; choose [S] Change SQL Server from the menu to set the SQL Server.
* WSUS Console must be installed locally.
* Must have internet access to download the SQL PowerShell Module.
* Must be using v22 or higher of the SQL Server PowerShell Module.

This script will present the following menu options for performing SUSDB maintenance. When the script is executed, a SUSDB-Maintenance.log file will be created and opened.

[S] Change SQL Server, currently set to 
[A] Update Count
[1] Update spDeleteUpdate procedure
[2] Shrink Files
[3] Shrink Database
[4] Reindex and Update Statistics
[5] Cleanup Sync History
[6] Cleanup Superseded Updates Older than x Days
[7] Cleanup Obsolete Updates
[8] WSUS Cleanup Wizard
[9] Cleanup Declined
[10] Shrink Files
[11] Shrink Database
[12] Reindex and Update Statistics
[RA] Run all above steps sequentially

Sample scripts are not supported under any Microsoft standard support program or service. Sample scripts are provided AS IS without warranty of any kind.
Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.
The entire risk arising out of the use or performance of the sample script and documentation remains with you.
In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever
(including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use
of or inability to use the sample script or documentation, even if Microsoft has been advised of the possibility of such damages.

#>

#Global Variables
$Global:LogFile = $null
$Global:SQLoutput = $null
$Global:Spaceused = $null
$Global:progresspreference = 'SilentlyContinue'
$Global:DaysSupersededNotDeclined = 30

$ErrorActionPreference = "Stop"

try {
    $SQLsetup = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Update Services\Server\Setup' -Name SqlServerName).SqlServerName
}
catch {
    $global:LocalSQLInstance = "SQL Server or WID NOT Found"
}

if ($SQLsetup -contains "MICROSOFT##WID" ) {
    $global:LocalSQLInstance = '\\.\pipe\MICROSOFT##WID\tsql\query'
}
elseif ($null -ne $SQLsetup) {
    $global:LocalSQLInstance = $SQLsetup
}
else {
    $global:LocalSQLInstance = "SQL Server or WID NOT Found"
}

#Region SQL_Queries
$spDeleteUpdate = "USE SUSDB
GO

/****** Object:  StoredProcedure [dbo].[spDeleteUpdate]    Script Date: 11/2/2020 8:55:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
ALTER PROCEDURE [dbo].[spDeleteUpdate]
    @localUpdateID int
AS
SET NOCOUNT ON
 Begin TRANSACTION
SAVE TRANSACTION DeleteUpdate
DECLARE @retcode INT
DECLARE @revisionID INT
DECLARE @revisionList TABLE(RevisionID INT PRIMARY KEY)
INSERT INTO @revisionList (RevisionID)
    SELECT r.RevisionID FROM dbo.tbRevision r
        WHERE r.LocalUpdateID = @localUpdateID
IF EXISTS (SELECT b.RevisionID FROM dbo.tbBundleDependency b WHERE b.BundledRevisionID IN (SELECT RevisionID FROM @revisionList))
   OR EXISTS (SELECT p.RevisionID FROM dbo.tbPrerequisiteDependency p WHERE p.PrerequisiteRevisionID IN (SELECT RevisionID FROM @revisionList))
 Begin
    RAISERROR('spDeleteUpdate got error: cannot delete update as it is still referenced by other update(s)', 16, -1)
    ROLLBACK TRANSACTION DeleteUpdate
    COMMIT TRANSACTION
    RETURN(1)
 End
INSERT INTO @revisionList (RevisionID)
    SELECT DISTINCT b.BundledRevisionID FROM dbo.tbBundleDependency b
        INNER JOIN dbo.tbRevision r ON r.RevisionID = b.RevisionID
        INNER JOIN dbo.tbProperty p ON p.RevisionID = b.BundledRevisionID
        WHERE r.LocalUpdateID = @localUpdateID
            AND p.ExplicitlyDeployable = 0
IF EXISTS (SELECT IsLocallyPublished FROM dbo.tbUpdate WHERE LocalUpdateID = @localUpdateID AND IsLocallyPublished = 1)
 Begin
    INSERT INTO @revisionList (RevisionID)
        SELECT DISTINCT pd.PrerequisiteRevisionID FROM dbo.tbPrerequisiteDependency pd
            INNER JOIN dbo.tbUpdate u ON pd.PrerequisiteLocalUpdateID = u.LocalUpdateID
            INNER JOIN dbo.tbProperty p ON pd.PrerequisiteRevisionID = p.RevisionID
            WHERE u.IsLocallyPublished = 1 AND p.UpdateType = 'Category'
 End
DECLARE #cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT t.RevisionID FROM @revisionList t ORDER BY t.RevisionID DESC
OPEN #cur
FETCH #cur INTO @revisionID
WHILE (@@ERROR=0 AND @@FETCH_STATUS=0)
 Begin
    IF EXISTS (SELECT b.RevisionID FROM dbo.tbBundleDependency b WHERE b.BundledRevisionID = @revisionID
                   AND b.RevisionID NOT IN (SELECT RevisionID FROM @revisionList))
       OR EXISTS (SELECT p.RevisionID FROM dbo.tbPrerequisiteDependency p WHERE p.PrerequisiteRevisionID = @revisionID
                      AND p.RevisionID NOT IN (SELECT RevisionID FROM @revisionList))
     Begin
        DELETE FROM @revisionList WHERE RevisionID = @revisionID
        IF (@@ERROR <> 0)
         Begin
            RAISERROR('Deleting disqualified revision from temp table failed', 16, -1)
            GOTO Error
         End
     End
    FETCH NEXT FROM #cur INTO @revisionID
 End
IF (@@ERROR <> 0)
 Begin
    RAISERROR('Fetching a cursor to value a revision', 16, -1)
    GOTO Error
 End
CLOSE #cur
DEALLOCATE #cur
DECLARE #cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT t.RevisionID FROM @revisionList t ORDER BY t.RevisionID DESC
OPEN #cur
FETCH #cur INTO @revisionID
WHILE (@@ERROR=0 AND @@FETCH_STATUS=0)
 Begin
    EXEC @retcode = dbo.spDeleteRevision @revisionID
    IF @@ERROR <> 0 OR @retcode <> 0
     Begin
        RAISERROR('spDeleteUpdate got error from spDeleteRevision', 16, -1)
        GOTO Error
     End
    FETCH NEXT FROM #cur INTO @revisionID
 End
IF (@@ERROR <> 0)
 Begin
    RAISERROR('Fetching a cursor to delete a revision', 16, -1)
    GOTO Error
 End
CLOSE #cur
DEALLOCATE #cur
COMMIT TRANSACTION
RETURN(0)
Error:
    CLOSE #cur
    DEALLOCATE #cur
    IF (@@TRANCOUNT > 0)
     Begin
        ROLLBACK TRANSACTION DeleteUpdate
        COMMIT TRANSACTION
     End
    RETURN(1)
GO"

$DB = "Use SUSDB
GO
 "

$Reindex = $DB + 'EXEC sp_MSforeachtable @command1="SET QUOTED_IDENTIFIER ON;ALTER INDEX ALL ON ? REBUILD;"'

$UpdateStatistics = $DB + 'Exec sp_msforeachtable "UPDATE STATISTICS ? WITH FULLSCAN, COLUMNS"'

$CleanupSyncHistory = "USE SUSDB 
GO 
DELETE FROM tbEventInstance WHERE EventNamespaceID = '2' AND EVENTID IN ('381', '382', '384', '386', '387', '389')"

$UpdateCount = "use SUSDB;
GO

DECLARE @numberOfMatch INT
DECLARE @tmpTable TABLE (
    name VARCHAR(25)
)
INSERT INTO @tmpTable
EXEC spGetObsoleteUpdatesToCleanup
SELECT @numberOfMatch = @@ROWCOUNT
select
(Select count (*) from vwMinimalUpdate ) 'Total Updates',
(Select count (*) from vwMinimalUpdate where declined=0) as 'Live Updates',
(Select count (*) from vwMinimalUpdate where IsSuperseded =1) as 'Superseded',
(Select count (*) from vwMinimalUpdate where IsSuperseded =1 and declined=0) as 'Superseded but not declined',
(Select count (*) from vwMinimalUpdate where declined=1) as 'Declined',
(Select count (*) from vwMinimalUpdate where IsSuperseded =1 and declined=1) 'Superseded and Declined',
(select Count(*)  From @tmpTable ) 'Obsolete Updates Needed to be cleaned'"

$Shrinkfile = "USE SUSDB;
GO
DBCC SHRINKFILE (SUSDB, 0);
GO"

$ShrinkDatabase = "
USE SUSDB;
GO
DBCC SHRINKDATABASE (SUSDB, 0);
GO"

$CleanupSupersededUpdates = "DECLARE @thresholdDays INT = $Global:DaysSupersededNotDeclined   -- Specify the number of days between today and the release date for which the superseded updates must not be declined. This should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.
DECLARE @testRun BIT = 0          -- Set this to 1 to test without declining anything. 
-- There shouldn't be any need to modify anything after this line.
DECLARE @uid UNIQUEIDENTIFIER
DECLARE @title NVARCHAR(500)
DECLARE @date DATETIME
DECLARE @userName NVARCHAR(100) = SYSTEM_USER 
DECLARE @count INT = 0 
DECLARE DU CURSOR FOR
       SELECT MU.UpdateID, U.DefaultTitle, U.CreationDate FROM vwMinimalUpdate MU 
       JOIN PUBLIC_VIEWS.vUpdate U ON MU.UpdateID = U.UpdateId
       WHERE MU.IsSuperseded = 1 AND MU.Declined = 0 AND MU.IsLatestRevision = 1
       AND MU.CreationDate < DATEADD(dd,-@thresholdDays,GETDATE())
       ORDER BY MU.CreationDate 
PRINT 'Declining superseded updates older than ' + CONVERT(NVARCHAR(5), @thresholdDays) + ' days.' + CHAR(10) 
OPEN DU
FETCH NEXT FROM DU INTO @uid, @title, @date
WHILE (@@FETCH_STATUS > - 1)
 Begin  
       SET @count = @count + 1
       PRINT 'Declining update ' + CONVERT(NVARCHAR(50), @uid) + ' (Creation Date ' + CONVERT(NVARCHAR(50), @date) + ') - ' + @title + ' ...'
       IF @testRun = 0
              EXEC spDeclineUpdate @updateID = @uid, @adminName = @userName, @failIfReplica = 1 
       FETCH NEXT FROM DU INTO @uid, @title, @date
 End 
CLOSE DU
DEALLOCATE DU 
PRINT CHAR(10) + 'Attempted to decline ' + CONVERT(NVARCHAR(10), @count) + ' updates.'"

$CleanupObsoleteUpdates = "DECLARE @var1 INT
DECLARE @msg nvarchar(100)
CREATE TABLE #results (Col1 INT)
        INSERT INTO #results(Col1) EXEC spGetObsoleteUpdatesToCleanup
DECLARE WC Cursor
        FOR
        SELECT Col1 FROM #results
OPEN WC
        FETCH NEXT FROM WC
        INTO @var1
        WHILE (@@FETCH_STATUS > -1)
         Begin SET @msg = 'Deleting' + CONVERT(varchar(10), @var1)
        RAISERROR(@msg,0,1) WITH NOWAIT EXEC spDeleteUpdate @localUpdateID=@var1
        FETCH NEXT FROM WC INTO @var1  End        
CLOSE WC
        DEALLOCATE WC
        
        DROP TABLE #results"

$Spaceused = "USE SUSDB;
SELECT
    name,
       size * 8/1024 'Size (MB)'   
FROM sys.database_files;"
#EndRegion SQL_Queries

Function Write-log {

    ############################
    #Write-Log in CMTrace Format
    ############################
 
    PARAM(
        [String]$Message,
        [String]$Path = $LogFile,
        [int]$severity,
        [string]$component
    )
 
    $TimeZoneBias = Get-WmiObject -Query "Select Bias from Win32_TimeZone"
    $Date = Get-Date -Format "HH:mm:ss.fff"
    $Date2 = Get-Date -Format "MM-dd-yyyy"    
 
    "<![LOG[$Message]LOG]!><time=$([char]34)$date$($TimeZoneBias.bias)$([char]34) date=$([char]34)$date2$([char]34) component=$([char]34)$component$([char]34) context=$([char]34)$([char]34) type=$([char]34)$severity$([char]34) thread=$([char]34)$([char]34) file=$([char]34)$([char]34)>" | Out-File -FilePath $Path -Append -NoClobber -Encoding default

    #Write-Log -Message "Starting installation" -severity 1 -component "Installation"
    #Write-Log -Message "Something went wrong" -severity 2 -component "Installation"
    #Write-Log -Message "BIG Error Message" -severity 3 -component "Installation"

}

function Write-Color([String[]]$Text, [ConsoleColor[]]$Color) {
    for ($i = 0; $i -lt $Text.Length; $i++) {
        Write-Host $Text[$i] -Foreground $Color[$i] -NoNewline
    }
    Write-Host
}

function UpdateCount {

    Write-log -Message "--> Begin Update Count" -severity 1 -component "Update Count"      
    Write-log -Message "Update Count" -severity 1 -component "Update Count"

    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $UpdateCount -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional

    Write-log -Message ("Total execution time for Update Count.........:" + ($($stats.ExecutionTime) / 1000) + " seconds")
    Write-log -Message ("Total Updates " + $SQLoutput.'Total Updates') -severity 1 -component "Update Count"
    Write-log -Message ("Live Updates " + $SQLoutput.'Live Updates') -severity 1 -component "Update Count"
    Write-log -Message ("Superseded " + $SQLoutput.'Superseded') -severity 1 -component "Update Count"
    Write-log -Message ("Superseded but not declined " + $SQLoutput.'Superseded but not declined') -severity 1 -component "Update Count"
    Write-log -Message ("Declined " + $SQLoutput.'Declined') -severity 1 -component "Update Count"
    Write-log -Message ("Superseded and Declined " + $SQLoutput.'Superseded and Declined') -severity 1 -component "Update Count"
    Write-log -Message ("Obsolete Updates Needed to be cleaned " + $SQLoutput.'Obsolete Updates Needed to be cleaned') -severity 1 -component "Update Count"            
    Write-log -Message "--> End Update Count" -severity 1 -component "Update Count"
}

function Update_spDeleteUpdate_Procedure {

    Write-log -Message "--> Begin update spDeleteUpdate procedure" -severity 1 -component "Update spDeleteUpdate"
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $spDeleteUpdate -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    Write-log -Message ("Total execution time.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Update spDeleteUpdate"
    Write-log -Message "SQL Output is $SQLoutput" -severity 1 -component "Update spDeleteUpdate"
    Write-log -Message "--> End update spDeleteUpdate procedure" -severity 1 -component "Update spDeleteUpdate"
}

function ShrinkFile {

    Write-log -Message "--> Begin shrink file" -severity 1 -component "Shrink File"            
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $Spaceused -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Shrink File"
    Write-log -Message ($SQLoutput.name[1] + " " + $SQLoutput."Size (MB)"[1] + " MB") -severity 1 -component "Shrink Files"

    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $Shrinkfile -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    $SQLoutput | Out-File -FilePath $LogFile -Append -Encoding ascii
    Write-log -Message ("Total execution time for Shrinking File.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Shrink File"    
    
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $Spaceused -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Shrink File"
    Write-log -Message ($SQLoutput.name[1] + " " + $SQLoutput."Size (MB)"[1] + " MB") -severity 1 -component "Shrink File"
    Write-log -Message "--> End shrink file" -severity 1 -component "Shrink File"
}

function ShrinkDatabase {

    Write-log -Message "--> Begin shrink database" -severity 1 -component "Shrink Database"
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $Spaceused -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Shrink Database"
    Write-log -Message ($SQLoutput.name[0] + " " + $SQLoutput."Size (MB)"[0] + " MB") -severity 1 -component "Shrink Database"
    
    Write-log -Message "--> Begin shrink database" -severity 1 -component "Shrink Database"
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $ShrinkDatabase -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    $SQLoutput | Out-File -FilePath $LogFile -Append -Encoding ascii
    Write-log -Message ("Total execution time for Shrinking Database.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Shrink Database"
    
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $Spaceused -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional   
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Shrink Database"
    Write-log -Message ($SQLoutput.name[0] + " " + $SQLoutput."Size (MB)"[0] + " MB") -severity 1 -component "Shrink Database"
    Write-log -Message "--> End shrink database" -severity 1 -component "Shrink Database"
}

function ReindexStatistics {

    Write-log -Message "--> Begin reindex and update statistics" -severity 1 -component "IndexStats"
    Write-log -Message "Reindexing" -severity 1 -component "IndexStats"
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $Reindex -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    $SQLoutput | Out-File -FilePath $LogFile -Append -Encoding ascii
    Write-log -Message ("Total execution time for Reindex.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "IndexStats"    

    Write-log -Message "Now Updating Statistics" -severity 1 -component "IndexStats"
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $UpdateStatistics -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    $SQLoutput | Out-File -FilePath $LogFile -Append -Encoding ascii
    Write-log -Message ("Total execution time for Updating Statistics.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "IndexStats"    
    Write-log -Message "--> End reindex and update statistics" -severity 1 -component "IndexStats"

}

function CleanUpSyncHistory {

    Write-log -Message "--> Begin cleanup sync history" -severity 1 -component "Cleanup Sync History"
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $CleanupSyncHistory -Verbose -StatisticsVariable stats -OutputSqlErrors $true -TrustServerCertificate -Encrypt Optional
    $SQLoutput | Out-File -FilePath $LogFile -Append -Encoding ascii
    Write-log -Message ("Total execution time for Cleaning up Sync History.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Cleanup Sync History"    
    Write-log -Message "--> End cleanup sync history" -severity 1 -component "Cleanup Sync History"
}

function CleanupSupersedUpdates {
    Write-log -Message "--> Begin cleanup superseded updates" -severity 1 -component "Cleanup Superseded Updates"
    Write-log -Message "Days specified: $Global:DaysSupersededNotDeclined" -severity 1 -component "Cleanup Superseded Updates"

    $CleanupSupersededUpdates = "DECLARE @thresholdDays INT = $Global:DaysSupersededNotDeclined   -- Specify the number of days between today and the release date for which the superseded updates must not be declined. This should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.
DECLARE @testRun BIT = 0          -- Set this to 1 to test without declining anything. 
-- There shouldn't be any need to modify anything after this line.
DECLARE @uid UNIQUEIDENTIFIER
DECLARE @title NVARCHAR(500)
DECLARE @date DATETIME
DECLARE @userName NVARCHAR(100) = SYSTEM_USER 
DECLARE @count INT = 0 
DECLARE DU CURSOR FOR
       SELECT MU.UpdateID, U.DefaultTitle, U.CreationDate FROM vwMinimalUpdate MU 
       JOIN PUBLIC_VIEWS.vUpdate U ON MU.UpdateID = U.UpdateId
       WHERE MU.IsSuperseded = 1 AND MU.Declined = 0 AND MU.IsLatestRevision = 1
       AND MU.CreationDate < DATEADD(dd,-@thresholdDays,GETDATE())
       ORDER BY MU.CreationDate 
PRINT 'Declining superseded updates older than ' + CONVERT(NVARCHAR(5), @thresholdDays) + ' days.' + CHAR(10) 
OPEN DU
FETCH NEXT FROM DU INTO @uid, @title, @date
WHILE (@@FETCH_STATUS > - 1)
 Begin  
       SET @count = @count + 1
       PRINT 'Declining update ' + CONVERT(NVARCHAR(50), @uid) + ' (Creation Date ' + CONVERT(NVARCHAR(50), @date) + ') - ' + @title + ' ...'
       IF @testRun = 0
              EXEC spDeclineUpdate @updateID = @uid, @adminName = @userName, @failIfReplica = 1 
       FETCH NEXT FROM DU INTO @uid, @title, @date
 End 
CLOSE DU
DEALLOCATE DU 
PRINT CHAR(10) + 'Attempted to decline ' + CONVERT(NVARCHAR(10), @count) + ' updates.'"


    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $CleanupSupersededUpdates -Verbose -StatisticsVariable stats -OutputSqlErrors $true -Database SUSDB -TrustServerCertificate -Encrypt Optional
    Write-log -Message ("Total execution time for Cleaning up Superseded Updates.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Cleanup Superseded Updates"
    Write-log -Message "SQL Output is $SQLoutput" -severity 1 -component "Cleanup Superseded Updates"
    Write-log -Message "--> End cleanup superseded updates" -severity 1 -component "Cleanup Superseded Updates"
}

function CleanupObsoleteUpdates {

    Write-log -Message "--> Begin cleanup obsolete updates" -severity 1 -component "Cleanup Obsolete Updates"
    $SQLoutput = Invoke-Sqlcmd -ServerInstance $LocalSQLInstance -Query $CleanupObsoleteUpdates -Verbose -StatisticsVariable stats -OutputSqlErrors $true -Database SUSDB -TrustServerCertificate -Encrypt Optional
    $SQLoutput | Out-File -FilePath $LogFile -Append -Encoding ascii    
    Write-log -Message ("Total execution time for Cleaning up Obsolete Updates.........:" + ($($stats.ExecutionTime) / 1000) + " seconds") -severity 1 -component "Cleanup Obsolete Updates"
    Write-log -Message "--> End cleanup obsolete updates" -severity 1 -component "Cleanup Obsolete Updates"
}

function WSUSCleanUpWizard {

    Write-log -Message "--> Begin WSUS cleanup wizard" -severity 1 -component "WSUS Cleanup Wizard"
    [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | Out-Null
    $CleanUpWizard = {
        [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | Out-Null
        $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer();
        $cleanupScope = New-Object Microsoft.UpdateServices.Administration.CleanupScope;
        $cleanupScope.DeclineSupersededUpdates = $true
        $cleanupScope.DeclineExpiredUpdates = $true
        $cleanupScope.CleanupObsoleteUpdates = $true
        $cleanupScope.CompressUpdates = $true
        $cleanupScope.CleanupObsoleteComputers = $true
        $cleanupScope.CleanupUnneededContentFiles = $true
        $cleanupManager = $wsus.GetCleanupManager();
        $cleanupManager.PerformCleanup($cleanupScope);                         
    }

    $RunCleanUpWizard = Invoke-Command -ScriptBlock $CleanUpWizard

    Write-log -Message ("Disk Space Freed " + $RunCleanUpWizard.DiskSpaceFreed + " MB") -severity 1 -component "WSUS Cleanup Wizard"
    Write-log -Message ("Expired Updates Declined " + $RunCleanUpWizard.ExpiredUpdatesDeclined) -severity 1 -component "WSUS Cleanup Wizard"
    Write-log -Message ("Obsolete Computers Deleted " + $RunCleanUpWizard.ObsoleteComputersDeleted) -severity 1 -component "WSUS Cleanup Wizard"
    Write-log -Message ("Obsolete Updates Deleted " + $RunCleanUpWizard.ObsoleteUpdatesDeleted) -severity 1 -component "WSUS Cleanup Wizard"
    Write-log -Message ("Superseded Updates Declined " + $RunCleanUpWizard.SupersededUpdatesDeclined) -severity 1 -component "WSUS Cleanup Wizard"
    Write-log -Message ("Updates Compressed " + $RunCleanUpWizard.UpdatesCompressed) -severity 1 -component "WSUS Cleanup Wizard"
    Write-log -Message "--> End WSUS cleanup wizard" -severity 1 -component "WSUS Cleanup Wizard"
}

function CleanUpDeclined {

    Write-log -Message "--> Begin cleanup declined" -severity 1 -component "Cleanup Declined"
    [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer();
    $wsus.GetUpdates() | Where-Object { $_.IsDeclined -eq $true } | ForEach-Object { $wsus.DeleteUpdate($_.Id.UpdateId.ToString()); Write-Host $_.Title removed } 
    Write-log -Message "--> End cleanup declined" -severity 1 -component "Cleanup Declined"
}

function ChangeSQL {
    Write-log -Message "--> Begin change SQL" -severity 1 -component "Change SQL"
    $global:LocalSQLInstance = Read-Host -Prompt 'Enter the name of the SQL Server'
    Write-log -Message "--> SQL Server changed to $LocalSQLInstance" -severity 1 -component "Change SQL"
    Write-log -Message "--> End change SQL" -severity 1 -component "Change SQL"
}
function Show-Menu {
    Write-log -Message "--> Begin Show Menu" -severity 1 -component "Show Menu"
    Clear-Host
    Write-Host "================ $Title ================" -BackgroundColor Black -ForegroundColor Yellow
      
    #Write-Color -Text "[S] ", "Change SQL Server, currently set to $LocalSQLInstance" -Color Yellow, Cyan
    Write-Color -Text "[S] ", "Change SQL Server, currently set to ", $LocalSQLInstance -Color Yellow, Cyan, Green
    Write-Color -Text "[A] ", "Update Count" -Color Yellow, Cyan
    Write-Color -Text "[1] ", "Update spDeleteUpdate procedure" -Color Yellow, Cyan #https://docs.microsoft.com/en-US/troubleshoot/mem/configmgr/spdeleteupdate-slow-performance
    Write-Color -Text "[2] ", "Shrink Files" -Color Yellow, Cyan
    Write-Color -Text "[3] ", "Shrink Database" -Color Yellow, Cyan
    Write-Color -Text "[4] ", "Reindex and Update Statistics" -Color Yellow, Cyan
    Write-Color -Text "[5] ", "Cleanup Sync History" -Color Yellow, Cyan
    Write-Color -Text "[6] ", "Cleanup Superseded Updates Older than x Days" -Color Yellow, Cyan
    Write-Color -Text "[7] ", "Cleanup Obsolete Updates" -Color Yellow, Cyan
    Write-Color -Text "[8] ", "WSUS Cleanup Wizard" -Color Yellow, Cyan
    Write-Color -Text "[9] ", "Cleanup Declined" -Color Yellow, Cyan
    Write-Color -Text "[10] ", "Shrink Files" -Color Yellow, Cyan
    Write-Color -Text "[11] ", "Shrink Database" -Color Yellow, Cyan
    Write-Color -Text "[12] ", "Reindex and Update Statistics" -Color Yellow, Cyan { {} }
    Write-Color -Text "[RA] ", "Run all above steps sequentially" -Color Yellow, Cyan
    Write-Host
    Write-Color -Text "[Q] ", "Quit" -Color Yellow, Cyan
    Write-Host
    
}
function Test-SQLModuleInstalled {
    ##############################################
    # Checking to see if the SqlServer module is already installed; if not, installing it for the current user
    ##############################################
    $SQLModuleCheck = (Get-Module -ListAvailable SqlServer).Version.Major
    if ($SQLModuleCheck -notin 22) {
        Write-Host "SqlServer Module Not Found - Installing" 
        # Not installed, trusting PS Gallery to remove prompt on install
        Write-log -Message "SQLServer module is not installed, trusting PS Gallery for install." -severity 1 -component "SQL Check"
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
        # Installing module
        Write-log -Message "SqlServer Module Not Found - Installing" -severity 1 -component "SQL Check"        
        Install-Module -Name SqlServer -Scope AllUsers -Confirm:$false -AllowClobber -Force -Verbose -MinimumVersion 22.1.1
        Write-log -Message "SqlServer Module Installed" -severity 1 -component "SQL Check"
    }
    ##############################################
    # Importing the SqlServer module
    ##############################################
    Write-log -Message "Importing SQL Server Module" -severity 1 -component "SQL Check"
    Import-Module SqlServer -MinimumVersion 22.1.1 -Force
}

#Region Initialize
#Check if running as admin
$admin = ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544')
if ($admin -ne 'True') {
    Write-Host "`nMust run PowerShell as administrator.`n" -ForegroundColor Yellow
    Exit
}
else {
    #Region LogCheck
    $ScriptLocation = Get-Location
    $LogFile = "$ScriptLocation\SUSDB-Maintenance.log"
    If ( -not (Test-Path -Path $LogFile -PathType Leaf)) {
        try {
            $null = New-Item -ItemType File -Path $LogFile -Force -ErrorAction Stop
            Write-Host "The file [$LogFile] has been created."
            Invoke-Expression $LogFile
        }
        catch {
            throw $_.Exception.Message
        }
    }
    else {
        Write-Host "Log file [$LogFile] already existed."
        Invoke-Expression $LogFile
    }
    #EndRegion LogCheck

    Write-Host "Checking SQL Module" -ForegroundColor Green
    Test-SQLModuleInstalled
    
}
#EndRegion Initialize

#Region ShowMenu
do {
    Show-Menu -Title 'SUSDB Maintenance'
    $selection = Read-Host "Please make a selection"
    switch ($selection) {
        'S' {
            #Change SQL Server
            ChangeSQL
            
        }'A' {
            #Update Count
            UpdateCount

        }'1' {
            #Update spDeleteUpdate procedure --> https://docs.microsoft.com/en-US/troubleshoot/mem/configmgr/spdeleteupdate-slow-performance
            Update_spDeleteUpdate_Procedure

        }'2' {
            #Shrink Files
            ShrinkFile
        }'3' {
            #Shrink Database
            ShrinkDatabase
 
        }'4' {
            #Reindex and Update Statistics
            ReindexStatistics
            
        }'5' {
            #Cleanup Sync History
            CleanUpSyncHistory

        }'6' {
            #Cleanup Superseded Updates
            Write-Host "Specify the number of days between today and the release date for which the superseded updates must not be declined.`nThis should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.`n"
            $Global:DaysSupersededNotDeclined = Read-Host -Prompt 'Days '
            
            if ($Global:DaysSupersededNotDeclined -gt 0 -and $Global:DaysSupersededNotDeclined -le 99) {
                Write-log -Message "Number of days entered :  $Global:DaysSupersededNotDeclined , proceeding with cleaning up superseded updates." -severity 1 -component "Cleanup Superseded Updates"
                CleanupSupersedUpdates 
            }
            else {
                Write-Host "`nInvalid entry, must be between 1-99.`n" -ForegroundColor Red
                Write-log -Message "Number of days entered [$Global:DaysSupersededNotDeclined] is invalid, must be between 1-99." -severity 3 -component "Cleanup Superseded Updates"                
            }
            

        }'7' {
            #Cleanup Obsolete Updates
            CleanupObsoleteUpdates

        }'8' {
            #WSUS Cleanup Wizard
            WSUSCleanUpWizard                 
            
        }'9' {
            #Cleanup Declined
            CleanUpDeclined

        }'10' {
            #Shrink File
            ShrinkFile
        }'11' {
            #Shrink Database
            ShrinkDatabase
 
        }'12' {
            #Reindex and Update Statistics
            ReindexStatistics
            
        }'RA' {
            Write-log -Message "--> Begin run all" -severity 1 -component "Run All"
            
            Write-Host "Specify the number of days between today and the release date for which the superseded updates must not be declined.`nThis should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.`n"
            $Global:DaysSupersededNotDeclined = Read-Host -Prompt 'Days '
            
            if ($Global:DaysSupersededNotDeclined -gt 0 -and $Global:DaysSupersededNotDeclined -le 99) {
                Write-log -Message "Number of days entered :  $Global:DaysSupersededNotDeclined , proceeding with cleaning up superseded updates." -severity 1 -component "Run All"                
            }
            else {
                Write-Host "`nInvalid entry, must be between 1-99.`n" -ForegroundColor Red
                Write-log -Message "Number of days entered [$Global:DaysSupersededNotDeclined] is invalid, must be between 1-99." -severity 3 -component "Run All"
                Exit
            }

            UpdateCount
            Update_spDeleteUpdate_Procedure
            ShrinkFile
            ShrinkDatabase
            ReindexStatistics
            CleanUpSyncHistory
            CleanupSupersedUpdates
            CleanupObsoleteUpdates
            WSUSCleanUpWizard
            CleanUpDeclined
            ShrinkFile
            ShrinkDatabase
            ReindexStatistics
            UpdateCount
            Write-log -Message "--> End run all" -severity 1 -component "Run All"
            
        }'q' {
            Write-Host
            Write-Host "Have a nice day!`n" -ForegroundColor Yellow
        }
        default {
            Write-Host
            Write-Host "You didn't make a valid selection.`n" -ForegroundColor Red            
        }
    }

    Pause
}
until ($selection -eq 'q')
#EndRegion ShowMenu
```
