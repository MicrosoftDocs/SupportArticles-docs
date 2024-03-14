---
title: GL Trial Balance SRS Reports return no data
description: This article provides a resolution for the problem where GL Trial Balance SRS reports do not return any data in Microsoft Dynamics GP 2010 R2 and higher versions.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# GL Trial Balance SRS Reports return no data using Microsoft Dynamics GP

This article helps you resolve the problem where GL Trial Balance SRS reports do not return any data in Microsoft Dynamics GP 2010 R2 and higher versions.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2588519

## Symptoms

The GL Trial Balance Detail and Trial Balance Summary SRS reports do not return any data in Microsoft Dynamics GP 2010 SP2 or higher versions.

## Cause

Some of the clauses in the stored procedure in Microsoft Dynamics GP 2010 SP2 will never be met. (Quality Report #62905)

## Resolution

This bug is currently scheduled to be fixed in GP 2010 SP3.

Work-around: Until the bug is fixed, use the below steps to modify the stored procedure  seeglPrintSRSTrialBalance to prevent this issue:

1. Open SQL Server Management Studio using the appropriate method below:

    - If you are using Microsoft SQL Server 2005, run the statement in Microsoft SQL Server Management Studio. To open Management Studio, click **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** and then click **SQL Server Management Studio**. Click **Connect** to connect to the appropriate Server name.
    - If you are using Microsoft SQL Server 2005 Express, run the statement in Microsoft SQL Server Management Studio Express. To open Management Studio Express, click **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** and then click **SQL Server Management Studio Express**. Click **Connect** to connect to the appropriate Server name.
    - If you are using Microsoft SQL Server 2008, run the statement in Microsoft SQL Server Management Studio. To open Management Studio, click **Start**, point to **Programs**, point to Microsoft SQL Server 2008 and then click **SQL Server Management Studio**. Click **Connect** to connect to the appropriate Server name.

2. In Object Explorer, click to expand the **SQL instance**. Click to expand **Databases**. Then click to expand the **company database ID**.
3. Then click to expand **Programmability** and expand **Stored Procedures**.
4. Find the stored procedure `dbo.seeglPrintSRSTrialBalance`.
5. To make a copy of it, right-click on it and select **Script Stored Procedure As** and **Create To and File**. Enter a file name and location to save this copy to for safe-keeping.
6. Right-click on it again and select Modify to open and display the stored procedure in a query window.
7. For Word Wrap, click on **Tools**, click on **Options**, expand **Text Editor**, expand **All Languages**, click to select **General** and mark the checkbox on the right for Word wrap and click **OK**.
8. In the query window for the stored procedure, find the following code (Use **CTRL** + **F** and click **Find Next**):

    ```sql
    @I_tHistoryYear, 1, 3,
    ```

9. Replace the value of 3 with 2, which makes it look like this: (Make this change in one spot.)

    ```sql
    @I_tHistoryYear, 1, 2,
    ```

10. Find the exec statement that starts with the following code shown below and is located toward the end of the stored procedure (Use CTRL + F):

    ```sql
    exec ('select d.*, isnull([s].[YEAR1], 0) as [YEAR1], isnull([s].[JRNENTRY], 0) as
    ```

11. Enter--before the above exec statement to comment it out, making the first part of this line to look like this:

    ```sql
    --exec ('select d.*, isnull([s].[YEAR1], 0) as [YEAR1], isnull([s].[JRNENTRY], 0) as
    ```

12. Go to the end of the stored procedure and insert the following code in a new line:

    ```sql
    if (@I_tInactiveAccounts = 0)
    begin 
    EXEC ( 
    'select d.*, isnull([s].[YEAR1], 0) as [YEAR1], isnull([s].[JRNENTRY], 0) as [JRNENTRY], 
    isnull([s].[RCTRXSEQ], 0.00000) as [RCTRXSEQ], isnull([s].[SOURCDOC], '''') as [SOURCDOC], 
    isnull([s].[REFRENCE], '''') as [REFRENCE], isnull([s].[DSCRIPTN], '''') as [DSCRIPTN], 
    isnull([s].[TRXDATE], ''1/1/1900'') as [TRXDATE], isnull([s].[TRXSORCE], '''') as [TRXSORCE], 
    isnull([s].[ACTINDX], 0) as [ACTINDX], isnull([s].[POLLDTRX], 0) as [POLLDTRX], isnull([s].[LASTUSER], '''') as [LASTUSER], 
    isnull([s].[LSTDTEDT], ''1/1/1900'') as [LSTDTEDT], isnull([s].[ORGNTSRC], '''') as [ORGNTSRC], 
    isnull([s].[ORGNATYP], 0) as [ORGNATYP], isnull([s].[QKOFSET], 0) as [QKOFSET], isnull([s].[SERIES], 0) as [SERIES], 
    isnull([s].[ORTRXTYP], 0) as [ORTRXTYP], isnull([s].[ORCTRNUM], '''') as [ORCTRNUM], isnull([s].[ORMSTRID], '''') as [ORMSTRID], 
    isnull([s].[ORMSTRNM], '''') as [ORMSTRNM], isnull([s].[ORDOCNUM], '''') as [ORDOCNUM], isnull([s].[ORPSTDDT], ''1/1/1900'') as [ORPSTDDT], 
    isnull([s].[ORTRXSRC], '''') as [ORTRXSRC], isnull([s].[OrigDTASeries], 0) as [OrigDTASeries], isnull(s.[OrigSeqNum], 0) as [OrigSeqNum], 
    isnull([s].[SEQNUMBR], 0) as [SEQNUMBR], isnull([s].[DTA_GL_Status], 0) as [DTA_GL_Status], isnull(s.[DTA_Index], 0.00000) as [DTA_Index], 
    isnull([s].[NOTEINDX], 0.00000) as [NOTEINDX], isnull([s].[ICTRX], 0) as [ICTRX], isnull([s].[ORCOMID], '''') as [ORCOMID], 
    isnull([s].[ORIGINJE], 0) as [ORIGINJE], isnull([s].[PERIODID], 0) as [PERIODID], isnull([s].[CRDTAMNTD], 0.00000) as [CRDTAMNTD], 
    isnull([s].[DEBITAMTD], 0.00000) as [DEBITAMTD], isnull([s].[DOCDATE], ''1/1/1900'') as [DOCDATE], isnull([s].[PSTGNMBR], 0) as [PSTGNMBR], 
    isnull([s].[PPSGNMBR], 0) as [PPSGNMBR], isnull([s].[CorrespondingUnit], '''') as [CorrespondingUnit], isnull([s].[PERINDX], 0) as [PeriodIndex], 
    isnull([s].[PERNAME], '''') as [PeriodName], isnull([s].[DEX_ROW_ID], 0) as [DEX_ROW_IDD], case when [ACCTTYPE] = 1 then isnull([s].[DEBITAMTD], 0.00000) else 0 end as [DEBITAMT], 
    case when [ACCTTYPE] = 1 then isnull([s].[CRDTAMNTD], 0.00000) else 0 end as [CREDITAMT], [m].*, case when TRXDATE is null then 1 else DATEPART(month, TRXDATE) end as MonthIndex, 
    case when TRXDATE is null then ''Janurary'' else DateName(month, TRXDATE) end as MonthField, case when SOURCDOC is null then ''*No Transactions for this account*'' else '''' end as ''ActZeroDesc'', 
    case when ACTIVE = 0 then ''*Inactive account*'' else '''' end as ''ActInactiveDesc'', case when [s].[DEX_ROW_ID] is null then [BGNGBAL] else case when [s].[DEX_ROW_ID] = (select min([tmp].[DEX_ROW_ID]) 
    from #GLTBDTemp tmp where [s].[ACTINDX] = [tmp].[ACTINDX] and [tmp].[TRXDATE] = (select min([tmp].[TRXDATE]) from #GLTBDTemp tmp where [s].[ACTINDX] = [tmp].[ACTINDX])) then [BGNGBAL] else 0 end end as Beg_Bal, 
    case when [s].[DEX_ROW_ID] is null then [ENDNGBAL] else case when [s].[DEX_ROW_ID] = (select min([tmp].[DEX_ROW_ID]) from #GLTBDTemp tmp where [s].[ACTINDX] = [tmp].[ACTINDX] ) then [ENDNGBAL] else 0 end end as End_Bal from '
    + @temptable + ' d left join #GLTBDTemp s on d.ACTINDX = s.ACTINDX left join GL00100 m on d.ACTINDX = m.ACTINDX where s.TRXDATE between '''
    + @I_dStartingDate + ''' and ''' + @I_dEndingDate + '''') 
    end
    else 
    begin
    EXEC ( 
    'select d.*, isnull([s].[YEAR1], 0) as [YEAR1], isnull([s].[JRNENTRY], 0) as [JRNENTRY], 
    isnull([s].[RCTRXSEQ], 0.00000) as [RCTRXSEQ], isnull([s].[SOURCDOC], '''') as [SOURCDOC], 
    isnull([s].[REFRENCE], '''') as [REFRENCE], isnull([s].[DSCRIPTN], '''') as [DSCRIPTN], 
    isnull([s].[TRXDATE], ''1/1/1900'') as [TRXDATE], isnull([s].[TRXSORCE], '''') as [TRXSORCE], 
    isnull([s].[ACTINDX], 0) as [ACTINDX], isnull([s].[POLLDTRX], 0) as [POLLDTRX], isnull([s].[LASTUSER], '''') as [LASTUSER], 
    isnull([s].[LSTDTEDT], ''1/1/1900'') as [LSTDTEDT], isnull([s].[ORGNTSRC], '''') as [ORGNTSRC], 
    isnull([s].[ORGNATYP], 0) as [ORGNATYP], isnull([s].[QKOFSET], 0) as [QKOFSET], isnull([s].[SERIES], 0) as [SERIES], 
    isnull([s].[ORTRXTYP], 0) as [ORTRXTYP], isnull([s].[ORCTRNUM], '''') as [ORCTRNUM], isnull([s].[ORMSTRID], '''') as [ORMSTRID], 
    isnull([s].[ORMSTRNM], '''') as [ORMSTRNM], isnull([s].[ORDOCNUM], '''') as [ORDOCNUM], isnull([s].[ORPSTDDT], ''1/1/1900'') as [ORPSTDDT], 
    isnull([s].[ORTRXSRC], '''') as [ORTRXSRC], isnull([s].[OrigDTASeries], 0) as [OrigDTASeries], isnull(s.[OrigSeqNum], 0) as [OrigSeqNum], 
    isnull([s].[SEQNUMBR], 0) as [SEQNUMBR], isnull([s].[DTA_GL_Status], 0) as [DTA_GL_Status], isnull(s.[DTA_Index], 0.00000) as [DTA_Index], 
    isnull([s].[NOTEINDX], 0.00000) as [NOTEINDX], isnull([s].[ICTRX], 0) as [ICTRX], isnull([s].[ORCOMID], '''') as [ORCOMID], 
    isnull([s].[ORIGINJE], 0) as [ORIGINJE], isnull([s].[PERIODID], 0) as [PERIODID], isnull([s].[CRDTAMNTD], 0.00000) as [CRDTAMNTD], 
    isnull([s].[DEBITAMTD], 0.00000) as [DEBITAMTD], isnull([s].[DOCDATE], ''1/1/1900'') as [DOCDATE], isnull([s].[PSTGNMBR], 0) as [PSTGNMBR], 
    isnull([s].[PPSGNMBR], 0) as [PPSGNMBR], isnull([s].[CorrespondingUnit], '''') as [CorrespondingUnit], isnull([s].[PERINDX], 0) as [PeriodIndex], 
    isnull([s].[PERNAME], '''') as [PeriodName], isnull([s].[DEX_ROW_ID], 0) as [DEX_ROW_IDD], case when [ACCTTYPE] = 1 then isnull([s].[DEBITAMTD], 0.00000) else 0 end as [DEBITAMT], 
    case when [ACCTTYPE] = 1 then isnull([s].[CRDTAMNTD], 0.00000) else 0 end as [CREDITAMT], [m].*, case when TRXDATE is null then 1 else DATEPART(month, TRXDATE) end as MonthIndex, 
    case when TRXDATE is null then ''Janurary'' else DateName(month, TRXDATE) end as MonthField, case when SOURCDOC is null then ''*No Transactions for this account*'' else '''' end as ''ActZeroDesc'', 
    case when ACTIVE = 0 then ''*Inactive account*'' else '''' end as ''ActInactiveDesc'', case when [s].[DEX_ROW_ID] is null then [BGNGBAL] else case when [s].[DEX_ROW_ID] = (select min([tmp].[DEX_ROW_ID]) 
    from #GLTBDTemp tmp where [s].[ACTINDX] = [tmp].[ACTINDX] and [tmp].[TRXDATE] = (select min([tmp].[TRXDATE]) from #GLTBDTemp tmp where [s].[ACTINDX] = [tmp].[ACTINDX])) then [BGNGBAL] else 0 end end as Beg_Bal, 
    case when [s].[DEX_ROW_ID] is null then [ENDNGBAL] else case when [s].[DEX_ROW_ID] = (select min([tmp].[DEX_ROW_ID]) from #GLTBDTemp tmp where [s].[ACTINDX] = [tmp].[ACTINDX] ) then [ENDNGBAL] else 0 end end as End_Bal from '
    + @temptable + ' d left join #GLTBDTemp s on d.ACTINDX = s.ACTINDX left join GL00100 m on d.ACTINDX = m.ACTINDX')
    end
    ```

13. Click **Execute** (or press **F5**) to run the script against the Company database, and it will alter the existing stored procedure with the changes needed. These modifications should result in having the data populate on the GL Trial Balance Detail and Trial Balance Summary SRS reports.
