---
title: Hardware inventory process fails
description: Fixes an issue where the hardware inventory process in Configuration Manager fails and the SMSexec.exe process shows high sustained CPU utilization.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Hardware inventory fails and the SMSexec.exe process shows high sustained CPU utilization

This article helps you fix an issue where the hardware inventory process in Configuration Manager fails and the SMSexec.exe process shows high sustained CPU utilization.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 2488396

## Symptom

When using Configuration Manager, processing of hardware inventory (.MIF files) fails and the SMSexec.exe process shows high sustained CPU utilization. Also, MIF files backlog in the *inboxes\auth\dataldr.box\process* folder:

The `NextGroupKey` value in the `ArchitectureMap` table will be unusually high (> 20,000).

The following query can be used to examine the value of the `NextGroupKey`:

```sql
select NextGroupKey from ArchitectureMap where ArchitectureKey = 5
```

If SQLTracing is enabled on the site server, you will see the following messages repeated:

> SQL>>> select NextGroupKey from ArchitectureMap where ArchitectureKey = 5  
> SQL>>>>> Done.  
> SQL>>> update ArchitectureMap set NextGroupKey = NextGroupKey + 1 where ArchitectureKey = 5 and NextGroupKey = 15080  
> SQL>>>>> Done.

You can enable SQLTracing by setting the following value to **1**.

- On 64-bit systems:

  `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\SMS\Tracing\SQLEnabled`

- On 32-bit systems:

  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SQLEnabled`

## Cause

This issue can occur if the global **No count** option is enabled on the SQL Server hosting the Configuration Manager database. If this is enabled, Configuration Manager cannot get the correct rowcount value from SQL Server, and thus it cannot complete the cycle to extend the schema.

## Resolution

Disable the **No count** option and processing will continue normally. The **No count** option can be found in the SQL Server Management Studio: **Properties** of the SQL Server > **Connections** > **No count**. It should be unchecked.

## More information

The **No count** option isn't enabled by default. Microsoft has not tested Configuration Manager with the SQL Server **No count** global option enabled and using this option isn't supported. Regardless, you should determine whether other applications that are using the same SQL Server require the **No count** setting to be enabled before disabling it.
