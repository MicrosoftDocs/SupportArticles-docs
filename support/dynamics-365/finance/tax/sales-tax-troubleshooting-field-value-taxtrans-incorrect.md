---
# required metadata

title: Incorrect field value in TaxTrans
description: Provides troubleshooting information that can help when field values are incorrect in TaxTrans.
author: EricWangChen
ms.date: 04/30/2024

# optional metadata

#ms.search.form:
audience: Application user
# ms.devlang: 
ms.reviewer: kfend, maplnan

# ms.tgt_pltfrm: 
ms.custom: sap:Tax - indirect tax
ms.search.region: Global
# ms.search.industry: 
ms.author: wangchen
ms.search.validFrom: 2021-04-01
ms.dyn365.ops.version: 10.0.1
---

# Field value is incorrect in TaxTrans

If a field value in **TaxTrans** is incorrect, use the information in this article to try to resolve the issue.

## Overview of values

The following list shows how **TaxTrans**, **TaxUncommitted**, and **TmpTaxWorkTrans** are similar data sets, but in work differently.

- **TaxTrans** is the final posted tax transaction result persisted in the database.
- **TaxUncommitted** is the intermediate calculated tax result persisted in the database (if applicable), which will be used later in posting.
- **TmpTaxWorkTrans** is the temporary calculated tax result in the in-memory table (Table Type = InMemory).

If you find the root cause of an incorrect **TaxTrans** column, you've also found the root cause of an incorrect **TaxUncommitted** or **TmpTaxWorkTrans** column as the three columns are copied from each other.

Typically, during tax calculation, **TmpTaxWorkTrans** is generated, and then, if applicable, **TaxUncommitted** is generated. During tax posting, **TaxTrans** is generated.

## Add breakpoints

To add breakpoints, complete the following steps:

1. Add extensions and breakpoints in `insert()` and `update()` in the extensions as shown below.

     - **TaxTrans**

        ```x++
        [ExtensionOf(tableStr(TaxTrans))]
        public final class TaxTrans_Extension
        {
            public void insert()
            {
                next insert();
            }
        
            public void update()
            {
                next update();
            }
        
        }
        ```

     - **TaxUncommitted**

        ```x++
        [ExtensionOf(tableStr(TaxUncommitted))]
        public final class TaxUncommitted_Extension
        {
            public void insert()
            {
                next insert();
            }
        
            public void update()
            {
                next update();
            }
        
        }
        ```

     - **TmpTaxWorkTrans**

        ```x++
        [ExtensionOf(tableStr(TmpTaxWorkTrans))]
        public final class TmpTaxWorkTrans_Extension
        {
            public void insert(boolean _ignoreCalculatedSalesTax)
            {
                next insert(_ignoreCalculatedSalesTax);
            }
        
            public void update(boolean _ignoreCalculatedSalesTax)
            {
                next update(_ignoreCalculatedSalesTax);
            }
        
        }
        ```

2. Alternatively, you can add breakpoints directly when **TaxUncommitted** isn't included.

     - `TaxTrans.insert()`, `TaxTrans.update()`
     - `TmpTaxWorkTrans.insert()`, `TmpTaxWorkTrans.update()`

## Reproduce and debug

After the breakpoints are set, every data persistency change is visible during debugging. To find the root cause of an incorrect column of **TaxTrans**, **TaxUncommitted**, or **TmpTaxWorkTrans**, review and note the following items:

- The last breakpoint where the column is correct.
- The first breakpoint where the column is incorrect.
- What happens in between those two points.

## Determine whether customization exists

If you've completed the steps in the previous sections but haven't been able to resolve the issue, determine whether customization exists. If no customization exists, contact Microsoft Support for assistance.
