---

# required metadata

title: Tax transaction ID is incorrect
description: Provides steps to correct the tax transaction ID.
author: shaoling
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

# Tax transaction ID is incorrect

You can take the following steps to correct the tax transaction ID:

1. The code logic to generate transaction ID is in `TaxGSTInvoiceHelper_IN::generateGSTTransID()`. Set a breakpoint there, and start debugging.

2. If the issue isn't resolved after completing step 1, determine whether customization exists. If no customization exists, contact Microsoft Support for further assistance. If possible, provide the trace file for the posting step.
