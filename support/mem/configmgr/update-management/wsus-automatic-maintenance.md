---
title: Manual and automatic WSUS database maintenance
description: Describes steps and scripts to automatically or manually maintain the Windows Server Update Services (WSUS) database.
ms.reviewer: daschuh
ms.date: 09/01/2026
ai-usage: ai-assisted
ms.custom: sap:Software Update Management (SUM)\WSUS Database Maintenance
---
# Maintain the Windows Server Update Services (WSUS) database manually or automatically

## Summary

This article describes how to maintain the Windows Server Update Services (WSUS) database (SUSDB) manually or automatically. Over time, SUSDB accumulates superseded, expired, and obsolete updates that can degrade synchronization performance, slow down the WSUS console, and cause scan failures on client computers. Follow these concise steps and scripts to assess SUSDB health and keep your update management infrastructure running efficiently.

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
> - Run the steps on each WSUS server in the hierarchy. When you clean up and remove items from WSUS servers, start at the lowest level of the hierarchy.
> - Ensure that you disable any scheduled synchronizations, either in Configuration Manager (if used) or on standalone WSUS servers.

The following steps can resolve many issues with scanning and synchronization. If there are a large number of declined updates, you might need to repeat steps 9 through 12 multiple times. After each run, execute the [SQL query](#query-to-obtain-the-update-count) to confirm that the update count is decreasing. Steps 8 and 9 might result in errors each time, which is expected. Therefore, you need to repeat steps 9 through 12 multiple times. Some steps (especially step 9) might take several hours to complete.

1. Run the SQL script described in [Slow performance of the spDeleteUpdate procedure](spdeleteupdate-slow-performance.md).
1. Shrink the SUSDB files.
1. Shrink the SUSDB database.
1. Reindex and update statistics on SUSDB.

   1. To reindex SUSDB, run the following SQL script:

      ```sql
      EXEC sp_MSforeachtable @command1="SET QUOTED_IDENTIFIER ON;ALTER INDEX ALL ON ? REBUILD;"
      ```

   1. To update statistics, run the following SQL script:

      ```sql
      Exec sp_msforeachtable "UPDATE STATISTICS ? WITH FULLSCAN, COLUMNS" 
      ```

1. Clean up the synchronization history.

   > [!NOTE]
   > If there are a large number of synchronizations, the WSUS console might crash.

   ```sql
   USE SUSDB 
   GO 
   DELETE FROM tbEventInstance WHERE EventNamespaceID = '2' AND EVENTID IN ('381', '382', '384', '386', '387', '389')
   ```

1. Clean up superseded updates that are older than 30 days or that match your specific configuration.

   > [!NOTE]
   >
   > - The value of `30` in the first line indicates the number of days between today and the release date, during which superseded updates shouldn't be marked as declined.
   > - In Configuration Manager, this value should align with the [supersedence rules](/mem/configmgr/sum/plan-design/plan-for-software-updates#BKMK_SupersedenceRules) that you configure in the software update point (SUP) component properties.
   > - On standalone WSUS servers, specify the number of days you want to retain superseded updates. For example, set the value to `60` instead of `30` to keep two months of superseded updates. Any updates that are older than this period are marked as declined and cleaned up.

   ```sql
   DECLARE @thresholdDays INT = 30   -- Specify the number of days between today and the release date during which superseded updates should not be marked as declined. If Configuration Manager is being used with WSUS, this value should match the configuration of supersedence rules in the software update point (SUP) component properties.
   DECLARE @testRun BIT = 0        -- Set this value to 1 to test without declining anything. 
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

1. Clean up obsolete updates.

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

1. From an elevated Windows PowerShell prompt, run the following script to start the WSUS Cleanup wizard:

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

1. From an elevated Windows PowerShell prompt, run the following script to clean up declined updates:

   ```powershell
   [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
   $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer();
   $wsus.GetUpdates() | Where {$_.IsDeclined -eq $true} | ForEach-Object {$wsus.DeleteUpdate($_.Id.UpdateId.ToString()); Write-Host $_.Title removed } 
   ```

1. Shrink the SUSDB files.
1. Shrink the SUSDB database.
1. Reindex and update statistics on SUSDB.

   1. To reindex SUSDB, run the following SQL script:

      ```sql
      EXEC sp_MSforeachtable @command1="SET QUOTED_IDENTIFIER ON;ALTER INDEX ALL ON ? REBUILD;"
      ```

   1. To update statistics, run the following SQL script:

      ```sql
      Exec sp_msforeachtable "UPDATE STATISTICS ? WITH FULLSCAN, COLUMNS"
      ```

## Maintain the WSUS database (SUSDB) automatically

The following PowerShell script replicates the manual steps. When you run the script, it creates and opens a SUSDB-Maintenance.log file.

> [!IMPORTANT]
> Ensure that you disable any scheduled synchronizations, either in Configuration Manager (if used) or on standalone WSUS servers.

```powershell
<# SUSDB-Maintenance

Version 2.8
Last Update: 08/10/2026

Requirements
* WID must be local.
* Remote connections for SQL now supported, choose [S] Change SQL Server from menu to set the SQL Server.
* WSUS Console must be installed local.
* No longer requires SQL Server PowerShell Module - uses native .NET SqlClient.
* Runs on Windows PowerShell 5.1 and PowerShell 7. The WSUS API is .NET Framework only, so on PowerShell 7 steps [6], [8] and [9] relay that work to powershell.exe.
* SUSDB-Maintenance.log rolls over to SUSDB-Maintenance.lo_ once it passes 5 MB.
* Set $Global:TrustServerCertificate to $false where the SQL Server certificate is already trusted by this machine.
* WSUS replica mode blocks declines and cleanup. Steps [6], [8] and [9] detect it, temporarily disable it and restore it when the step ends.
  [RA] holds a single window open across those steps instead of toggling the setting for each one.
  Replica mode is read and written through the local WSUS console API, not SUSDB.
  Set $Global:AutoDisableReplicaMode to $false to leave replica mode alone and only warn.

This script will present the following menu options for performing SUSDB Maintenance.  SUSDB-Maintenance.log will be created and opened when the script is run.

[S] Change SQL Server, currently set to 
[M] Toggle MaxXMLPerRequest, currently set to 
[D] Delete Test Detectoids

[A] Update Count
[1] Update spDeleteUpdate procedure
[2] Shrink Files
[3] Shrink Database
[4] Reindex and Update Statistics
[5] Cleanup Sync History
[6] Cleanup Superseded Updates Older than x Months
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
$Global:ScriptVersion = '2.8'
$Global:LogFile = $null
$Global:progresspreference = 'SilentlyContinue'
# Expressed in months to match the supersedence rule in ConfigMgr SUP component properties.
$Global:MonthsSupersededNotDeclined = 3
$Global:MaxXMLDefault = 5242880
# Cached MaxXMLPerRequest so the menu does not query SQL on every redraw. Null means "re-read".
$Global:MaxXMLCache = $null
# Tracks that the read was attempted, so an unreachable server is not retried on every redraw.
$Global:MaxXMLChecked = $false
$Global:TestDetectoidPattern = 'Product Detectoid for ProductName TestProduct%'
# Set to $false to warn about replica mode but never change it.
$Global:AutoDisableReplicaMode = $true
# Nesting depth of the current replica mode window, so Run All toggles the setting once rather than per step.
$Global:ReplicaModeDepth = 0
$Global:ReplicaModeRestore = $false
# Resume-ReplicaMode runs from a finally block, so it flags a failed restore here instead of throwing over the step's own exception.
$Global:ReplicaModeRestoreFailed = $false
# CMTrace and OneTrace skip lines whose thread or file attribute is empty, so both are always populated.
$Global:LogSourceFile = 'SUSDB-Maintenance.ps1'
# BOM-less UTF8 - Out-File -Encoding utf8 on 5.1 emits a BOM that shows up as ??? in the log viewer.
$Global:LogEncoding = New-Object System.Text.UTF8Encoding($false)
# Standard-time bias only, so it cannot change mid-run - read once rather than on every log line.
$Global:TimeZoneBias = (Get-CimInstance -ClassName Win32_TimeZone).Bias
# Set to $false where the SQL Server presents a certificate this machine already trusts.
$Global:TrustServerCertificate = $true
# Microsoft.UpdateServices.Administration is .NET Framework only - on PowerShell 7 it fails with
# "The requested security protocol is not supported", so WSUS API work is relayed to Windows PowerShell.
$Global:WindowsPowerShellPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

$ErrorActionPreference = "Stop"

try {
    $SQLsetup = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Update Services\Server\Setup' -Name SqlServerName).SqlServerName
}
catch {
    $SQLsetup = $null
}

# -like rather than -contains: the registry value can be server-qualified, and -contains on a string is exact equality.
if ($SQLsetup -like "*MICROSOFT##WID*") {
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

$CleanupSyncHistory = "USE SUSDB;
DELETE FROM tbEventInstance WHERE EventNamespaceID = '2' AND EVENTID IN ('381', '382', '384', '386', '387', '389');"

$UpdateCountQuery = "use SUSDB;
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

$GetMaxXML = "USE SUSDB;
SELECT MaxXMLPerRequest FROM tbConfigurationC;"

$CountTestDetectoids = "USE SUSDB;
SELECT COUNT(*) AS MatchCount
FROM dbo.tbUpdate u
JOIN dbo.tbRevision r ON r.LocalUpdateID = u.LocalUpdateID AND r.IsLatestRevision = 1
JOIN dbo.tbProperty p ON p.RevisionID = r.RevisionID
JOIN dbo.tbLocalizedPropertyForRevision tbrp ON tbrp.RevisionID = r.RevisionID
JOIN dbo.tbLocalizedProperty tlp ON tlp.LocalizedPropertyID = tbrp.LocalizedPropertyID
WHERE p.UpdateType = 'Detectoid'
  AND tbrp.LanguageID = p.DefaultPropertiesLanguageID
  AND tlp.Title LIKE '$Global:TestDetectoidPattern';"

# Deletes the test detectoids via the supported dbo.spDeleteUpdateByUpdateID.
# Detectoids still referenced by other updates raise an error - those are caught and skipped.
# Ends with a SELECT so the deleted/skipped counts are returned to the caller.
$DeleteTestDetectoidsSql = "USE SUSDB;
SET NOCOUNT ON;

DECLARE @updateID uniqueidentifier;
DECLARE @retcode  int;
DECLARE @deleted  int = 0;
DECLARE @skipped  int = 0;

DECLARE detectoid_cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT u.UpdateID
    FROM dbo.tbUpdate u
    JOIN dbo.tbRevision r ON r.LocalUpdateID = u.LocalUpdateID AND r.IsLatestRevision = 1
    JOIN dbo.tbProperty p ON p.RevisionID = r.RevisionID
    JOIN dbo.tbLocalizedPropertyForRevision tbrp ON tbrp.RevisionID = r.RevisionID
    JOIN dbo.tbLocalizedProperty tlp ON tlp.LocalizedPropertyID = tbrp.LocalizedPropertyID
    WHERE p.UpdateType = 'Detectoid'
      AND tbrp.LanguageID = p.DefaultPropertiesLanguageID
      AND tlp.Title LIKE '$Global:TestDetectoidPattern';

OPEN detectoid_cur;
FETCH NEXT FROM detectoid_cur INTO @updateID;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRY
        EXEC @retcode = dbo.spDeleteUpdateByUpdateID @updateID;
        IF @retcode = 0 SET @deleted += 1; ELSE SET @skipped += 1;
    END TRY
    BEGIN CATCH
        SET @skipped += 1;
        PRINT CONCAT('Skipped ', CONVERT(varchar(40), @updateID), ' : ', ERROR_MESSAGE());
    END CATCH

    FETCH NEXT FROM detectoid_cur INTO @updateID;
END

CLOSE detectoid_cur;
DEALLOCATE detectoid_cur;

PRINT CONCAT('Detectoids deleted: ', @deleted, '  |  skipped/referenced: ', @skipped);
SELECT @deleted AS Deleted, @skipped AS Skipped;"
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
 
    $Date = Get-Date -Format "HH:mm:ss.fff"
    $Date2 = Get-Date -Format "MM-dd-yyyy"    
 
    $Line = "<![LOG[$Message]LOG]!><time=$([char]34)$date$($Global:TimeZoneBias)$([char]34) date=$([char]34)$date2$([char]34) component=$([char]34)$component$([char]34) context=$([char]34)$([char]34) type=$([char]34)$severity$([char]34) thread=$([char]34)$PID$([char]34) file=$([char]34)$Global:LogSourceFile$([char]34)>"

    # Every catch block in this script logs, so a locked or unwritable log must not throw back at the caller.
    try {
        [System.IO.File]::AppendAllText($Path, $Line + [Environment]::NewLine, $Global:LogEncoding)
    }
    catch {
        Write-Host "Unable to write to log [$Path]: $($_.Exception.Message)" -ForegroundColor DarkYellow
    }

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

function Format-Elapsed([TimeSpan]$Span) {
    # 'c' keeps the day component, which hh\:mm\:ss silently drops on runs over 24 hours.
    return [timespan]::FromSeconds([math]::Round($Span.TotalSeconds)).ToString('c')
}

function Get-SqlConnectionString {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ServerInstance,

        [Parameter(Mandatory = $false)]
        [string]$Database,

        [Parameter(Mandatory = $false)]
        [int]$ConnectTimeout = 15
    )

    $trustCert = if ($Global:TrustServerCertificate) { 'True' } else { 'False' }

    if ($ServerInstance -like '*pipe*') {
        # WID connection
        return "Server=np:$ServerInstance;Database=SUSDB;Integrated Security=True;TrustServerCertificate=$trustCert;Connect Timeout=$ConnectTimeout;"
    }

    if ($Database) {
        return "Server=$ServerInstance;Database=$Database;Integrated Security=True;TrustServerCertificate=$trustCert;Connect Timeout=$ConnectTimeout;"
    }

    return "Server=$ServerInstance;Integrated Security=True;TrustServerCertificate=$trustCert;Connect Timeout=$ConnectTimeout;"
}

function Test-SqlInstance {
    <#
    .SYNOPSIS
    Opens and closes a connection so a bad server name fails in seconds instead of stalling the menu.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$ServerInstance,

        [Parameter(Mandatory = $false)]
        [int]$TimeoutSeconds = 5
    )

    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = Get-SqlConnectionString -ServerInstance $ServerInstance -Database 'SUSDB' -ConnectTimeout $TimeoutSeconds

    try {
        $connection.Open()
        return $true
    }
    catch {
        Write-Host "Connection failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-log -Message "Connection test to [$ServerInstance] failed: $($_.Exception.Message)" -severity 3 -component "Change SQL"
        return $false
    }
    finally {
        $connection.Dispose()
    }
}

function Invoke-CustomSqlCommand {
    <#
    .SYNOPSIS
    Executes SQL commands without requiring SQL Server PowerShell module
    
    .PARAMETER ServerInstance
    SQL Server instance name (can be pipe name for WID)
    
    .PARAMETER Query
    SQL query to execute
    
    .PARAMETER Database
    Database name (optional)
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$ServerInstance,
        
        [Parameter(Mandatory = $true)]
        [string]$Query,
        
        [Parameter(Mandatory = $false)]
        [string]$Database
    )
    
    $startTime = Get-Date
    # A List mutated via Add() avoids the event handler having to reassign a captured variable.
    $infoMessages = [System.Collections.Generic.List[string]]::new()
    $sqlErrors = [System.Collections.Generic.List[string]]::new()
    
    try {
        # Create connection
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = Get-SqlConnectionString -ServerInstance $ServerInstance -Database $Database
        
        # Add event handler for info messages (PRINT statements, etc.)
        # FireInfoMessageEventOnUserErrors below sends severity 11-16 errors here instead of throwing,
        # so separate them out by Class rather than letting them pass as ordinary PRINT output.
        $connection.add_InfoMessage({
            param($eventSender, $eventArgs)
            foreach ($sqlError in $eventArgs.Errors) {
                if ($sqlError.Class -ge 11) {
                    $sqlErrors.Add("Msg $($sqlError.Number), Level $($sqlError.Class), State $($sqlError.State), Line $($sqlError.LineNumber): $($sqlError.Message)")
                }
            }
            $infoMessages.Add($eventArgs.Message)
        }.GetNewClosure())
        
        $connection.FireInfoMessageEventOnUserErrors = $true
        $connection.Open()
        
        # Split query by GO statements (batch separator)
        $batches = $Query -split '\r?\nGO\r?\n|\r?\nGO$|^GO\r?\n' | Where-Object { $_.Trim() -ne '' }
        
        $lastResultSet = $null
        
        foreach ($batch in $batches) {
            $trimmedBatch = $batch.Trim()
            if ($trimmedBatch -eq '' -or $trimmedBatch -eq 'GO') {
                continue
            }
            
            # Create command
            $command = $connection.CreateCommand()
            $command.CommandText = $trimmedBatch
            $command.CommandTimeout = 0 # No timeout
            
            # Execute and capture results
            $reader = $command.ExecuteReader()
            
            # Read all result sets from this batch
            do {
                $dataTable = New-Object System.Data.DataTable
                $dataTable.Load($reader)
                
                if ($dataTable.Rows.Count -gt 0) {
                    $lastResultSet = $dataTable
                }
            } while (!$reader.IsClosed)
            
            $reader.Close()
        }
        
        # Calculate execution time
        $endTime = Get-Date
        $executionTime = ($endTime - $startTime).TotalMilliseconds

        if ($sqlErrors.Count -gt 0) {
            Write-Host "SQL reported $($sqlErrors.Count) error(s) - failing this step. See the log." -ForegroundColor Red
            Write-log -Message "SQL reported $($sqlErrors.Count) error(s) of severity 11-16. Failing the operation so callers can detect it." -severity 3 -component "SQL"

            if ($sqlErrors -match 'replica mode') {
                Write-Host "`n*************************************************************" -ForegroundColor Red
                Write-Host "*** WSUS REPLICA MODE DETECTED" -ForegroundColor Red
                Write-Host "*** SQL rejected the work with 'Cannot perform this action" -ForegroundColor Red
                Write-Host "*** when the server is in replica mode'. Nothing was changed." -ForegroundColor Red
                Write-Host "*************************************************************`n" -ForegroundColor Red
                Write-log -Message "WSUS REPLICA MODE DETECTED - SQL rejected the operation ('Cannot perform this action when the server is in replica mode'). No changes were made by this step." -severity 3 -component "SQL"
            }

            # Sample only - a single cleanup pass can raise the same error thousands of times.
            foreach ($sqlErrorText in ($sqlErrors | Sort-Object -Unique | Select-Object -First 5)) {
                Write-log -Message "SQL: $sqlErrorText" -severity 3 -component "SQL"
            }

            throw "SQL execution failed with $($sqlErrors.Count) error(s) of severity 11-16. First error: $($sqlErrors[0])"
        }
        
        # Create return object with statistics
        $result = [PSCustomObject]@{
            Results = $lastResultSet
            ExecutionTime = $executionTime
            RowsAffected = if ($lastResultSet) { $lastResultSet.Rows.Count } else { 0 }
            InfoMessages = $infoMessages
            SqlErrors = $sqlErrors
        }
        
        return $result
    }
    finally {
        if ($connection.State -eq 'Open') {
            $connection.Close()
        }
    }
}

function Invoke-WsusApi {
    <#
    .SYNOPSIS
    Runs WSUS API script text in process on Windows PowerShell, or through powershell.exe on PowerShell 7.

    .DESCRIPTION
    Every body emits plain text rather than objects, so both paths behave identically and long
    operations keep streaming their progress to the caller.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Body
    )

    # 'Stop' turns non-terminating WSUS API errors into failures instead of output that the caller mistakes for success.
    $prologue = "`$ErrorActionPreference = 'Stop'`r`n[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.UpdateServices.Administration')`r`n"

    if ($PSVersionTable.PSEdition -ne 'Core') {
        # & gives the scriptblock its own scope, so the preference does not leak back into the caller.
        & ([scriptblock]::Create($prologue + $Body))
        return
    }

    if (-not (Test-Path -Path $Global:WindowsPowerShellPath -PathType Leaf)) {
        throw "PowerShell 7 cannot call the WSUS API and Windows PowerShell was not found at [$Global:WindowsPowerShellPath]."
    }

    # powershell.exe still exits 0 after an unhandled error, so the relayed script has to set the exit code itself.
    $script = @"
$prologue
try {
$Body
}
catch {
    Write-Output "WSUS API call failed: `$(`$_.Exception.Message)"
    exit 1
}
"@

    $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($script))
    & $Global:WindowsPowerShellPath -NoProfile -NonInteractive -EncodedCommand $encoded 2>&1 | ForEach-Object { [string]$_ }

    if ($LASTEXITCODE -ne 0) {
        throw "The Windows PowerShell relay for the WSUS API exited with code $LASTEXITCODE - see the output above."
    }
}

function Get-ReplicaMode {
    # Replica mode is not exposed as a SUSDB column, so it has to come from the WSUS API.
    try {
        $output = @(Invoke-WsusApi -Body '[Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer().GetConfiguration().IsReplicaServer')
        $value = $output | Where-Object { $_ -match '^(True|False)$' } | Select-Object -Last 1

        if ($null -eq $value) {
            throw "Unexpected output from the WSUS API: $($output -join ' ')"
        }

        return [bool]::Parse([string]$value)
    }
    catch {
        Write-log -Message "Unable to read replica mode from the WSUS API: $($_.Exception.Message)" -severity 2 -component "Replica Mode"
        return $null
    }
}

function Set-ReplicaMode {
    param(
        [Parameter(Mandatory = $true)]
        [bool]$Enabled
    )

    $value = if ($Enabled) { '$true' } else { '$false' }

    $null = Invoke-WsusApi -Body @"
`$config = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer().GetConfiguration()
`$config.IsReplicaServer = $value
`$config.Save()
"@
}

function Invoke-WithoutReplicaMode {
    <#
    .SYNOPSIS
    Runs a step with WSUS replica mode turned off, then puts the original setting back.

    .DESCRIPTION
    A replica server refuses declines and cleanup ("Cannot perform this action when the server is
    in replica mode"). Replica mode is restored in a finally block so it survives a failed step.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [scriptblock]$Action,

        [Parameter(Mandatory = $true)]
        [string]$Component
    )

    Suspend-ReplicaMode -Component $Component

    try {
        & $Action
    }
    finally {
        Resume-ReplicaMode -Component $Component
    }
}

function Suspend-ReplicaMode {
    <#
    .SYNOPSIS
    Turns WSUS replica mode off and records whether Resume-ReplicaMode has to turn it back on.

    .DESCRIPTION
    Calls are nested by depth, so Run All can hold one window open across the whole cleanup block
    while the steps inside it call Invoke-WithoutReplicaMode without toggling replica mode again.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Component
    )

    $Global:ReplicaModeDepth++
    if ($Global:ReplicaModeDepth -gt 1) {
        Write-log -Message "Replica mode window is already open - leaving the setting alone for this step." -severity 1 -component $Component
        return
    }

    $wasReplica = Get-ReplicaMode

    if ($null -eq $wasReplica) {
        Write-Host "Unable to read the replica mode setting from WSUS - continuing without changing it." -ForegroundColor Yellow
        Write-log -Message "Unable to read replica mode - continuing without changing it. If this server is a replica the step will fail." -severity 2 -component $Component
        return
    }

    if (-not $wasReplica) {
        return
    }

    Write-Host "`n*************************************************************" -ForegroundColor Yellow
    Write-Host "*** WSUS REPLICA MODE DETECTED - this server is a replica." -ForegroundColor Yellow
    Write-Host "*** Declines and cleanup are blocked while replica mode is on." -ForegroundColor Yellow
    if ($Global:AutoDisableReplicaMode) {
        Write-Host "*** Temporarily disabling replica mode - it is re-enabled" -ForegroundColor Yellow
        Write-Host "*** automatically once the affected steps have finished." -ForegroundColor Yellow
    }
    else {
        Write-Host "*** AutoDisableReplicaMode is off - this step will likely fail." -ForegroundColor Yellow
    }
    Write-Host "*************************************************************`n" -ForegroundColor Yellow
    Write-log -Message "WSUS REPLICA MODE DETECTED (IsReplicaServer = True)." -severity 2 -component $Component

    if (-not $Global:AutoDisableReplicaMode) {
        Write-log -Message "AutoDisableReplicaMode is disabled - replica mode left enabled." -severity 2 -component $Component
        return
    }

    try {
        Set-ReplicaMode -Enabled $false
        $Global:ReplicaModeRestore = $true
        Write-Host "Replica mode temporarily disabled.`n" -ForegroundColor Cyan
        Write-log -Message "Replica mode temporarily disabled." -severity 2 -component $Component
    }
    catch {
        Write-Host "Failed to disable replica mode: $($_.Exception.Message)" -ForegroundColor Red
        Write-log -Message "Failed to disable replica mode: $($_.Exception.Message)" -severity 3 -component $Component
    }
}

function Resume-ReplicaMode {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Component
    )

    if ($Global:ReplicaModeDepth -le 0) {
        return
    }

    $Global:ReplicaModeDepth--
    if ($Global:ReplicaModeDepth -gt 0 -or -not $Global:ReplicaModeRestore) {
        return
    }

    try {
        Set-ReplicaMode -Enabled $true
        $Global:ReplicaModeRestore = $false
        $Global:ReplicaModeRestoreFailed = $false
        Write-Host "`nReplica mode re-enabled.`n" -ForegroundColor Cyan
        Write-log -Message "Replica mode re-enabled." -severity 2 -component $Component
    }
    catch {
        # Leaving a replica server out of replica mode changes how it syncs, so this must be impossible to miss.
        # Keep ReplicaModeRestore = $true so a later replica-mode window can retry the restore.
        # Throwing here would run from a finally block and mask the step's own exception, so the caller reads the flag instead.
        $Global:ReplicaModeRestoreFailed = $true
        Write-Host "`n*************************************************************" -ForegroundColor Red
        Write-Host "*** REPLICA MODE COULD NOT BE RE-ENABLED" -ForegroundColor Red
        Write-Host "*** $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "*** Re-enable it manually: WSUS console > Options >" -ForegroundColor Red
        Write-Host "*** Update Source and Proxy Server > This server is a replica." -ForegroundColor Red
        Write-Host "*************************************************************`n" -ForegroundColor Red
        Write-log -Message "FAILED to re-enable replica mode: $($_.Exception.Message). Re-enable it manually in the WSUS console (Options > Update Source and Proxy Server)." -severity 3 -component $Component
    }
}

function UpdateCount {

Write-log -Message "--> Begin Update Count" -severity 1 -component "Update Count"      
    Write-log -Message "Update Count" -severity 1 -component "Update Count"

$result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $UpdateCountQuery
    
    if ($result.Results -and $result.Results.Rows.Count -gt 0) {
        $SQLoutput = $result.Results.Rows[0]
        
        Write-log -Message ("Total execution time for Update Count.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Update Count"
        Write-log -Message ("Total Updates " + $SQLoutput.'Total Updates') -severity 1 -component "Update Count"
        Write-log -Message ("Live Updates " + $SQLoutput.'Live Updates') -severity 1 -component "Update Count"
        Write-log -Message ("Superseded " + $SQLoutput.'Superseded') -severity 1 -component "Update Count"
        Write-log -Message ("Superseded but not declined " + $SQLoutput.'Superseded but not declined') -severity 1 -component "Update Count"
        Write-log -Message ("Declined " + $SQLoutput.'Declined') -severity 1 -component "Update Count"
        Write-log -Message ("Superseded and Declined " + $SQLoutput.'Superseded and Declined') -severity 1 -component "Update Count"
        Write-log -Message ("Obsolete Updates Needed to be cleaned " + $SQLoutput.'Obsolete Updates Needed to be cleaned') -severity 1 -component "Update Count"
    }
    else {
        Write-log -Message "No results returned from Update Count query" -severity 2 -component "Update Count"
    }
    
    Write-log -Message "--> End Update Count" -severity 1 -component "Update Count"
}

function Update_spDeleteUpdate_Procedure {

Write-log -Message "--> Begin update spDeleteUpdate procedure" -severity 1 -component "Update spDeleteUpdate"
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $spDeleteUpdate
    Write-log -Message ("Total execution time.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Update spDeleteUpdate"
    Write-log -Message "--> End update spDeleteUpdate procedure" -severity 1 -component "Update spDeleteUpdate"
}

function ShrinkFile {

Write-log -Message "--> Begin shrink file" -severity 1 -component "Shrink File"            
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $Spaceused
    $SQLoutput = $result.Results
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Shrink File"
    
    if ($SQLoutput -and $SQLoutput.Rows.Count -gt 1) {
        Write-log -Message ($SQLoutput.Rows[1].name + " " + $SQLoutput.Rows[1]."Size (MB)" + " MB") -severity 1 -component "Shrink Files"
    }

$result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $Shrinkfile
    Write-log -Message ("Total execution time for Shrinking File.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Shrink File"    
    
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $Spaceused
    $SQLoutput = $result.Results
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Shrink File"
    
    if ($SQLoutput -and $SQLoutput.Rows.Count -gt 1) {
        Write-log -Message ($SQLoutput.Rows[1].name + " " + $SQLoutput.Rows[1]."Size (MB)" + " MB") -severity 1 -component "Shrink File"
    }
    
    Write-log -Message "--> End shrink file" -severity 1 -component "Shrink File"
}

function ShrinkDatabase {

Write-log -Message "--> Begin shrink database" -severity 1 -component "Shrink Database"
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $Spaceused
    $SQLoutput = $result.Results
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Shrink Database"
    
    if ($SQLoutput -and $SQLoutput.Rows.Count -gt 0) {
        Write-log -Message ($SQLoutput.Rows[0].name + " " + $SQLoutput.Rows[0]."Size (MB)" + " MB") -severity 1 -component "Shrink Database"
    }
    
    Write-log -Message "--> Begin shrink database" -severity 1 -component "Shrink Database"
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $ShrinkDatabase
    Write-log -Message ("Total execution time for Shrinking Database.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Shrink Database"
    
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $Spaceused
    $SQLoutput = $result.Results
    Write-log -Message ("Total execution time for checking Space Used.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Shrink Database"
    
    if ($SQLoutput -and $SQLoutput.Rows.Count -gt 0) {
        Write-log -Message ($SQLoutput.Rows[0].name + " " + $SQLoutput.Rows[0]."Size (MB)" + " MB") -severity 1 -component "Shrink Database"
    }
    
    Write-log -Message "--> End shrink database" -severity 1 -component "Shrink Database"
}

function ReindexStatistics {

Write-log -Message "--> Begin reindex and update statistics" -severity 1 -component "IndexStats"
    Write-log -Message "Reindexing" -severity 1 -component "IndexStats"
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $Reindex
    Write-log -Message ("Total execution time for Reindex.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "IndexStats"

Write-log -Message "Now Updating Statistics" -severity 1 -component "IndexStats"
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $UpdateStatistics
    Write-log -Message ("Total execution time for Updating Statistics.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "IndexStats"    
    Write-log -Message "--> End reindex and update statistics" -severity 1 -component "IndexStats"

}

function CleanUpSyncHistory {

Write-log -Message "--> Begin cleanup sync history" -severity 1 -component "Cleanup Sync History"
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $CleanupSyncHistory
    Write-log -Message ("Total execution time for Cleaning up Sync History.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Cleanup Sync History"    
    Write-log -Message "--> End cleanup sync history" -severity 1 -component "Cleanup Sync History"
}

function CleanupSupersedUpdates {
    Write-log -Message "--> Begin cleanup superseded updates" -severity 1 -component "Cleanup Superseded Updates"

    # The query works in days, so convert against the real calendar rather than assuming 30-day months.
    $Now = Get-Date
    $ThresholdDays = [int]($Now - $Now.AddMonths(-$Global:MonthsSupersededNotDeclined)).TotalDays
    Write-log -Message "Months specified: $Global:MonthsSupersededNotDeclined ($ThresholdDays days, cutoff $($Now.AddMonths(-$Global:MonthsSupersededNotDeclined).ToString('MM-dd-yyyy')))" -severity 1 -component "Cleanup Superseded Updates"

$CleanupSupersededUpdates = "DECLARE @thresholdMonths INT = $Global:MonthsSupersededNotDeclined   -- Specify the number of months between today and the release date for which the superseded updates must not be declined. This should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.
DECLARE @thresholdDays INT = $ThresholdDays   -- Calendar-accurate day equivalent of @thresholdMonths, calculated by the script.
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
PRINT 'Declining superseded updates older than ' + CONVERT(NVARCHAR(5), @thresholdMonths) + ' months (' + CONVERT(NVARCHAR(10), @thresholdDays) + ' days).' + CHAR(10) 
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

    # spDeclineUpdate is called with @failIfReplica = 1, so replica mode has to be off for this to do anything.
    Invoke-WithoutReplicaMode -Component "Cleanup Superseded Updates" -Action {
        $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $CleanupSupersededUpdates -Database "SUSDB"
        Write-log -Message ("Total execution time for Cleaning up Superseded Updates.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Cleanup Superseded Updates"

        # Last PRINT from the query is the 'Attempted to decline N updates.' summary.
        if ($result.InfoMessages.Count -gt 0) {
            Write-log -Message ("SQL: " + $result.InfoMessages[-1]) -severity 1 -component "Cleanup Superseded Updates"
        }
    }

    Write-log -Message "--> End cleanup superseded updates" -severity 1 -component "Cleanup Superseded Updates"
}

function CleanupObsoleteUpdates {

Write-log -Message "--> Begin cleanup obsolete updates" -severity 1 -component "Cleanup Obsolete Updates"
    $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $CleanupObsoleteUpdates -Database "SUSDB"
    Write-log -Message ("Total execution time for Cleaning up Obsolete Updates.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Cleanup Obsolete Updates"
    Write-log -Message "--> End cleanup obsolete updates" -severity 1 -component "Cleanup Obsolete Updates"
}

function WSUSCleanUpWizard {

Write-log -Message "--> Begin WSUS cleanup wizard" -severity 1 -component "WSUS Cleanup Wizard"

    $CleanUpWizardBody = @'
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer()
$cleanupScope = New-Object Microsoft.UpdateServices.Administration.CleanupScope
$cleanupScope.DeclineSupersededUpdates = $true
$cleanupScope.DeclineExpiredUpdates = $true
$cleanupScope.CleanupObsoleteUpdates = $true
$cleanupScope.CompressUpdates = $true
$cleanupScope.CleanupObsoleteComputers = $true
$cleanupScope.CleanupUnneededContentFiles = $true
$result = $wsus.GetCleanupManager().PerformCleanup($cleanupScope)
"Disk Space Freed $($result.DiskSpaceFreed) MB"
"Expired Updates Declined $($result.ExpiredUpdatesDeclined)"
"Obsolete Computers Deleted $($result.ObsoleteComputersDeleted)"
"Obsolete Updates Deleted $($result.ObsoleteUpdatesDeleted)"
"Superseded Updates Declined $($result.SupersededUpdatesDeclined)"
"Updates Compressed $($result.UpdatesCompressed)"
'@

    # DeclineSupersededUpdates and DeclineExpiredUpdates are rejected while the server is a replica.
    Invoke-WithoutReplicaMode -Component "WSUS Cleanup Wizard" -Action {
        Invoke-WsusApi -Body $CleanUpWizardBody | ForEach-Object {
            Write-log -Message ([string]$_) -severity 1 -component "WSUS Cleanup Wizard"
        }
    }

    Write-log -Message "--> End WSUS cleanup wizard" -severity 1 -component "WSUS Cleanup Wizard"
}

function CleanUpDeclined {

Write-log -Message "--> Begin cleanup declined" -severity 1 -component "Cleanup Declined"

    # Emitted line by line so the parent can log and show progress while the deletes are still running.
    $CleanUpDeclinedBody = @'
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer()
$declined = @($wsus.GetUpdates() | Where-Object { $_.IsDeclined -eq $true })
"COUNT=$($declined.Count)"
foreach ($update in $declined) {
    try {
        $wsus.DeleteUpdate($update.Id.UpdateId)
        "REMOVED=$($update.Title)"
    }
    catch {
        "SKIPPED=$($update.Title)"
    }
}
'@

    # A replica takes its approvals from the upstream server and refuses update deletions.
    Invoke-WithoutReplicaMode -Component "Cleanup Declined" -Action {
        $total = 0
        $removed = 0
        $skipped = 0
        $processed = 0

        Write-Host "Retrieving updates from WSUS - this can take a long time..." -ForegroundColor Cyan

        Invoke-WsusApi -Body $CleanUpDeclinedBody | ForEach-Object {
            $line = [string]$_

            if ($line -like 'COUNT=*') {
                $total = [int]$line.Substring(6)
                Write-Host "Found $total declined update(s) to process." -ForegroundColor Cyan
                Write-log -Message "Declined updates found: $total" -severity 1 -component "Cleanup Declined"
                return
            }

            if ($line -like 'REMOVED=*') {
                $removed++
                Write-log -Message "Removed: $($line.Substring(8))" -severity 1 -component "Cleanup Declined"
            }
            elseif ($line -like 'SKIPPED=*') {
                $skipped++
                Write-log -Message "Skipped: $($line.Substring(8))" -severity 2 -component "Cleanup Declined"
            }
            else {
                return
            }

            $processed++

            # Every 50 keeps the console alive without emitting a line per update.
            if ($processed % 50 -eq 0) {
                Write-Host ("[{0}] {1} of {2} processed - {3} removed, {4} skipped" -f (Get-Date).ToString('MM-dd-yyyy HH:mm:ss'), $processed, $total, $removed, $skipped) -ForegroundColor DarkGray
            }
        }

        Write-Host "`nCleanup declined complete - $removed removed, $skipped skipped (still referenced).`n" -ForegroundColor Green
        Write-log -Message "Cleanup declined complete - $removed removed, $skipped skipped (still referenced)." -severity 1 -component "Cleanup Declined"
    }

    Write-log -Message "--> End cleanup declined" -severity 1 -component "Cleanup Declined"
}

function Get-MaxXMLPerRequest {
    # Returns the current tbConfigurationC.MaxXMLPerRequest value, or $null if it cannot be read.
    try {
        $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $GetMaxXML -Database "SUSDB"
        if ($result.Results -and $result.Results.Rows.Count -gt 0) {
            return [int]$result.Results.Rows[0]['MaxXMLPerRequest']
        }
    }
    catch {
        return $null
    }
    return $null
}

function ToggleMaxXML {
    Write-log -Message "--> Begin toggle MaxXMLPerRequest" -severity 1 -component "MaxXMLPerRequest"

    $current = Get-MaxXMLPerRequest
    if ($null -eq $current) {
        Write-Host "`nUnable to read the current MaxXMLPerRequest value from SUSDB. No change made.`n" -ForegroundColor Red
        Write-log -Message "Unable to read the current MaxXMLPerRequest value from SUSDB." -severity 3 -component "MaxXMLPerRequest"
        Write-log -Message "--> End toggle MaxXMLPerRequest" -severity 1 -component "MaxXMLPerRequest"
        return
    }

    Write-log -Message "Current MaxXMLPerRequest value: $current" -severity 1 -component "MaxXMLPerRequest"
    $Global:MaxXMLCache = $current

    $target = $null
    if ($current -eq 0) {
        $target = $Global:MaxXMLDefault
    }
    elseif ($current -eq $Global:MaxXMLDefault) {
        $target = 0
    }
    else {
        # Unexpected value - warn and let the operator decide rather than changing silently.
        Write-Host "`nMaxXMLPerRequest is currently set to an unexpected value: $current" -ForegroundColor Yellow
        Write-Host "Expected either 0 or the default ($Global:MaxXMLDefault)." -ForegroundColor Yellow
        Write-log -Message "MaxXMLPerRequest is an unexpected value: $current (expected 0 or $Global:MaxXMLDefault)." -severity 2 -component "MaxXMLPerRequest"
        $choice = Read-Host "Enter [0] to set 0, [D] to set default ($Global:MaxXMLDefault), anything else to cancel"
        switch ($choice) {
            '0' { $target = 0 }
            { $_ -in 'D', 'd' } { $target = $Global:MaxXMLDefault }
            default {
                Write-Host "`nCancelled - MaxXMLPerRequest unchanged.`n" -ForegroundColor Green
                Write-log -Message "Operator cancelled MaxXMLPerRequest change (value left at $current)." -severity 1 -component "MaxXMLPerRequest"
                Write-log -Message "--> End toggle MaxXMLPerRequest" -severity 1 -component "MaxXMLPerRequest"
                return
            }
        }
    }

    try {
        # $target is always an integer (0 or the default) - safe to embed in the statement.
        $setQuery = "USE SUSDB; UPDATE tbConfigurationC SET MaxXMLPerRequest = $target;"
        $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $setQuery -Database "SUSDB"
        $Global:MaxXMLCache = $target
        $targetLabel = if ($target -eq $Global:MaxXMLDefault) { "$target (default)" } else { "$target" }
        Write-Host "`nMaxXMLPerRequest changed from $current to $targetLabel.`n" -ForegroundColor Green
        Write-log -Message "MaxXMLPerRequest changed from $current to $target." -severity 1 -component "MaxXMLPerRequest"
        Write-log -Message ("Total execution time for setting MaxXMLPerRequest.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "MaxXMLPerRequest"
        Write-Host "An IISRESET is required for this change to take effect.`n" -ForegroundColor Yellow
        Write-log -Message "An IISRESET is required for the MaxXMLPerRequest change to take effect." -severity 2 -component "MaxXMLPerRequest"
    }
    catch {
        Write-Host "`nFailed to update MaxXMLPerRequest: $($_.Exception.Message)`n" -ForegroundColor Red
        Write-log -Message "Failed to update MaxXMLPerRequest: $($_.Exception.Message)" -severity 3 -component "MaxXMLPerRequest"
    }

    Write-log -Message "--> End toggle MaxXMLPerRequest" -severity 1 -component "MaxXMLPerRequest"
}

function DeleteTestDetectoids {
    Write-log -Message "--> Begin delete test detectoids" -severity 1 -component "Delete Test Detectoids"
    Write-log -Message "Title pattern: $Global:TestDetectoidPattern" -severity 1 -component "Delete Test Detectoids"

    # Count first so the delete is skipped when there is nothing to remove.
    $matchCount = 0
    try {
        $countResult = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $CountTestDetectoids -Database "SUSDB"
        if ($countResult.Results -and $countResult.Results.Rows.Count -gt 0) {
            $matchCount = [int]$countResult.Results.Rows[0]['MatchCount']
        }
    }
    catch {
        Write-Host "`nFailed to count test detectoids: $($_.Exception.Message)`n" -ForegroundColor Red
        Write-log -Message "Failed to count test detectoids: $($_.Exception.Message)" -severity 3 -component "Delete Test Detectoids"
        Write-log -Message "--> End delete test detectoids" -severity 1 -component "Delete Test Detectoids"
        return
    }

    Write-log -Message "Matching test detectoids found: $matchCount" -severity 1 -component "Delete Test Detectoids"

    if ($matchCount -le 0) {
        Write-Host "`nNo test detectoids found - delete skipped.`n" -ForegroundColor Green
        Write-log -Message "No test detectoids found - delete skipped." -severity 1 -component "Delete Test Detectoids"
        Write-log -Message "--> End delete test detectoids" -severity 1 -component "Delete Test Detectoids"
        return
    }

    Write-log -Message "Reference: Resolved: Windows Server Update Services sync operations issues and timeouts - https://support.microsoft.com/en-us/servicing/os/windows/docs/2026/07/kb5121986-windows-server-update-service-sync-operations-issues-and-timeouts" -severity 2 -component "Delete Test Detectoids"

    Write-Host "`nDeleting $matchCount test detectoid(s) - this can take several minutes...`n" -ForegroundColor Cyan

    try {
        $result = Invoke-CustomSqlCommand -ServerInstance $LocalSQLInstance -Query $DeleteTestDetectoidsSql -Database "SUSDB"
        $deleted = 0
        $skipped = 0
        if ($result.Results -and $result.Results.Rows.Count -gt 0) {
            $deleted = [int]$result.Results.Rows[0]['Deleted']
            $skipped = [int]$result.Results.Rows[0]['Skipped']
        }
        Write-log -Message ("Total execution time for deleting test detectoids.........:" + ($result.ExecutionTime / 1000) + " seconds") -severity 1 -component "Delete Test Detectoids"
        Write-log -Message "Test detectoids deleted: $deleted | skipped (still referenced): $skipped" -severity 1 -component "Delete Test Detectoids"
        Write-Host "`nDone. Test detectoids deleted: $deleted | skipped (still referenced): $skipped`n" -ForegroundColor Green
        if ($deleted -gt 0) {
            Write-Host "An IISRESET is required now that test detectoids have been deleted. (after script finishes)`n" -ForegroundColor Yellow
            Write-log -Message "An IISRESET is required now that test detectoids have been deleted. (after script finishes)" -severity 2 -component "Delete Test Detectoids"
        }
    }
    catch {
        Write-Host "`nFailed to delete test detectoids: $($_.Exception.Message)`n" -ForegroundColor Red
        Write-log -Message "Failed to delete test detectoids: $($_.Exception.Message)" -severity 3 -component "Delete Test Detectoids"
    }

    Write-log -Message "--> End delete test detectoids" -severity 1 -component "Delete Test Detectoids"
}

function ChangeSQL {
    Write-log -Message "--> Begin change SQL" -severity 1 -component "Change SQL"

    $Previous = $global:LocalSQLInstance
    $Entry = (Read-Host -Prompt 'Enter the name of the SQL Server').Trim()

    if ([string]::IsNullOrWhiteSpace($Entry)) {
        Write-Host "`nNothing entered - SQL Server left at $Previous.`n" -ForegroundColor Yellow
        Write-log -Message "No server name entered - SQL Server left at $Previous." -severity 2 -component "Change SQL"
        Write-log -Message "--> End change SQL" -severity 1 -component "Change SQL"
        return
    }

    # Validate here, otherwise an unreachable name only surfaces as a stalled menu on the next redraw.
    Write-Host "`nTesting connection to [$Entry]..." -ForegroundColor Cyan

    if (-not (Test-SqlInstance -ServerInstance $Entry)) {
        Write-Host "`nCould not reach [$Entry] or its SUSDB database - SQL Server left at $Previous.`n" -ForegroundColor Red
        Write-log -Message "Connection test failed - SQL Server left at $Previous." -severity 3 -component "Change SQL"
        Write-log -Message "--> End change SQL" -severity 1 -component "Change SQL"
        return
    }

    $global:LocalSQLInstance = $Entry
    # MaxXMLPerRequest is per-server, so force a re-read against the new instance.
    $Global:MaxXMLCache = $null
    $Global:MaxXMLChecked = $false

    Write-Host "`nConnected. SQL Server set to $Entry.`n" -ForegroundColor Green
    Write-log -Message "--> SQL Server changed to $LocalSQLInstance" -severity 1 -component "Change SQL"
    Write-log -Message "--> End change SQL" -severity 1 -component "Change SQL"
}
function Show-Menu {
    param([string]$Title)

    Clear-Host
    Write-Host "================ $Title ================" -BackgroundColor Black -ForegroundColor Yellow
      
    #Write-Color -Text "[S] ", "Change SQL Server, currently set to $LocalSQLInstance" -Color Yellow, Cyan
    Write-Color -Text "[S] ", "Change SQL Server, currently set to ", $LocalSQLInstance -Color Yellow, Cyan, Green

    # Read once per session rather than on every redraw; [M] refreshes it and [S] clears it.
    if (-not $Global:MaxXMLChecked) {
        $Global:MaxXMLCache = Get-MaxXMLPerRequest
        $Global:MaxXMLChecked = $true
    }
    $currentMaxXML = $Global:MaxXMLCache

    if ($null -eq $currentMaxXML) {
        $maxXMLDisplay = "Unknown"
    }
    elseif ($currentMaxXML -eq $Global:MaxXMLDefault) {
        $maxXMLDisplay = "$currentMaxXML (default)"
    }
    else {
        $maxXMLDisplay = "$currentMaxXML"
    }
    Write-Color -Text "[M] ", "Toggle MaxXMLPerRequest, currently set to ", $maxXMLDisplay, " (cached, re-read on [M] or [S])" -Color Yellow, Cyan, Green, DarkGray
    Write-Color -Text "[D] ", "Delete Test Detectoids" -Color Yellow, Cyan
    Write-Host
    Write-Color -Text "[A] ", "Update Count" -Color Yellow, Cyan
    Write-Color -Text "[1] ", "Update spDeleteUpdate procedure" -Color Yellow, Cyan #https://docs.microsoft.com/en-US/troubleshoot/mem/configmgr/spdeleteupdate-slow-performance
    Write-Color -Text "[2] ", "Shrink Files" -Color Yellow, Cyan
    Write-Color -Text "[3] ", "Shrink Database" -Color Yellow, Cyan
    Write-Color -Text "[4] ", "Reindex and Update Statistics" -Color Yellow, Cyan
    Write-Color -Text "[5] ", "Cleanup Sync History" -Color Yellow, Cyan
    Write-Color -Text "[6] ", "Cleanup Superseded Updates Older than x Months" -Color Yellow, Cyan
    Write-Color -Text "[7] ", "Cleanup Obsolete Updates" -Color Yellow, Cyan
    Write-Color -Text "[8] ", "WSUS Cleanup Wizard" -Color Yellow, Cyan
    Write-Color -Text "[9] ", "Cleanup Declined" -Color Yellow, Cyan
    Write-Color -Text "[10] ", "Shrink Files" -Color Yellow, Cyan
    Write-Color -Text "[11] ", "Shrink Database" -Color Yellow, Cyan
    Write-Color -Text "[12] ", "Reindex and Update Statistics" -Color Yellow, Cyan
    Write-Color -Text "[RA] ", "Run all above steps sequentially" -Color Yellow, Cyan
    Write-Host
    Write-Color -Text "[Q] ", "Quit" -Color Yellow, Cyan
    Write-Host
    
}

#Region Initialize
#Check if running as admin
$admin = ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544')
if (-not $admin) {
    Write-Host "`nMust run PowerShell as administrator.`n" -ForegroundColor Yellow
    Exit
}

#Region LogCheck
# $PSScriptRoot is empty when the body is run as a selection rather than as a .ps1 file.
$ScriptLocation = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$LogFile = "$ScriptLocation\SUSDB-Maintenance.log"

# Roll over at 5 MB using the ConfigMgr .lo_ convention so CMTrace stays responsive.
if ((Test-Path -Path $LogFile -PathType Leaf) -and ((Get-Item -Path $LogFile).Length -gt 5MB)) {
    Move-Item -Path $LogFile -Destination ([System.IO.Path]::ChangeExtension($LogFile, 'lo_')) -Force
}

If ( -not (Test-Path -Path $LogFile -PathType Leaf)) {
    try {
        $null = New-Item -ItemType File -Path $LogFile -Force -ErrorAction Stop
        Write-Host "The file [$LogFile] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
else {
    Write-Host "Log file [$LogFile] already existed."
}

# CMTrace and OneTrace decide the format from the first line they see, so the log must not be empty when it opens.
Write-log -Message "--> SUSDB-Maintenance $Global:ScriptVersion started by $env:USERDOMAIN\$env:USERNAME on $env:COMPUTERNAME" -severity 1 -component "Initialize"
Write-log -Message "PowerShell $($PSVersionTable.PSVersion) | SQL Server: $LocalSQLInstance | Log: $LogFile" -severity 1 -component "Initialize"

# Opening the log is a convenience - a missing .log file association must not stop the script.
try {
    Invoke-Item -Path $LogFile
}
catch {
    Write-Host "Could not open the log automatically: $($_.Exception.Message)" -ForegroundColor Yellow
}
#EndRegion LogCheck

Write-Host "Script initialized - using native .NET SqlClient (no SQL module required)" -ForegroundColor Green
#EndRegion Initialize

#Region ShowMenu
do {
    Show-Menu -Title 'SUSDB Maintenance'
    $selection = Read-Host "Please make a selection"

    # Keeps a failed operation from terminating the whole script, since $ErrorActionPreference is Stop.
    try {
        switch ($selection) {
        'S' {
            #Change SQL Server
            ChangeSQL
            
        }'M' {
            #Toggle MaxXMLPerRequest
            ToggleMaxXML

}'A' {
            #Update Count
            UpdateCount

}'D' {
            #Delete Test Detectoids
            DeleteTestDetectoids

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
            Write-Host "Specify the number of months between today and the release date for which the superseded updates must not be declined.`nThis should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.`n"
            $MonthsEntry = Read-Host -Prompt 'Months '
            $MonthsValue = 0

            # Read-Host returns a string, so the range test must be done on a parsed integer.
            # 600 months (50 years) is far beyond the age of any update in SUSDB and keeps the calculated cutoff date clear of the SQL datetime floor of 01-01-1753.
            if ([int]::TryParse($MonthsEntry.Trim(), [ref]$MonthsValue) -and $MonthsValue -gt 0 -and $MonthsValue -le 600) {
                $Global:MonthsSupersededNotDeclined = $MonthsValue
                Write-log -Message "Number of months entered :  $Global:MonthsSupersededNotDeclined , proceeding with cleaning up superseded updates." -severity 1 -component "Cleanup Superseded Updates"
                CleanupSupersedUpdates 
            }
            else {
                Write-Host "`nInvalid entry, must be a whole number between 1 and 600.`n" -ForegroundColor Red
                Write-log -Message "Number of months entered [$MonthsEntry] is invalid, must be a whole number between 1 and 600." -severity 3 -component "Cleanup Superseded Updates"                
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
            
            Write-Host "Specify the number of months between today and the release date for which the superseded updates must not be declined.`nThis should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.`n"
            $MonthsEntry = Read-Host -Prompt 'Months '
            $MonthsValue = 0

            # Read-Host returns a string, so the range test must be done on a parsed integer.
            # 600 months (50 years) is far beyond the age of any update in SUSDB and keeps the calculated cutoff date clear of the SQL datetime floor of 01-01-1753.
            if ([int]::TryParse($MonthsEntry.Trim(), [ref]$MonthsValue) -and $MonthsValue -gt 0 -and $MonthsValue -le 600) {
                $Global:MonthsSupersededNotDeclined = $MonthsValue
                Write-log -Message "Number of months entered :  $Global:MonthsSupersededNotDeclined , proceeding with cleaning up superseded updates." -severity 1 -component "Run All"                

                $RunAllSteps = 'UpdateCount', 'DeleteTestDetectoids', 'Update_spDeleteUpdate_Procedure',
                               'ShrinkFile', 'ShrinkDatabase', 'ReindexStatistics', 'CleanUpSyncHistory',
                               'CleanupSupersedUpdates', 'CleanupObsoleteUpdates', 'WSUSCleanUpWizard',
                               'CleanUpDeclined', 'ShrinkFile', 'ShrinkDatabase', 'ReindexStatistics', 'UpdateCount'

                $FailedSteps = [System.Collections.Generic.List[string]]::new()
                $RunAllStart = Get-Date
                $StepNumber = 0

                # One replica mode window spanning the first to the last step WSUS blocks on a replica,
                # rather than one per step - the guards inside those steps then become no-ops.
                $ReplicaSteps = 'CleanupSupersedUpdates', 'WSUSCleanUpWizard', 'CleanUpDeclined'
                $ReplicaIndexes = @(0..($RunAllSteps.Count - 1) | Where-Object { $RunAllSteps[$_] -in $ReplicaSteps })
                $ReplicaFirst = if ($ReplicaIndexes.Count -gt 0) { $ReplicaIndexes[0] } else { -1 }
                $ReplicaLast = if ($ReplicaIndexes.Count -gt 0) { $ReplicaIndexes[-1] } else { -1 }

                # Console progress matters here because the log may be closed and steps can run for a long time silently.
                Write-Host "`nRun All started $($RunAllStart.ToString('MM-dd-yyyy HH:mm:ss')) - $($RunAllSteps.Count) steps to run.`n" -ForegroundColor Cyan

                try {
                    foreach ($RunAllStep in $RunAllSteps) {
                        $StepNumber++
                        $StepStart = Get-Date

                        if (($StepNumber - 1) -eq $ReplicaFirst) {
                            Write-log -Message "Opening a single replica mode window for steps $($ReplicaFirst + 1) to $($ReplicaLast + 1)." -severity 1 -component "Run All"
                            Suspend-ReplicaMode -Component "Run All"
                        }

                        Write-Host ("[{0}] Step {1} of {2} - {3} - running..." -f $StepStart.ToString('MM-dd-yyyy HH:mm:ss'), $StepNumber, $RunAllSteps.Count, $RunAllStep) -ForegroundColor Cyan
                        Write-log -Message "Step $StepNumber of $($RunAllSteps.Count) - $RunAllStep - running" -severity 1 -component "Run All"

                        try {
                            & $RunAllStep

                            $StepEnd = Get-Date
                            Write-Host ("[{0}] Step {1} of {2} - {3} - done in {4}" -f $StepEnd.ToString('MM-dd-yyyy HH:mm:ss'), $StepNumber, $RunAllSteps.Count, $RunAllStep, (Format-Elapsed ($StepEnd - $StepStart))) -ForegroundColor Green
                            Write-log -Message "Step $StepNumber of $($RunAllSteps.Count) - $RunAllStep - done in $(Format-Elapsed ($StepEnd - $StepStart))" -severity 1 -component "Run All"
                        }
                        catch {
                            $StepEnd = Get-Date
                            $FailedSteps.Add($RunAllStep)
                            Write-Host "`n*************************************************************" -ForegroundColor Red
                            Write-Host ("*** [{0}] STEP FAILED: Step {1} of {2} - {3}" -f $StepEnd.ToString('MM-dd-yyyy HH:mm:ss'), $StepNumber, $RunAllSteps.Count, $RunAllStep) -ForegroundColor Red
                            Write-Host "*** $($_.Exception.Message)" -ForegroundColor Red
                            Write-Host "*** Continuing with the next step." -ForegroundColor Red
                            Write-Host "*************************************************************`n" -ForegroundColor Red
                            Write-log -Message "STEP FAILED [Step $StepNumber of $($RunAllSteps.Count) - $RunAllStep]: $($_.Exception.Message)" -severity 3 -component "Run All"
                        }

                        if (($StepNumber - 1) -eq $ReplicaLast) {
                            Resume-ReplicaMode -Component "Run All"
                        }
                    }
                }
                finally {
                    # Covers a break out of the loop before the last replica step was reached.
                    while ($Global:ReplicaModeDepth -gt 0) {
                        Resume-ReplicaMode -Component "Run All"
                    }
                }

                # A server left out of replica mode is a failure of the run, even when every step itself succeeded.
                if ($Global:ReplicaModeRestoreFailed) {
                    $Global:ReplicaModeRestoreFailed = $false
                    $FailedSteps.Add('Restore replica mode')
                }

                $RunAllElapsed = (Get-Date) - $RunAllStart

                if ($FailedSteps.Count -gt 0) {
                    Write-Host "`n*************************************************************" -ForegroundColor Red
                    Write-Host "*** RUN ALL COMPLETED WITH ERRORS - $($FailedSteps.Count) failure(s) across $($RunAllSteps.Count) step(s)" -ForegroundColor Red
                    Write-Host "*** Failed: $($FailedSteps -join ', ')" -ForegroundColor Red
                    Write-Host "*** Total elapsed $(Format-Elapsed $RunAllElapsed)" -ForegroundColor Red
                    Write-Host "*** Review $LogFile for details." -ForegroundColor Red
                    Write-Host "*************************************************************`n" -ForegroundColor Red
                    Write-log -Message "RUN ALL COMPLETED WITH ERRORS - $($FailedSteps.Count) failure(s) across $($RunAllSteps.Count) step(s): $($FailedSteps -join ', ') - total elapsed $(Format-Elapsed $RunAllElapsed)" -severity 3 -component "Run All"
                }
                else {
                    Write-Host "`nRun All completed - all $($RunAllSteps.Count) steps succeeded in $(Format-Elapsed $RunAllElapsed).`n" -ForegroundColor Green
                    Write-log -Message "Run All completed - all $($RunAllSteps.Count) steps succeeded in $(Format-Elapsed $RunAllElapsed)" -severity 1 -component "Run All"
                }
            }
            else {
                Write-Host "`nInvalid entry, must be a whole number between 1 and 600.`n" -ForegroundColor Red
                Write-log -Message "Number of months entered [$MonthsEntry] is invalid, must be a whole number between 1 and 600. Run All cancelled." -severity 3 -component "Run All"
            }

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
    }
    catch {
        Write-Host "`nSelection [$selection] failed: $($_.Exception.Message)`n" -ForegroundColor Red
        Write-log -Message "Selection [$selection] failed: $($_.Exception.Message)" -severity 3 -component "Menu"

        # A replica server must never be left out of replica mode because a step threw.
        while ($Global:ReplicaModeDepth -gt 0) {
            Resume-ReplicaMode -Component "Menu"
        }
    }

    # Run All folds this into its own summary and clears the flag, so anything left here belongs to a single selection.
    if ($Global:ReplicaModeRestoreFailed) {
        $Global:ReplicaModeRestoreFailed = $false
        Write-Host "`nSelection [$selection] FAILED - replica mode could not be re-enabled.`n" -ForegroundColor Red
        Write-log -Message "Selection [$selection] failed - replica mode could not be re-enabled. Re-enable it manually in the WSUS console (Options > Update Source and Proxy Server)." -severity 3 -component "Menu"
    }

    if ($selection -ne 'q') { Pause }
}
until ($selection -eq 'q')
#EndRegion ShowMenu
```
