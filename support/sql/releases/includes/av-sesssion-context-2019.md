---
ms.author: jopilov
author: PiJoCoder
ms.date: 04/02/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage), evergreen
---

SQL Server 2019 CU14 introduced a fix [14307204](../sqlserver-2019/cumulativeupdate14.md#14307204) to [address wrong results in parallel plans returned by the built-in SESSION_CONTEXT](https://support.microsoft.com/help/5008114). However, this fix might create access violation dump files when the SESSION is reset for reuse. To mitigate this issue and avoid incorrect results, you can disable the original fix, and also disable the parallelism for the built-in `SESSION_CONTEXT`. To do this, use the following trace flags:

- 11042 - This trace flag disables the parallelism for the built-in `SESSION_CONTEXT`.

- 9432 - This trace flag disables the fix that was introduced in SQL Server 2019 CU14.
