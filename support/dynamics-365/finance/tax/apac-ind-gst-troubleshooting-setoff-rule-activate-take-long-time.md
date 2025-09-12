---
# required metadata

title: Activating the setoff rule takes a long time
description: Provides troubleshooting information to help speed up the activation process for setoff rules.
author: shaoling
manager: beya
ms.date: 04/30/2024

# optional metadata

#ms.search.form:
audience: Application user
# ms.devlang: 
ms.reviewer: kfend, maplnan

# ms.tgt_pltfrm: 
ms.custom: sap:Tax - India tax\Issues with India goods and service tax (IN GST)
ms.search.region: India
# ms.search.industry: 
ms.author: wangchen
ms.search.validFrom: 2021-04-01
ms.dyn365.ops.version: 10.0.1
---

# Activating the setoff rule takes longer time than expected

When you select **Activate** to activate the setoff hierarchy profile, it may take longer time than expected. The delay usually happens when activating a profile for a long period, such as one year.

To solve this issue, take the following steps:

1. Go to **Workspaces** > **Feature management** and in the list, find the feature, **Activate setoff hierarchy profile in batch**.
2. Select **Enable now**.
3. Activate the setoff hierarchy profile in batch mode.
4. On the **Batch jobs** page, find the job in the list and check the status.
5. If the issue can't be resolved, determine whether customization exists. If no customization exists, contact Microsoft Support for further assistance.
