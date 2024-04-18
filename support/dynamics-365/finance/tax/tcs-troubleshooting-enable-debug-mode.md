---
# required metadata 

title: Enable debug mode in Tax Calculation
description: Introduces how to enable the debug mode in the Tax Calculation service to investigate issues. 
author: hangwan
ms.date: 04/18/2024

# optional metadata 

ms.search.form: TaxIntegrationTaxServiceParameters
audience: Application User 
# ms.devlang: 
ms.reviewer: kfend, maplnan
# ms.tgt_pltfrm: 
ms.custom: sap:Tax - indirect tax\Issues with tax calculation service
ms.search.region: Global
# ms.search.industry: 
ms.author: hangwan
ms.search.validFrom: 03/23/2022
ms.dyn365.ops.version: 10.0.21 
---

# How to enable debug mode in the Tax Calculation service

To enable the debug mode in the Tax Calculation service, take the following steps:

1. Add _&debug=vs%2CconfirmExit&_ to the URL of Application Object Server (AOS), and then refresh the page.
2. When you select **Sales tax** to calculate the sale tax, a text file that is named _TaxServiceTroubleshootingLog.txt_ is opened. The _TaxServiceTroubleshootingLog.txt_ file contains `TaxableDocument` and the calculation parameter. These results are returned from tax service and exception information for troubleshooting.

## Sample

```json
===============================Tax service calculation input JSON:=====================================
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
===========================Tax service calculation result JSON:=================================
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
