---
title: Request Count data is missing from APM reports
description: Fixes an issue in which the Request Count and Request Time (sec) values are missing from APM reports after you upgrade to System Center 2012 R2 Operations Manager.
ms.date: 04/15/2024
ms.reviewer: scottwal, lamosley
---
# Request Count data is missing from APM reports after upgrading to Operations Manager 2012 R2

This article helps you fix an issue in which the **Request Count** and **Request Time (sec)** values are missing from Application Performance Monitoring (APM) reports after you upgrade to System Center 2012 R2 Operations Manager.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager Service Pack 1  
_Original KB number:_ &nbsp; 2984838

## Symptoms

After you upgrade from System Center 2012 Operations Manager Service Pack 1 to System Center 2012 R2 Operations Manager, the **Request Count** and **Request Time (sec)** values are no longer available in APM reports. These values are displayed as 0 (zero) for a while after the upgrade.

## Cause

The APM performance counter names for **.NET Apps** were changed to just **Apps** in the Operations Manager database. However, there were no corresponding name changes in the Operations Manager data warehouse.

## Resolution

To resolve this issue, start SQL Server Management Studio, and then connect to the Operations Manager data warehouse database. After you're connected, run the following script to update the counter names in the data warehouse.

```sql
---------------------Update Counter Names in the DW------------------------
use [OperationsManagerDW]
Update apm.PCTYPE Set TYPE = replace(TYPE, '\.NET Apps\', '\Apps\')

----------------------------Begin SP Updates-------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ApplicationActivityBreakdownByMonthDate]    Script Date: 03/10/2014 00:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************/
/* OBJECT: Stored Procedure                                                             */
/* NAME: ApplicationActivityBreakdownByMonthDate                                        */
/* USED IN: Application Status  Report, Application Activity                            */
/* DESCRIPTION: This SP is used in report above in case, when grouping by month date    */
/*      specified                                                                       */
/* INPUT PARAMETERS:                                                                    */
/*      @SOURCEIDS      - List of the source id, separated by comma. Exp: '1,2,3'       */
/*      @COMPUTERIDS    - List of the computer id, separated by comma. Exp: '1,2,3'     */
/*      @ENDDATE        - End date of the period in Client time zone                    */
/*      @PERIOD         - Period type(Day, Week or Month).                              */  
/*                      - Use for the Start Date calculate of the period                */
/*      @AVERAGEINTERVAL- This value specifies interval, for which average values will  */
/*                          be calculated. Possible values: 1(1 month), 2(2 month),     */
/*                          3(3 month), 6(6 month), 17 (7 day)                          */
/*      @GROUPBY        - Specifies result gouping type. Possible values:               */
/*                  Hour - Group by hours.  Rersult set will contain 24 rows            */
/*                      corresponding to 24 hours. Date field - 0-23, Hour field - 0    */
/*                  WeekDay - Group by week days. For this grouping type extra grouping */
/*                      is applied - by hours. So result data set contains 7*24 rows.   */
/*                      Date field values - 1-7, Hour fields - 0-23                     */
/*                  Month - Group by Month. For this grouping type extra grouping       */
/*                      is applied - by months. So result data set contains 12*24 rows. */
/*                      and Hour field - 0-23                                           */
/*      @TRESHOLD       - Event duration treshold                                       */
/*      @PROBLEM        - Event problem type (all, critical)                            */
/*      @TIMEZONE       - correlate parameter (timezone by min)                         */
/*                      - for the End Date calculate                                    */
/****************************************************************************************/
ALTER PROCEDURE [apm].[ApplicationActivityBreakdownByMonthDate]
    @SOURCEIDS NVARCHAR(MAX),
    @COMPUTERIDS NVARCHAR(MAX),
    @ENDDATE DATETIME,
    @TIMEZONE INT,
    @PERIOD INT,
    @AVERAGEINTERVAL INT,
    @GROUPBY NVARCHAR(10),
    @THRESHOLD INT,
    @PROBLEM NVARCHAR(10),
    @PMSTATUS NVARCHAR(50)
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON;

/************************************************************************************/
/*  Prepare auxiliary variables for the further calculation                         */
/************************************************************************************/
    --Used for counting average value for last three months
    DECLARE @PERIODDAYSCOUNT int
    SET @PERIODDAYSCOUNT = 31
    SET @ENDDATE = DATEADD(minute, -@TIMEZONE, @ENDDATE)
    DECLARE @STARTDATE DateTime
    SET @STARTDATE = DATEADD(d, -@PERIODDAYSCOUNT, @ENDDATE)
    DECLARE @LASTPERIODSTARTDATE DateTime
    SET @LASTPERIODSTARTDATE = DATEADD(d, -@PERIODDAYSCOUNT, @STARTDATE)
    DECLARE @AVERAGEPERIODSTARTDATE DateTime
    SET @AVERAGEPERIODSTARTDATE = (CASE
                                        WHEN @AVERAGEINTERVAL < 10 THEN DATEADD(month, -@AVERAGEINTERVAL, @STARTDATE)
                                        ELSE DATEADD(day, -(@AVERAGEINTERVAL-10), @STARTDATE)
                                   END)
    DECLARE @PROCESSORCOUNTERID INT
    SELECT @PROCESSORCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\% Processor Time'
    DECLARE @MEMORYCOUNTERID INT
    SELECT @MEMORYCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\Private Bytes'
    DECLARE @IOCOUNTERID INT
    SELECT @IOCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\IO Data Bytes/sec'
    DECLARE @MONITOREDREQUESTCOUNTERID INT
    SELECT @MONITOREDREQUESTCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Apps\Monitored Requests'
    DECLARE @REQUESTTIMECOUNTERID INT
    SELECT @REQUESTTIMECOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Apps\Avg. Request Time'

/************************************************************************************/
/*                          ASSISTING TEMP TABLES                                   */
/************************************************************************************/
    -- Filter table, which contains machine ids and source ids
    -- typeid defines filter type - 1 for source and 2 for machine
    -- valueId filter value - source id and machine id
    CREATE TABLE #SOURCEMACHINEFILTERTABLE(
        TYPEID INT,
        VALUEID INT
    )
    -- Fill table #SOURCEMACHINEFILTERTABLE
    INSERT
        INTO #SOURCEMACHINEFILTERTABLE
            SELECT
                p.typeId AS TYPEID,
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter 
                APM.GetMultiParameters(@SOURCEIDS, @COMPUTERIDS) AS p
    -- Filter table, which contains PM Statuses of Events
    CREATE TABLE #PMSTATUSFILTERTABLE(
        VALUEID INT
    )
    -- Fill table #PMSTATUSFILTERTABLE
    INSERT
        INTO #PMSTATUSFILTERTABLE
            SELECT
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@PMSTATUS, N'') AS p
    -- To form application pool with all sources run in it, it is need to get all sources and its process
    CREATE TABLE #PROCESSFORSOURCE
    (
        SOURCEID INT,
        PCPROCESSID INT,
        MACHINEID INT,
        EXTRAINFO NVARCHAR(255) COLLATE DATABASE_DEFAULT,
        PROCESS NVARCHAR(255) COLLATE DATABASE_DEFAULT
    )

    INSERT INTO #PROCESSFORSOURCE
        SELECT
            ph.SourceId,
            ph.PCProcessId,
            ph.MachineId,
            COALESCE(p.Extrainfo, N'') AS EXTRAINFO,
            --Select process name till # symbol (w3wp#1 -> w3wp, w3wp -> w3wp)
            APM.RemoveProcessIdFromName(p.Process) AS Process
        FROM
            (
                SELECT DISTINCT
                    ph.SourceId,
                    ph.pcprocessId,
                    ph.MachineId
                FROM
                    APM.PerfHourly AS ph (NOLOCK)
                WHERE
                    ph.pcprocessId IS NOT NULL
                    AND ph.UTCDate >= @STARTDATE
                    AND ph.UTCDate < @ENDDATE 
            ) AS ph
            JOIN APM.PCProcess AS p (NOLOCK) ON p.pcprocessId = ph.pcprocessId 
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 2 AND ph.MachineId = f.VALUEID)

    -- Report frame. It contains all sources, for which values sould be selected, 
    -- and dates for the specified period (StartDate : EndDate)  
    ;WITH SourcesDates AS
    (
        SELECT
            VALUEID AS sourceid,
            s.source AS source,
            -- Select 31 day from end date in ClientTime zone, without hours
            CONVERT(NVARCHAR, DATEADD(d, -d.n, DATEADD(minute, @TIMEZONE, @ENDDATE)), 112) AS ClientDate
        FROM
            #SOURCEMACHINEFILTERTABLE AS source
            JOIN APM.source (NOLOCK) AS s ON s.sourceid = source.VALUEID
            CROSS JOIN APM.fn_nums(31) AS d
        WHERE
            source.TYPEID = 1
    ),
    AppPoolInfo AS
    (
        SELECT
            c.SOURCEID,
            c.EXTRAINFO,
            c.PROCESS,
            -- all source names which have the same process name as passed in @SOURCEIDS
            (SELECT A.source AS [data()]
                FROM
                (
                    SELECT DISTINCT
                        N'''' + s.source + N'''' +  N',' AS source
                    FROM
                        #PROCESSFORSOURCE AS c1
                        JOIN APM.Source AS s ON c1.SOURCEID = s.SourceId
                    WHERE
                        c1.EXTRAINFO = c.EXTRAINFO
                        AND c1.PROCESS = c.PROCESS
                        AND c1.MACHINEID = c.MACHINEID
                ) AS A
                FOR XML PATH ('')
            ) AS AppPoolSources
        FROM
            #PROCESSFORSOURCE AS c
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = c.SOURCEID)
        GROUP BY
            c.SOURCEID,
            c.MACHINEID,
            c.EXTRAINFO,
            c.PROCESS
    ),
    --Add Pool name in-front of source list, if it is executable application, then app pool countains source name
    PrepareAppPoolInfo AS (
        SELECT DISTINCT
            CASE
                WHEN COALESCE(info.ExtraInfo,'') = '' THEN CASE info.AppPoolSources WHEN '' THEN '' ELSE LEFT(info.AppPoolSources, LEN(info.AppPoolSources)-1) END
                ELSE info.ExtraInfo + CASE info.AppPoolSources WHEN '' THEN '' ELSE ' (' + LEFT(info.AppPoolSources, LEN(info.AppPoolSources) - 1) + ')' END
            END AppPool,
            info.SourceId,
            info.ExtraInfo
        FROM
            AppPoolInfo AS info
    ),
    -- Forms application pool list for each source
    -- Format: AppPool1 ('Source1', 'Source2', Source3), AppPool2 ('Source1', 'Source4')
    SourceAppPools AS (
        SELECT
            s.SourceId,
            s.Source,
            COALESCE((SELECT a.AppPool AS [data()]
                FROM
                (
                    SELECT DISTINCT
                        info.AppPool +  N',' AS AppPool
                    FROM
                        PrepareAppPoolInfo as info
                    WHERE
                        info.Sourceid = s.Sourceid
                ) AS A
                FOR XML PATH ('')
            ),s.Source +  '-') AS AppPoolInfo
        FROM
            APM.Source AS s
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = s.SourceId)
    ),
    --Prepares and filters events for further manipulations
    ActivityBreakdown_EventsFiltered AS
    (
        SELECT
            e.sourceid,
            e.eventid,
            e.utceventdate AS eventdate,
            -- Event Date in Client Timezone without hours
            CONVERT(NVARCHAR, DATEADD(minute, @TIMEZONE, e.utceventdate), 112) AS ClientDate,
            --hour is taken as DateDifference in day between 05/04/2009 9:00AM and 05/03/2009 9:00PM is one day,
            --despite in case of @PERIOD = 'Day' it can be interpretated as one day (if 05/04/2009 9:00AM is end date), so difference should be taken as 0
            ABS(DATEDIFF(hour, e.utceventdate, @ENDDATE)) / (@PERIODDAYSCOUNT*24) AS PeriodId,
            e.eventgroupid,
            db.ADDRESS AS SeViewerAddress
        FROM
            APM.Event AS e
            JOIN APM.SeViewerDB AS db ON e.seviewerdbid = db.seviewerdbid
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.VALUEID = e.sourceid and f1.TYPEID = 1)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.VALUEID = e.machineid and f2.TYPEID = 2)
   JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMStatus)
        WHERE
            ((e.EventClassType = N'Performance' AND e.eventduration / 1000000.0 >= @THRESHOLD)
            OR e.EventClassType = N'exception')
            AND (e.category LIKE @PROBLEM OR e.category IS NULL)
            AND e.utceventdate >= @AVERAGEPERIODSTARTDATE
            AND e.utceventdate < @ENDDATE
            AND (e.HeavyLight <> 0 OR e.HeavyLight IS NULL)
    ),
    /************************************************************************************/
    /*                          Base pcounter queries                                   */
    /************************************************************************************/
    -- Calculate resource utilization by Source in one hour.
    -- Aggregation between instances should be done here (for cases when one source run in several process in one hour)
    SourceHourlyResourceUtilization AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            -- PerfHourly date in client time zone without hours
            CONVERT(NVARCHAR, DATEADD(minute, @TIMEZONE ,ph.UTCDate), 112) AS ClientDate,
            ph.PCTypeId AS Type,
            ---------- Pivot instance count by period type -----------
            (CASE
                WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE
                THEN SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter)
            END) AS LastInstanceCount,
            (CASE
                WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE
                THEN SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter)
            END) AS CurInstanceCount,
            (CASE 
                WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE
                THEN SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter)
            END) AS AvgInstanceCount,

            ---------- Pivot resource value by period type -----------
            (CASE
                WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS LastValue,
            (CASE
                WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS CurValue,
            (CASE
                WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS AvgValue,
            ABS(DATEDIFF(hour, ph.UTCDate, @ENDDATE)) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            APM.PerfHourly AS ph (NOLOCK)
            --Join with #SOURCEMACHINEFILTERTABLE with typeid = 1 provides filtering perfHourly by sourceid
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND f1.VALUEID = ph.SourceId)
            --Join with #SOURCEMACHINEFILTERTABLE with typeid = 2 provides filtering perfHourly by machineid
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
        WHERE
            ph.UTCDate >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDate < @ENDDATE
            AND ph.PCTypeId IN (@PROCESSORCOUNTERID, @IOCOUNTERID, @MEMORYCOUNTERID)
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.UTCDate,
            ph.PCTypeId
    ),
    -- Bring ClientDate to current period, as in result data set, data only for current period are shown
    -- (all other should be shown relative to current period)
    SourceHourlyResourceUtilizationByCurrentPeriod AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            -- PeriodId is 0 for the current period, 1 for last and 1..n for average
            -- this manipulation should bring Client date to current period
            DATEADD(day, ph.PeriodId*31, ClientDate) AS ClientDate,
            ph.Type,
            ph.LastInstanceCount,
            ph.CurInstanceCount,
            ph.AvgInstanceCount,
            ph.LastValue,
            ph.CurValue,
            ph.AvgValue,
            ph.PeriodId
        FROM
            SourceHourlyResourceUtilization AS ph
    ),
    --Calculate average source resource utilization for each resource type
    --and for specified grouping period and date
    ApplicationResourceUtilizationByMachines AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.ClientDate,
            -- Instance count should be same for different resource types in one hour for one process
            -- and averaging them won't make any difference but allow to avoid one aggregation step  
            AVG(ph.CurInstanceCount) AS CurInstanceCount,
            AVG(ph.LastInstanceCount) AS LastInstanceCount,
            AVG(ph.AvgInstanceCount) AS AvgInstanceCount,
            ---------- Pivot resource by counter type -----------
            ----------- 'Process% Processor Time' counter -------------------
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.CurValue END) AS CurCPUSum,
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.LastValue END) AS LastCPUSum,
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.AvgValue END) AS AvgCPUSum,
            ----------- 'ProcessPrivate Bytes' counter -------------------
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.CurValue END)  AS CurMemSum,
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.LastValue END) AS LastMemSum,
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.AvgValue END)  AS AvgMemSum,
            ----------- 'ProcessIO Data Bytes/sec' counter -------------------
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.CurValue END) AS CurIOSum,
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.LastValue END) AS LastIOSum,
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.AvgValue END) AS AvgIOSum
        FROM
            SourceHourlyResourceUtilizationByCurrentPeriod AS ph
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.ClientDate
    ),
    -- Count Monitored Requests and Avg. Request Timefor Application on each machine
    -- as source can run on different machines with same process name and app pool, but different sources set, 
    -- it is important to group by machine to, to avoid calculation of requests from the other app pool
    -- Summarize request count in each period (PeriodId differs only for AvgValue)
    ApplicationNetAppCountersByMachinePrepare AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            CONVERT(NVARCHAR, DATEADD(minute, @TIMEZONE, ph.UTCDate), 112) AS ClientDate,
            ----------------- Pivot Monitor Request Counter by period ------------------
            CASE WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE
                 THEN SUM(CASE WHEN ph.PCTypeId = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END)  
            END AS LastMonRequest,
            CASE WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE
                THEN SUM(CASE WHEN ph.PCTypeId = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END)
            END AS CurMonRequest,
            CASE WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE
                THEN SUM(CASE WHEN ph.PCTypeId = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END)
            END AS AvgMonRequest,

            ----------------- Pivot Avg. Request Time Counter by period ------------------
            CASE WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE
                THEN AVG(CASE WHEN ph.PCTypeId = @REQUESTTIMECOUNTERID THEN ph.SumValue / ph.SampleCount END)
            END AS LastAvgReqTime,
            CASE WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE
                THEN AVG(CASE WHEN ph.PCTypeId = @REQUESTTIMECOUNTERID THEN ph.SumValue / ph.SampleCount END)
            END AS CurAvgReqTime,
            CASE WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE
                THEN AVG(CASE WHEN ph.PCTypeId = @REQUESTTIMECOUNTERID THEN ph.SumValue / ph.SampleCount END)
            END AS AvgReqTime,
            ABS(DATEDIFF(hour, ph.UTCDate, @ENDDATE)) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            apm.PerfHourly AS ph (NOLOCK)
            --Join with #SOURCEMACHINEFILTERTABLE provides filtering perfHourly by sourceid
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND ph.SourceId = f1.VALUEID)
            --Join with #SOURCEMACHINEFILTERTABLE provides filtering perfHourly by machineid
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
        WHERE
            ph.UTCDate >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDate < @ENDDATE
            AND ph.PCTypeID IN (@REQUESTTIMECOUNTERID, @MONITOREDREQUESTCOUNTERID)
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.UTCDate
    ),
    -- Bring ClientDate to current period, as in result data set, data only for current period are shown
    -- (all other should be shown relative to current period)
    ApplicationNetAppCountersByCurrentPeriod AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            -- PeriodId is 0 for the current period, 1 for last and 1..n for average
            -- this manipulation should bring Client date to current period
            DATEADD(day, ph.PeriodId*31, ClientDate) AS ClientDate,
            ph.LastMonRequest,
            ph.CurMonRequest,
            ph.AvgMonRequest,
            ph.LastAvgReqTime,
            ph.CurAvgReqTime,
            ph.AvgReqTime,
            ph.PeriodId
        FROM
            ApplicationNetAppCountersByMachinePrepare AS ph
    ),
    --Calculate average request time  and  sum request count for specified grouping period and date
    ApplicationNetAppCountersByMachine AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.ClientDate,
            SUM(ph.LastMonRequest) AS LastMonRequest,
            SUM(ph.CurMonRequest) AS CurMonRequest,
            SUM(ph.AvgMonRequest) AS AvgMonRequest,
            AVG(ph.LastAvgReqTime) AS LastAvgReqTime,
            AVG(ph.CurAvgReqTime) AS CurAvgReqTime,
            AVG(ph.AvgReqTime) AS AvgReqTime  
        FROM
            ApplicationNetAppCountersByCurrentPeriod ph
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.ClientDate
    ),
    --  Union .NET counters and process counters for period Id. Period Id differs only for average(last three months) values, so grouping only for them
    PCountersGroupedByMachineId AS (
        SELECT
            pc.machineId,
            pc.SourceId,
            pc.ClientDate,
            MAX(netApp.CurMonRequest) AS CurReqCount,
            MAX(netApp.LastMonRequest) AS LastReqCount,
            AVG(netApp.AvgMonRequest) AS AvgReqCount,

            MAX(netApp.CurAvgReqTime) AS CurAvgReqTime,
            MAX(netApp.LastAvgReqTime) AS LastAvgReqTime,
            AVG(netApp.AvgReqTime) AS AvgReqTime,

            MAX(pc.CurCPUSum) AS CurCPUSum,
            MAX(pc.LastCPUSum) AS LastCPUSum,
            AVG(pc.AvgCPUSum) AS AvgCPUSum,
            MAX(pc.CurMemSum) AS CurMemSum,
            MAX(pc.LastMemSum) AS LastMemSum,
            AVG(pc.AvgMemSum) AS AvgMemSum,
            MAX(pc.CurIOSum) AS CurIOSum,
            MAX(pc.LastIOSum) AS LastIOSum,
            AVG(pc.AvgIOSum) AS AvgIOSum
       FROM ApplicationResourceUtilizationByMachines pc
       LEFT JOIN ApplicationNetAppCountersByMachine AS netApp ON netApp.MachineId = pc.MachineId
                AND netApp.SourceId = pc.SourceId AND netApp.PeriodId = netApp.PeriodId
                AND netApp.ClientDate = pc.ClientDate
        GROUP BY
            pc.machineId,
            pc.SourceId,
            pc.ClientDate
    ),
    -- Calculate average source resource utilization between machines  
    ActivePreparePCounters AS (
        SELECT
            pc.SourceId,
            -- Convert date to appropriate format to provide correct comparison
            pc.ClientDate,
            SUM(CurReqCount) AS CurReqCount,
            SUM(LastReqCount) AS LastReqCount,
            SUM(AvgReqCount) AS AvgReqCount,
            AVG(CurAvgReqTime) AS CurAvgReqTime,
            AVG(LastAvgReqTime) AS LastAvgReqTime,
            AVG(AvgReqTime) AS AvgReqTime,
            AVG(CurCPUSum / COALESCE(m.CPUCount, 1)) AS CurCPUSum,
            AVG(LastCPUSum / COALESCE(m.CPUCount, 1) ) AS LastCPUSum,
            AVG(AvgCPUSum / COALESCE(m.CPUCount, 1)) AS AvgCPUSum,

            AVG(CurMemSum) AS CurMemSum,
            AVG(LastMemSum) AS LastMemSum,
            AVG(AvgMemSum) AS AvgMemSum,
            AVG(CurIOSum) AS CurIOSum,
            AVG(LastIOSum) AS LastIOSum,
            AVG(AvgIOSum) AS AvgIOSum
        FROM
            PCountersGroupedByMachineId AS pc
            JOIN apm.Machine AS m ON m.MachineId = pc.MachineId
        GROUP BY
            pc.SourceId,
            pc.ClientDate
    ),
    -- Count events for the current, last and average period.
    -- PeriodId is 0 for Current period, 1 for last period, and 1..n for average period
    PrepareEventsAvg AS
    (
        SELECT
            e.sourceid AS sourceid,
            -- PeriodId is 0 for the current period, 1 for last and 1..n for average
            -- this manipulation should bring Client date to current period
            DATEADD(day, e.PeriodId*31, e.ClientDate) AS ClientDate,
            e.PeriodId,
            MAX(E.SeViewerAddress) AS SeViewerAddress,  
            COUNT(CASE WHEN e.eventdate >= @STARTDATE AND e.eventdate < @ENDDATE THEN eventid END) AS CurrentEventsCount,
            COUNT(CASE WHEN e.eventdate >= @LASTPERIODSTARTDATE  AND e.eventdate < @STARTDATE THEN eventid END) AS LasEventsCount,
            COUNT(CASE WHEN E.eventdate >= @AVERAGEPERIODSTARTDATE AND E.eventdate < @STARTDATE THEN eventid END) AS AvgEventsCount
        FROM
            ActivityBreakdown_EventsFiltered AS e
        GROUP BY
            e.sourceid,
            e.PeriodId,
            e.ClientDate
    ),
    Events AS
    (
        SELECT
            e.sourceid AS sourceid,
            -- Convert date to appropriate format to provide correct comparison
            e.ClientDate,
            MAX(E.SeViewerAddress) AS SeViewerAddress,
            --PeriodId differs only for average, so for current and last period it doesn't matter which agg function is taken
            MAX(CurrentEventsCount) AS CurrentEventsCount,
            MAX(LasEventsCount) AS LasEventsCount,
            --Average counting is not included current period
            AVG(AvgEventsCount) AS AvgEventsCount
        FROM
            PrepareEventsAvg AS e
        GROUP BY
            sourceid,
            e.ClientDate
    ),
    -- Check that CPU count is defined for all computers, where application run.
    -- Computers set, where application run, does not depend on specified period by design, as otherwise there is performance problems
    MachineCPUUndefinedFlag AS
    (
        SELECT
            sf.SOURCEID,
            MIN(COALESCE(m.CPUCount, -1)) AS CPUUndefinedFlag
        FROM
            #PROCESSFORSOURCE AS sf
            JOIN apm.Machine AS m (NOLOCK) ON sf.MACHINEID = m.MachineId
        GROUP BY
            sf.SOURCEID
    )
    SELECT
 -- Convert to ISO8601 format to work properly with VB Script. This cannot be done earlier as join is done on this fields
 CONVERT(DATETIME,  SourcesDates.ClientDate, 126) AS ClientDate,
        -- These fake fields are need to provide compatibility with SP ApplicationStatusDrillthrough
        1 AS Date,
        0 AS Hours,
        1 AS OutputDate,
        1 AS Period,
        SourcesDates.Sourceid,
        SourcesDates.Source AS Source,
        COALESCE(pc.CurReqCount, 0) AS CurMonitoredRequestSum,
        COALESCE(pc.LastReqCount, 0) AS LastMonitoredRequestSum,
        COALESCE(pc.AvgReqCount, 0) AS AvgMonitoredRequestSum,
        COALESCE(pc.CurAvgReqTime, 0) AS CurAvgReqTime,
        COALESCE(pc.LastAvgReqTime, 0) AS LastAvgReqTime,
        COALESCE(pc.AvgReqTime, 0) AS AvgReqTime,
        COALESCE(pc.CurCPUSum, 0) AS CurCPUValue,
        COALESCE(pc.lastCPUSum, 0) AS LastCPUValue,
        COALESCE(pc.AvgCPUSum, 0) AS AvgValue,
        COALESCE(pc.CurMemSum, 0) AS CurMemValue,
        COALESCE(pc.LastMemSum, 0) AS LastMemValue,
        COALESCE(pc.AvgMemSum, 0) AS AvgMemValue,
        COALESCE(pc.CurIOSum, 0) AS CurIOValue,
        COALESCE(pc.LastIOSum, 0) AS LastIOValue,
        COALESCE(pc.AvgIOSum, 0) AS AvgIOValue,
        COALESCE(e.CurrentEventsCount, 0) AS NewEventsCount,
        COALESCE(e.LasEventsCount, 0) AS OldEventsCount,
        COALESCE(e.AvgEventsCount, 0) AS AvgEventsCount,
        -- cpuFlag.CPUUndefinedFlag is null for current source if there is no one PCounter row
        -- in PerfHourly table for specified period. If so, there is no need to show message about it
        COALESCE(cpuFlag.CPUUndefinedFlag, 1) AS CPUUndefinedFlag,
        CASE LEFT(AppPool.AppPoolInfo,1)
            WHEN N'''' THEN N''
            WHEN N'' THEN ''
            ELSE REPLACE(LEFT(AppPool.AppPoolInfo, LEN(AppPool.AppPoolInfo)-1), N'''', N'')
        END AS pool,
        E.SeViewerAddress
    FROM
        SourcesDates
        LEFT OUTER JOIN MachineCPUUndefinedFlag AS cpuFlag ON SourcesDates.Sourceid = cpuFlag.Sourceid
        LEFT OUTER JOIN ActivePreparePCounters AS pc ON (pc.ClientDate = SourcesDates.ClientDate AND pc.SourceId = SourcesDates.Sourceid)
        LEFT OUTER JOIN Events AS e ON (e.ClientDate = SourcesDates.ClientDate AND e.Sourceid = SourcesDates.Sourceid)
        JOIN SourceAppPools AS AppPool ON (AppPool.Sourceid = SourcesDates.Sourceid)
    ORDER BY
        Source,
        ClientDate
END
GO
-------------------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ApplicationAnalysisExceptionEvents]    Script Date: 03/10/2014 00:35:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************/
/* OBJECT: Stored Procedure                                                         */
/* NAME: ApplicationAnalysisExceptionEvents                                             */
/* USED IN: Application Analysis report for exception events    */
/* INPUT PARAMETERS:                                                                */
/*      @STARTDATE - Start date of the priod                                        */
/*      @ENDDATE - End date of the period                                           */
/*      @SOURCEID - SourceId                                                        */
/*      @MACHINEIDS - List of machine Id, separated by comma. Exp: '4,5,6'          */
/*      @INCLUDESUBNET - List masks, which should be included                       */
/*      @EXCLUDESUBNET - List masks, which should be excluded                       */
/************************************************************************************/
ALTER PROCEDURE [apm].[ApplicationAnalysisExceptionEvents]
    @STARTDATE DATETIME,
    @ENDDATE DATETIME,
    @SOURCEID NVARCHAR(MAX),
    @MACHINEIDS NVARCHAR(MAX),
    @INCLUDESUBNET NVARCHAR(MAX),
    @EXCLUDESUBNET NVARCHAR(MAX),
    @PMSTATUS NVARCHAR(50)
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON
/****************************************************************************************/
/*                      ASSISTING TEMP TABLES                                           */
/****************************************************************************************/
SELECT
    @INCLUDESUBNET = REPLACE(@INCLUDESUBNET, N'*', N'%'),
    @EXCLUDESUBNET = REPLACE(@EXCLUDESUBNET, N'*', N'%')

-- Filter table, which contains machine ids
CREATE TABLE #MACHINEFILTERTABLE(
    VALUEID INT
)
-- Fill table #MACHINEFILTERTABLE
INSERT
    INTO #MACHINEFILTERTABLE
        SELECT
            CAST(p.value AS INT) AS VALUEID
        FROM
            --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
            APM.GetMultiParameters(@MACHINEIDS, N'') AS p
    -- Filter table, which contains PM Statuses of Events
    CREATE TABLE #PMSTATUSFILTERTABLE(
        VALUEID INT
    )
    -- Fill table #PMSTATUSFILTERTABLE
    INSERT
        INTO #PMSTATUSFILTERTABLE
            SELECT
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@PMSTATUS, N'') AS p
-- Filter table for SubnetC values
CREATE TABLE #SUBNETCFILTERTABLE
(
    IPID INT
)
-- Insert into filter id of the SubnetC to increase performence for event table
INSERT INTO #SUBNETCFILTERTABLE
SELECT DISTINCT
    ipid
FROM
    APM.IP AS ip (NOLOCK)
    JOIN APM.GetMultiParameters(CASE WHEN LEN(@INCLUDESUBNET) > 0 THEN @INCLUDESUBNET ELSE N'%' END, N'') AS p1 ON (ip.SubnetC LIKE p1.Value)
    LEFT OUTER JOIN APM.GetMultiParameters(CASE WHEN LEN(@EXCLUDESUBNET) > 0 THEN @EXCLUDESUBNET ELSE N'Fake' END, N'') AS p2 ON (ip.SubnetC LIKE p2.Value)
WHERE
--Exclude subnets which have correspondance in @EXCLUDESUBNET parameter
    p2.typeId IS NULL
;WITH RequestPCTypeId AS
(
    SELECT
        PCTypeID
    FROM
        APM.PCTYPE
    WHERE
        TYPE = N'\Apps\Monitored Requests'
),
RequestCount AS
(
    SELECT
        SUM(SUMVALUE) AS RequestCount
    FROM
        APM.PerfHourly AS ph (NOLOCK)
        -- Filter client events by machines
        JOIN #MACHINEFILTERTABLE AS f1 ON (ph.MachineId = f1.VALUEID)
        JOIN RequestPCTypeId AS pct ON pct.PCTypeID = ph.PCTypeID
    WHERE
        UTCDATE >= @STARTDATE
        AND UTCDATE < @ENDDATE
        AND ph.sourceid = @SOURCEID
),
EventDescription AS
(
    SELECT
        COUNT(CSEVENTID) AS EventCount,
        COUNT(DISTINCT CSEVENTGROUPID) AS ProblemCount,
        COUNT(CASE WHEN CHARINDEX(N'MSIE', E.BROWSER) > 0 THEN E.CSEVENTID ELSE NULL END) AS IEEventCount,
        COUNT(CASE WHEN CHARINDEX(N'Firefox', E.BROWSER) > 0 THEN E.CSEVENTID ELSE NULL END) AS FirefoxEventCount,
        DESCRIPTION
    FROM
        APM.CSEVENT AS e (NOLOCK)
        -- Filter client events by machines
        JOIN #MACHINEFILTERTABLE AS f1 ON (e.MachineId = f1.VALUEID)
        -- Filter client events by subnets
        JOIN #SUBNETCFILTERTABLE AS f2 ON (e.ipid = f2.IPID)
  JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMStatus)
    WHERE
        e.ClassType = N'exception'
        AND UTCDATE > @STARTDATE
        AND UTCDATE < @ENDDATE
        AND e.sourceid = @SOURCEID
    GROUP BY
        DESCRIPTION
),
OrderedDataSet AS
(
    SELECT
        ROW_NUMBER() OVER(ORDER BY E.EventCount DESC) AS id,
        EventCount,
        ProblemCount,
        IEEventCount,
        FirefoxEventCount,
        Description,
        SUM(E.EventCount) OVER() AS TotalEventCount,
        SUM(E.ProblemCount) OVER() AS TotalProblemCount
    FROM
        EventDescription AS e
)
SELECT
    TOP(10) E.*, req.RequestCount
FROM
    OrderedDataSet AS e
    CROSS JOIN RequestCount AS req
ORDER BY
    E.ID
END
GO
------------------------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ApplicationAnalysisOverallStatistics]    Script Date: 03/10/2014 00:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************/
/* OBJECT: Stored Procedure                                                         */
/* NAME: ApplicationAnalysisOverallStatistics                                       */
/* USED IN: Application Analysis report                                         */
/* INPUT PARAMETERS:                                                                */
/*      @STARTDATE - Start date of the priod                                        */
/*      @ENDDATE - End date of the period                                           */
/*      @SOURCEID - SourceId                                                        */
/*      @MACHINEIDS - List of machine Id, separated by comma. Exp: '4,5,6'          */
/*      @INCLUDESUBNET - List masks, which should be included                       */
/*      @EXCLUDESUBNET - List masks, which should be excluded                       */
/************************************************************************************/
ALTER PROCEDURE [apm].[ApplicationAnalysisOverallStatistics] 
    @STARTDATE DATETIME,
    @ENDDATE DATETIME,
    @SOURCEID NVARCHAR(MAX), 
    @MACHINEIDS NVARCHAR(MAX),
    @INCLUDESUBNET NVARCHAR(MAX),
    @EXCLUDESUBNET NVARCHAR(MAX),
 @PMSTATUS NVARCHAR(50)
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON
/****************************************************************************************/
/*                      ASSISTING TEMP TABLES                                           */
/****************************************************************************************/
SELECT
    @INCLUDESUBNET = REPLACE(@INCLUDESUBNET, N'*', N'%'),
    @EXCLUDESUBNET = REPLACE(@EXCLUDESUBNET, N'*', N'%')

-- Filter table, which contains machine ids
CREATE TABLE #MACHINEFILTERTABLE(
    VALUEID INT
)
-- Fill table #MACHINEFILTERTABLE
INSERT
    INTO #MACHINEFILTERTABLE
        SELECT
            CAST(p.value AS INT) AS VALUEID
        FROM
            --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
            APM.GetMultiParameters(@MACHINEIDS, N'') AS p
    -- Filter table, which contains PM Statuses of Events
    CREATE TABLE #PMSTATUSFILTERTABLE(
        VALUEID INT
    )
    -- Fill table #PMSTATUSFILTERTABLE
    INSERT
        INTO #PMSTATUSFILTERTABLE
            SELECT
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@PMSTATUS, N'') AS p
-- Filter table for SubnetC values
CREATE TABLE #SUBNETCFILTERTABLE
(
    IPID INT
)
-- Insert into filter id of the SubnetC to increase performence for event table
INSERT INTO #SUBNETCFILTERTABLE
SELECT DISTINCT
    ipid
FROM
    APM.IP AS ip (NOLOCK)
    JOIN APM.GetMultiParameters(CASE WHEN LEN(@INCLUDESUBNET) > 0 THEN @INCLUDESUBNET ELSE N'%' END, N'') AS p1 ON (ip.SubnetC LIKE p1.Value)
    LEFT OUTER JOIN APM.GetMultiParameters(CASE WHEN LEN(@EXCLUDESUBNET) > 0 THEN @EXCLUDESUBNET ELSE N'Fake' END, N'') AS p2 ON (ip.SubnetC LIKE p2.Value)
WHERE
--Exclude subnets which have correspondance in @EXCLUDESUBNET parameter
    p2.typeId IS NULL
CREATE TABLE #CLIENTEVENTS
(
    CSEVENTID INT,
    CSEVENTGROUPID INT,
    CLASSTYPE NVARCHAR(50) COLLATE DATABASE_DEFAULT
)
INSERT INTO #CLIENTEVENTS
    SELECT
        e.cseventid,
        e.csEventGroupId,
        e.ClassType
    FROM
        APM.CSEVENT AS e (NOLOCK)
        -- Filter client events by machines
        JOIN #MACHINEFILTERTABLE AS f1 ON (e.MachineId = f1.VALUEID)
        -- Filter client events by subnets
        JOIN #SUBNETCFILTERTABLE AS f2 ON (e.ipid = f2.IPID)
  JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMStatus)
    WHERE
        e.sourceid = @SOURCEID
        AND UTCDATE > @STARTDATE
        AND UTCDATE < @ENDDATE
;WITH RequestPCTypeId AS
(
    SELECT
        PCTypeID
    FROM
        APM.PCTYPE
    WHERE
        TYPE = N'\Apps\Monitored Requests'
),
RequestCount AS
(
    SELECT
        SUM(SUMVALUE) AS RequestCount
    FROM
        APM.PerfHourly AS ph
        -- Filter client events by machines
        JOIN #MACHINEFILTERTABLE AS f1 ON (ph.MachineId = f1.VALUEID)
        JOIN RequestPCTypeId AS pct ON pct.PCTypeID = ph.PCTypeID
    WHERE
        ph.sourceid = @SOURCEID
        AND UTCDATE > @STARTDATE
        AND UTCDATE < @ENDDATE  
),
AJAXEvents AS
(
    SELECT
        AVG(ajax.REQUESTSIZE + ajax.ResponseSize) AS AjaxCallSize,
        AVG(ajax.TotalTime) AS AjaxCallDuration,
        MAX(ajax.REQUESTSIZE + ajax.ResponseSize) AS MaxAjaxCallSize,
        MAX(ajax.TotalTime) AS MaxAjaxCallDuration,
        COUNT(ajax.CSEventId) AS AjaxCallCount
    FROM
        APM.CSAJAX AS ajax (NOLOCK)
        JOIN #CLIENTEVENTS AS e ON ajax.CSEventId = e.CSEVENTID
    WHERE
        e.CLASSTYPE = N'performance'
),
ExceptionEvents AS
(
    SELECT
        COUNT(CSEVENTID) AS EventCount,
        COUNT(CSEVENTGROUPID) AS ProblemCount
    FROM
        #CLIENTEVENTS AS e
    WHERE
        e.CLASSTYPE = N'exception'
),
PerformanceEvents AS
(
    SELECT
        COUNT(CSEVENTID) AS EventCount,
        COUNT(CSEVENTGROUPID) AS ProblemCount
    FROM
        #CLIENTEVENTS AS e
    WHERE
        e.CLASSTYPE = N'performance'
)
SELECT
    e.EventCount AS ExceptionEventsCount,
    e.ProblemCount AS ExceptionProblemCount,
    perf.EventCount AS PerformanceEventsCount,
    perf.ProblemCount AS PerformanceProblemCount,
    ajax.AjaxCallSize/1024.0 AS AjaxCallSize,
    ajax.AjaxCallDuration/1000.0 AS AjaxCallDuration,
    ajax.MaxAjaxCallSize/1024.0 AS MaxAjaxCallSize,
    ajax.MaxAjaxCallDuration/1000.0 AS MaxAjaxCallDuration,
    ajax.AjaxCallCount,
    req.RequestCount
FROM
    ExceptionEvents AS e
    CROSS JOIN PerformanceEvents AS perf
    CROSS JOIN RequestCount AS req
    CROSS JOIN AJAXEvents AS ajax
END
GO
-------------------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ApplicationResourceUtilization]    Script Date: 03/10/2014 00:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************/
/* OBJECT: Stored Procedure                                                         */
/* NAME: ApplicationResourceUtilization                                             */
/* USED IN: Application ResourceUtilization report                                  */
/* INPUT PARAMETERS:                                                                */
/*      @DATESTART - Start date of the priod                                        */
/*      @DATEEND - End date of the period                                           */
/*      @SOURCEIDS - List of source Id, separated by comma. Exp: '1,2,3'            */
/*      @MACHINEIDS - List of machine Id, separated by comma. Exp: '4,5,6'          */
/*      @SORTORDER - Specifies field to which sorting should be applayed            */
/*                  1. CPU value                                                    */
/*                  2. Memory value                                                 */
/*                  3. I/O value                                                    */
/*                  4. Request count                                                */
/*      @TOPROWCOUNT - defines number of top rows, which will be returned           */
/************************************************************************************/
ALTER PROCEDURE [apm].[ApplicationResourceUtilization]
    @DATESTART DATETIME,
    @DATEEND DATETIME,
    @SOURCEIDS NVARCHAR(MAX),
    @MACHINEIDS NVARCHAR(MAX),
    @SORTORDER INT,
    @TOPROWCOUNT INT
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON
/****************************************************************************************/
/*                      ASSISTING TEMP TABLES                                           */
/****************************************************************************************/
-- Filter table, which contains machine ids and source ids
-- typeid defines filter type - 1 for source and 2 for machine
-- valueId filter value - source id and machine id
CREATE TABLE #SOURCEMACHINEFILTERTABLE(
    TYPEID INT,
    VALUEID INT
)
-- Fill table #SOURCEMACHINEFILTERTABLE
INSERT
    INTO #SOURCEMACHINEFILTERTABLE
        SELECT
            p.typeId AS TYPEID,
            CAST(p.value AS INT) AS VALUEID
        FROM
            --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter 
            APM.GetMultiParameters(@SOURCEIDS, @MACHINEIDS) AS p
-- Filter PerfHourly table to decrease nummber of rows for further manipulations.
-- Filtering by sources could not be done as some of the filtered sources can be in app pools,
-- so they should present in calculations
CREATE TABLE #PERFHOURLYFILTERBYMACHINE
(
        UTCDate DATETIME,
        SOURCEID INT,
        MACHINEID INT,
        PCPROCESSID INT,
        SUMVALUE FLOAT,
        SAMPLECOUNT BIGINT,
        PACKAGECOUNTER BIGINT,
        MAXVALUE FLOAT,
        TYPE NVARCHAR(MAX) collate database_default
)
--Fill table #PERFHOURLYFILTERBYMACHINE
INSERT
    INTO #PERFHOURLYFILTERBYMACHINE
        SELECT
            ph.UTCDate,
            ph.sourceId,
            ph.MachineId,
            ph.pcprocessId,
            ph.SumValue,
            ph.SampleCount,
            ph.PackageCounter,
            ph.MaxValue,
            t.Type
        FROM
            APM.PerfHourly AS ph (NOLOCK)
            JOIN APM.PCType AS t (NOLOCK) ON t.pctypeid = ph.pctypeid
            --Join with #SOURCEMACHINEFILTERTABLE provides filtering perfHourly by machineid
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 2 AND f.VALUEID = ph.MachineId)
        WHERE
            ph.UTCDate >= @DATESTART
            AND ph.UTCDate < @DATEEND
            AND t.type IN
                (
                    N'\Process\% Processor Time',
                    N'\Process\IO Data Bytes/sec',
                    N'\Process\Private Bytes',
                    N'\Apps\Monitored Requests',
                    -- 'Processor% Processor Time' counter is taken to calculate application activity,
                    -- relative to hours, when machine sent counter
                    N'\Processor\% Processor Time'
                )
--Assisting table for application pool forming
CREATE TABLE #PROCESSNAMEFORSOURCE(
    SOURCE NVARCHAR(255) collate database_default,
    SOURCEID INT,
    MACHINEID INT,
    EXTRAINFO NVARCHAR(MAX) collate database_default,
    PROCESS NVARCHAR(255) collate database_default
)
-- Insert source and machine with correspondent process name and extrainfo
-- Here machine is used, as same source with same process name can run in different machines
INSERT INTO #PROCESSNAMEFORSOURCE
    SELECT DISTINCT
        S.Source,
        ph.SOURCEID,
        ph.MACHINEID,
        COALESCE(p.Extrainfo, N'') AS EXTRAINFO,
        --Select process name till # symbol (w3wp#1 -> w3wp, w3wp -> w3wp)
        APM.RemoveProcessIdFromName(p.Process) AS Process
    FROM
        #PERFHOURLYFILTERBYMACHINE AS ph
        JOIN APM.Source AS s (NOLOCK) ON ph.SOURCEID = s.sourceId
        JOIN APM.PCProcess AS p (NOLOCK) ON p.pcprocessId = ph.PCPROCESSID
/********************************************************************************/
/*                                  MAIN QUERY                                  */
/********************************************************************************/
--Get sources name, ids list separated by comma per app pool
;WITH AppPoolInfo AS
(
    SELECT
        c.EXTRAINFO,
        c.PROCESS,
        c.MACHINEID,
        -- all source names which have the same process name as passed in @SOURCEIDS
        (SELECT A.source AS [data()]
            FROM
            (
                SELECT DISTINCT
                    N'''' + c1.SOURCE + N'''' +  N',' AS source
                FROM
                    #PROCESSNAMEFORSOURCE AS c1
                WHERE
                    c1.EXTRAINFO = c.EXTRAINFO
                    AND c1.PROCESS = c.PROCESS
                    AND c1.MACHINEID = c.MACHINEID
            ) AS A
            FOR XML PATH ('')
        ) AS AppPoolSources,
        --Select SourceIds list for application pool, this string is need to avoid drillthrought to other reports
        (SELECT A.source AS [data()]
            FROM
            (
                SELECT DISTINCT
                    CAST(c1.SOURCEID AS NVARCHAR(5)) + N',' AS source
                FROM
                    #PROCESSNAMEFORSOURCE AS c1
                WHERE
                    c1.EXTRAINFO = c.EXTRAINFO
                    AND c1.PROCESS = c.PROCESS
                    AND c1.MACHINEID = c.MACHINEID
            ) AS A
            FOR XML PATH ('')
        ) AS SourceIds

    FROM
        #PROCESSNAMEFORSOURCE AS c
        JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = c.SOURCEID)
    GROUP BY
        c.EXTRAINFO,
        c.PROCESS,
        c.MACHINEID
),
-- Filter sources for which data should be selected;
-- as info should be selected not only for transfered sources, but also for sources
-- in the same app pool
SourceFilter AS
(
--One application can be in the several app pools, so use DISTINCT
    SELECT DISTINCT
        s2.SOURCEID
    FROM
        #PROCESSNAMEFORSOURCE AS s1
        JOIN #PROCESSNAMEFORSOURCE AS s2 ON s1.EXTRAINFO = s2.EXTRAINFO AND s1.PROCESS = s2.PROCESS
        JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND s1.SOURCEID = f.VALUEID)
),
--Filter PerfHourly by source
PerfHourlyBySource AS
(
    SELECT
        ph.UTCDate,
        ph.PCPROCESSID,
        ph.MACHINEID,
        ph.SUMVALUE,
        ph.SAMPLECOUNT,
        ph.PACKAGECOUNTER,
        ph.MAXVALUE,
        ph.SOURCEID,
        ph.TYPE
    FROM
        #PERFHOURLYFILTERBYMACHINE AS ph (NOLOCK)
        JOIN SourceFilter AS s ON s.SOURCEID = ph.SOURCEID
),
--Calculate resource utilization by processes on machines in one hour
ProcessHourlyResourceUtilization AS
(
    SELECT
        ph.MachineId,
        ph.UTCDate,
        ph.pcprocessId,
        ph.Type,
        -- Select MAX value as in case of app pool, some of the application
        -- could work not whole hour, and the value should be taken for the
        -- application worked for the longest period
        MAX(ph.SumValue) AS SumValue,
        MAX(ph.MaxValue) AS MaxValue,
        MAX(ph.SampleCount) AS SampleCount,
        MAX(ph.PackageCounter) AS PackageCounter
    FROM
        PerfHourlyBySource AS ph
    WHERE
        --This condition allows to exclude Monitored Requests counter
        PCProcessId IS NOT NULL
    GROUP BY
        ph.MachineId,
        ph.UTCDate,
        ph.pcprocessId,
        ph.Type
),
-- Calculate resource utilization by application in one hour.
-- Here "application" means - for web application = AppPool, otherwise = processname
ApplicationHourlyResourceUtilization AS
(
    SELECT
        ph.MachineId,
        ph.UTCDate,
        ph.Type,
        SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter) AS InstanceCount,
        --Select process name till # symbol
        APM.RemoveProcessIdFromName(p.Process) AS ProcessName,
        COALESCE(p.ExtraInfo, N'') AS ProcessExtraInfo,
        SUM(SumValue)/SUM(SampleCount) AS AvgValue,
        MAX(ph.MaxValue) AS MaxValue
    FROM
        ProcessHourlyResourceUtilization AS ph
        JOIN APM.PCProcess AS p (NOLOCK) ON ph.PCProcessId = p.PCProcessId
    GROUP BY
        ph.MachineId,
        ph.UTCDate,
        ph.Type,
        APM.RemoveProcessIdFromName(p.Process),
        p.ExtraInfo
),
--Calculate average application resource utilization over all specified period per machine
ApplicationResourceUtilizationByMachines AS
(
    SELECT
        ph.MachineId,
        ph.ProcessName,
        ph.ProcessExtraInfo,
        -- Number of hours when application was active
        COUNT(DISTINCT ph.UTCDate) AS ApplicationAvailabilityHours,
        -- Instance count should be same for different resource types in one hour for one process
        -- and averaging them won't make any difference but allow to avoid one aggregation step  
        AVG(ph.InstanceCount) AS InstanceCount,
        MAX(ph.InstanceCount) AS MaxInstanceCount,
        AVG(CASE WHEN InstanceCount < 1 THEN InstanceCount ELSE 1 END) AS AppActivity,
        AVG(CASE WHEN ph.type = N'\Process\% Processor Time' THEN ph.AvgValue END) AS CPUAvgValue,
        AVG(CASE WHEN ph.type = N'\Process\IO Data Bytes/sec' THEN ph.AvgValue END) AS IOAvgValue,
        AVG(CASE WHEN ph.type = N'\Process\Private Bytes' THEN ph.AvgValue END) AS MemoryAvgValue,
        MAX(CASE WHEN ph.type = N'\Process\% Processor Time' THEN ph.MaxValue END) AS CPUMaxValue,
        MAX(CASE WHEN ph.type = N'\Process\IO Data Bytes/sec' THEN ph.MaxValue END) AS IOMaxValue,
        MAX(CASE WHEN ph.type = N'\Process\Private Bytes' THEN ph.MaxValue END) AS MemoryMaxValue
    FROM
        ApplicationHourlyResourceUtilization AS ph
    GROUP BY
        ph.MachineId,
        ph.ProcessName,
        ph.ProcessExtraInfo
),
-- Count hours when computer sent counters.
-- This value is used to calculate application activity between hours
ComputerAvailabilityHours AS
(
    SELECT
        COUNT(DISTINCT ph.UTCDate) AS HoursCount,
        ph.MACHINEID
    FROM
        #PERFHOURLYFILTERBYMACHINE AS ph
    WHERE
        ph.SOURCEID IS NULL
        AND ph.PCPROCESSID IS NULL
        AND ph.TYPE = N'\Processor\% Processor Time'
    GROUP BY
        ph.MACHINEID
),
-- Count Monitored Requests for Application on each machine
-- as source can run on different machines with same process name and app pool, but different sources set,
-- it is important to group by machine to, to avoid calculation of requests from the other app pool
ApplicationRequestCountByMachine AS
(
    SELECT
        ph.MACHINEID,
        c.EXTRAINFO,
        c.PROCESS,
        SUM(ph.SUMVALUE) AS RequestCount
    FROM
        PerfHourlyBySource AS ph
        -- If source was running in several app pools  
        -- #PROCESSNAMEFORSOURCE would contain several rows for one sourceid.
        -- In this case request count will be counted for all app pools
        JOIN #PROCESSNAMEFORSOURCE AS c ON (ph.SOURCEID = c.SOURCEID AND ph.MACHINEID = c.MACHINEID)
    WHERE
        ph.TYPE = N'\Apps\Monitored Requests'
    GROUP BY
        ph.MACHINEID,
        c.EXTRAINFO,
        c.PROCESS
),
--Summary application resource utilization info by machines
ApplicationResourceUtilization AS
(
    SELECT
        -- Enumerate computers within application by specified orderBy value
        ROW_NUMBER() OVER (PARTITION BY
-- Application pool sources added to grouping as on different machines app pool with the same names
-- can contain different sources set, and app pools assumed to be same only
-- if its name and sources set are the same
                        appPool.ExtraInfo,
                        appPool.Process,
                        appPool.AppPoolSources
                        ORDER BY
                        CASE @SORTORDER
                            WHEN 1 THEN ph.CPUAvgValue/COALESCE(m.CPUCount, 1)
                            WHEN 2 THEN ph.MemoryAvgValue
                            WHEN 3 THEN ph.IOAvgValue
                            WHEN 4 THEN r.RequestCount
                        END DESC) AS ComputerId,
        m.machine,
        m.MachineId,
        COALESCE(m.CpuCount, 1) AS CPUCount,
        appPool.ExtraInfo,
        appPool.Process,
        -- Remove comma form the end of source list
        CASE appPool.AppPoolSources WHEN '' THEN '' ELSE LEFT(appPool.AppPoolSources, LEN(appPool.AppPoolSources)-1) END AS AppPoolSources,
        -- Use application activity during all period for instance count calculation and application activity
        InstanceCount*ph.ApplicationAvailabilityHours*1.0/mc.HoursCount AS InstanceCount,
        AppActivity*ph.ApplicationAvailabilityHours*1.0/mc.HoursCount AS AppActivity,
        MaxInstanceCount AS MaxInstanceCount,
        -- CPU load should be normalized on core count for each machine
        CPUAvgValue/COALESCE(m.CPUCount, 1) AS CPUAvgValue,
        CPUMaxValue/COALESCE(m.CPUCount, 1) AS CPUMaxValue,
        IOAvgValue AS IOAvgValue,
        IOMaxValue AS IOMaxValue,
        MemoryAvgValue AS MemoryAvgValue,
        MemoryMaxValue AS MemoryMaxValue,
        r.RequestCount AS RequestCount,
        appPool.SourceIds,
        -- Flag to define if cpu count is not null,
        -- in case of  CPUDefineFlag = 0, show warning message about it in report
        COALESCE(m.CPUCount, 0) AS CPUDefineFlag,
        -- Calculate average value for SortBy field for application over all its machines
        -- This value will be used to enumerate application by specified OrderBy Value
        AVG(CASE @SORTORDER
                WHEN 1 THEN ph.CPUAvgValue/COALESCE(m.CPUCount, 1)
                WHEN 2 THEN ph.MemoryAvgValue
                WHEN 3 THEN ph.IOAvgValue
            END)
            OVER (PARTITION BY appPool.ExtraInfo,
                        appPool.Process,
                        AppPoolSources  ) AS OrderByValue,
        -- For order by requests sum of requests should be calculated
        SUM(r.RequestCount) OVER(PARTITION BY appPool.ExtraInfo,
                        appPool.Process,
                        AppPoolSources) AS ApplicationRequestCount
    FROM
        ApplicationResourceUtilizationByMachines AS ph
        JOIN AppPoolInfo AS appPool ON (appPool.ExtraInfo = ph.ProcessExtraInfo AND
                                appPool.Process = ph.ProcessName AND
                                appPool.MachineId = ph.MachineId)
        LEFT OUTER JOIN ApplicationRequestCountByMachine AS r ON (ph.ProcessName = r.Process
                                                                AND ph.ProcessExtraInfo = r.ExtraInfo
                                                                AND ph.MachineId = r.MachineId)
        JOIN ComputerAvailabilityHours AS mc ON mc.MachineId = ph.MachineId
        JOIN APM.Machine AS m (NOLOCK) ON m.MachineId = ph.MachineId
),
-- Value of Id field is duplicated for each application.
OrderedDataSet AS
(
    SELECT
        -- DENSE_RANK function returns equal id for equal values in Over expression
        -- This allow to enumerate Application within result set by specified order by value
        DENSE_RANK() OVER(ORDER BY
                            (CASE
                                WHEN @SORTORDER = 4 THEN ApplicationRequestCount
                                ELSE OrderByValue
                            END) DESC,
                            ExtraInfo,
                            AppPoolSources  ) AS Id,
        OrderByValue,
        ComputerId,
        machine,
        MachineId,
        CPUCount,
        CASE
            WHEN LEN(ExtraInfo) > 0 THEN ExtraInfo + N' - '+ AppPoolSources
            -- remove quotes from the start and end of the source name
            ELSE CASE AppPoolSources WHEN '' THEN '' ELSE SUBSTRING(AppPoolSources, 2, LEN(AppPoolSources)-2) END
        END AS AppPoolName,
        CASE
            WHEN LEN(ExtraInfo) > 0 THEN ExtraInfo  
            ELSE CASE AppPoolSources WHEN '' THEN '' ELSE SUBSTRING(AppPoolSources, 2, LEN(AppPoolSources)-2) END
        END AS ApplicationName,
        InstanceCount,
        MaxInstanceCount,
        AppActivity,
        CPUAvgValue,
        CPUMaxValue,
        IOAvgValue/1024 AS IOAvgValue,
        IOMaxValue/1024 AS IOMaxValue,
        MemoryAvgValue/(1024*1024) AS MemoryAvgValue,
        MemoryMaxValue/(1024*1024) AS MemoryMaxValue,
        RequestCount,
        SourceIds,
        CPUDefineFlag
    FROM
        ApplicationResourceUtilization
)
SELECT
    *
FROM
    OrderedDataSet
WHERE
    Id <= @TOPROWCOUNT
ORDER BY
    Id
END
GO

--------------------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ApplicationStatusClient]    Script Date: 03/10/2014 00:40:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************/
/* OBJECT: Stored Procedure                                                             */
/* NAME: ApplicationStatusClient                                                        */
/* USED IN: Application Status Client Report                                            */
/* INPUT PARAMETERS:                                                                    */
/*      @SOURCEIDS      - List of the source id, separated by comma. Exp: '1,2,3'       */
/*      @COMPUTERIDS    - List of the computer id, separated by comma. Exp: '1,2,3'     */
/*      @ENDDATE        - End date of the period (in Client timezone)                   */
/*      @PERIOD         - Period type(Day, Week or Month).                              */  
/*                      - Use for the Start Date calculate of the period                */
/*      @AVERAGEINTERVAL- This value specifies interval, for which average values will  */
/*                          be calculated. Possible values: 1(1 month), 2(2 month),     */
/*                          3(3 month), 6(6 month), 17 (7 day)                          */
/*      @TRESHOLD       - Event duration treshold                                       */
/*      @PROBLEM        - Event problem type (all, critical)                            */
/*      @INCLUDESUBNET - List masks, which should be included                           */
/*      @EXCLUDESUBNET - List masks, which should be excluded                           */
/*      @WARNINGTHRESHOLD - Threshold specified by user to notify about warning     */
/*      @ERRORTHRESHOLD - Threshold specified by user to notify about errors        */
/*      @TIMEZONE       - correlate parameter (timezone by min) to return result        */
/*                          in clien timezone                                           */
/****************************************************************************************/
ALTER PROCEDURE [apm].[ApplicationStatusClient]
    @SOURCEIDS NVARCHAR(MAX),
    @COMPUTERIDS NVARCHAR(MAX),
    @ENDDATE DATETIME,
    @PERIOD INT,
    @AVERAGEINTERVAL INT,
    @THRESHOLD INT,
    @PROBLEM NVARCHAR(10),
    @INCLUDESUBNET NVARCHAR(MAX),
    @EXCLUDESUBNET NVARCHAR(MAX),
    @ERRORTHRESHOLD INT,
    @WARNINGTHRESHOLD INT,
    @TIMEZONE INT,
    @PMSTATUS NVARCHAR(50)
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
      @INCLUDESUBNET = REPLACE(@INCLUDESUBNET, N'*', N'%'),
      @EXCLUDESUBNET = REPLACE(@EXCLUDESUBNET, N'*', N'%')

/************************************************************************************/
/*  Prepare auxiliary variables for the further calculation                         */
/************************************************************************************/
    DECLARE @CLIENTENDDATE DateTime
    SET @CLIENTENDDATE = @ENDDATE

    --Convert End date to UTC
    SET @ENDDATE = DATEADD(minute, -@TIMEZONE, @CLIENTENDDATE)
    --Used for counting average value for last three months
    DECLARE @PERIODDAYSCOUNT int
    SET @PERIODDAYSCOUNT = (CASE    
                                WHEN @PERIOD = 1 THEN 1
                                WHEN @PERIOD = 2 THEN 7
                                WHEN @PERIOD = 3 THEN 31
                            END)
    DECLARE @STARTDATE DateTime
    SET @STARTDATE = DATEADD(d, -@PERIODDAYSCOUNT, @ENDDATE)
    DECLARE @CLIENTSTARTDATE DateTime
    SET @CLIENTSTARTDATE = DATEADD(d, -@PERIODDAYSCOUNT, @CLIENTENDDATE)

    DECLARE @HOURSCOUNT int
    SET @HOURSCOUNT = (CASE
                                WHEN @PERIOD = 1 THEN 24
                                WHEN @PERIOD = 2 THEN 24
                                WHEN @PERIOD = 3 THEN 1 -- Every day of the month have one hour - 00:00
                            END)
    DECLARE @LASTPERIODSTARTDATE DateTime
    SET @LASTPERIODSTARTDATE = DATEADD(d, -@PERIODDAYSCOUNT, @STARTDATE)
    DECLARE @AVERAGEPERIODSTARTDATE DateTime
    SET @AVERAGEPERIODSTARTDATE = (CASE
                                        WHEN @AVERAGEINTERVAL < 10 THEN DATEADD(month, -@AVERAGEINTERVAL, @STARTDATE)
                                        ELSE DATEADD(day, -(@AVERAGEINTERVAL-10), @STARTDATE)
                                   END)

    DECLARE @PROCESSORCOUNTERID INT
    SELECT @PROCESSORCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE type = N'\Process\% Processor Time'
    DECLARE @MEMORYCOUNTERID INT
    SELECT @MEMORYCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE type = N'\Process\Private Bytes'
    DECLARE @IOCOUNTERID INT
    SELECT @IOCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE type = N'\Process\IO Data Bytes/sec'
    DECLARE @MONITOREDREQUESTCOUNTERID INT
    SELECT @MONITOREDREQUESTCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE type = N'\Apps\Monitored Requests'
    DECLARE @REQUESTTIMECOUNTERID INT
    SELECT @REQUESTTIMECOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE type = N'\Apps\Avg. Request Time'
/************************************************************************************/
/*                          ASSISTING TEMP TABLES                                   */
/************************************************************************************/
    -- Filter table, which contains machine ids and source ids
    -- typeid defines filter type - 1 for source and 2 for machine
    -- valueId filter value - source id and machine id
    CREATE TABLE #SOURCEMACHINEFILTERTABLE(
        TYPEID INT,
        VALUEID INT
    )
    -- Fill table #SOURCEMACHINEFILTERTABLE
    INSERT
        INTO #SOURCEMACHINEFILTERTABLE
            SELECT
                p.typeId AS TYPEID,
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@SOURCEIDS, @COMPUTERIDS) AS p
    -- Filter table, which contains PM Statuses of Events
    CREATE TABLE #PMSTATUSFILTERTABLE(
        VALUEID INT
    )
    -- Fill table #PMSTATUSFILTERTABLE
    INSERT
        INTO #PMSTATUSFILTERTABLE
            SELECT
                CAST(p.VALUE AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@PMSTATUS, N'') AS p
    -- Filter table for SubnetC values
    CREATE TABLE #SUBNETCFILTERTABLE
    (
        IPID INT,
        SUBNETC NVARCHAR(50) collate database_default  
    )
    -- Insert into filter id of the SubnetC to increase performance for event table
    INSERT INTO #SUBNETCFILTERTABLE
    SELECT DISTINCT
        ipid,
        SubNetC
    FROM
        apm.IP AS ip (NOLOCK)
        JOIN APM.GetMultiParameters(CASE WHEN LEN(@INCLUDESUBNET) > 0 THEN @INCLUDESUBNET ELSE N'%' END, N'') AS p1 ON (ip.SubnetC LIKE p1.Value)
        LEFT OUTER JOIN APM.GetMultiParameters(CASE WHEN LEN(@EXCLUDESUBNET) > 0 THEN @EXCLUDESUBNET ELSE N'Fake' END, N'') AS p2 ON (ip.SubnetC LIKE p2.Value)
    WHERE
    --Exclude subnets which have correspondance in @EXCLUDESUBNET parameter
        p2.typeId IS NULL

    -- To form application pool with all sources run in it, it is need to get all sources and its process
    CREATE TABLE #PROCESSFORSOURCE
    (
        SOURCEID INT,
        PCPROCESSID INT,
        MACHINEID INT,
        EXTRAINFO NVARCHAR(255) collate database_default,
        PROCESS NVARCHAR(255) collate database_default
    )

    INSERT INTO #PROCESSFORSOURCE
        SELECT
            ph.SourceId,
            ph.PCProcessId,
            ph.MachineId,
            COALESCE(p.Extrainfo, N'') AS EXTRAINFO,
            --Select process name till # symbol (w3wp#1 -> w3wp, w3wp -> w3wp)
            APM.RemoveProcessIdFromName(p.Process) AS Process
        FROM
            (
                SELECT DISTINCT
                    ph.SourceId,
                    ph.pcprocessId,
                    ph.MachineId
                FROM
                    apm.PerfHourly AS ph (NOLOCK)
                WHERE
                    ph.pcprocessId IS NOT NULL
                    AND ph.UTCDate >= @STARTDATE
                    AND ph.UTCDate < @ENDDATE
            ) AS ph
            JOIN apm.PCProcess AS p (NOLOCK) ON p.pcprocessId = ph.pcprocessId 
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 2 AND ph.MachineId = f.VALUEID)

/************************************************************************************/
/*                          Main query                                              */
/************************************************************************************/
-- Report frame. It contains all sources, for which values sould be selected,
-- and dates for the specified period (StartDate : EndDate)  
;WITH SourcesDates AS
(
    SELECT
        s.SourceId,
        s.source AS source,
        s.RowId,
        s.IsClient,
        -- Select 1, 7 or 31 day from end date in ClientTime zone, without hours.
        -- After that add appropriate hours
        DATEADD(HOUR, h.n-1, CONVERT(NVARCHAR, DATEADD(d, -d.n, @CLIENTENDDATE), 112)) AS ClientDate
    FROM
        (SELECT
                ROW_NUMBER() OVER(
                                PARTITION BY
                                        CASE WHEN s.Source like N'%(Client)' THEN 1
                                            ELSE 0
                                        END
                                ORDER BY
                                    S.Source
                                ) AS RowId,
                                
                s.Source,
                S.SourceId,
                (CASE WHEN s.Source like N'%(Client)' THEN 1
                    ELSE 0
                END ) AS IsClient
            FROM
                apm.SOURCE AS s
                JOIN #SOURCEMACHINEFILTERTABLE AS sourceFilter ON s.SourceId = sourceFilter.VALUEID
            WHERE
                sourceFilter.TYPEID = 1
        ) AS S
        CROSS JOIN APM.fn_nums(@PERIODDAYSCOUNT) AS d
        CROSS JOIN APM.fn_nums(@HOURSCOUNT) AS h
),
-- Get sources name, ids list separated by comma per app pool
-- This info should be selected for all sources, even they are in the same application pool
-- as in this report grouping by source is applied not by application pool.
    AppPoolInfo AS
    (
        SELECT
            c.SOURCEID,
            c.EXTRAINFO,
            c.PROCESS,
            -- all source names which have the same process name as passed in @SOURCEIDS
            (SELECT A.source AS [data()]
                FROM
                (
                    SELECT DISTINCT
                        N'''' + s.source + N'''' +  N',' AS source
                    FROM
                        #PROCESSFORSOURCE AS c1
                        JOIN Source AS s ON c1.SOURCEID = s.SourceId
                    WHERE
                        c1.EXTRAINFO = c.EXTRAINFO
                        AND c1.PROCESS = c.PROCESS
                        AND c1.MACHINEID = c.MACHINEID
                ) AS A
                FOR XML PATH ('')
            ) AS AppPoolSources
        FROM
            #PROCESSFORSOURCE AS c
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = c.SOURCEID)
        GROUP BY
            c.SOURCEID,
            c.MACHINEID,
            c.EXTRAINFO,
            c.PROCESS
    ),
    --Add Pool name in-front of source list, if it is executable application, then app pool countains source name
    PrepareAppPoolInfo AS (
        SELECT DISTINCT
            CASE
                WHEN COALESCE(info.ExtraInfo,'') = '' THEN CASE info.AppPoolSources WHEN '' THEN '' ELSE LEFT(info.AppPoolSources, LEN(info.AppPoolSources)-1) END
                ELSE info.ExtraInfo + CASE info.AppPoolSources WHEN '' THEN '' ELSE ' (' + LEFT(info.AppPoolSources, LEN(info.AppPoolSources) - 1) + ')' END
            END AppPool,
            info.SourceId,
            info.ExtraInfo
        FROM
            AppPoolInfo AS info
    ),
-- Forms application pool list for each source
-- Format: AppPool1 ('Source1', 'Source2', Source3), AppPool2 ('Source1', 'Source4')
    SourceAppPools AS (
        SELECT
            s.SourceId,
            s.Source,
            COALESCE((SELECT a.AppPool AS [data()]
                FROM
                (
                    SELECT DISTINCT
                        info.AppPool +  N',' AS AppPool
                    FROM
                        PrepareAppPoolInfo as info
                    WHERE
                        info.Sourceid = s.Sourceid
                ) AS A
                FOR XML PATH ('')
            ),s.Source +  '-') AS AppPoolInfo
        FROM
            apm.Source AS s
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = s.SourceId)
    ),
    --Prepares and filters server events for further manipulations
    ApplicationStatusClient_EventsFiltered AS
    (
        SELECT
            e.sourceid,
            e.eventid,
            -- this field is need to determine number of days when
            -- there were some events in DB. If number of days is less than 7,
            -- then it is supposed that average valu is not correct enought
            DATEDIFF(DAY, DATEADD(mi, @TIMEZONE, e.utceventdate), @CLIENTSTARTDATE) AS EventFillFactor,
            --Removing APM.GetDatePart replacing the execution by the code below.
            --It boosts the overall performance as it reduces the number of calls of scalar function
            CASE @PERIOD
                WHEN 3 THEN CONVERT(NVARCHAR, DATEADD(mi, @TIMEZONE, e.utceventdate), 112)
                ELSE DATEADD(hh,
                            DATEPART(hh, DATEADD(mi, CAST(@TIMEZONE AS int), e.utceventdate)),
                    CONVERT(NVARCHAR, DATEADD(mi, @TIMEZONE, e.utceventdate), 112))
            END as Date,
            --hour is taken as DateDifference in day between 05/04/2009 9:00AM and 05/03/2009 9:00PM is one day,
            --despite in case of @PERIOD = 'Day' it can be interpretated as one day (if 05/04/2009 9:00AM is end date), so difference should be taken as 0
            (DATEDIFF(hour, e.utceventdate, @ENDDATE)-1) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            apm.Event AS e (NOLOCK)
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.VALUEID = e.sourceid and f1.TYPEID = 1)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.VALUEID = e.machineid and f2.TYPEID = 2)
            JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMStatus)
        WHERE
            ((e.EventClassType = N'Performance' AND e.eventduration/1000000.0 >= @THRESHOLD )
            OR e.EventClassType = N'exception')
            AND (e.category LIKE @PROBLEM OR e.category IS NULL)
            AND e.utceventdate >= @AVERAGEPERIODSTARTDATE
            AND e.utceventdate < @ENDDATE
    ),
    PrepareEventsServerAvg AS
    (
        SELECT
            e.sourceid AS sourceid,
            e.PeriodId,
            -- PeriodId is 0 for the current period, 1 for last and 1..n for average
            -- This manipulation should shift Client date to current period for
            -- other periods - average and last. Client date is in client time zone
            DATEADD(day, e.PeriodId*@PERIODDAYSCOUNT, e.Date) AS ClientDate,
            MAX(EventFillFactor) AS EventFillFactor,
            COUNT(CASE WHEN e.PeriodId = 0 THEN eventid END) AS CurrentEventsCount,
            COUNT(CASE WHEN e.PeriodId = 1 THEN eventid END) AS LastEventsCount,
            COUNT(CASE WHEN PeriodId > 0 THEN eventid END) AS AvgEventsCount
        FROM
            ApplicationStatusClient_EventsFiltered AS e
        GROUP BY
            e.SourceId,
            e.PeriodId,
            e.Date
    ),
    EventsServer AS
    (
        SELECT
            e.sourceid AS sourceid,
            e.ClientDate,
            MAX(EventFillFactor) AS EventFillFactor,
            MAX(CurrentEventsCount) AS CurrentEventsCount,
            MAX(LastEventsCount) AS LastEventsCount,
            AVG(CASE WHEN PeriodId > 0 THEN AvgEventsCount*1.0 END) AS AvgEventsCount
        FROM
            PrepareEventsServerAvg AS e
        GROUP BY
            sourceid,
            e.ClientDate
    ),

/****************************************************************************************************************/
/*                          Section selects client events                                                       */  
/****************************************************************************************************************/
    -- Select Client Side events
    ApplicationStatusClient_ClientEventsFiltered AS
    (
        SELECT
            e.SourceId,
            e.CSEventId AS EventId,
            -- this field is need to determine number of days when
            -- there were some events in DB. If number of days is less than 7,
            -- then it is supposed that average value is not correct enought
            DATEDIFF(DAY, DATEADD(mi, @TIMEZONE, e.utcdate), @CLIENTSTARTDATE) AS EventFillFactor,
            -- If specified period is Month then take only date part
            -- In other cases round date to hours, without minutes and seconds
            CASE @PERIOD
                WHEN 3 THEN CONVERT(NVARCHAR, DATEADD(mi, @TIMEZONE, e.utcdate), 112)
                ELSE DATEADD(hh,
                            DATEPART(hh, DATEADD(mi, CAST(@TIMEZONE AS int), e.utcdate)),
                    CONVERT(NVARCHAR, DATEADD(mi, @TIMEZONE, e.utcdate), 112))
            END as Date,
            --hour is taken as DateDifference in day between 05/04/2009 9:00AM and 05/03/2009 9:00PM is one day,
            --despite in case of @PERIOD = 'Day' it can be interpretated as one day (if 05/04/2009 9:00AM is end date), so difference should be taken as 0
            (DATEDIFF(hour, e.utcdate, @ENDDATE)- 1) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            apm.CSEvent AS e (NOLOCK)
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.VALUEID = e.sourceid and f1.TYPEID = 1)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.VALUEID = e.machineid and f2.TYPEID = 2)
            JOIN #SUBNETCFILTERTABLE AS f3 ON e.ipid = f3.IPID
   JOIN #PMSTATUSFILTERTABLE AS f4 ON (f4.VALUEID = e.PMStatus)
        WHERE
            e.utcdate >= @AVERAGEPERIODSTARTDATE
            AND e.utcdate < @ENDDATE
            AND e.PageUri IS NOT NULL
            AND (e.ClassType = N'exception' OR e.TotalTime/1000.0 >= @THRESHOLD)
    ),
    -- Group by date (rounded in previous step) and count events
    PrepareEventsClientAvg AS
    (
        SELECT
            e.sourceid AS sourceid,
            e.PeriodId,
            DATEADD(day, e.PeriodId*@PERIODDAYSCOUNT, e.Date) AS ClientDate,
            MAX(EventFillFactor) AS EventFillFactor,
            COUNT(CASE WHEN e.PeriodId = 0 THEN eventid END) AS CurrentEventsCount,
            COUNT(CASE WHEN e.PeriodId = 1 THEN eventid END) AS LastEventsCount,
            COUNT(CASE WHEN PeriodId > 0 THEN eventid END) AS AvgEventsCount
        FROM
            ApplicationStatusClient_ClientEventsFiltered AS e
        GROUP BY
            e.SourceId,
            e.PeriodId,
            e.[Date]
    ),
    -- This step is meaningful only for average period AS all events are averaged between "average" period days
    EventsClient AS
    (
        SELECT
            e.sourceid AS sourceid,
            e.ClientDate,
            MAX(EventFillFactor) AS EventFillFactor,
            MAX(CurrentEventsCount) AS CurrentEventsCount,
            MAX(LastEventsCount) AS LastEventsCount,
            AVG(CASE WHEN PeriodId > 0 THEN AvgEventsCount*1.0 END) AS AvgEventsCount
        FROM
            PrepareEventsClientAvg AS e
        GROUP BY
            e.SourceId,
            e.ClientDate
    ),
    /*************************************************************************************/
    /*                          Activity pcounter queries                                */
    /************************************************************************************/
    -- Select Pcounters with specified filtering for activity statistics
    ApplicationStatusActivityPerHour AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            -- this field is need to determine number of days when
            -- there were some pc in DB. If number of days is less than 7,
            -- then it is supposed that average valu is not correct enought
            DATEDIFF(DAY, DATEADD(mi, @TIMEZONE, ph.UTCDate), @CLIENTSTARTDATE) AS ActivityPCFillFactor,
            CASE @PERIOD
                WHEN 3 THEN CONVERT(NVARCHAR, DATEADD(mi, @TIMEZONE, ph.UTCDate), 112)
                ELSE DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDate)
            END as ClientDate,
            (CASE WHEN ph.PCTypeId = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END) AS MonRequest,
            (CASE WHEN ph.PCTypeId = @REQUESTTIMECOUNTERID THEN ph.SumValue / ph.SampleCount END) AS RequestTime,
            (DATEDIFF(hour, ph.utcdate, @ENDDATE) - 1) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            apm.PerfHourly AS ph (NOLOCK)
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND ph.SourceId = f1.VALUEID)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
        WHERE
            ph.UTCDate >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDate < @ENDDATE
            AND ph.PCTypeID IN (@REQUESTTIMECOUNTERID, @MONITOREDREQUESTCOUNTERID)
    ),
    -- Next step aggregates data only then period is one month.
    -- After this step data are aggregated by days.
    -- For other periods this step is only pivots data by periods.
    ApplicationStatusActivityByDay AS
    (
         SELECT
            MachineId,
            SourceId,
            PeriodId,
            MAX(ActivityPCFillFactor) AS ActivityPCFillFactor,
            DATEADD(day, PeriodId*@PERIODDAYSCOUNT, ClientDate) AS ClientDate,
            SUM(CASE WHEN PeriodId = 0 THEN MonRequest END) AS CurrentRequestCount,
            SUM(CASE WHEN PeriodId = 1 THEN MonRequest END) AS LastRequestCount,
            SUM(CASE WHEN PeriodId > 0 THEN MonRequest END) AS AvgRequestCount,
            AVG(CASE WHEN PeriodId = 0 THEN RequestTime END) AS CurrentRequestTime,
            AVG(CASE WHEN PeriodId = 1 THEN RequestTime END) AS LastRequestTime,
            AVG(CASE WHEN PeriodId > 0 THEN RequestTime END) AS AvgRequestTime
        FROM
            ApplicationStatusActivityPerHour
        GROUP BY
            MachineId,
            SourceId,
            PeriodId,
            ClientDate
    ),
    -- This step is meaningful only for average period AS all counters are averaged between "average" period dates
    ApplicationStatusActivityByPeriod AS
    (
         SELECT
            MachineId,
            SourceId,
            ClientDate,
            MAX(ActivityPCFillFactor) AS ActivityPCFillFactor,
            MAX(CurrentRequestCount) AS CurrentRequestCount,
            MAX(LastRequestCount) AS LastRequestCount,
            AVG(CASE WHEN PeriodId > 0 THEN AvgRequestCount*1.0 END) AS AvgRequestCount,
            MAX(CurrentRequestTime) AS CurrentRequestTime,
            MAX(LastRequestTime) AS LastRequestTime,
            AVG(CASE WHEN PeriodId > 0 THEN AvgRequestTime END) AS AvgRequestTime
        FROM
            ApplicationStatusActivityByDay
        GROUP BY
            MachineId,
            SourceId,
            ClientDate
    ),
    --Aggregate data between machines
    ApplicationStatusActivityBySource AS
    (
         SELECT
            SourceId,
            ClientDate,
            MAX(ActivityPCFillFactor) AS ActivityPCFillFactor,
            SUM(CurrentRequestCount) AS CurrentRequestCount,
            SUM(LastRequestCount) AS LastRequestCount,
            SUM(AvgRequestCount) AS AvgRequestCount,
            AVG(CurrentRequestTime) AS CurrentRequestTime,
            AVG(LastRequestTime) AS LastRequestTime,
            AVG(AvgRequestTime) AS AvgRequestTime
        FROM
            ApplicationStatusActivityByPeriod
        GROUP BY
            SourceId,
            ClientDate
    ),
    /************************************************************************************/
    /*                          Resources pcounter queries                              */
    /************************************************************************************/
    -- Filter resource counters
    ApplicationStatusResourcesPerHour AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            -- this field is need to determine number of days when
            -- there were some pc in DB. If number of days is less than 7,
            -- then it is supposed that average valu is not correct enought
            DATEDIFF(DAY, DATEADD(mi, @TIMEZONE, ph.UTCDate), @CLIENTSTARTDATE) AS ResourcePCFillFactor,
            CASE @PERIOD
                WHEN 3 THEN CONVERT(NVARCHAR, DATEADD(mi, @TIMEZONE, ph.UTCDate), 112)
                ELSE DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDate)
            END as ClientDate,
            (CASE WHEN ph.PCTypeId = @PROCESSORCOUNTERID THEN SUM(ph.SumValue)/SUM(ph.SampleCount) END) AS CPUUsage,
            (CASE WHEN ph.PCTypeId = @IOCOUNTERID THEN SUM(ph.SumValue)/SUM(ph.SampleCount) END) AS IOUsage,
            (CASE WHEN ph.PCTypeId = @MEMORYCOUNTERID THEN SUM(ph.SumValue)/SUM(ph.SampleCount) END) AS MemoryUsage,
            (DATEDIFF(hour, ph.utcdate, @ENDDATE)-1) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            apm.PerfHourly AS ph (NOLOCK)
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND ph.SourceId = f1.VALUEID)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
        WHERE
            ph.UTCDate >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDate < @ENDDATE
            AND ph.PCTypeID IN (@PROCESSORCOUNTERID, @IOCOUNTERID, @MEMORYCOUNTERID)
        GROUP BY
            ph.UTCDate,
            ph.PCTypeId,
            ph.MachineId,
            ph.SourceId
     ),
    -- Group resources by date defined by user. For Period = Week and day this step only devides data by period  
    ApplicationStatusResourcesByDay AS
    (
         SELECT
            MachineId,
            SourceId,
            PeriodId,
            MAX(ResourcePCFillFactor) AS ResourcePCFillFactor,
            DATEADD(day, PeriodId*@PERIODDAYSCOUNT, ClientDate) AS ClientDate,
            AVG(CASE WHEN PeriodId = 0 THEN CPUUsage END) AS CurrentCPUUsage,
            AVG(CASE WHEN PeriodId = 1 THEN CPUUsage END) AS LastCPUUsage,
            AVG(CASE WHEN PeriodId > 0 THEN CPUUsage END) AS AvgCPUUsage,
            AVG(CASE WHEN PeriodId = 0 THEN IOUsage END) AS CurrentIOUsage,
            AVG(CASE WHEN PeriodId = 1 THEN IOUsage END) AS LastIOUsage,
            AVG(CASE WHEN PeriodId > 0 THEN IOUsage END) AS AvgIOUsage,
            AVG(CASE WHEN PeriodId = 0 THEN MemoryUsage END) AS CurrentMemoryUsage,
            AVG(CASE WHEN PeriodId = 1 THEN MemoryUsage END) AS LastMemoryUsage,
            AVG(CASE WHEN PeriodId > 0 THEN MemoryUsage END) AS AvgMemoryUsage
        FROM
            ApplicationStatusResourcesPerHour
        GROUP BY
            MachineId,
            SourceId,
            PeriodId,
            ClientDate
    ),
    --This step aggregates data for "average" period, for other periods it is meaningful
    ApplicationStatusResourcesByPeriod AS
    (
         SELECT
            SourceId,
            ClientDate,
            MAX(ResourcePCFillFactor) AS ResourcePCFillFactor,
            MAX(CurrentCPUUsage/ COALESCE(m.CPUCount, 1)) AS CurrentCPUUsage,
            MAX(LastCPUUsage/ COALESCE(m.CPUCount, 1)) AS LastCPUUsage,
            AVG(CASE WHEN PeriodId > 0 THEN AvgCPUUsage/ COALESCE(m.CPUCount, 1) END) AS AvgCPUUsage,
            MAX(CurrentIOUsage) AS CurrentIOUsage,
            MAX(LastIOUsage) AS LastIOUsage,
            AVG(CASE WHEN PeriodId > 0 THEN AvgIOUsage END) AS AvgIOUsage,
            MAX(CurrentMemoryUsage) AS CurrentMemoryUsage,
            MAX(LastMemoryUsage) AS LastMemoryUsage,
            AVG(CASE WHEN PeriodId > 0 THEN AvgMemoryUsage END) AS AvgMemoryUsage
        FROM
            ApplicationStatusResourcesByDay AS r
            JOIN apm.Machine AS m ON m.MachineId = r.MachineId
        GROUP BY
            r.MachineId,
            SourceId,
            ClientDate
    ),
    -- Aggregate values between machines
    ApplicationStatusResourcesBySource AS
    (
         SELECT
            SourceId,
            ClientDate,
            MAX(ResourcePCFillFactor) AS ResourcePCFillFactor,
            AVG(CurrentCPUUsage) AS CurrentCPUUsage,
            AVG(LastCPUUsage) AS LastCPUUsage,
            AVG(AvgCPUUsage) AS AvgCPUUsage,
            AVG(CurrentIOUsage) AS CurrentIOUsage,
            AVG(LastIOUsage) AS LastIOUsage,
            AVG(AvgIOUsage) AS AvgIOUsage,
            AVG(CurrentMemoryUsage) AS CurrentMemoryUsage,
            AVG(LastMemoryUsage) AS LastMemoryUsage,
            AVG(AvgMemoryUsage) AS AvgMemoryUsage
        FROM
            ApplicationStatusResourcesByPeriod
        GROUP BY
            SourceId,
            ClientDate
    ),
    --Check if for some of the machines cpu count is not defined
    MachineCPUUndefinedFlag AS
    (
        SELECT
            sf.SOURCEID,
            MIN(COALESCE(m.CPUCount, -1)) AS CPUUndefinedFlag
        FROM
            #PROCESSFORSOURCE AS sf
            JOIN apm.Machine AS m (NOLOCK) ON sf.MACHINEID = m.MachineId
        GROUP BY
            sf.SOURCEID
    ),
    --Combine all data together
    CombinedData AS
    (
        SELECT
            SourcesDates.RowId AS RowId,
            SourcesDates.IsClient,
            SourcesDates.ClientDate,
            SourcesDates.Source,
            SourcesDates.SourceId,
            AppPool.AppPoolInfo,
            rpc.CurrentCPUUsage,
            rpc.LastCPUUsage,
            rpc.AvgCPUUsage,
            MAX(rpc.ResourcePCFillFactor) OVER(PARTITION BY SourcesDates.SourceId) AS ResourcePCFillFactor,
            (CASE WHEN COALESCE(rpc.AvgCPUUsage, 0) > 0
                    THEN
                        ABS(COALESCE(rpc.CurrentCPUUsage,0) - COALESCE(rpc.AvgCPUUsage, 0))*1.0/rpc.AvgCPUUsage
                    ELSE 0
            END) AS CpuStatus,
            rpc.CurrentIOUsage/(1024.0) AS CurrentIOUsage,
            rpc.LastIOUsage/(1024.0) AS LastIOUsage,
            rpc.AvgIOUsage/(1024.0) AS AvgIOUsage,
            (CASE WHEN COALESCE(rpc.AvgIOUsage, 0) > 0 
                    THEN
                        ABS(COALESCE(rpc.CurrentIOUsage,0) - COALESCE(rpc.AvgIOUsage, 0))*1.0/rpc.AvgIOUsage
                    ELSE 0
            END) AS IOStatus,
            rpc.CurrentMemoryUsage/(1024.0*1024) AS CurrentMemoryUsage,
            rpc.LastMemoryUsage/(1024.0*1024) AS LastMemoryUsage,
            rpc.AvgMemoryUsage/(1024.0*1024) AS AvgMemoryUsage,
            (CASE WHEN COALESCE(rpc.AvgMemoryUsage, 0) > 0 
                    THEN
                        ABS(COALESCE(rpc.CurrentMemoryUsage,0) - COALESCE(rpc.AvgMemoryUsage, 0))*1.0/rpc.AvgMemoryUsage
                    ELSE 0
            END) AS MemoryStatus,
            MAX(apc.ActivityPCFillFactor) OVER(PARTITION BY SourcesDates.SourceId) AS ActivityPCFillFactor,
            apc.CurrentRequestCount,
            apc.LastRequestCount,
            apc.AvgRequestCount,
            (CASE WHEN COALESCE(apc.AvgRequestCount, 0) > 0
                    THEN
                        ABS(COALESCE(apc.CurrentRequestCount,0) - COALESCE(apc.AvgRequestCount, 0))*1.0/apc.AvgRequestCount
                    ELSE 0
            END) AS RequestStatus,
            apc.CurrentRequestTime/1000.0 AS CurrentRequestTime,
            apc.LastRequestTime/1000.0 AS LastRequestTime,
            apc.AvgRequestTime/1000.0 AS AvgRequestTime,
            (CASE WHEN COALESCE(apc.AvgRequestTime, 0) > 0
                    THEN
                        ABS(COALESCE(apc.CurrentRequestTime,0) - COALESCE(apc.AvgRequestTime, 0))*1.0/apc.AvgRequestTime
                    ELSE 0
            END) AS RequestTimeStatus,
            MAX(COALESCE(E.EventFillFactor, cs.EventFillFactor)) OVER(PARTITION BY SourcesDates.SourceId) AS EventFillFactor,
            COALESCE(E.CurrentEventsCount, cs.CurrentEventsCount) AS CurrentEventsCount,
            COALESCE(E.LastEventsCount, cs.LastEventsCount) AS LastEventsCount,
            COALESCE(E.AvgEventsCount, cs.AvgEventsCount) AS AvgEventsCount,
            (CASE WHEN COALESCE(COALESCE(E.AvgEventsCount, cs.AvgEventsCount), 0) > 0
                    THEN
                        ABS(COALESCE(COALESCE(E.CurrentEventsCount, cs.CurrentEventsCount),0) - COALESCE(COALESCE(E.AvgEventsCount, cs.AvgEventsCount), 0))*1.0/COALESCE(E.AvgEventsCount, cs.AvgEventsCount)
                    ELSE 0
            END) AS EventStatus
        FROM
            SourcesDates
            JOIN SourceAppPools AS AppPool ON (AppPool.Sourceid = SourcesDates.Sourceid)
            LEFT OUTER JOIN MachineCPUUndefinedFlag AS cpuFlag ON SourcesDates.Sourceid = cpuFlag.Sourceid
            LEFT OUTER JOIN ApplicationStatusResourcesBySource AS rpc ON (rpc.ClientDate = SourcesDates.ClientDate AND rpc.SourceId = SourcesDates.Sourceid)
            LEFT OUTER JOIN ApplicationStatusActivityBySource AS apc ON (apc.ClientDate = SourcesDates.ClientDate AND apc.SourceId = SourcesDates.Sourceid)
            LEFT OUTER JOIN EventsServer AS e ON (e.ClientDate = SourcesDates.ClientDate AND e.SourceId = SourcesDates.Sourceid)
            LEFT OUTER JOIN EventsClient AS cs ON (cs.ClientDate = SourcesDates.ClientDate AND cs.SourceId = SourcesDates.Sourceid)
    )
    SELECT
        RowId,
        IsClient,
        ClientDate,
        Source,
        SourceId,
        AppPoolInfo,
        CurrentCPUUsage,
        LastCPUUsage,
        AvgCPUUsage,
        -- If resource counters are presents not more than for 7 day, then don't show threshold message
        (CASE WHEN CpuStatus*100 >= @WARNINGTHRESHOLD AND ResourcePCFillFactor >= 7 THEN ClientDate END) AS CPUWarningDate,
        (CASE WHEN CpuStatus*100 >= @ERRORTHRESHOLD AND ResourcePCFillFactor >= 7 THEN ClientDate END) AS CPUErrorDate,
        CurrentIOUsage,
        LastIOUsage,
        AvgIOUsage,
        -- If resource counters are presents not more than for 7 day, then don't show threshold message
        (CASE WHEN IOStatus*100 >= @WARNINGTHRESHOLD AND ResourcePCFillFactor >= 7 THEN ClientDate END) AS IOWarningDate,
        (CASE WHEN IOStatus*100 >= @ERRORTHRESHOLD AND ResourcePCFillFactor >= 7 THEN ClientDate END) AS IOErrorDate,
        CurrentMemoryUsage,
        LastMemoryUsage,
        AvgMemoryUsage,
        -- If resource counters are presents not more than for 7 day, then don't show threshold message
        (CASE WHEN MemoryStatus*100 >= @WARNINGTHRESHOLD AND ResourcePCFillFactor >= 7 THEN ClientDate END) AS MemoryWarningDate,
        (CASE WHEN MemoryStatus*100 >= @ERRORTHRESHOLD AND ResourcePCFillFactor >= 7 THEN ClientDate END) AS MemoryErrorDate,
        CurrentRequestCount,
        LastRequestCount,
        AvgRequestCount,
        -- If activity counters are presents not more than for 7 day, then don't show threshold message
        (CASE WHEN RequestStatus*100 >= @WARNINGTHRESHOLD AND ActivityPCFillFactor >= 7 THEN ClientDate END) AS RequestWarningDate,
        (CASE WHEN RequestStatus*100 >= @ERRORTHRESHOLD AND ActivityPCFillFactor >= 7 THEN ClientDate END) AS RequestErrorDate,
        CurrentRequestTime,
        LastRequestTime,
        AvgRequestTime,
        -- If activity counters are presents not more than for 7 day, then don't show threshold message
        (CASE WHEN RequestTimeStatus*100 >= @WARNINGTHRESHOLD AND ActivityPCFillFactor >= 7 THEN ClientDate END) AS RequestTimeWarningDate,
        (CASE WHEN RequestTimeStatus*100 >= @ERRORTHRESHOLD AND ActivityPCFillFactor >= 7 THEN ClientDate END) AS RequestTimeErrorDate,
        CurrentEventsCount,
        LastEventsCount,
        AvgEventsCount,
        -- If events are presents not more than for 7 day, then don't show threshold message
        (CASE WHEN EventStatus*100 >= @WARNINGTHRESHOLD AND EventFillFactor >= 7 THEN ClientDate END) AS EventWarningDate,
        (CASE WHEN EventStatus*100 >= @ERRORTHRESHOLD AND EventFillFactor >= 7 THEN ClientDate END) AS EventErrorDate,
        EventStatus,
        EventFillFactor,
        ActivityPCFillFactor,
        ResourcePCFillFactor
    FROM
        CombinedData
    ORDER BY
        RowId,
        IsClient,
        ClientDate  
END
GO
-----------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ApplicationStatusDrillthrough]    Script Date: 03/10/2014 00:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************/
/* OBJECT: Stored Procedure                                                             */
/* NAME: ApplicationStatusDrillthrough                                                  */
/* USED IN: Application Status  Report, Application Daily Activity                      */
/* INPUT PARAMETERS:                                                                    */
/*      @SOURCEIDS      - List of the source id, separated by comma. Exp: '1,2,3'       */
/*      @COMPUTERIDS    - List of the computer id, separated by comma. Exp: '1,2,3'     */
/*      @ENDDATE        - End date of the period                                        */
/*      @PERIOD         - Period type(Day, Week or Month).                              */  
/*                      - Use for the Start Date calculate of the period                */
/*      @AVERAGEINTERVAL- This value specifies interval, for which average values will  */
/*                          be calculated. Possible values: 1(1 month), 2(2 month),     */
/*                          3(3 month), 6(6 month), 17 (7 day)                          */
/*      @GROUPBY        - Specifies result gouping type. Possible values:               */
/*                  Hour - Group by hours.  Rersult set will contain 24 rows            */
/*                      corresponding to 24 hours. Date field - 0-23, Hour field - 0    */
/*                  WeekDay - Group by week days. For this grouping type extra grouping */
/*                      is applied - by hours. So result data set contains 7*24 rows.   */
/*                      Date field values - 1-7, Hour fields - 0-23                     */
/*                  Month - Group by Month. For this grouping type extra grouping       */
/*                      is applied - by months. So result data set contains 12*24 rows. */
/*                      and Hour field - 0-23                                           */
/*      @TRESHOLD       - Event duration treshold                                       */
/*      @PROBLEM        - Event problem type (all, critical)                            */
/*      @TIMEZONE       - correlate parameter (timezone by min)                         */
/*                      - for the End Date calculate                                    */
/****************************************************************************************/
ALTER PROCEDURE [apm].[ApplicationStatusDrillthrough]
    @SOURCEIDS NVARCHAR(MAX),
    @COMPUTERIDS NVARCHAR(MAX),
    @ENDDATE DATETIME,
    @TIMEZONE INT,
    @PERIOD INT,
    @AVERAGEINTERVAL INT,
    @GROUPBY NVARCHAR(10),
    @THRESHOLD INT,
    @PROBLEM NVARCHAR(10),
    @PMSTATUS NVARCHAR(50)
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON;

/************************************************************************************/
/*  Prepare auxiliary variables for the further calculation                         */
/************************************************************************************/
    SET @ENDDATE = DATEADD(minute, -@TIMEZONE, @ENDDATE)
    DECLARE @STARTDATE DateTime
    SET @STARTDATE = DATEADD(d, -(CASE WHEN @PERIOD = 1 THEN 1 WHEN @PERIOD = 2 THEN 7 ELSE 31 END), @ENDDATE)
    DECLARE @LASTPERIODSTARTDATE DateTime
    SET @LASTPERIODSTARTDATE = DATEADD(d, -APM.GetQueryDateCount(@PERIOD, @STARTDATE), @STARTDATE)
    DECLARE @AVERAGEPERIODSTARTDATE DateTime
    SET @AVERAGEPERIODSTARTDATE = (CASE
                                        WHEN @AVERAGEINTERVAL < 10 THEN DATEADD(month, -@AVERAGEINTERVAL, @STARTDATE)
                                        ELSE DATEADD(day, -(@AVERAGEINTERVAL-10), @STARTDATE)
                                   END)
    --Used for counting average value for last three months
    DECLARE @PERIODDAYSCOUNT int
    SET @PERIODDAYSCOUNT = APM.GetQueryDateCount(@PERIOD, @STARTDATE);

    DECLARE @PROCESSORCOUNTERID INT
    SELECT @PROCESSORCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE TYPE = N'\Process\% Processor Time'
    DECLARE @MEMORYCOUNTERID INT
    SELECT @MEMORYCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE TYPE = N'\Process\Private Bytes'
    DECLARE @IOCOUNTERID INT
    SELECT @IOCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE TYPE = N'\Process\IO Data Bytes/sec'
    DECLARE @MONITOREDREQUESTCOUNTERID INT
    SELECT @MONITOREDREQUESTCOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE TYPE = N'\Apps\Monitored Requests'
    DECLARE @REQUESTTIMECOUNTERID INT
    SELECT @REQUESTTIMECOUNTERID = PCtypeId FROM apm.PCType (NOLOCK) WHERE TYPE = N'\Apps\Avg. Request Time'
/************************************************************************************/
/*                          ASSISTING TEMP TABLES                                   */
/************************************************************************************/
    -- Filter table, which contains machine ids and source ids
    -- typeid defines filter type - 1 for source and 2 for machine
    -- valueId filter value - source id and machine id 
    CREATE TABLE #SOURCEMACHINEFILTERTABLE(
        TYPEID INT,
        VALUEID INT
    )
    -- Fill table #SOURCEMACHINEFILTERTABLE
    INSERT
        INTO #SOURCEMACHINEFILTERTABLE
            SELECT
                p.typeId AS TYPEID,
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@SOURCEIDS, @COMPUTERIDS) AS p
    -- Filter table, which contains PM Statuses of Events
    CREATE TABLE #PMSTATUSFILTERTABLE(
        VALUEID INT
    )
    -- Fill table #PMSTATUSFILTERTABLE
    INSERT
        INTO #PMSTATUSFILTERTABLE
            SELECT
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@PMSTATUS, N'') AS p
    -- To form application pool with all sources run in it, it is need to get all sources and its process
    CREATE TABLE #PROCESSFORSOURCE
    (
        SOURCEID INT,
        PCPROCESSID INT,
        MACHINEID INT,
        EXTRAINFO NVARCHAR(255) collate database_default,
        PROCESS NVARCHAR(255) collate database_default
    )

    INSERT INTO #PROCESSFORSOURCE
        SELECT
            ph.SOURCEID,
            ph.PCPROCESSID,
            ph.MACHINEID,
            COALESCE(p.EXTRAINFO, N'') AS EXTRAINFO,
            --Select process name till # symbol (w3wp#1 -> w3wp, w3wp -> w3wp)
            APM.RemoveProcessIdFromName(p.PROCESS) AS Process
        FROM
            (
                SELECT DISTINCT
                    ph.SOURCEID,
                    ph.PCPROCESSID,
                    ph.MACHINEID
                FROM
                    APM.PerfHourly AS ph (NOLOCK)
                WHERE
                    ph.PCPROCESSID IS NOT NULL
                    AND ph.UTCDATE >= @STARTDATE
                    AND ph.UTCDATE < @ENDDATE
            ) AS ph
            JOIN APM.PCProcess AS p (NOLOCK) ON p.PCPROCESSID = ph.PCPROCESSID
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 2 AND ph.MACHINEID = f.VALUEID)

/************************************************************************************/
/*                          Main query                                              */
/************************************************************************************/
  
-- Report frame. It contains all sources, for which data sould be selected,
-- and date values accordingly to specified period and grouping type.  
   ;WITH SourcesDates AS
    (
        SELECT
            VALUEID AS sourceid,
            s.SOURCE AS source,
            Hours.n-1 AS hours,
            D.date AS date
        FROM
            #SOURCEMACHINEFILTERTABLE AS source
            JOIN APM.source (NOLOCK) AS s ON s.SOURCEID = source.VALUEID,
            APM.fn_nums(
                (CASE
                    WHEN @GROUPBY = 'WeekDay' THEN 24
                    ELSE 1
                END)) AS Hours,
            (SELECT
                (CASE
                    WHEN @GROUPBY = 'Hour' THEN n-1
                    WHEN @GROUPBY = 'WeekDay' THEN n
                    WHEN @GROUPBY = 'MonthDay' THEN n
                END) AS date
            FROM
                APM.fn_nums(
                    CASE
                        WHEN @GROUPBY = 'Hour' THEN 24
                        WHEN @GROUPBY = 'WeekDay' THEN 7
                        WHEN @GROUPBY = 'MonthDay' THEN 31
                    END
                )
            ) AS D
        WHERE
            source.TYPEID = 1
    ),
-- Get sources name, ids list separated by comma per app pool
-- This info should be selected for all sources, even they are in the same application pool
-- as in this report grouping by source is applied not by application pool.
    AppPoolInfo AS
    (
        SELECT
            c.SOURCEID,
            c.EXTRAINFO,
            c.PROCESS,
            -- all source names which have the same process name as passed in @SOURCEIDS
            (SELECT A.source AS [data()]
                FROM
                (
                    SELECT DISTINCT
                        N'''' + s.source + N'''' +  N',' AS source
                    FROM
                        #PROCESSFORSOURCE AS c1
                        JOIN APM.Source AS s ON c1.SOURCEID = s.SourceId
                    WHERE
                        c1.EXTRAINFO = c.EXTRAINFO
                        AND c1.PROCESS = c.PROCESS
                        AND c1.MACHINEID = c.MACHINEID
                ) AS A
                FOR XML PATH ('')
            ) AS AppPoolSources
        FROM
            #PROCESSFORSOURCE AS c
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = c.SOURCEID)
        GROUP BY
            c.SOURCEID,
            c.MACHINEID,
            c.EXTRAINFO,
            c.PROCESS
    ),
    --Add Pool name in-front of source list, if it is executable application, then app pool countains source name
    PrepareAppPoolInfo AS (
        SELECT DISTINCT
            CASE
                WHEN COALESCE(info.EXTRAINFO,'') = '' THEN CASE info.AppPoolSources WHEN '' THEN '' ELSE LEFT(info.AppPoolSources, LEN(info.AppPoolSources)-1) END
                ELSE info.EXTRAINFO + CASE info.AppPoolSources WHEN '' THEN '' ELSE ' (' + LEFT(info.AppPoolSources, LEN(info.AppPoolSources) - 1) + ')' END
            END AppPool,
            info.SOURCEID,
            info.EXTRAINFO
        FROM
            AppPoolInfo AS info
    ),
-- Forms application pool list for each source
-- Format: AppPool1 ('Source1', 'Source2', Source3), AppPool2 ('Source1', 'Source4')
    SourceAppPools AS (
        SELECT
            s.SOURCEID,
            s.SOURCE,
            COALESCE((SELECT a.AppPool AS [data()]
                FROM
                (
                    SELECT DISTINCT
                        info.AppPool +  N',' AS AppPool
                    FROM
                        PrepareAppPoolInfo as info
                    WHERE
                        info.Sourceid = s.Sourceid
                ) AS A
                FOR XML PATH ('')
            ),s.SOURCE +  '-') AS AppPoolInfo
        FROM
            APM.Source AS s
            JOIN #SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = s.SOURCEID)
    ),
--Prepares and filters events for further manipulations
    ActivityBreakdown_EventsFiltered AS
    (
        SELECT
            e.SOURCEID,
            e.EVENTID,
            e.UTCEVENTDATE AS eventdate,
            --Removing APM.GetDatePart replacing the execution by the code below.
            --It boosts the overall performance as it reduces the number of calls of scalar function
            CASE @GROUPBY
            WHEN 'Hour' THEN Datepart(hh, DATEADD(mi, CAST(@TIMEZONE AS int), e.utceventdate))
            WHEN 'WeekDay' THEN Datepart(dw, DATEADD(mi, CAST(@TIMEZONE AS int), e.utceventdate))
            WHEN 'MonthDay' THEN Datepart(d, DATEADD(mi, CAST(@TIMEZONE AS int), e.utceventdate))
            END as date,
            CASE
                WHEN @GROUPBY = 'WeekDay'
                    THEN DatePart(Hour, DATEADD(mi, CAST(@TIMEZONE AS int), e.utceventdate))
                ELSE 0
            END AS Hour,
            --hour is taken as DateDifference in day between 05/04/2009 9:00AM and 05/03/2009 9:00PM is one day,
            --despite in case of @PERIOD = 'Day' it can be interpretated as one day (if 05/04/2009 9:00AM is end date), so difference should be taken as 0
            ABS(DATEDIFF(hour, e.UTCEVENTDATE, @STARTDATE)) / (@PERIODDAYSCOUNT*24) AS PeriodId,
            e.EVENTGROUPID,
            db.ADDRESS AS SeViewerAddress
        FROM
            APM.Event AS e
            JOIN APM.SeViewerDB AS db ON e.SEVIEWERDBID = db.SEVIEWERDBID
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.VALUEID = e.SOURCEID and f1.TYPEID = 1)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.VALUEID = e.MACHINEID and f2.TYPEID = 2)
   JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMSTATUS)
        WHERE
            ((e.EVENTCLASSTYPE = N'Performance' AND e.EVENTDURATION / 1000000.0 >= @THRESHOLD)
            OR e.EVENTCLASSTYPE = N'exception')
            AND (e.CATEGORY LIKE @PROBLEM OR e.CATEGORY IS NULL)
            AND e.UTCEVENTDATE >= @AVERAGEPERIODSTARTDATE
            AND e.UTCEVENTDATE < @ENDDATE
            AND (e.HEAVYLIGHT <> 0 OR e.HeavyLight IS NULL)
    ),
    /************************************************************************************/
    /*                          Base pcounter queries                                   */
    /************************************************************************************/
    -- Calculate resource utilization by Source in one hour.
    -- Aggregation between instances should be done here (for cases when one source run in several process in one hour)
    SourceHourlyResourceUtilization AS
    (
        SELECT
            ph.MACHINEID,
            ph.SOURCEID,
            ph.UTCDATE,
            ph.PCTYPEID AS Type,

            ---------- Pivot instance count by period type -----------
            (CASE
                WHEN ph.UTCDATE >= @LASTPERIODSTARTDATE AND ph.UTCDATE < @STARTDATE
                THEN SUM(ph.SAMPLECOUNT)*1.0/MAX(ph.PACKAGECOUNTER)
            END) AS LastInstanceCount,
            (CASE
                WHEN ph.UTCDATE >= @STARTDATE AND ph.UTCDATE < @ENDDATE
                THEN SUM(ph.SAMPLECOUNT)*1.0/MAX(ph.PACKAGECOUNTER)
            END) AS CurInstanceCount,
            (CASE
                WHEN ph.UTCDATE >= @AVERAGEPERIODSTARTDATE AND ph.UTCDATE < @STARTDATE
                THEN SUM(ph.SAMPLECOUNT)*1.0/MAX(ph.PACKAGECOUNTER)
            END) AS AvgInstanceCount,

            ---------- Pivot resource value by period type -----------
            (CASE
                WHEN ph.UTCDATE >= @LASTPERIODSTARTDATE AND ph.UTCDATE < @STARTDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS LastValue,
            (CASE
                WHEN ph.UTCDATE >= @STARTDATE AND ph.UTCDATE < @ENDDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS CurValue,
            (CASE
                WHEN ph.UTCDATE >= @AVERAGEPERIODSTARTDATE AND ph.UTCDATE < @STARTDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS AvgValue,
            --Removing APM.GetDatePart replacing the execution by the code below.
            --It boosts the overall performance as it reduces the number of calls of scalar function
            CASE @GROUPBY
            WHEN 'Hour' THEN Datepart(hh, DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDate))
            WHEN 'WeekDay' THEN Datepart(dw, DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDate))
            WHEN 'MonthDay' THEN Datepart(d, DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDate))
            END as Date,
            (CASE WHEN @GROUPBY = 'WeekDay' THEN DatePart(Hour, DATEADD(mi, CAST(@TIMEZONE AS int),  ph.UTCDate)) ELSE 0 END) AS Hours,
            --hour is taken as DateDifference in day between 05/04/2009 9:00AM and 05/03/2009 9:00PM is one day,
            --despite in case of @PERIOD = 'Day' it can be interpretated as one day (if 05/04/2009 9:00AM is end date), so difference should be taken as 0
            ABS(DATEDIFF(hour, ph.UTCDATE, @ENDDATE)) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            APM.PerfHourly AS ph (NOLOCK)
            --Join with #SOURCEMACHINEFILTERTABLE with typeid = 1 provides filtering perfHourly by sourceid
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND f1.VALUEID = ph.SOURCEID)
            --Join with #SOURCEMACHINEFILTERTABLE with typeid = 2 provides filtering perfHourly by machineid
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MACHINEID)
        WHERE
            ph.UTCDATE >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDATE < @ENDDATE
            AND ph.PCTYPEID IN (@PROCESSORCOUNTERID, @IOCOUNTERID, @MEMORYCOUNTERID)
        GROUP BY
            ph.MACHINEID,
            ph.SOURCEID,
            ph.UTCDATE,
            ph.PCTYPEID
    )
    ,
--Calculate average source resource utilization for each resource type
--and for specified grouping period and date
    ApplicationResourceUtilizationByMachines AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.Date,
            ph.Hours,
            -- Instance count should be same for different resource types in one hour for one process
            -- and averaging them won't make any difference but allow to avoid one aggregation step  
            AVG(ph.CurInstanceCount) AS CurInstanceCount,
            AVG(ph.LastInstanceCount) AS LastInstanceCount,
            AVG(ph.AvgInstanceCount) AS AvgInstanceCount,

            ---------- Pivot resource by counter type -----------
            ----------- 'Process% Processor Time' counter -------------------
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.CurValue END) AS CurCPUSum,
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.LastValue END) AS LastCPUSum,
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.AvgValue END) AS AvgCPUSum,
            ----------- 'ProcessPrivate Bytes' counter -------------------
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.CurValue END)  AS CurMemSum,
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.LastValue END) AS LastMemSum,
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.AvgValue END)  AS AvgMemSum,
            ----------- 'ProcessIO Data Bytes/sec' counter -------------------
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.CurValue END) AS CurIOSum,
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.LastValue END) AS LastIOSum,
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.AvgValue END) AS AvgIOSum
        FROM
            SourceHourlyResourceUtilization AS ph
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.Date,
            ph.Hours
    ),
    -- Count Monitored Requests and Avg. Request Time for Application on each machine
    -- as source can run on different machines with same process name and app pool, but different sources set, 
    -- it is important to group by machine to, to avoid calculation of requests from the other app pool
    -- Summarize request count in each period (PeriodId differs only for AvgValue)
    ApplicationNetAppCountersByMachinePrepare AS
    (
        SELECT
            ph.MACHINEID,
            ph.SOURCEID,
            ----------------- Pivot Monitor Request Counter by period ------------------
            CASE WHEN ph.UTCDATE >= @LASTPERIODSTARTDATE AND ph.UTCDATE < @STARTDATE
                 THEN SUM(CASE WHEN ph.PCTYPEID = @MONITOREDREQUESTCOUNTERID THEN ph.SUMVALUE END)  
            END AS LastMonRequest,
            CASE WHEN ph.UTCDATE >= @STARTDATE AND ph.UTCDATE < @ENDDATE
                THEN SUM(CASE WHEN ph.PCTYPEID = @MONITOREDREQUESTCOUNTERID THEN ph.SUMVALUE END)
            END AS CurMonRequest,
            CASE WHEN ph.UTCDATE >= @AVERAGEPERIODSTARTDATE AND ph.UTCDATE < @STARTDATE
                THEN SUM(CASE WHEN ph.PCTYPEID = @MONITOREDREQUESTCOUNTERID THEN ph.SUMVALUE END)
            END AS AvgMonRequest,

            ----------------- Pivot Avg. Request Time Counter by period ------------------
            CASE WHEN ph.UTCDATE >= @LASTPERIODSTARTDATE AND ph.UTCDATE < @STARTDATE
                THEN AVG(CASE WHEN ph.PCTYPEID = @REQUESTTIMECOUNTERID THEN ph.SUMVALUE / ph.SAMPLECOUNT END)
            END AS LastAvgReqTime,
            CASE WHEN ph.UTCDATE >= @STARTDATE AND ph.UTCDATE < @ENDDATE
                THEN AVG(CASE WHEN ph.PCTYPEID = @REQUESTTIMECOUNTERID THEN ph.SUMVALUE / ph.SAMPLECOUNT END)
            END AS CurAvgReqTime,
            CASE WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE
                THEN AVG(CASE WHEN ph.PCTYPEID = @REQUESTTIMECOUNTERID THEN ph.SUMVALUE / ph.SAMPLECOUNT END)
            END AS AvgReqTime,
            --Removing APM.GetDatePart replacing the execution by the code below.
            --It boosts the overall performance as it reduces the number of calls of scalar function
            CASE @GROUPBY
            WHEN 'Hour' THEN Datepart(hh, DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDATE))
            WHEN 'WeekDay' THEN Datepart(dw, DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDATE))
            WHEN 'MonthDay' THEN Datepart(d, DATEADD(mi, CAST(@TIMEZONE AS int), ph.UTCDATE))
            END as Date,
            (CASE WHEN @GROUPBY = 'WeekDay' THEN DatePart(Hour, DATEADD(mi, CAST(@TIMEZONE AS int),  ph.UTCDATE)) ELSE 0 END) AS Hours,
            --hour is taken as DateDifference in day between 05/04/2009 9:00AM and 05/03/2009 9:00PM is one day,
            --despite in case of @PERIOD = 'Day' it can be interpretated as one day (if 05/04/2009 9:00AM is end date), so difference should be taken as 0
            ABS(DATEDIFF(hour, ph.UTCDATE, @ENDDATE)) / (@PERIODDAYSCOUNT*24) AS PeriodId
        FROM
            APM.PerfHourly AS ph (NOLOCK)
            --Join with #SOURCEMACHINEFILTERTABLE provides filtering perfHourly by sourceid
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND ph.SOURCEID = f1.VALUEID)
            --Join with #SOURCEMACHINEFILTERTABLE provides filtering perfHourly by machineid
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MACHINEID)
        WHERE
            ph.UTCDATE >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDATE < @ENDDATE
            AND ph.PCTYPEID IN (@REQUESTTIMECOUNTERID, @MONITOREDREQUESTCOUNTERID)
        GROUP BY
            ph.MACHINEID,
            ph.SOURCEID,
            ph.UTCDATE
    ),
--Calculate average request time  and  sum request count for specified grouping period and date
    ApplicationNetAppCountersByMachine AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.Date,
            ph.Hours,
            SUM(ph.LastMonRequest) AS LastMonRequest,
            SUM(ph.CurMonRequest) AS CurMonRequest,
            SUM(ph.AvgMonRequest) AS AvgMonRequest,
            AVG(ph.LastAvgReqTime) AS LastAvgReqTime,
            AVG(ph.CurAvgReqTime) AS CurAvgReqTime,
            AVG(ph.AvgReqTime) AS AvgReqTime  
        FROM
            ApplicationNetAppCountersByMachinePrepare ph
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            ph.Date,
            ph.Hours
    ),
--  Union .NET counters and process counters for period Id. Period Id differs only for average(last three months) values, so grouping only for them
    PCountersGroupedByMachineId AS (
        SELECT
            pc.machineId,
            pc.SourceId,
            pc.Hours,
            pc.date,
            MAX(netApp.CurMonRequest) AS CurReqCount,
            MAX(netApp.LastMonRequest) AS LastReqCount,
            AVG(netApp.AvgMonRequest) AS AvgReqCount,

            MAX(netApp.CurAvgReqTime) AS CurAvgReqTime,
            MAX(netApp.LastAvgReqTime) AS LastAvgReqTime,
            AVG(netApp.AvgReqTime) AS AvgReqTime,

            MAX(pc.CurCPUSum) AS CurCPUSum,
            MAX(pc.LastCPUSum) AS LastCPUSum,
            AVG(pc.AvgCPUSum) AS AvgCPUSum,
            MAX(pc.CurMemSum) AS CurMemSum,
            MAX(pc.LastMemSum) AS LastMemSum,
            AVG(pc.AvgMemSum) AS AvgMemSum,
            MAX(pc.CurIOSum) AS CurIOSum,
            MAX(pc.LastIOSum) AS LastIOSum,
            AVG(pc.AvgIOSum) AS AvgIOSum
       FROM ApplicationResourceUtilizationByMachines pc
       LEFT JOIN ApplicationNetAppCountersByMachine AS netApp ON netApp.MachineId = pc.MachineId
                AND netApp.SourceId = pc.SourceId AND netApp.PeriodId = netApp.PeriodId
                AND netApp.Hours = pc.Hours AND netApp.Date = pc.Date
        GROUP BY
            pc.machineId,
            pc.SourceId,
            pc.Hours,
            pc.date
    ),
-- Calculate average source resource utilization between machines  
    ActivePreparePCounters AS (
        SELECT
            pc.SourceId,
            pc.Hours,
            pc.date,
            SUM(CurReqCount) AS CurReqCount,
            SUM(LastReqCount) AS LastReqCount,
            SUM(AvgReqCount) AS AvgReqCount,
            AVG(CurAvgReqTime) AS CurAvgReqTime,
            AVG(LastAvgReqTime) AS LastAvgReqTime,
            AVG(AvgReqTime) AS AvgReqTime,
            AVG(CurCPUSum / COALESCE(m.CPUCount, 1)) AS CurCPUSum,
            AVG(LastCPUSum / COALESCE(m.CPUCount, 1) ) AS LastCPUSum,
            AVG(AvgCPUSum / COALESCE(m.CPUCount, 1)) AS AvgCPUSum,

            AVG(CurMemSum) AS CurMemSum,
            AVG(LastMemSum) AS LastMemSum,
            AVG(AvgMemSum) AS AvgMemSum,
            AVG(CurIOSum) AS CurIOSum,
            AVG(LastIOSum) AS LastIOSum,
            AVG(AvgIOSum) AS AvgIOSum
        FROM
            PCountersGroupedByMachineId pc
            JOIN APM.Machine AS m ON m.MACHINEID = pc.MachineId
        GROUP BY
            pc.SourceId,
            pc.Hours,
            pc.date
    ),
--Count events for the current, last and average period. PeriodId differs only for average
    PrepareEventsAvg AS
    (
        SELECT
            e.sourceid AS sourceid,
            e.date,
            e.hour,
            e.PeriodId,
            MAX(E.SeViewerAddress) AS SeViewerAddress,  
            COUNT(CASE WHEN e.eventdate >= @STARTDATE AND e.eventdate < @ENDDATE THEN eventid END) AS CurrentEventsCount,
            COUNT(CASE WHEN e.eventdate >= @LASTPERIODSTARTDATE  AND e.eventdate < @STARTDATE THEN eventid END) AS LasEventsCount,
            COUNT(CASE WHEN E.eventdate >= @AVERAGEPERIODSTARTDATE AND E.eventdate < @STARTDATE THEN eventid END) AS AvgEventsCount
        FROM
            ActivityBreakdown_EventsFiltered AS e
        GROUP BY
            sourceid,
            PeriodId,
            e.date,
            e.hour
    ),
    Events AS
    (
        SELECT
            e.sourceid AS sourceid,
            e.date,
            e.hour,
            MAX(E.SeViewerAddress) AS SeViewerAddress,
            --PeriodId differs only for average, so for current and last period it doesn't matter which agg function is taken
            MAX(CurrentEventsCount) AS CurrentEventsCount,
            MAX(LasEventsCount) AS LasEventsCount,
            --Average counting is not included current period
            AVG(AvgEventsCount) AS AvgEventsCount
        FROM
            PrepareEventsAvg AS e
        GROUP BY
            sourceid,
            e.date,
            e.hour  
    ),
    MachineCPUUndefinedFlag AS
    (
        SELECT
            sf.SOURCEID,
            MIN(COALESCE(m.CPUCOUNT, -1)) AS CPUUndefinedFlag
        FROM
            #PROCESSFORSOURCE AS sf
            JOIN APM.Machine AS m (NOLOCK) ON sf.MACHINEID = m.MACHINEID
        GROUP BY
            sf.SOURCEID
    )
    SELECT
    -- This fake fields is need to provide compatibility with SP ApplicationStatusDrillthrough
    GetDate() AS ClientDate,
        SourcesDates.date AS Date,
        SourcesDates.Hours AS Hours,
        SourcesDates.Sourceid,
        SourcesDates.Source AS Source,
--Period is used to organize result values, for example if @PERIOD is Day and @ENDDATE = '05/06/2009 13:00',
--this value should put 23 hour of 05/05/2009 before 10 hour of 05/06/2009
        (CASE
            WHEN (SourcesDates.date - APM.GetDatePart(@GROUPBY, DATEADD(mi, CAST(@TIMEZONE AS int), @ENDDATE))
            ) < 0 THEN 0
            WHEN (SourcesDates.date - APM.GetDatePart(@GROUPBY, DATEADD(mi, CAST(@TIMEZONE AS int), @ENDDATE))
            ) >= 0 THEN 1
        END) AS Period,
        COALESCE(pc.CurReqCount, 0) AS CurMonitoredRequestSum,
        COALESCE(pc.LastReqCount, 0) AS LastMonitoredRequestSum,
        COALESCE(pc.AvgReqCount, 0) AS AvgMonitoredRequestSum,
        COALESCE(pc.CurAvgReqTime, 0) AS CurAvgReqTime,
        COALESCE(pc.LastAvgReqTime, 0) AS LastAvgReqTime,
        COALESCE(pc.AvgReqTime, 0) AS AvgReqTime,
        COALESCE(pc.CurCPUSum, 0) AS CurCPUValue,
        COALESCE(pc.lastCPUSum, 0) AS LastCPUValue,
        COALESCE(pc.AvgCPUSum, 0) AS AvgValue,
        COALESCE(pc.CurMemSum, 0) AS CurMemValue,
        COALESCE(pc.LastMemSum, 0) AS LastMemValue,
        COALESCE(pc.AvgMemSum, 0) AS AvgMemValue,
        COALESCE(pc.CurIOSum, 0) AS CurIOValue,
        COALESCE(pc.LastIOSum, 0) AS LastIOValue,
        COALESCE(pc.AvgIOSum, 0) AS AvgIOValue,
        COALESCE(e.CurrentEventsCount, 0) AS NewEventsCount,
        COALESCE(e.LasEventsCount, 0) AS OldEventsCount,
        COALESCE(e.AvgEventsCount, 0) AS AvgEventsCount,
        -- cpuFlag.CPUUndefinedFlag is null for current source if there is no one process PCounter row
        -- in PerfHourly table for specified period. If so there is no need to show message about it
        COALESCE(cpuFlag.CPUUndefinedFlag, 1) AS CPUUndefinedFlag,
        (CASE
            WHEN (@GROUPBY = 'Hour' AND ((SourcesDates.date % 2) = 0)) THEN  SourcesDates.date
            WHEN (@GROUPBY = 'WeekDay' AND ((SourcesDates.Hours + 12) % 24) = 0) THEN  SourcesDates.date
            WHEN (@GROUPBY = 'MonthDay') THEN  SourcesDates.date
            ELSE -1
        END) AS OutputDate,
        CASE LEFT(AppPool.AppPoolInfo,1)
            WHEN N'''' THEN N''
            WHEN N'' THEN ''
            ELSE REPLACE(LEFT(AppPool.AppPoolInfo, LEN(AppPool.AppPoolInfo)-1), N'''', N'')
        END AS pool,
        E.SeViewerAddress
    FROM
        SourcesDates
        LEFT OUTER JOIN MachineCPUUndefinedFlag AS cpuFlag ON SourcesDates.Sourceid = cpuFlag.Sourceid
        LEFT OUTER JOIN ActivePreparePCounters AS pc ON (pc.date = SourcesDates.date AND pc.SourceId = SourcesDates.Sourceid AND SourcesDates.Hours = pc.Hours)
        LEFT OUTER JOIN Events AS e ON (e.date = SourcesDates.date AND e.Sourceid = SourcesDates.Sourceid AND e.hour = SourcesDates.Hours)
        JOIN SourceAppPools AS AppPool ON (AppPool.Sourceid = SourcesDates.Sourceid)
    ORDER BY
        Source,
        Period DESC,
        Date,
        Hours
END
GO
--------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ApplicationStatusSummaryStatistics]    Script Date: 03/10/2014 00:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************/
/* OBJECT: Stored Procedure                                                         */
/* NAME: ApplicationStatusSummaryStatistics                                         */
/* USED IN: Application Status  Report                                              */
/* INPUT PARAMETERS:                                                                */
/*      @SOURCEIDS - List of the source id, separated by comma. Exp: '1,2,3'        */
/*      @COMPUTERIDS - List of the computer id, separated by comma. Exp: '1,2,3'    */
/*      @ENDDATE     - End date of the period                                       */
/*      @PERIOD      - Period type(Day, Week or Month).                             */
/*                   - Use for the Start Date calculate of the period               */
/*      @AVERAGEINTERVAL- This value specifies interval, for which average values   */
/*                          be calculated. Possible values: 1(1 month), 2(2 month), */
/*                          3(3 month), 6(6 month), 17 (7 day)                      */
/*      @TRESHOLD    - Event duration treshold                                      */
/*      @PROBLEM     - Event problem type (all, critical)                           */
/*      @TIMEZONE    - correlate parameter (timezone by min)                        */
/*                   - for the End Date calculate                                   */
/************************************************************************************/
ALTER PROCEDURE [apm].[ApplicationStatusSummaryStatistics] 
    @SOURCEIDS NVARCHAR(MAX),
    @COMPUTERIDS NVARCHAR(MAX),
    @ENDDATE DATETIME,
    @PERIOD INT,
    @AVERAGEINTERVAL INT,
    @THRESHOLD INT,
    @PROBLEM NVARCHAR(10),
    @TIMEZONE INT,
    @PMSTATUS NVARCHAR(50)
WITH RECOMPILE
AS
BEGIN
  SET NOCOUNT ON;
/************************************************************************************/
/*  Prepare auxiliary variables for the further calculation                         */
/************************************************************************************/
    --Calculate End Date in view of timezone
    SET @ENDDATE = DATEADD(minute, -@TIMEZONE, @ENDDATE)
    --Used for counting average value for last three months
    DECLARE @PERIODDAYSCOUNT int
    SET @PERIODDAYSCOUNT = APM.GetQueryDateCount(@PERIOD, @ENDDATE)
    --Calculate Start Date in view of period type
    DECLARE @STARTDATE DateTime
    SET @STARTDATE = DATEADD(d, -@PERIODDAYSCOUNT, @ENDDATE)
    --Calculate previos period Start Date
    DECLARE @LASTPERIODSTARTDATE DateTime
    SET @LASTPERIODSTARTDATE = DATEADD(d, -@PERIODDAYSCOUNT, @STARTDATE)
    --Calculate average period Start Date
    DECLARE @AVERAGEPERIODSTARTDATE DateTime
    SET @AVERAGEPERIODSTARTDATE = (CASE
                                        WHEN @AVERAGEINTERVAL < 10 THEN DATEADD(month, -@AVERAGEINTERVAL, @STARTDATE)
                                        ELSE DATEADD(day, -(@AVERAGEINTERVAL-10), @STARTDATE)
                                   END)
    DECLARE @PROCESSORCOUNTERID INT
    SELECT @PROCESSORCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\% Processor Time'
    DECLARE @MEMORYCOUNTERID INT
    SELECT @MEMORYCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\Private Bytes'
    DECLARE @IOCOUNTERID INT
    SELECT @IOCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\IO Data Bytes/sec'
    DECLARE @MONITOREDREQUESTCOUNTERID INT
    SELECT @MONITOREDREQUESTCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Apps\Monitored Requests'
    DECLARE @REQUESTTIMECOUNTERID INT
    SELECT @REQUESTTIMECOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Apps\Avg. Request Time'
    /************************************************************************************/
    /*                          ASSISTING TEMP TABLES                                   */
    /************************************************************************************/
    -- Filter table, which contains machine ids and source ids
    -- typeid defines filter type - 1 for source and 2 for machine
    -- valueId filter value - source id and machine id
    CREATE TABLE #SOURCEMACHINEFILTERTABLE(
        TYPEID INT,
        VALUEID INT
    )
    -- Fill table #SOURCEMACHINEFILTERTABLE
    INSERT
        INTO #SOURCEMACHINEFILTERTABLE
            SELECT
                p.typeId AS TYPEID,
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@SOURCEIDS, @COMPUTERIDS) AS p
    -- Filter table, which contains PM Statuses of Events
    CREATE TABLE #PMSTATUSFILTERTABLE(
        VALUEID INT
    )
    -- Fill table #PMSTATUSFILTERTABLE
    INSERT
        INTO #PMSTATUSFILTERTABLE
            SELECT
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@PMSTATUS, N'') AS p
    /************************************************************************************/
    /*                          Filtered events for further manipulations               */
    /************************************************************************************/
    ;WITH GetSummaryStatistics_EventsFiltered AS
    (
        SELECT
            e.SourceId,
            e.EventId,
            e.UtcEventDate AS Date,
            ABS(DATEDIFF(d, DATEADD(minute, @TIMEZONE, e.UtcEventDate), @ENDDATE)) / @PERIODDAYSCOUNT AS PeriodId
        FROM
            APM.Event AS e
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND f1.VALUEID = e.SourceId)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = e.MachineId)
   JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMStatus)
        WHERE
            (e.EventClassType = N'exception' OR (e.EventClassType = 'performance' AND e.eventduration / 1000000.0 >= @THRESHOLD))
            AND (e.category LIKE @PROBLEM OR e.category IS NULL)
            AND e.utceventdate >= @AVERAGEPERIODSTARTDATE
            AND e.utceventdate < @ENDDATE
            AND (e.HeavyLight <> 0 OR e.HeavyLight IS NULL)
    ),
    /************************************************************************************/
    /*                          Resource Utilizayion Queries                            */
    /************************************************************************************/
-- Calculate resource utilization by Source in one hour.
-- Aggregation between instances should be done here (for cases when one source run in several process in one hour)
    SourceHourlyResourceUtilization AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ph.UTCDate,
            ph.PCTypeId AS [Type],
            ---------- Pivot instance count by period type -----------
            (CASE
                WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE
                THEN SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter)
            END) AS LastInstanceCount,
            (CASE
                WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE
                THEN SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter)
            END) AS CurInstanceCount,
            (CASE
                WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE
                THEN SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter)
            END) AS AvgInstanceCount,

            ---------- Pivot resource value by period type -----------
            (CASE
                WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS LastValue,
            (CASE
                WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS CurValue,
            (CASE
                WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE THEN SUM(SumValue)/SUM(SampleCount)
            END) AS AvgValue,

            ABS(DATEDIFF(day, DATEADD(minute, @TIMEZONE, ph.utcdate), @ENDDATE)) / @PERIODDAYSCOUNT AS PeriodId
        FROM
            APM.PerfHourly AS ph (NOLOCK)
            --Join with #SOURCEMACHINEFILTERTABLE with typeId = 1 provides filtering perfHourly by sourceid
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND f1.VALUEID = ph.SourceId)
            --Join with #SOURCEMACHINEFILTERTABLE with typeId = 2 provides filtering perfHourly by machineid
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
        WHERE
            ph.UTCDate >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDate < @ENDDATE
            AND ph.PCTypeId IN (@PROCESSORCOUNTERID, @IOCOUNTERID, @MEMORYCOUNTERID)
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.UTCDate,
            ph.PCTypeId
    ),
    --Calculate average application resource utilization over all specified period per machine
    --and for specified grouping period
    ApplicationResourceUtilizationByMachines AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            -- Instance count should be same for different resource types in one hour for one process
            -- and averaging them won't make any difference but allow to avoid one aggregation step  
            AVG(ph.CurInstanceCount) AS CurInstanceCount,
            AVG(ph.LastInstanceCount) AS LastInstanceCount,
            AVG(ph.AvgInstanceCount) AS AvgInstanceCount,

            ---------- Pivot resource by counter type -----------
            ----------- 'Process% Processor Time' counter -------------------
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.CurValue END) AS CurCPUSum,
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.LastValue END) AS LastCPUSum,
            AVG(CASE WHEN ph.type = @PROCESSORCOUNTERID THEN ph.AvgValue END) AS AvgCPUSum,
            ----------- 'ProcessPrivate Bytes' counter -------------------
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.CurValue END)  AS CurMemSum,
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.LastValue END) AS LastMemSum,
            AVG(CASE WHEN ph.type = @MEMORYCOUNTERID THEN ph.AvgValue END)  AS AvgMemSum,
            ----------- 'ProcessIO Data Bytes/sec' counter -------------------
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.CurValue END) AS CurIOSum,
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.LastValue END) AS LastIOSum,
            AVG(CASE WHEN ph.type = @IOCOUNTERID THEN ph.AvgValue END) AS AvgIOSum
        FROM
            SourceHourlyResourceUtilization AS ph
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId
    ),
    -- Count Monitored Requests and Avg. Request Timefor Application on each machine
    -- as source can run on different machines with same process name and app pool, but different sources set, 
    -- it is important to group by machine to, to avoid calculation of requests from the other app pool
    -- Summarize request count in each period (PeriodId differs only for AvgValue)
    ApplicationNetAppCountersByMachinePrepare AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ----------------- Pivot Monitor Request Counter by period ------------------
            CASE WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE
                 THEN SUM(CASE WHEN ph.PCTypeID = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END)  
            END AS LastMonRequest,
            CASE WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE
                THEN SUM(CASE WHEN ph.PCTypeID = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END)
            END AS CurMonRequest,
            CASE WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE
                THEN SUM(CASE WHEN ph.PCTypeID = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END)
            END AS AvgMonRequest,

            ----------------- Pivot Avg. Request Time Counter by period ------------------
            CASE WHEN ph.UtcDate >= @LASTPERIODSTARTDATE AND ph.UtcDate < @STARTDATE
                THEN AVG(CASE WHEN ph.PCTypeID = @REQUESTTIMECOUNTERID THEN ph.SumValue / ph.SampleCount END)
            END AS LastAvgReqTime,
            CASE WHEN ph.UtcDate >= @STARTDATE AND ph.UtcDate < @ENDDATE
                THEN AVG(CASE WHEN ph.PCTypeID = @REQUESTTIMECOUNTERID THEN ph.SumValue / ph.SampleCount END)
            END AS CurAvgReqTime,
            CASE WHEN ph.utcdate >= @AVERAGEPERIODSTARTDATE AND ph.utcdate < @STARTDATE
                THEN AVG(CASE WHEN ph.PCTypeID = @REQUESTTIMECOUNTERID THEN ph.SumValue / ph.SampleCount END)
            END AS AvgReqTime,
            ABS(DATEDIFF(day, DATEADD(minute, @TIMEZONE, ph.utcdate), @ENDDATE)) / @PERIODDAYSCOUNT AS PeriodId
        FROM
            APM.PerfHourly AS ph (NOLOCK)
            --Join with #SOURCEMACHINEFILTERTABLE provides filtering perfHourly by sourceid
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND ph.SourceId = f1.VALUEID)
            --Join with #SOURCEMACHINEFILTERTABLE provides filtering perfHourly by machineid
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
        WHERE
            ph.UTCDate >= @AVERAGEPERIODSTARTDATE
            AND ph.UTCDate < @ENDDATE
            AND ph.PCTypeID IN (@REQUESTTIMECOUNTERID, @MONITOREDREQUESTCOUNTERID)
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.UTCDate
    ),
--Calculate average request time  and  sum request count for specified grouping period
    ApplicationNetAppCountersByMachine AS
    (
        SELECT
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId,
            SUM(ph.LastMonRequest) AS LastMonRequest,
            SUM(ph.CurMonRequest) AS CurMonRequest,
            SUM(ph.AvgMonRequest) AS AvgMonRequest,
            AVG(ph.LastAvgReqTime) AS LastAvgReqTime,
            AVG(ph.CurAvgReqTime) AS CurAvgReqTime,
            AVG(ph.AvgReqTime) AS AvgReqTime  
        FROM
            ApplicationNetAppCountersByMachinePrepare ph
        GROUP BY
            ph.MachineId,
            ph.SourceId,
            ph.PeriodId
    ),
--Union .NET counters and process counters for period Id.
--PeriodId differs only for average, so for current and last period it doesn't matter which agg function is taken
    ActivePreparePCounters AS (
        SELECT
            pc.machineId,
            pc.SourceId,

            MAX(netApp.CurMonRequest) AS CurReqCount,
            MAX(netApp.LastMonRequest) AS LastReqCount,
            AVG(netApp.AvgMonRequest) AS AvgReqCount,

            MAX(netApp.CurAvgReqTime) AS CurAvgReqTime,
            MAX(netApp.LastAvgReqTime) AS LastAvgReqTime,
            AVG(netApp.AvgReqTime) AS AvgReqTime,

            MAX(pc.CurInstanceCount) AS CurInstanceCount,
            MAX(pc.LastInstanceCount) AS LastInstanceCount,
            AVG(pc.AvgInstanceCount) AS AvgInstanceCount,

            MAX(pc.CurCPUSum) AS CurCPUSum,
            MAX(pc.LastCPUSum) AS LastCPUSum,
            AVG(pc.AvgCPUSum) AS AvgCPUSum,

            MAX(pc.CurMemSum) AS CurMemSum,
            MAX(pc.LastMemSum) AS LastMemSum,
            AVG(pc.AvgMemSum) AS AvgMemSum,

            MAX(pc.CurIOSum) AS CurIOSum,
            MAX(pc.LastIOSum) AS LastIOSum,
            AVG(pc.AvgIOSum) AS AvgIOSum
       FROM
            ApplicationResourceUtilizationByMachines AS pc
            LEFT JOIN ApplicationNetAppCountersByMachine AS netApp ON netApp.MachineId = pc.MachineId
                AND netApp.SourceId = pc.SourceId AND netApp.PeriodId = netApp.PeriodId
       GROUP BY
            pc.machineId,
            pc.SourceId  
    ),
--Group PC between machines
    PCounters AS
    (
        SELECT
            pc.SourceId AS SourceId,
            SUM(pc.CurReqCount) AS CurReqCount,
            SUM(pc.LastReqCount) AS LastReqCount,
            SUM(pc.AvgReqCount) AS AvgReqCount,
            AVG(pc.CurAvgReqTime) AS CurAvgReqTime,
            AVG(pc.LastAvgReqTime) AS LastAvgReqTime,
            AVG(pc.AvgReqTime) AS AvgReqTime,
            AVG(pc.CurCPUSum / COALESCE(m.CPUCount, 1)) AS CurCPUSum,
            AVG(pc.LastCPUSum / COALESCE(m.CPUCount, 1)) AS LastCPUSum,
            AVG(pc.AvgCPUSum / COALESCE(m.CPUCount, 1)) AS AvgCPUSum,
            AVG(pc.CurMemSum) AS CurMemSum,
            AVG(pc.LastMemSum) AS LastMemSum,
            AVG(pc.AvgMemSum) AS AvgMemSum,
            AVG(pc.CurIOSum) AS CurIOSum,
            AVG(pc.LastIOSum) AS LastIOSum,
            AVG(pc.AvgIOSum) AS AvgIOSum,
            AVG(pc.CurInstanceCount) AS CurInstanceCount,
            AVG(pc.LastInstanceCount) AS LastInstanceCount,
            AVG(pc.AvgInstanceCount) AS AvgInstanceCount
        FROM
            ActivePreparePCounters AS pc
            JOIN APM.Machine AS m ON m.MachineId = pc.MachineId
        GROUP BY
            pc.SourceId
    ),
    PrepareEvents AS
    (
        SELECT
            e.SourceId,
            e.PeriodId,
            COUNT(CASE WHEN e.date >= @STARTDATE AND e.date < @ENDDATE THEN e.eventid END) AS CurEventCount,
            COUNT(CASE WHEN e.date >= @LASTPERIODSTARTDATE AND e.date < @STARTDATE THEN e.eventid END) AS LastEventCount,
            COUNT(CASE WHEN e.date < @STARTDATE THEN e.eventid END) AS AverageEventCount
        FROM
            GetSummaryStatistics_EventsFiltered AS e
        GROUP BY
            e.SourceId,
            e.PeriodId
    ),
--Aggregate average event count. As PeriodId differs only for avg value, it doesn't matter which aggregation function is taken for other values
    Events AS
    (
        SELECT
            e.SourceId,
            MAX(e.CurEventCount) AS CurEventCount,
            MAX(e.LastEventCount) AS LastEventCount,
            --Average counting should not include current period
            AVG(CASE WHEN PeriodID > 0 THEN e.AverageEventCount END) AS AverageEventCount
        FROM
            PrepareEvents AS e
        GROUP BY
            e.SourceId
    ),
    --  this query separated from GetSummaryStatistics_EventsFiltered as it has smaller period
    GetSummaryStatistics_EventsProblemsFiltered AS
    (
        SELECT
            e.SourceId,
            e.EventId,
            e.EventClassType,
            e.Description,
            e.RootNodeName,
            --Forms description for perfNode this way to avoid duration in event description
            COALESCE(RIGHT(pn.Description, LEN(pn.Description) - CHARINDEX(':', pn.Description)), N'') AS PerfNode,
            e.UtcEventDate AS Date,
            eg.FirstEventDate
        FROM
            APM.Event AS e
            JOIN APM.EventGroup AS eg ON e.eventgroupId = eg.EventGroupId
            JOIN #SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND f1.VALUEID = e.SourceId)
            JOIN #SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = e.MachineId)
   JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMStatus)
            OUTER APPLY (
                SELECT TOP(1)
                    pn.description
                FROM
                    APM.PerformanceNode AS pn
                WHERE
                    pn.eventid = e.eventid AND e.resourceid = pn.resourceid
                ORDER BY
                    pn.selfduration DESC
            ) AS pn
        WHERE
            (e.EventClassType = N'exception' OR (e.EventClassType = 'performance' AND e.eventduration / 1000000.0 >= @THRESHOLD))
            AND (e.category LIKE @PROBLEM OR e.category IS NULL)
            AND e.utceventdate >= @LASTPERIODSTARTDATE
            AND e.utceventdate < @ENDDATE
            AND (e.HeavyLight <> 0 OR e.HeavyLight IS NULL)
    ),
    EventProblems AS
    (
        SELECT
            e.SourceId,
            COUNT(DISTINCT CASE WHEN (EventClassType = 'Performance' AND e.date >= @STARTDATE AND e.date < @ENDDATE) THEN rootnodeName + perfNode END) AS CurPerformanceProblemCount,
            COUNT(DISTINCT CASE WHEN (EventClassType <> 'Performance' AND e.date >= @STARTDATE AND e.date < @ENDDATE) THEN e.description END) AS CurExceptionProblemCount,
            COUNT(CASE WHEN (EventClassType = 'Performance' AND e.date >= @STARTDATE AND e.date < @ENDDATE) THEN e.eventid END) AS CurPerformanceEventCount,
            COUNT(CASE WHEN (EventClassType <> 'Performance' AND e.date >= @STARTDATE AND e.date < @ENDDATE) THEN e.eventid END) AS CurExceptionEventCount,
            COUNT(DISTINCT CASE WHEN (EventClassType = 'Performance' AND e.date >= @LASTPERIODSTARTDATE AND e.date < @STARTDATE) THEN rootnodeName + perfNode END) AS LastPerformanceProblemCount,
            COUNT(DISTINCT CASE WHEN (EventClassType <> 'Performance' AND e.date >= @LASTPERIODSTARTDATE AND e.date < @STARTDATE) THEN e.description END) AS LastExceptionProblemCount,
            COUNT(CASE WHEN (EventClassType = 'Performance' AND e.date >= @LASTPERIODSTARTDATE AND e.date < @STARTDATE) THEN e.eventid END) AS LastPerformanceEventCount,
            COUNT(CASE WHEN (EventClassType <> 'Performance' AND e.date >= @LASTPERIODSTARTDATE AND e.date < @STARTDATE) THEN e.eventid END) AS LastExceptionEventCount,
            COUNT(DISTINCT CASE WHEN (e.EventClassType = 'performance' AND e.firsteventdate >= @STARTDATE) THEN e.rootnodeName + perfNode END) as NewPerfProblemsCount,
            COUNT(DISTINCT CASE WHEN (e.EventClassType <> 'performance' AND e.firsteventdate >= @STARTDATE) THEN e.description END) as NewExpProblemsCount
        FROM
            GetSummaryStatistics_EventsProblemsFiltered AS e
        GROUP BY
            e.SourceId
    ),
    ResultQuery AS
    (
        SELECT
            ROW_NUMBER() OVER(ORDER BY s.SourceId) AS Id,
            s.SourceId,
            s.Source,
            COALESCE(pc.CurReqCount, 0) AS CurMonitoredRequestSum,
            COALESCE(pc.LastReqCount, 0) AS LastMonitoredRequestSum,
            COALESCE(pc.AvgReqCount, 0) AS AvgMonitoredRequestSum,
            COALESCE(pc.CurAvgReqTime, 0) AS CurAvrValue,
            COALESCE(pc.LastAvgReqTime, 0) AS LastAvgValue,
            COALESCE(pc.AvgReqTime, 0) AS AvgValue,
            COALESCE(pc.CurCPUSum, 0) AS CurCPUValue,
            COALESCE(pc.LastCPUSum, 0) AS LastCPUValue,
            COALESCE(pc.AvgCPUSum, 0) AS CPUAvgValue,
            COALESCE(pc.CurMemSum, 0) AS CurMemValue,
            COALESCE(pc.LastMemSum, 0) AS LastMemValue,
            COALESCE(pc.AvgMemSum, 0) AS MemAvgValue,
            COALESCE(pc.CurIOSum, 0) AS CurIOValue,
            COALESCE(pc.LastIOSum, 0) AS LastIOValue,
            COALESCE(pc.AvgIOSum, 0) AS IOAvgValue,

            COALESCE(pc.CurInstanceCount, 0) AS CurInstanceCount,
            COALESCE(pc.LastInstanceCount, 0) AS LastInstanceCount,
            COALESCE(pc.AvgInstanceCount, 0) AS AvgInstanceCount,

            COALESCE(E.LastEventCount, 0) AS LastEventCount,
            COALESCE(e.CurEventCount, 0) AS CurrentEventCount,  
            COALESCE(e.AverageEventCount, 0) AS AvgEventsCount,
            COALESCE(p.CurExceptionEventCount, 0) AS CurExceptionEventCount,
            COALESCE(p.CurPerformanceEventCount, 0) AS CurPerformanceEventCount,
            COALESCE(p.LastPerformanceEventCount, 0) AS LastPerformanceEventCount,
            COALESCE(p.LastExceptionEventCount, 0) AS LastExceptionEventCount,
            COALESCE(p.CurPerformanceProblemCount, 0) AS CurPerformanceProblemCount,
            COALESCE(p.CurExceptionProblemCount, 0) AS CurExceptionProblemCount,
            COALESCE(p.LastPerformanceProblemCount, 0) AS LastPerformanceProblemCount,
            COALESCE(p.LastExceptionProblemCount, 0) AS LastExceptionProblemCount,
            COALESCE(p.NewPerfProblemsCount, 0) AS NewPerfProblemsCount,
            COALESCE(p.NewExpProblemsCount, 0) AS NewExpProblemsCount
        FROM
            #SOURCEMACHINEFILTERTABLE AS sd
            JOIN APM.Source AS s (NOLOCK) ON sd.VALUEID = s.SourceId
            LEFT OUTER JOIN PCounters AS pc ON s.SourceId = pc.Sourceid
            LEFT OUTER JOIN Events AS e ON s.Sourceid = e.Sourceid
            LEFT OUTER JOIN EventProblems AS p ON s.Sourceid = p.Sourceid
        WHERE
            sd.TYPEID = 1
    )
        SELECT
            LastResults.Id AS RowId,
            SourceId,
            Source,
            -------Instance Count----------
            CurInstanceCount,
            LastInstanceCount,
            AvgInstanceCount,
            -------MonitoredRequest--------
            CurMonitoredRequestSum,
            LastMonitoredRequestSum,
            AvgMonitoredRequestSum,
            -------Avg value----------
            CurAvrValue,
            LastAvgValue,
            AvgValue,
            ------CPU Value----------
            CurCPUValue,
            LastCPUValue,
            CPUAvgValue,
            ------ Mem value------------
            CurMemValue,
            LastMemValue,
            MemAvgValue,
            --------- IO value-------------
            CurIOValue,
            LastIOValue,
            IOAvgValue,
            ------- Events count----------
            AvgEventsCount,
            CurrentEventCount,
            LastEventCount,
            --------- Exception & Performance Event Count ---------
            CurExceptionEventCount,
            CurPerformanceEventCount,
            LastPerformanceEventCount,
            LastExceptionEventCount,
            --------  Exception & Performance Problem Count ---------
            CurPerformanceProblemCount,
            CurExceptionProblemCount,
            LastPerformanceProblemCount,
            LastExceptionProblemCount,
            NewPerfProblemsCount,
            NewExpProblemsCount
        FROM
            ResultQuery AS LastResults
        ORDER BY
            RowId
END
GO

----------------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ComputerResourceUtilization]    Script Date: 03/10/2014 00:43:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************/
/* OBJECT: Stored Procedure                                                         */
/* NAME: ComputerResourceUtilization                                                */
/* USED IN: Computer resource utilization report                                    */
/* INPUT PARAMETERS:                                                                */
/*      @DATESTART - Start date of the priod                                        */
/*      @DATEEND - End date of the period                                           */
/*      @MACHINEIDS - List of machine Id, separated by comma. Exp: '4,5,6'          */
/*      @SORTORDER - Specifies field to which sorting should be applayed            */
/*                  1. CPU value                                                    */
/*                  2. Memory value                                                 */
/*                  3. I/O value                                                    */
/*                  4. Request count                                                */
/*      @TOPROWCOUNT - defines number of top rows, which will be returned           */
/************************************************************************************/
ALTER PROCEDURE [apm].[ComputerResourceUtilization]
    @DATESTART DateTime,
    @DATEEND DateTime,
    @MACHINEIDS NVARCHAR(MAX),
    @SORTORDER INT,
    @TOPROWCOUNT INT
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON
/****************************************************************************************/
/*                              ASSISTING TEMP TABLES                                   */
/****************************************************************************************/
-- Filter table, which contains machine Ids 
    CREATE TABLE #COMPUTERPCOUNTERANALYSIS_FILTERTABLE
    (
        VALUEID INT
    )
-- Split @MACHINEIDS and fill table with values from it
    INSERT
        INTO #COMPUTERPCOUNTERANALYSIS_FILTERTABLE
            SELECT
                CAST(p.value AS int)
            FROM
                APM.GetMultiParameters(@MACHINEIDS, N'') p
--Filter PerfHourly table for further manipulations
    CREATE TABLE #COMPUTERPCOUNTERANALYSIS_PERFHOURLY
    (
        MACHINEID INT,
        PCTYPE NVARCHAR(100) collate database_default,
        SUMVALUE FLOAT,
        MAXVALUE FLOAT,
        SAMPLECOUNT BIGINT
    )
    INSERT
        INTO #COMPUTERPCOUNTERANALYSIS_PERFHOURLY
            SELECT
                ph.MachineId AS MachineId,
                t.type AS PCType,
                ph.SumValue AS SumValue,
                ph.MaxValue AS MaxValue,
                ph.SampleCount AS SampleCount
            FROM
                APM.PerfHourly AS ph (NOLOCK)
                JOIN APM.PCType AS t (NOLOCK) ON ph.PCTypeId = t.PCTypeId
                JOIN #COMPUTERPCOUNTERANALYSIS_FILTERTABLE f ON ph.MachineId = f.VALUEID
            WHERE
                ph.UTCDate >= @DATESTART
                AND ph.UTCDate < @DATEEND
                AND ph.SourceId IS NULL
                AND ph.PCProcessId IS NULL
                AND t.Type IN (
                    N'\Processor\% Processor Time',
                    N'\Process\Private Bytes',
                    N'\Process\IO Data Bytes/sec',
                    N'\Apps\Monitored Requests')

/****************************************************************************************/
/*                                      MAIN QUERY                                      */
/****************************************************************************************/
    ;WITH ComputerResourceUtilization AS
    (
        SELECT
            ph.MACHINEID,
            AVG(CASE ph.PCTYPE WHEN N'\Processor\% Processor Time' THEN ph.SUMVALUE/SAMPLECOUNT END) AS ProcessorValue,
            MAX(CASE ph.PCTYPE WHEN N'\Processor\% Processor Time' THEN ph.MAXVALUE END) AS MaxProcessorValue,
            AVG(CASE ph.PCTYPE WHEN N'\Process\Private Bytes' THEN ph.SUMVALUE/SAMPLECOUNT END) AS MemoryValue,
            MAX(CASE ph.PCTYPE WHEN N'\Process\Private Bytes' THEN ph.MAXVALUE END) AS MaxMemoryValue,
            AVG(CASE ph.PCTYPE WHEN N'\Process\IO Data Bytes/sec' THEN ph.SUMVALUE/SAMPLECOUNT END) AS IOValue,
            MAX(CASE ph.PCTYPE WHEN N'\Process\IO Data Bytes/sec' THEN ph.MAXVALUE END) AS MaxIOValue,
            SUM(CASE ph.PCTYPE WHEN N'\Apps\Monitored Requests' THEN ph.SUMVALUE END) AS RequestValue  
        FROM
            #COMPUTERPCOUNTERANALYSIS_PERFHOURLY AS ph
        GROUP BY
            ph.MACHINEID
    ),
    OrderedDataSet AS
    (
        SELECT
            ROW_NUMBER() OVER(ORDER BY
                CASE @SORTORDER
                    WHEN 1 THEN cr.ProcessorValue
                    WHEN 2 THEN cr.MemoryValue
                    WHEN 3 THEN cr.IOValue
                    WHEN 4 THEN cr.RequestValue
                END DESC
            ) AS Id,
            m.Machine,
            m.MachineId,
            COALESCE(m.CPUCount, 1) AS CPUCount,
            cr.ProcessorValue AS ProcessorValue,
            cr.MaxProcessorValue AS MaxProcessorValue,
            cr.MemoryValue/(1024*1024) AS MemoryValue,
            cr.MaxMemoryValue/(1024*1024) AS MaxMemoryValue,
            cr.IOValue/1024 AS IOValue,
            cr.MaxIOValue/1024 AS MaxIOValue,
            cr.RequestValue AS RequestValue,
            -- Flag to define if cpu count is not null,
            -- in case of  CPUDefineFlag = 0, show warning message about it in report
            COALESCE(m.CPUCount, 0) AS CPUDefineFlag
        FROM
            ComputerResourceUtilization AS cr
            JOIN APM.Machine AS m (NOLOCK) ON m.MachineId = cr.MachineId
    )
    SELECT
        *
    FROM
        OrderedDataSet
    WHERE
        Id <= @TOPROWCOUNT
END
GO
--------------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ComputerResourceUtilizationBySource]    Script Date: 03/10/2014 00:44:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************/
/* OBJECT: Stored Procedure                                                         */
/* NAME: ComputerResourceUtilizationBySource                                        */
/* USED IN: Computer resource utilization sub report                                */
/* INPUT PARAMETERS:                                                                */
/*      @DATESTART - Start date of the priod                                        */
/*      @DATEEND - End date of the period                                           */
/*      @SOURCEIDS - List of the source id, separated by comma. Exp: '1,2,3'        */
/*      @MACHINEID - Machine Id for which data should be selected                   */
/*      @SORTORDER - Specifies field to which sorting should be applayed            */
/*                  1. CPU value                                                    */
/*                  2. Memory value                                                 */
/*                  3. I/O value                                                    */
/*                  4. Request count                                                */
/************************************************************************************/
ALTER PROCEDURE [apm].[ComputerResourceUtilizationBySource]
    @DATESTART DATETIME,
    @DATEEND DATETIME,
    @SOURCEIDS NVARCHAR(MAX),
    @MACHINEID NVARCHAR(255),
    @SORTORDER INT
WITH RECOMPILE
AS
BEGIN
SET NOCOUNT ON
/************************************************************************************/
/*                  PREPARE ASSISTING TEMP TABLES                                   */
/************************************************************************************/
--Filter table, which contains source ids, transfered to SP in @SOURCEIDS parameter
CREATE TABLE #SOURCEPCOUNTERANALYSIS_FILTERTABLE(
        VALUEID INT
)
-- Split computer ids list separated by comma and fill table with it
INSERT
    INTO #SOURCEPCOUNTERANALYSIS_FILTERTABLE
        SELECT
            CAST(p.value AS INT)
        FROM
            --Splits incoming string. Uses comma as substring delimiter
            APM.GetMultiParameters(@SOURCEIDS, N'') AS p
--Filter PerfHourly table to decrease records count fot further calcultaions
CREATE TABLE #PERFHOURLYBYMACHINE(
        UTCDate DATETIME,
        SOURCEID INT,
        PCPROCESSID INT,
        SUMVALUE FLOAT,
        SAMPLECOUNT BIGINT,
        PACKAGECOUNTER BIGINT,
        MAXVALUE FLOAT,
        TYPE NVARCHAR(MAX) collate database_default
)
INSERT INTO #PERFHOURLYBYMACHINE
    SELECT
        ph.UTCDate,
        ph.sourceId,
        ph.pcprocessId,
        ph.SumValue,
        ph.SampleCount,
        ph.PackageCounter,
        ph.MaxValue,
        t.Type
    FROM
        APM.PerfHourly AS ph (NOLOCK)
        JOIN APM.PCType AS t (NOLOCK) ON t.pctypeid = ph.pctypeid
    WHERE
        ph.UTCDate >= @DATESTART
        AND ph.UTCDate < @DATEEND
        AND ph.MachineId = @MACHINEID
        AND t.type IN
            (
                N'\Process\% Processor Time',
                N'\Process\IO Data Bytes/sec',
                N'\Process\Private Bytes',
                N'\Apps\Monitored Requests',
                -- 'Processor% Processor Time' counter is taken to calculate application activity,
                -- relative to hours, when machine had been sending counter
                N'\Processor\% Processor Time'
            )
--Assisting table for application pool forming
CREATE TABLE #PROCESSNAMEFORSOURCE(
    SOURCE NVARCHAR(255) collate database_default,
    SOURCEID INT,
    EXTRAINFO NVARCHAR(MAX) collate database_default,
    PROCESS NVARCHAR(255) collate database_default
)
--Insert source name with correspondent process name and extrainfo
INSERT INTO #PROCESSNAMEFORSOURCE
    SELECT DISTINCT
        S.Source,
        ph.SOURCEID,
        COALESCE(p.Extrainfo, N'') AS EXTRAINFO,
        --Select process name till # symbol (w3wp#1 -> w3wp, w3wp -> w3wp)
        APM.RemoveProcessIdFromName(p.Process) AS Process
    FROM
        #PERFHOURLYBYMACHINE AS ph
        JOIN APM.Source AS s (NOLOCK) ON ph.SOURCEID = s.sourceId
        JOIN APM.PCProcess AS p (NOLOCK) ON p.pcprocessId = ph.PCPROCESSID  
/********************************************************************************/
/*                                  MAIN QUERY                                  */
/********************************************************************************/
--Get sources name, ids list separated by comma per app pool
;WITH AppPoolInfo AS
(
    SELECT
        c.EXTRAINFO,
        c.PROCESS,
        -- source names
        (SELECT A.source AS [data()]
            FROM
            (
                SELECT DISTINCT
                    N'''' + c1.SOURCE + N'''' +  N',' AS source
                FROM
                    #PROCESSNAMEFORSOURCE as c1
                WHERE
                    c1.EXTRAINFO = c.EXTRAINFO
                    AND c1.PROCESS = c.PROCESS
            ) AS A
            FOR XML PATH ('')
        ) AS AppPoolSources,
        -- source ids
        (SELECT A.sourceid AS [data()]
            FROM
            (
                SELECT DISTINCT
                    CAST(c1.SOURCEID AS NVARCHAR) + N',' AS sourceid
                FROM
                    #PROCESSNAMEFORSOURCE AS c1
                WHERE
                    c1.EXTRAINFO = c.EXTRAINFO
                    AND c1.PROCESS = c.PROCESS
            ) AS A
            FOR XML PATH ('')
        ) AS SourceIds
    FROM
        #PROCESSNAMEFORSOURCE AS c
        JOIN #SOURCEPCOUNTERANALYSIS_FILTERTABLE AS f ON f.VALUEID = c.SOURCEID
    GROUP BY
        c.EXTRAINFO,
        c.PROCESS
),
-- Filter sources for which data should be selected;
-- as info should be selected not only for transfered sources, but also for sources
-- in the same app pool
SourceFilter AS
(
--One application can be in the several app pools, so use DISTINCT
    SELECT DISTINCT
        s2.SOURCEID
    FROM
        #PROCESSNAMEFORSOURCE AS s1
        JOIN #PROCESSNAMEFORSOURCE AS s2 ON s1.EXTRAINFO = s2.EXTRAINFO AND s1.PROCESS = s2.PROCESS
        JOIN #SOURCEPCOUNTERANALYSIS_FILTERTABLE AS f ON s1.SOURCEID = f.VALUEID
),
--Filter PerfHourly by source
PerfHourlyBySource AS
(
    SELECT
        ph.UTCDate,
        ph.PCPROCESSID,
        ph.SUMVALUE,
        ph.SAMPLECOUNT,
        ph.PACKAGECOUNTER,
        ph.MAXVALUE,
        --This field is used for '.NET AppsMonitored Requests' (this counter depends on source only, not process)
        ph.SOURCEID,
        ph.TYPE
    FROM
        #PERFHOURLYBYMACHINE AS ph (NOLOCK)
        JOIN SourceFilter AS s ON s.SOURCEID = ph.SOURCEID
),
--Calculate resource utilization by process in one hour
ProcessHourlyResourceUtilization AS
(
    SELECT
        ph.UTCDate,
        ph.pcprocessId,
        ph.Type,
        -- Select MAX value as in case of app pool, some of the application
        -- could work only part of the hour, and the value should be taken for the
        -- application worked for the longest period
        MAX(ph.SumValue) AS SumValue,
        MAX(ph.MaxValue) AS MaxValue,
        MAX(ph.SampleCount) AS SampleCount,
        MAX(ph.PackageCounter) AS PackageCounter
    FROM
        PerfHourlyBySource AS ph
    WHERE
        --This condition allows to exclude Monitored Requests counter
        PCProcessId IS NOT NULL
    GROUP BY
        ph.UTCDate,
        ph.pcprocessId,
        ph.Type
),
--Calculate resource utilization by application in one hour
--application means - web application = AppPool, otherwise = processname
ApplicationHourlyResourceUtilization AS
(
    SELECT
        ph.UTCDate,
        ph.Type,
        SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter) AS InstanceCount,
        --Select process name till # symbol
        APM.RemoveProcessIdFromName(p.Process) AS ProcessName,
        COALESCE(p.ExtraInfo, N'') AS ProcessExtraInfo,
        SUM(SumValue)/SUM(SampleCount) AS AvgValue,
        MAX(ph.MaxValue) AS MaxValue
    FROM
        ProcessHourlyResourceUtilization AS ph
        JOIN APM.PCProcess AS p (NOLOCK) ON ph.PCProcessId = p.PCProcessId
    GROUP BY
        ph.UTCDate,
        ph.Type,
        APM.RemoveProcessIdFromName(p.Process),
        p.ExtraInfo
),
--Calculate average application resource utilization over all specified period
ApplicationResourceUtilization AS
(
    SELECT
        ph.ProcessName,
        ph.ProcessExtraInfo,
        -- Number of hours when app was active
        COUNT(DISTINCT ph.UTCDate) AS ApplicationAvailabilityHours,
        -- Instance count should be same for different resource types in one hour for one process
        -- and averaging them won't make any difference but allow to avoid one aggregation step  
        AVG(ph.InstanceCount) AS InstanceCount,
        MAX(ph.InstanceCount) AS MaxInstanceCount,
        AVG(CASE WHEN InstanceCount < 1 THEN InstanceCount ELSE 1 END) AS AppActivity,
        AVG(CASE WHEN ph.type = N'\Process\% Processor Time' THEN ph.AvgValue END) AS CPUAvgValue,
        AVG(CASE WHEN ph.type = N'\Process\IO Data Bytes/sec' THEN ph.AvgValue END) AS IOAvgValue,
        AVG(CASE WHEN ph.type = N'\Process\Private Bytes' THEN ph.AvgValue END) AS MemoryAvgValue,
        MAX(CASE WHEN ph.type = N'\Process\% Processor Time' THEN ph.MaxValue END) AS CPUMaxValue,
        MAX(CASE WHEN ph.type = N'\Process\IO Data Bytes/sec' THEN ph.MaxValue END) AS IOMaxValue,
        MAX(CASE WHEN ph.type = N'\Process\Private Bytes' THEN ph.MaxValue END) AS MemoryMaxValue
    FROM
        ApplicationHourlyResourceUtilization AS ph
    GROUP BY
        ph.ProcessName,
        ph.ProcessExtraInfo
),
--Count Monitored Requests for Application
ApplicationRequestCount AS
(
    SELECT
        c.EXTRAINFO,
        c.PROCESS,
        SUM(ph.SUMVALUE) AS RequestCount
    FROM
        PerfHourlyBySource AS ph
        -- If source was running in several app pools  
        -- #PROCESSNAMEFORSOURCE would contain several rows for one sourceid.
        -- In this case request count will be counted for all app pools
        JOIN #PROCESSNAMEFORSOURCE AS c ON ph.SOURCEID = c.SOURCEID
    WHERE
        ph.type = N'\Apps\Monitored Requests'
    GROUP BY
        c.EXTRAINFO,
        c.PROCESS
),
-- Count hours when computer sent counters.
-- This value is used to calculate application activity between hours
ComputerAvailabilityHours AS
(
    SELECT
        COUNT(DISTINCT ph.UTCDate) AS HoursCount
    FROM
        #PERFHOURLYBYMACHINE AS ph
    WHERE
        ph.SOURCEID  IS NULL
        AND ph.PCPROCESSID IS NULL
        AND ph.TYPE = N'\Processor\% Processor Time'
),
OrderedDataSet AS
(
    SELECT
        ROW_NUMBER() OVER (ORDER BY
                            CASE @SORTORDER
                                WHEN 1 THEN res.CPUAvgValue
                                WHEN 2 THEN res.MemoryAvgValue
                                WHEN 3 THEN res.IOAvgValue
                                WHEN 4 THEN req.RequestCount
                            END DESC) AS Id,
        b.ExtraInfo AS AppPoolName,
        --Remove comma from the end
        CASE b.AppPoolSources WHEN '' THEN '' ELSE LEFT(b.AppPoolSources, LEN(b.AppPoolSources)-1) END AS AppPoolSources,
        -- SourceIds string is used for drillthrought report for transfering sources to it
        b.SourceIds,
        req.RequestCount,
        -- Correct instance count and application activity with hours, when application was active
        res.InstanceCount * (res.ApplicationAvailabilityHours*1.0/ca.HoursCount) AS InstanceCount,
        res.MaxInstanceCount,
        res.AppActivity * (res.ApplicationAvailabilityHours*1.0/ca.HoursCount) AS AppActivity,
        -- Calculate resource utilization
        res.CPUAvgValue/COALESCE(m.cpucount, 1) AS CPUAvgValue,
        res.IOAvgValue/1024 AS IOAvgValue,
        res.MemoryAvgValue/(1024*1024) AS MemoryAvgValue,
        res.CPUMaxValue/COALESCE(m.cpucount, 1) AS CPUMaxValue,
        res.IOMaxValue/1024 AS IOMaxValue,
        res.MemoryMaxValue/(1024*1024) AS MemoryMaxValue,
        -- This field used for chart value in subreport bottom,
        -- and it should include application activity both for hour and for specified period (application availability),
        -- in order to be consistan with computer resources
        (CASE @SORTORDER
                WHEN 1 THEN res.CPUAvgValue/COALESCE(m.cpucount, 1) * res.AppActivity * (res.ApplicationAvailabilityHours*1.0/ca.HoursCount)
                WHEN 2 THEN res.MemoryAvgValue/(1024*1024) * res.AppActivity * (res.ApplicationAvailabilityHours*1.0/ca.HoursCount)
                WHEN 3 THEN res.IOAvgValue/1024 * res.AppActivity * (res.ApplicationAvailabilityHours*1.0/ca.HoursCount)
                WHEN 4 THEN req.RequestCount
        END) AS OrderedValue
    FROM
        AppPoolInfo AS b
        JOIN ApplicationResourceUtilization AS res ON res.ProcessExtraInfo = b.ExtraInfo AND res.ProcessName = b.Process
        LEFT OUTER JOIN ApplicationRequestCount AS req ON req.ExtraInfo = b.ExtraInfo AND req.Process = b.Process
        JOIN APM.Machine AS m (NOLOCK) ON m.machineid = @MACHINEID
        -- This query has only one record, and this value is common for all sources,
        -- so use CROSS JOIN
        CROSS JOIN ComputerAvailabilityHours AS ca
)
SELECT
    Id,
    CASE
        WHEN LEN(AppPoolName) > 0 THEN AppPoolName + N' - '+ AppPoolSources
        ELSE CASE AppPoolSources WHEN '' THEN '' ELSE SUBSTRING(AppPoolSources, 2, LEN(AppPoolSources)-2) END
    END AS AppPoolName,
    SourceIds,
    RequestCount,
    InstanceCount,
    MaxInstanceCount,
    AppActivity,
    CPUAvgValue,
    CPUMaxValue,
    MemoryAvgValue,
    MemoryMaxValue,
    IOAvgValue,
    IOMaxValue,
    OrderedValue
FROM
    OrderedDataSet
ORDER BY
    Id
END
GO
------------------------------------------------------------------
USE [OperationsManagerDW]
GO
/****** Object:  StoredProcedure [apm].[ResourceUtilizationTrend]    Script Date: 03/10/2014 00:46:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************/
/* OBJECT: Stored Procedure                                                         */
/* NAME: ResourceUtilizationTrend                                                   */
/* USED IN: Day of Week Utilization, Hour of Day Utilization,                       */
/*      Utilization Trend reports                                                   */
/* INPUT PARAMETERS:                                                                */
/*      @SOURCEIDS - List of source Id, separated by comma. Exp: '1,2,3'            */
/*      @MACHINEIDS - List of machine Id, separated by comma. Exp: '4,5,6'          */
/*      @STARTDATE - Start date of the priod                                        */
/*      @ENDDATE - End date of the period                                           */
/*      @TIMEZONE - Time offset relative to UTC. Used in SP to calculate            */
/*              period in UTC and for conversion UTC time back                      */
/*              to user time (for showing in trend chart)                           */
/*      @GROUPBY - Specifies result gouping type. Possible values:                  */
/*              Hour - Group by hours.  Rersult set will contain 24 rows            */
/*                  corresponding to 24 hours. Date field - 0-23, Hour field - 0    */
/*              WeekDay - Group by week days. For this grouping type extra grouping */
/*                  is applied - by hours. So result data set contains 7*24 rows.   */
/*                  Date field values - 1-7, Hour fields - 0-23                 */
/*              Date - Group by date. Number of row equal to days count in specified*/
/*                  period. If extra parameter @GROUPBYHOUR = 1, then extra grouping*/
/*                  by hours applied. If @GROUPBYHOUR = 0, than date field values - */
/*                  0-(@ENDDATE-@STARTDATE) and Hour field - 0.If @GROUPBYHOUR = 1*/
/*                  than date field values - 0-(@ENDDATE-@STARTDATE)                */
/*                  and Hour field - 0-23                                           */
/*      @GROUPBYHOUR - flag to apply extra grouping by Hour. Available only for     */
/*                  grouping by Date.                                               */
/************************************************************************************/
ALTER PROCEDURE [apm].[ResourceUtilizationTrend]
    @SOURCEIDS NVARCHAR(MAX),
    @MACHINEIDS NVARCHAR(MAX),
    @STARTDATE DATETIME,
    @ENDDATE DATETIME,
    @TIMEZONE INT,
    @GROUPBY NVARCHAR(10),
    @PMSTATUS NVARCHAR(50),
    @GROUPBYHOUR BIT = 0
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON;
/************************************************************************************************************************/
/*                              DECLARE SP VARIABLES                                                                    */
/************************************************************************************************************************/
--Convert start date to utc format
    DECLARE @UTCSTARTDATE DATETIME
    SET @UTCSTARTDATE = DATEADD(minute, -@TIMEZONE, @STARTDATE)
--Convert end date to utc format
    DECLARE @UTCENDDATE DATETIME
    SET @UTCENDDATE = DATEADD(minute, -@TIMEZONE, @ENDDATE)
-- Day count in specified period
    DECLARE @PERIOD INT
    SET @PERIOD = ABS(DATEDIFF(day, @STARTDATE, @ENDDATE)) + 1
-- Define if extra grouping by hours should be applied
    DECLARE @DOGROUPINGBYHOUR BIT
    SET @DOGROUPINGBYHOUR = CASE
-- For group by WeekDay always do extra grouping by hours, for grouping by Date, only if @GROUPBYHOUR = 1 specified
                                WHEN @GROUPBY = 'WeekDay' THEN 1
                                WHEN (@GROUPBY = 'Date' AND @GROUPBYHOUR = 1) THEN 1
                                ELSE 0
                        END
    DECLARE @PROCESSORCOUNTERID INT
    SELECT @PROCESSORCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\% Processor Time'
    DECLARE @MEMORYCOUNTERID INT
    SELECT @MEMORYCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\Private Bytes'
    DECLARE @IOCOUNTERID INT
    SELECT @IOCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Process\IO Data Bytes/sec'
    DECLARE @MONITOREDREQUESTCOUNTERID INT
    SELECT @MONITOREDREQUESTCOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Apps\Monitored Requests'
    DECLARE @REQUESTTIMECOUNTERID INT
    SELECT @REQUESTTIMECOUNTERID = PCtypeId FROM APM.PCType (NOLOCK) WHERE type = N'\Apps\Avg. Request Time'
/************************************************************************************************************/
/*                                  PREPARE ASSISTING TABLES                                                */
/************************************************************************************************************/
-- Filter table, which contains machine ids and source ids
-- typeid defines filter type - 1 for source and 2 for machine
-- valueId filter value - source id and machine id
CREATE TABLE #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE(
    TYPEID INT,
    VALUEID INT
)
-- Fill table #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE
INSERT
    INTO #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE
        SELECT
            p.typeId AS TYPEID,
            CAST(p.value AS INT) AS VALUEID
        FROM
            --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter 
            APM.GetMultiParameters(@SOURCEIDS, @MACHINEIDS) AS p
    -- Filter table, which contains PM Statuses of Events
    CREATE TABLE #PMSTATUSFILTERTABLE(
        VALUEID INT
    )
    -- Fill table #PMSTATUSFILTERTABLE
    INSERT
        INTO #PMSTATUSFILTERTABLE
            SELECT
                CAST(p.value AS INT) AS VALUEID
            FROM
                --GetMultiParameters function splits incoming strings. It uses comma as substring delimiter
                APM.GetMultiParameters(@PMSTATUS, N'') AS p
--Assisting table for application pool forming
CREATE TABLE #PROCESSNAMEFORSOURCE(
    SOURCE NVARCHAR(255) collate database_default,
    SOURCEID INT,
    MACHINEID INT,
    EXTRAINFO NVARCHAR(MAX) collate database_default,
    PROCESS NVARCHAR(255) collate database_default
)
-- Insert source and machine with correspondent process name and extrainfo
-- Here machine is used, as same source with same process name can run in different machines
INSERT INTO #PROCESSNAMEFORSOURCE
    SELECT DISTINCT
        S.Source,
        ph.SourceId,
        ph.MachineId,
        COALESCE(p.Extrainfo, N'') AS EXTRAINFO,
        --Select process name till # symbol (w3wp#1 -> w3wp, w3wp -> w3wp)
        APM.RemoveProcessIdFromName(p.Process) AS Process
    FROM
        (
            SELECT DISTINCT
                ph.SourceId,
                ph.pcprocessId,
                ph.MachineId
            FROM
                APM.PerfHourly AS ph (NOLOCK)
            WHERE
                ph.pcprocessId IS NOT NULL
                AND ph.UTCDate >= @UTCSTARTDATE
                AND ph.UTCDate < @UTCENDDATE
        ) AS ph
        JOIN APM.PCProcess AS p (NOLOCK) ON p.pcprocessId = ph.pcprocessId
 JOIN APM.Source AS s (NOLOCK) ON s.SourceId = ph.SourceId
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 2 AND ph.MachineId = f.VALUEID)

-- Assisting table, which contains filtered rows from Event table  
CREATE TABLE #EVENTFILTER
(
    EVENTID BIGINT,
    SOURCEID INT,
    SEVIEWERADDRESS NVARCHAR(MAX) collate database_default,
    HOUR INT,
    DATE INT
)
INSERT INTO #EVENTFILTER
    SELECT
        e.EventId,
        E.SourceId,
        -- Select event SeViewerd address to provide link to it in report
        db.Address AS SEVIEWERADDRESS,
        -- If grouping by hour should be done, then get hour from event date, else - 0
        -- Hour will be in user time, not in UTC
        (CASE
            WHEN @DOGROUPINGBYHOUR = 1
                THEN DATEPART(hour, DATEADD(mi, @TIMEZONE, e.utceventdate))
            ELSE 0
        END) AS HOUR,
        -- Get grouping date (for week day - week day number1-7, for hour day hour 0-23,
        -- for date - number of days between event date and specified period start day 0-(@ENDDATE-@STARTDATE))
        -- This information is in user time
        (CASE
            WHEN @GROUPBY = 'Date'
                THEN ABS(DATEDIFF(d, @STARTDATE, DATEADD(minute, @TIMEZONE, e.utceventdate)))
            ELSE APM.GetDatePart(@GROUPBY, DATEADD(mi, @TIMEZONE, e.utceventdate))
        END) AS DATE
    FROM
        APM.EVENT AS e
        JOIN APM.SeViewerDB AS db ON e.seviewerdbid = db.seviewerdbid
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE f1 ON e.SourceId = f1.VALUEID AND f1.TYPEID = 1
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE f2 ON e.MachineId = f2.VALUEID AND f2.TYPEID = 2
  JOIN #PMSTATUSFILTERTABLE AS f3 ON (f3.VALUEID = e.PMStatus)
    WHERE
        e.UTCEventDate >= @UTCSTARTDATE
        AND e.UTCEventDate < @UTCENDDATE
        AND (e.HeavyLight IS NULL OR e.HeavyLight  > 0)

/********************************************************************************/
/*                                  MAIN QUERY                                  */
/********************************************************************************/
-- Get sources name, ids list separated by comma per app pool
-- This info should be selected for all sources, even they are in the same application pool
-- as in this report grouping by source is applied not by application pool.
;WITH AppPoolInfo AS
(
    SELECT
        c.EXTRAINFO,
        c.PROCESS,
        c.SOURCEID,
        -- all source names which have the same process name as passed in @SOURCEIDS
        (SELECT A.source AS [data()]
            FROM
            (
                SELECT DISTINCT
                    N'''' + c1.SOURCE + N'''' +  N',' AS source
                FROM
                    #PROCESSNAMEFORSOURCE AS c1
                WHERE
                    c1.EXTRAINFO = c.EXTRAINFO
                    AND c1.PROCESS = c.PROCESS
                    AND c1.MACHINEID = c.MACHINEID
            ) AS A
            FOR XML PATH ('')
        ) AS AppPoolSources
    FROM
        #PROCESSNAMEFORSOURCE AS c
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE AS f ON (f.TYPEID = 1 AND f.VALUEID = c.SOURCEID)
    GROUP BY
        c.EXTRAINFO,
        c.PROCESS,
        c.MACHINEID,
        c.SOURCEID
),
SourceDescription AS (
    SELECT DISTINCT
        CASE
            -- For web application add app pool name before source list (remove comma from the source list end)
            WHEN LEN(pd.ExtraInfo) > 0 THEN pd.ExtraInfo + CASE pd.AppPoolSources WHEN '' THEN '' ELSE ' (' + LEFT(pd.AppPoolSources, LEN(pd.AppPoolSources) - 1) + ')' END
            -- For executable application remove quotes from the start and end and remove comma
            ELSE CASE pd.AppPoolSources WHEN '' THEN '' ELSE SUBSTRING(pd.AppPoolSources, 2, LEN(pd.AppPoolSources)-3) END

        END AppPool,
        pd.SourceId
    FROM
        AppPoolInfo AS pd
),
-- Forms application pool list for each source
-- Format: AppPool1 - ('Source1', 'Source2', Source3), AppPool2 - ('Source1', 'Source4')
SourceAppPools AS (
    SELECT
        s.SourceId,
        -- Also select source name, to show it to user in report
        s.Source,
        (SELECT a.AppPool AS [data()]
            FROM
            (
                SELECT DISTINCT
                    sd.AppPool +  N', ' AS AppPool
                FROM
                    SourceDescription as sd
                WHERE
                    sd.SourceId = s.Sourceid
            ) AS A
            FOR XML PATH ('')
        ) AS AggAppPool
    FROM
        #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE AS f
        JOIN APM.Source AS s (NOLOCK) ON f.VALUEID = s.SourceId
    WHERE
        f.TYPEID = 1
),
-- Report frame. It contains all sources, for which data sould be selected,
-- and date values accordingly to specified period and grouping type.  
SourcesDates AS
(
    SELECT DISTINCT
        -- Remove comma from the end
        CASE sd.AggAppPool WHEN '' THEN '' ELSE LEFT(sd.AggAppPool, LEN(sd.AggAppPool) - 1) END AS AppPool,
        sd.Source AS Source,
        sd.SourceId AS SourceId,
        -- Decrease hours to one. Result either 0-23, or 0 (if grouping by hours not specified)
        Hours.n-1 AS hours,
        D.date AS date
    FROM
        SourceAppPools AS sd
        -- If groupng by hours should be applied, select values for hours 1-24, else select only one value - 1
        CROSS JOIN APM.fn_nums(
            (CASE
                WHEN @DOGROUPINGBYHOUR = 1 THEN 24
                ELSE 1
            END)) AS Hours
        -- Select date, depending on Group by parameter
        CROSS JOIN (SELECT
            (CASE
                -- Values 0-23
                WHEN @GROUPBY = 'Hour' THEN n-1
                -- Values 1-7
                WHEN @GROUPBY = 'WeekDay' THEN n
                -- Values 0 - (@ENDDATE - @STARTDATE)
                WHEN @GROUPBY = 'Date' THEN n - 1
            END) AS date
        FROM
            APM.fn_nums(
                CASE
                    WHEN @GROUPBY = 'Hour' THEN 24
                    WHEN @GROUPBY = 'WeekDay' THEN 7
                    WHEN @GROUPBY = 'Date' THEN (@PERIOD)
                END
            )
        ) AS D
),
-- Calculate resource utilization by SOURCE in one hour.
-- Here counter values are aggregated between sources assosiated with app pool (process).
-- If source presents in several app pools, then in this step values from all of them will be aggregated 
SourceHourlyResourceUtilization AS
(
    SELECT
        ph.MachineId,
-- Single source is a source for which information should be selected
-- Information about each process assosiated with single source and consolidated for it
        ph.SourceId AS SingleSourceId,
        ph.UTCDate,
        ph.PCTypeId,
        SUM(ph.SampleCount)*1.0/MAX(ph.PackageCounter) AS InstanceCount,
        SUM(SumValue)/SUM(SampleCount) AS AvgValue
    FROM
        APM.PerfHourly AS ph (NOLOCK)
        --Join with #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE provides filtering perfHourly by sourceid
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND f1.VALUEID = ph.SourceId)
        --Join with #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE provides filtering perfHourly by machineid
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
    WHERE
        ph.UTCDate >= @UTCSTARTDATE
        AND ph.UTCDate < @UTCENDDATE
        AND PCTypeId IN (@PROCESSORCOUNTERID, @MEMORYCOUNTERID, @IOCOUNTERID)
    GROUP BY
        ph.MachineId,
        ph.SourceId,
        ph.UTCDate,
        ph.PCTypeId
),
--Calculate average source resource utilization for each resource type
ApplicationResourceUtilizationByType AS
(
    SELECT
        ph.MachineId,
        ph.SingleSourceId,
        -- If grouping by hour should be done, then get hour from PCounter date, else - 0
        -- Hour will be in user time, not in UTC
        (CASE
            WHEN @DOGROUPINGBYHOUR = 1
                THEN DATEPART(hour, DATEADD(mi, @TIMEZONE, ph.utcdate))
            ELSE 0
        END) AS Hour,
        -- Get grouping date (for week day - week day number1-7, for hour day hour 0-23,
        -- for date - number of days between PCounter date and specified period start day 0-(@ENDDATE-@STARTDATE))
        -- This information is in user time
        (CASE
            WHEN @GROUPBY = 'Date'
                THEN ABS(DATEDIFF(d, @STARTDATE, DATEADD(minute, @TIMEZONE, ph.utcdate))) 
            ELSE APM.GetDatePart(@GROUPBY, DATEADD(mi, @TIMEZONE, ph.utcdate))
        END) AS Date,
        -- Instance count should be same for different resource types in one hour for one process
        -- and averaging them won't make any difference but allow to avoid one aggregation step  
        AVG(ph.InstanceCount) AS InstanceCount,
        AVG(CASE WHEN ph.PCTypeId = @PROCESSORCOUNTERID THEN ph.AvgValue END) AS CPUAvgValue,
        AVG(CASE WHEN ph.PCTypeId = @IOCOUNTERID THEN ph.AvgValue END) AS IOAvgValue,
        AVG(CASE WHEN ph.PCTypeId = @MEMORYCOUNTERID THEN ph.AvgValue END) AS MemoryAvgValue
    FROM
        SourceHourlyResourceUtilization AS ph
    GROUP BY
        ph.MachineId,
        ph.SingleSourceId,
        ph.utcdate
),
--Calculate average source resource utilization for specified grouping date
ApplicationResourceUtilizationByGroupingDate AS
(
    SELECT
        ph.MachineId,
        ph.SingleSourceId,
        ph.Hour,
        ph.Date,
        AVG(InstanceCount) AS InstanceCount,
        AVG(CPUAvgValue) AS CPUAvgValue,
        AVG(IOAvgValue) AS IOAvgValue,
        AVG(MemoryAvgValue) AS MemoryAvgValue
    FROM
        ApplicationResourceUtilizationByType AS ph
    GROUP BY
        ph.MachineId,
        ph.SingleSourceId,
        ph.Hour,
        ph.Date
),
-- Calculate average source resource utilization between machines  
-- This aggregation is actual then grouping type is longer than specified period.
-- Exp: Group by week day, period - month. Then grouping between all mondays in this month should be applied
ApplicationResourceUtilizationBetweenMachines AS
(
    SELECT
        ph.SingleSourceId,
        ph.Hour,
        ph.Date,
        AVG(InstanceCount) AS InstanceCount,
        AVG(CPUAvgValue/COALESCE(m.CPUCount, 1)) AS CPUAvgValue,
        AVG(IOAvgValue) AS IOAvgValue,
        AVG(MemoryAvgValue) AS MemoryAvgValue
    FROM
        ApplicationResourceUtilizationByGroupingDate AS ph
        JOIN APM.Machine AS m (NOLOCK) ON m.MachineId = ph.MachineId
    GROUP BY
        ph.SingleSourceId,
        ph.Hour,
        ph.Date
),
-- Monitored requests and request average time calculation by mechines with specified grouping
-- For this counter type perfhourly table contain one record for source, utcdate and machine, so other grouping is redundant
RequestsBySources AS
(
    SELECT
        ph.SourceId,
        ph.MachineId,
        SUM(CASE WHEN ph.PCTypeId = @MONITOREDREQUESTCOUNTERID THEN ph.SumValue END) AS ReqCount,
        AVG(CASE WHEN ph.PCTypeId = @REQUESTTIMECOUNTERID THEN ph.SumValue/ph.SampleCount  END) AS AvgReqTime,
        -- If grouping by hour should be done, then get hour from PCounter date, else - 0
        -- Hour will be in user time, not in UTC
        (CASE
            WHEN @DOGROUPINGBYHOUR = 1
                THEN DATEPART(hour, DATEADD(mi, @TIMEZONE, ph.utcdate))
            ELSE 0
        END) AS Hour,
        -- Get grouping date (for week day - week day number1-7, for hour day hour 0-23,
        -- for date - number of days between PCounter date and specified period start day 0-(@ENDDATE-@STARTDATE))
        -- This information is in user time
        (CASE
            WHEN @GROUPBY = 'Date'
                THEN ABS(DATEDIFF(d, @STARTDATE, DATEADD(minute, @TIMEZONE, ph.utcdate))) 
            ELSE APM.GetDatePart(@GROUPBY, DATEADD(mi, @TIMEZONE, ph.utcdate))
        END) AS Date
    FROM
        APM.PerfHourly AS ph (NOLOCK)
        --Join with #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE provides filtering perfHourly by sourceid
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE AS f1 ON (f1.TYPEID = 1 AND f1.VALUEID = ph.SourceId)
        --Join with #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE provides filtering perfHourly by machineid
        JOIN #RESOURCEUTILIZATIONTREND_SOURCEMACHINEFILTERTABLE AS f2 ON (f2.TYPEID = 2 AND f2.VALUEID = ph.MachineId)
    WHERE
        ph.UTCDate >= @UTCSTARTDATE
        AND ph.UTCDate < @UTCENDDATE
        AND ph.PCTypeId IN (@MONITOREDREQUESTCOUNTERID, @REQUESTTIMECOUNTERID)
    GROUP BY
        ph.SourceId,
        ph.MachineId,
        -- This aggregation is actual then grouping type is longer than specified perid.
        -- Exp: Group by week day, period - month. Then grouping between all mondays in this month should be applied  
        (CASE
            WHEN @DOGROUPINGBYHOUR = 1
                THEN DATEPART(hour, DATEADD(mi, @TIMEZONE, ph.utcdate))
            ELSE 0
        END),
        (CASE
            WHEN @GROUPBY = 'Date'
                THEN ABS(DATEDIFF(d, @STARTDATE, DATEADD(minute, @TIMEZONE, ph.utcdate))) 
            ELSE APM.GetDatePart(@GROUPBY, DATEADD(mi, @TIMEZONE, ph.utcdate))
        END)
),
--Calculate request between machines
RequestsBetweenMachines AS
(
    SELECT
        SourceId,
        SUM(ReqCount) AS ReqCount,
        AVG(AvgReqTime) AS AvgReqTime,
        Hour,
        Date
    FROM
        RequestsBySources
    GROUP BY
        SourceId,
        Hour,
        Date
),
Events AS
(
    SELECT
        COUNT(e.EVENTID) AS EventCount,
        MAX(e.SEVIEWERADDRESS) AS SeViewerAddress,
        e.SOURCEID,
        e.HOUR,
        e.DATE
    FROM
        #EVENTFILTER AS e
    GROUP BY
        e.SOURCEID,
        e.HOUR,
        e.DATE
),
-- Check that CPU count is defined for all computers, where application run.
-- Computers set, where application run, does not depend on specified period by design, as otherwise there is performance problems
MachineCPUUndefinedFlag AS
(
    SELECT
        sf.SOURCEID,
        MIN(COALESCE(m.CPUCount, -1)) AS CPUUndefinedFlag
    FROM
        #PROCESSNAMEFORSOURCE AS sf
        JOIN APM.Machine AS m (NOLOCK) ON sf.MACHINEID = m.MachineId
    GROUP BY
        sf.SOURCEID
)
    SELECT
        sd.Date,
        sd.Hours,
        sd.AppPool AS ApplicationPool,
        sd.SourceId,
        sd.Source AS SingleSource,
        E.SeViewerAddress,
        COALESCE(pc.InstanceCount, 0) AS NumberOfApplicationInstances,
        COALESCE(req.ReqCount, 0) AS NumberOfRequests,
        COALESCE(req.AvgReqTime, 0) AS AverageRequestTime,
        COALESCE(pc.CPUAvgValue, 0) AS ResourceCPUUsage,
        COALESCE(pc.IOAvgValue, 0) AS ResourceIO,
        COALESCE(pc.MemoryAvgValue, 0) AS ResourceMemory,
        COALESCE(e.EventCount, 0) AS NumberOfEvents,
        -- cpuFlag.CPUUndefinedFlag is null for current source if there is no one PCounter row
        -- in PerfHourly table for specified period. If so, there is no need to show message about it
        COALESCE(cpuFlag.CPUUndefinedFlag, 1) AS CPUUndefinedFlag
    FROM
        SourcesDates AS sd
        LEFT OUTER JOIN MachineCPUUndefinedFlag AS cpuFlag ON sd.Sourceid = cpuFlag.Sourceid
        LEFT OUTER JOIN ApplicationResourceUtilizationBetweenMachines AS pc ON (sd.SourceId = pc.SingleSourceId AND pc.Hour = sd.Hours AND pc.Date = sd.Date)
        LEFT OUTER JOIN RequestsBetweenMachines AS req ON (sd.SourceId = req.SourceId AND req.Hour = sd.Hours AND req.Date = sd.Date)
        LEFT OUTER JOIN Events AS e ON (sd.SourceId = e.SourceId AND e.Hour = sd.Hours AND e.Date = sd.Date)
    ORDER BY
        sd.SourceId,
        sd.Date,
        sd.Hours
END
GO
-----------------------------------------End of SP Updates--------------------------------------------
```  

## More information

Running this SQL script changes APM reporting so that it will begin to display **Request Count** data for applications from the point at which the SQL Server update is run. You will no longer see **Request Count** data in the APM reports before the Operations Manager upgrade to System Center 2012 R2 Operations Manager. If you want to view data before the upgrade, run the reports, and then export them before you implement the changes that are described in the [Resolution](#resolution) section.
