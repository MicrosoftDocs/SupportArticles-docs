---
title: Lookup fields cannot save or provide results with Chrome 38
description: Microsoft Dynamics CRM lookups fail to save or provide results when using Google Chrome 38. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-apps-addons
---
# Microsoft Dynamics CRM lookup fields fail to save or provide results when using Google Chrome version 38

This article provides a resolution for the issue that Microsoft Dynamics CRM lookup fields fail to save or provide results when using Google Chrome version 38.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3008160

## Symptoms

In Microsoft Dynamics CRM 2013, you'll receive the **An error occurred** error when selecting on a lookup field on a form.

In Microsoft Dynamics CRM 2011, you'll be able to retrieve results on the lookup. On save, it will fail with **The lookup could not be resolved to a record in the system. You must select the record for the system to use before you can save**.

This issue only occurs on Google Chrome version 38, which was released October 7, 2014. It includes any build lower than **38.0.2125.111**. The version numbers can be found here: [Chrome Releases](https://chromereleases.googleblog.com/)

## Resolution

Google Chrome 38 version **38.0.2125.111** will resolve this issue. It's recommended to apply the latest updates for Google Chrome.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
