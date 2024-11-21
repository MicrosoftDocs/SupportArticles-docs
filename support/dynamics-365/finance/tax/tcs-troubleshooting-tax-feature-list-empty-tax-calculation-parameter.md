---
# required metadata

title: Empty tax feature list on Tax calculation parameters
description: Solves an issue where the list of tax features on the Tax calculation parameters page is empty.
author: wangchen
ms.date: 11/21/2024
ms.custom: sap:Tax - indirect tax\Issues with advanced tax calculation

# optional metadata

ms.search.form: TaxIntegrationTaxServiceParameters
audience: Application User
# ms.devlang: 
ms.reviewer: kfend, maplnan
# ms.tgt_pltfrm: 
ms.search.region: Global
# ms.search.industry: 
ms.author: wangchen
ms.search.validFrom: 2021-10-26
ms.dyn365.ops.version: 10.0.21
---
# The tax features list is empty on the Tax calculation parameters page

This article provides a resolution for an issue where the list of tax features on the **Tax calculation parameters** page is empty in Dynamics 365 Finance.

## Symptoms

In Dynamics 365 Finance, when you try to select a value in the **Name** field under **FEATURE** on the **Tax calculation parameters** page, the list of values is empty.

## Cause

The tax feature isn't created in [Globalization Studio](/dynamics365/finance/localizations/global/globalization-studio-overview).

## Resolution

To solve this issue, create the tax feature in Globalization Studio.

For more information, see [Configure the Tax Calculation feature](/dynamics365/finance/localizations/global/global-get-started-with-tax-calculation-service#configure-the-tax-calculation-feature).
