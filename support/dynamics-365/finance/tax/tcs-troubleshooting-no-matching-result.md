---
# required metadata

title: No matching result could be found error
description: Provides a resolution to solve the No matching result could be found error that occurs in the Tax Calculation service.
author: hangwan
ms.date: 10/31/2022

# optional metadata

ms.search.form: TaxIntegrationTaxServiceParameters
audience: Application User
# ms.devlang: 
ms.reviewer: kfend
# ms.tgt_pltfrm: 
# ms.custom: 
ms.search.region: Global
# ms.search.industry: 
ms.author: hangwan
ms.search.validFrom: 03/23/2022
ms.dyn365.ops.version: 10.0.21
---


# "No matching result could be found" error in the Tax Calculation service

This article explains the troubleshooting steps that you can take if you receive the "No matching result could be found" error in the Tax Calculation service.

## Symptoms

You receive the following error message:

> Header/Lines - 1, Tax group, no matching result could be found.

```json
======================Tax service calculation result JSON:===========================
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

The issue occurs when the feature setup in Regulatory Configuration Service (RCS) is incorrect.

## Resolution

1. Download the troubleshooting file. For more information, see [How to enable debug mode for troubleshooting](tcs-troubleshooting-enable-debug-mode.md).
2. Compare the Tax service calculation input with the feature setup to fix the setup issue.

    The following example shows the Tax service calculation input.

    ```json
    ===============================Tax service calculation input JSON:=====================================
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

    The following table lists the tax group applicability in RCS.

    | Header.Business process | Lines.Business Unit | Header.Ship From Zip Code | Tax Group |
    |-------------------------|---------------------|---------------------------|-----------|
    | Journal                 |                     |                           | Group A   |
    | Sales                   |                     | 30160                     | Group B   |

    According to the Tax service calculation input, the **Business Process** value on the header is **Sales**, and the **Ship From Zip Code** value on the header is **30159**. This input is based on the setup of applicability rules in RCS. Because there's no matching line, the error message occurs.

    > [!NOTE]
    > If the value in the applicability rule is blank, the rule is applicable to any value.

## Mitigation

Follow these steps to mitigate the error.

1. In RCS, go to **Globalization features** \> **Tax calculation**.
2. Create a new version of the feature.
3. Add a line for the corresponding information.

    | Header.Business process | Lines.Business Unit | Header.Ship From Zip Code| Tax Group |
    |-------------------------|---------------------|--------------------------|-----------|
    | Journal                 |                     |                          | Group A   |
    | Sales                   |                     | 30160                    | Group B   |
    | Sales                   |                     | 30159                    | Group B   |

4. Publish the feature setup version.
5. In Microsoft Dynamics 365 Finance, go to **Tax** \> **Setup** \> **Tax configuration** \> **Tax calculation parameters**, and then select the new version.
