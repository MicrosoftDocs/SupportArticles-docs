---
# required metadata 

title: Enable debug mode in Tax Calculation
description: Introduces how to enable the debug mode in Tax Calculation to investigate issues. 
author: hangwan
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
ms.author: hangwan
ms.search.validFrom: 03/23/2022
ms.dyn365.ops.version: 10.0.21 
---
# How to enable debug mode in Tax Calculation

To enable the debug mode in [Tax Calculation](/dynamics365/finance/localizations/global/global-tax-calcuation-service-overview) in Dynamics 365 Finance, take the following steps:

1. Add _&debug=vs%2CconfirmExit&_ to the URL of the Application Object Server (AOS), and then refresh the page.
2. When you select **Sales tax** to calculate the sale tax, a text file that is named _TaxServiceTroubleshootingLog.txt_ is opened. The _TaxServiceTroubleshootingLog.txt_ file contains `TaxableDocument` and the calculation parameter. These results are returned from the tax calculation and exception information for troubleshooting.

## Sample

```jsonc
===============================Tax calculation input JSON:=====================================
{
    "TaxableDocument": {
    "Header": [
        {
        "Lines": [
            {
            "Transaction Line ID": "5816,68719677391",
            ...
            }
        ],
        "Transaction Header ID": "2022,68719506302",
        ...
        }
    ]
    },
    "Parameter": {
    "ContinueOnErrors": true,
    ...
    },
    "Adjustment": {
    "Lines": {}
    }
}
===========================Tax calculation result JSON:=================================
{
    "taxDocument": {
    "Header": [
        {
        "Lines": [
            {
            "Tax Codes": {
                ...
            }
        ],
        "Measures": {
            "List Code": "EUTrade"
        },
        "Tax Registration ID": null,
        "Transaction Header ID": "2022,68719506302",
        "Errors": null
        }
    ]
    },
    "solutionId": "b51e0025-cbbe-4d37-bf0b-90d7be4f214d|1",
    "isPartialSuccess": false
}
=============================CorrelationId:==============================
"21f3a8a1-ee9a-477b-b44e-b8ec79e74d16"
```
