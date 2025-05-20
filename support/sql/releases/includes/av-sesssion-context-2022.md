---
ms.author: jopilov
author: PiJoCoder
ms.date: 05/20/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage), evergreen
---

SQL Server 2022 includes a fix to address wrong results in parallel plans returned by the built-in `SESSION_CONTEXT`. However, this fix might create access violation dump files when the SESSION is reset for reuse. To mitigate this issue and avoid incorrect results, you can disable the original fix, and also disable the parallelism for the built-in `SESSION_CONTEXT`. To do this, use the following trace flags:

- 11042 - This trace flag disables the parallelism for the built-in `SESSION_CONTEXT`.

- 9432 - This trace flag disables the fix that's included in SQL Server 2022.

Microsoft is working on a fix for this issue and it will be available in a future CU.
