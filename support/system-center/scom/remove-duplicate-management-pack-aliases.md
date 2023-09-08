---
title: Remove duplicate Management pack aliases
description: This article describes the procedure to remove duplicate management pack aliases before upgrading to System Center Operations Manager 2019 UR4.
ms.date: 03/30/2023
ms.prod-support-area-path: 
---
# Remove duplicate Management pack aliases

With System Center Operations Manager 2019 UR4 and 2022 RTM, System Center Operations Manager management pack reference aliases are case-sensitive and will create only unique aliases. As a result, System Center Operations Manager update rollup upgrades or version upgrades will fail in an environment where duplicate management pack reference aliases are already present.

This article helps remove the duplicate management pack reference aliases (if present) so that System Center Operations Manager update rollup upgrades or version upgrades complete successfully.

Ensure to remove all duplicate management pack aliases before you upgrade to System Center Operations Manager 2019 UR4.

## Detect duplicate management pack aliases

To detect management packs with duplicate management pack aliases, do the following:

Either launch PowerShell ISE on a Management Server or run the T-SQL against System Center Operations Manager Operations Database.

**PowerShell Script**

```powershell
############################################
#Identify MPs imported with duplicate Aliases
Import-Module OperationsManager
$mps = Get-SCOMManagementPack
foreach ($mp in $mps)
{
  	$hashTable = @{}
 	 foreach ($ref in $mp.References)
  	{
   	 try {$hashTable.Add($ref.Key, $ref.Value)}
    	catch
    	{
     	 $MPName = $mp.Name
     	 $MPDisplayName = $mp.DisplayName
     	 $MPVersion = $mp.Version
        "MP contains duplicate aliases: Name=($MPName) DiplayName=($MPDisplayName) Version=($MPVersion)"
    	}
  	}
}
############################################ 
```

**T-SQL**

```sql
-- LIST ALL MPs that have a duplicate Alias reference
DECLARE @mpFriendlyName NVARCHAR(255),
        @mpName         NVARCHAR(255),
        @mpId           UNIQUEIDENTIFIER,
        @mpXml          AS XML

CREATE TABLE #badmptable
  (
     mpid           UNIQUEIDENTIFIER,
     mpname         NVARCHAR(255),
     mpfriendlyname NVARCHAR(255)
  )

DECLARE mp_cursor CURSOR local forward_only read_only FOR
  SELECT mpfriendlyname,
         mpname,
         managementpackid,
         CONVERT(XML, mpxml)
  FROM   managementpack

OPEN mp_cursor

FETCH next FROM mp_cursor INTO @mpFriendlyName, @mpName, @mpId, @mpXml

WHILE @@FETCH_STATUS = 0
  BEGIN
      SELECT n.value('@Alias', 'nvarchar(255)') AS mpRef
      INTO   #temprefs
      FROM   @mpXml.nodes('/ManagementPack/Manifest/References/Reference') AS a(
             n)

      IF EXISTS (SELECT Count(*)
                 FROM   #temprefs
                 GROUP  BY mpref
                 HAVING Count(*) > 1)
        BEGIN
            INSERT INTO #badmptable
                        (mpid,
                         mpname,
                         mpfriendlyname)
            VALUES      ( @mpId,
                          @mpName,
                          @mpFriendlyName )
        END

      DROP TABLE #temprefs

      FETCH next FROM mp_cursor INTO @mpFriendlyName, @mpName, @mpId, @mpXml
  END

CLOSE mp_cursor

DEALLOCATE mp_cursor

SELECT *
FROM   #badmptable

DROP TABLE #badmptable
--End
```

### Scenario 1

If the output of the PowerShell or T-SQL script returns no value, then there are no duplicate management pack aliases. Proceed with UR4 upgrade.

### Scenario 2

If the output returns one or more rows, then do the following:

1. If the management pack is unsealed
      1. Export the management pack from the console.<br/>
      1. Open the management pack XML using a text editor.<br/>
      1. Identify the duplicate alias.<br/>
      1. Rename one of the aliases under **Reference** and all other places where the alias is used in the XML body.<br/>In this example, we have two aliases, which will be considered as duplicates in System Center Operations Manager 2019 UR4. 

            :::image type="content" source="./media/remove-duplicate-management-pack-aliases/aliases-example-inline.png" alt-text="Screenshot showing the aliases example." lightbox="./media/remove-duplicate-management-pack-aliases/aliases-example-expanded.png":::

            In order to detect where the aliases are used, search the XML with **AliasName**. In this case, it's **BADALIAS**. Note the places where the reference is used.

            Rename one of those aliases to a unique name under **Reference** and replace all the occurrences of the old name with the new name as detected in the above step.<br/>
      1. Once the duplicate aliases are renamed, reimport the management pack to System Center Operations Manager.<br/>

2.	If the management pack is sealed
      1. Open the sealed management pack as per the tool of preference.<br/>
      1. Identify the duplicate alias.<br/>
      1. Rename one of the aliases under **Reference** and all other places where the alias is used in the XML body.<br/>
      1. Rebuild the management pack and reimport in System Center Operations Manager.<br/>
      1. The same steps can be done by editing the XML - [Sealing the management pack](/system-center/scsm/seal-mp) and [reimporting the management pack](/system-center/scom/manage-mp-import-remove-delete).

Once the mitigation is done on all the management packs, rerun the PowerShell script or the T-SQL script to ensure it returns no output.

Follow the above steps for each management pack returned as output.
