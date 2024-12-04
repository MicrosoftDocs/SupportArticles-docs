---
# required metadata

title: No matching result could be found error
description: Provides a resolution to solve the No matching result could be found error that occurs in Tax Calculation.
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
# "No matching result could be found" error in the Tax Calculation

This article explains the troubleshooting steps that you can take if you receive the "No matching result could be found" error in [Tax Calculation](/dynamics365/finance/localizations/global/global-tax-calcuation-service-overview) in Dynamics 365 Finance.

## Symptoms

You receive the following error message:

> Header/Lines - 1, Tax group applicability, no matching result could be found.

```jsonc
======================Tax calculation result JSON:===========================
{
    "taxDocument": {
        "Header": [
            {
                "Lines": [
                    {
                        ...
                        "Errors": [
                            {
                                "Code": "TaxSetup20000",
                                "Message": "Header/Lines - 1, Tax group applicability, no matching result could be found."
                            }
                        ],
                        "Adjustment": null
                    }
                ],
                "Measures": {
                    ...
                },
                ...
            }
        ]
    },
    ...
}
```

## Cause

The issue occurs when the feature setup in [Globalization Studio](/dynamics365/finance/localizations/global/globalization-studio-overview) is incorrect.

## Resolution

1. Download the troubleshooting file. For more information, see [How to enable debug mode for troubleshooting](tcs-troubleshooting-enable-debug-mode.md).
2. Compare the Tax calculation input with the feature setup to fix the setup issue.

    The following example shows the Tax calculation input.

    ```jsonc
    ===============================Tax calculation input JSON:=====================================
    {
        "TaxableDocument": {
            "Header": [
                {
                    "Lines": [
                        {
                            ...
                        }
                    ],
                    "Business Process": "Sales",
                    "Ship From Zip Code": "30159",
                }
            ]
        },
        "Parameter": {
            ...
        },
        "Adjustment": {
            "Lines": {}
        }
    }
    ```

    The following table lists the tax group applicability in [Globalization Studio](/dynamics365/finance/localizations/global/globalization-studio-overview).

    | Header.Business process | Lines.Business Unit | Header.Ship From Zip Code | Tax Group |
    |-------------------------|---------------------|---------------------------|-----------|
    | Journal                 |                     |                           | Group A   |
    | Sales                   |                     | 30160                     | Group B   |

    According to the Tax calculation input, the **Business Process** value on the header is **Sales**, and the **Ship From Zip Code** value on the header is **30159**. This input is based on the setup of the applicability rules in Globalization Studio. Because there's no matching line, the error message occurs.

    > [!NOTE]
    > If the value in the applicability rule is blank, the rule is applicable to any value.

## Mitigation

Follow these steps to mitigate the error.

1. In Globalization Studio, go to **Globalization features** \> **Tax calculation**.
2. Create a new version of the feature.
3. Add a line for the corresponding information.

    | Header.Business process | Lines.Business Unit | Header.Ship From Zip Code| Tax Group |
    |-------------------------|---------------------|--------------------------|-----------|
    | Journal                 |                     |                          | Group A   |
    | Sales                   |                     | 30160                    | Group B   |
    | Sales                   |                     | 30159                    | Group B   |

4. Publish the feature setup version.
5. In Dynamics 365 Finance, go to **Tax** \> **Setup** \> **Tax configuration** \> **Tax calculation parameters**, and then select the new version.
