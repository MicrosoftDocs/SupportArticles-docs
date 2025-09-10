---
ms.author: jopilov
author: PiJoCoder
ms.date: 05/30/2025
ms.update-cycle: 1095-days
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage), evergreen
ms.reviewer: derekw，moraja，bcaetano，randolphwest，mathoma，v-cuichen
---

Queries that use the built-in `SESSION_CONTEXT` function might return incorrect results or trigger access violation (AV) dumps when executed in parallel query plans. This issue stems from the way `SESSION_CONTEXT` interacts with parallel execution threads, particularly when the session is reset for reuse.

For more information, see the [Known issues](/sql/t-sql/functions/session-context-transact-sql#known-issues) section in `SESSION_CONTEXT`.
