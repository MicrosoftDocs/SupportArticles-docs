---
title: Delete a corrupted Azure Analysis Services database
description: This article provides a workaround for the problem where you may be unable to delete a corrupted database in Azure Analysis Services by using JavaScript Object Notation (JSON) script in Microsoft SQL Server Management Studio (SSMS).
ms.date: 01/14/2021
ms.prod-support-area-path: 
ms.topic: troubleshooting
ms.prod: sql 
---
# JSON script sent via SSMS unable to delete a corrupted database in Azure Analysis Services

This article helps you work around the problem where you may be unable to delete a corrupted database in Azure Analysis Services by using JavaScript Object Notation (JSON) script in Microsoft SQL Server Management Studio (SSMS).

_Applies to:_ &nbsp; Analysis Services  
_Original KB number:_ &nbsp; 4460002

## Symptoms

You may be unable to delete a corrupted database in Azure Analysis Services by using JavaScript Object Notation (JSON) script in Microsoft SQL Server Management Studio (SSMS). When you try to do this, you may receive any of the following error messages from the corrupted database:

> Message: Storage blob does not exist: '\\\\?\\Root\\DatabaseName.0.db\\......'  
A duplicate value has been detected in the Unique Value store associated with the dictionary
The given credential is missing a required property. Data source kind: SQL. Authentication kind: UsernamePassword. Property name: Password  
Cannot execute the Delete command: database 'Database' cannot be found

## Workaround

To work around this issue, run an XML for Analysis (XMLA) query in SSMS to delete the corrupted database:

```xml
<Delete xmlns="[https://schemas.microsoft.com/analysisservices/2003/engine](https://schemas.microsoft.com/analysisservices/2003/engine)"**IgnoreFailures="true"** >
<Object>
<DatabaseID>DatabaseID```
</DatabaseID>
</Object>
</Delete>
```
