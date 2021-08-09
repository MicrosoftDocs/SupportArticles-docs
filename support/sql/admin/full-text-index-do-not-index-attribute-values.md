---
title: Full-text index doesn't index attribute values
description: This article provides resolutions for the problem where SQL Server full-text index on XML column does not index attribute values for the inner nodes.
ms.date: 01/15/2021
ms.prod-support-area-path: Administration and Management
ms.reviewer: joaol
---
# SQL Server full-text index on XML column doesn't index attribute values for the inner nodes

This article helps you resolve the problem where SQL Server full-text index on XML column doesesn't index attribute values for the inner nodes.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2513181

## Symptoms

In Microsoft SQL Server when indexing an XML column using full-text only node values and attribute values for the top node are indexed. Attribute values for any of the inner nodes are not indexed.

## Cause

This behavior happens because the XML word breaker that is shipped with SQL Server does not return attribute values for any of the inner nodes (xmlfilt.dll - Version: 12.0.9735.0).

## Resolution

This issue can be resolved using the XML word breaker that ships with Windows operating system when SQL Server is running on either Windows 7 or Windows Server 2008 R2 (version shipped with Windows use different file name - xmlfilter.dll). If you are running SQL Server on a lower version of Windows, you first need to upgrade to these operating systems and then use the following procedure to resolve this issue.

Procedure to resolve the problem on SQL Servers running on Windows Server 2008 R2 and Windows 7 environments:

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

> [!NOTE]
> You need to restart SQL Server Service after going through the following procedure for the changes to come into effect.

1. Navigate to the following registry hive on your SQL Server machine and save it as *SQLMSSearch.reg*.

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\<instance>\MSSearch\CLSID`

    > [!NOTE]
    > Replace the "\<instance>" in the path above with the relevant instance ID of SQL Server/SQL Server.

    For example, "MSQL10.MSSQLSERVER" for a default instance or "MSSQL10.KATMAI" for a named instance "Katmai"

    For more information, see [File Locations for Default and Named Instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server).

2. Edit *SQLMSSearch.reg* file with notepad and replace all occurrences of *xmlfilt.dll* by `C:\Windows\system32\xmlfilter.dll` and then save the changes.

    > [!NOTE]
    > - This assumes your windows folder is located at `C:\Windows`.
    > - You need to enter each backslash in the new path twice!

3. Click the file *SQLMSSearch.reg* to import the content into the registry.
4. Execute the following T-SQL commands to enable the new setting in SQL Server

    ```sql
    exec sp_fulltext_service 'load_os_resources', 1
    exec sp_fulltext_service 'verify_signature ', 0 
    exec sp_fulltext_service 'update_languages'
    exec sp_fulltext_service 'restart_all_fdhosts'
    ```

5. Check the availability of the new settings with this T-SQL command:

    ```sql
    EXEC sp_help_fulltext_system_components 'fullpath','c:\windows\system32\xmlfilter.dll'
    ```

    > [!NOTE]
    > You need to adapt the above command to suit the correct Windows system path on your system. Also ensure that all the languages (respectively their lcid), that should show the new behaviour are listed in the column "componentname" in the output.

## More information

Steps to repro:

1. Create a simple table as follows:

    ```sql
    CREATE TABLE [dbo].[testFTS]([idField] [int] PRIMARY KEY,
    [xmlField] [xml] NOT NULL)
    ```

2. Enable FTS on the xmlField field (the word breaking language that you select here is not relevant to the repro).
3. Insert one record on that table, as follows:

    ```sql
    insert into testFTS (idField, xmlField) values
    (1, '<TopNode TopFirstAtt="TopAttValue" TopSecondAtt="Second Value">
    <MiddleNode FirstAtt="ValueOne" SecondAtt="ValueTwo" ThirdAtt="ValueThree">
    <BottomNode BottomAtt="BottomValue">
    <InnerMostNode>Innermost Text</InnerMostNode>
    </BottomNode>
    </MiddleNode>
    <MiddleNode FirstAtt="ValueFour" SecondAtt="ValueFive" ThirdAtt="ValueSix">
    <BottomNode BottomAtt="OtherBottomValue" />
    </MiddleNode>
    <MiddleNode FirstAtt="ValueSeven" SecondAtt="ValueEight" ThirdAtt="ValueNine">
    <BottomNode BottomAtt="LastValue" />
    </MiddleNode>
    <NodeWithValue>Testing whether this value will be indexed</NodeWithValue>
    </TopNode>')
    ```

4. By querying `fts_index_keywords` for this particular table - `select * from sys.dm_fts_index_keywords(db_id(),object_id('testFTS'))`, the following results are obtained:

    | keyword| display_term| column_id| document_count |
    |---|---|---|---|
    | 0x0069006E00640065007800650064|indexed|2|1|
    | 0x0069006E006E00650072006D006F00730074|innermost|2|1|
    | 0x007300650063006F006E0064|second|2|1|
    | 0x00740065007300740069006E0067|testing|2|1|
    | 0x0074006500780074|text|2|1|
    | 0x0074006F007000610074007400760061006C00750065|topattvalue|2|1|
    | 0x00760061006C00750065|value|2|1|
    | 0x0077006800650074006800650072|whether|2|1|
    | 0xFF|END OF FILE|2|1|
    |||||

    These display terms appear to be restrict to:

    - Node values, regardless of how deeply they are nested within the XML document.
    - Attribute values only for the top node and not from any of the inner nodes that would be expected.
