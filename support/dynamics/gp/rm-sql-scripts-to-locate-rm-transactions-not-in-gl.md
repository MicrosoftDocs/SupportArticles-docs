---
title: RM SQL scripts to locate RM transactions that are not in GL
description: Provides RM  SQL scripts to locate RM Transactions that are not in GL in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# RM SQL scripts to locate RM transactions that are not in GL in Microsoft Dynamics GP

This article provides RM SQL scripts to locate RM transactions that are not in GL (work, open, or history) in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4229852

You can use the scripts below to locate transactions that are in the RM side (open and history) but not in the GL (work, open, or history). Any results returned, you will need to review those on your own.

```sql
select * from RM20101
where DOCNUMBR not in
(select ORCTRNUM from GL30000 where SERIES=3)
and DOCNUMBR not in
(select ORCTRNUM from GL20000 where SERIES=3)
and DOCNUMBR not in
(select a.ORCTRNUM from GL10001 a
inner join GL10000 b on a.JRNENTRY=b.JRNENTRY
where b.SERIES=3)
and VOIDSTTS=0 and POSTDATE<> '1900-01-01 00:00:00.000'
```

```sql
select * from RM30101
where DOCNUMBR not in 
(select ORCTRNUM from GL30000 where SERIES=3)
and DOCNUMBR not in
(select ORCTRNUM from GL20000 where SERIES=3)
and DOCNUMBR not in 
(select a.ORCTRNUM from GL10001 a
inner join GL10000 b on a.JRNENTRY=b.JRNENTRY
where b.SERIES=3)
and VOIDSTTS=0 and POSTDATE <> '1900-01-01 00:00:00.000'
```
