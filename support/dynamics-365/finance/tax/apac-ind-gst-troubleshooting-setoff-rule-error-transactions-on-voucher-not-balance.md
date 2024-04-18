---
# required metadata

title: Setoff rule error when you run a tax settlement
description: Provides troubleshooting information that can help fix the setoff rule error that might occur during a tax settlement.
author: yungu
manager: beya
ms.date: 04/18/2024

# optional metadata

# ms.search.form:
audience: Application user

# ms.devlang

ms.reviewer: kfend, maplnan

# ms.tgt_pltfrm

ms.custom: sap:Tax - India tax\Issues with India goods and service tax (IN GST)

ms.search.region: India

# ms.search.industry

ms.author: wangchen
ms.search.validFrom: 2021-04-01
ms.dyn365.ops.version: 10.0.1
---

# Setoff rule error when a tax settlement is run

When you run a tax settlement, you might receive an error message. Follow the steps in the sections of this article to fix the error.

## Find the version of the setoff rule that is currently used

1. Go to **Tax** > **Setup** > **Sales tax** > **Maintain setoff hierarchy profiles**.
2. Use the values in the **Effective date** column to find the version of the setoff rule that is currently used.

## Review the settings of the setoff rule

1. Go to **Tax** > **Setup** > **Sales tax** > **Sales tax hierarchies**.
2. Select the setoff rule that is currently used.
3. On the **Versions** FastTab, select **View** to determine which sales tax hierarchies are used.
4. Select **Setoff rules for sales tax hierarchies**.
5. Determine whether the **Recoverable** and **Payable** nodes are selected according to the setoff. If the nodes aren't marked as defined, there might be a posting issue. In this case, contact Microsoft.

## Determine whether customization exists

If you've completed the steps in the previous sections but have found no issue, determine whether customization exists. If no customization exists, create a Microsoft service request for further support.
