---
title: Flow Runtime errors and recommendations
description: Describes Flow Runtime errors and recommendations.
ms.reviewer: 
ms.date: 03/31/2021
ms.custom: sap:Flow run issues\Performance
---
# Flow Runtime errors and recommendations

This article describes Flow Runtime errors and recommendations.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4515139

## Flow Runtime errors

- If your Flow appears to run slowly, it's likely being throttled. For more information, see [Limits for automated, scheduled, and instant flows](/power-automate/limits-and-config#request-limits).
- If you're using the **Apply to Each** action, make sure you have concurrency enabled.
- If you're using variables, be aware that variables exclusively lock and will slow down loops significantly.
- If using a [Dynamics 365 trigger](/power-automate/connection-dynamics365#trigger-based-logic), consider using the [Common Data Service connector](/power-automate/connection-cds) instead. In rare cases, Dynamics 365 triggers can take up to 2 hours to fire.

## Use Custom Headers in HTTP Actions

Certain headers are removed from the HTTP Action. To pass custom headers through prepend them with **X-**, for example, instead of Content-Disposition, use **X-Content-Disposition**.
