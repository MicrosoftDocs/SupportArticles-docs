---
# required metadata

title: Empty tax feature list in Tax calculation parameters
description: Explains how to solve an issue where the list of tax features on the Tax calculation parameters page is empty.
author: wangchen
ms.date: 04/30/2024

# optional metadata

ms.search.form: TaxIntegrationTaxServiceParameters
audience: Application User
# ms.devlang: 
ms.reviewer: kfend, maplnan
# ms.tgt_pltfrm: 
ms.custom: ms.custom: sap:Tax - indirect tax\Issues with advanced tax calculation service
ms.search.region: Global
# ms.search.industry: 
ms.author: wangchen
ms.search.validFrom: 2021-10-26
ms.dyn365.ops.version: 10.0.21
---
# The tax features list is empty in the Tax calculation parameters page

## Symptoms

When you open Finance, go to **Tax** \> **Setup** \> **Tax configuration** \> **Tax calculation parameters**, and try to select a value in the **Feature setup name** field, the list of values is empty.

## Cause

The tax feature is not created in Globalization studio.

## Resolution

Create tax feature in Globalization studio.

1. In Globalization studio, go to **Globalization services** \> **Tax calculation**.
2. Create a new feature
