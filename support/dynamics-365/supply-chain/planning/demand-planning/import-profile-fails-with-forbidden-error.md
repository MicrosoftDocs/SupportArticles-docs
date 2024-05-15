---
title: Import profile job fails with a Forbidden error
description: Provides a resolution for the Forbidden error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/10/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---
# An import profile job fails with a "Forbidden" error

This article provides a resolution for the "Forbidden" error that occurs when an [import profile job](/dynamics365/supply-chain/demand-planning/import-data#create-an-import-profile-for-importing-directly-from-supply-chain-management) fails in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

The Dynamics 365 Finance and Operations import profile job fails, and the job execution details contain an error mentioning "Forbidden."

## Resolution

To solve this issue, follow these steps:

1. Navigate to **Data Management Workspace** > **Framework parameters** > **General**.
2. Change the value of **Shared access signature expiration time in minutes** from **0** to **120**.

## More information

- [Demand planning import profile troubleshooting guide](import-landing-page.md)
- [An import profile job fails with a "Timeout" error](project-time-out.md)
- [Import profile job fails due to special characters](special-characters.md)
- [Import profile job fails due to insufficient permissions](user-insufficient-permissions.md)
- [Import data into Demand planning](/dynamics365/supply-chain/demand-planning/import-data)
