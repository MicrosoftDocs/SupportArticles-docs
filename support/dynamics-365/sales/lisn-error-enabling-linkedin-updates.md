---
title: Error in enabling LinkedIn updates
description: Learn how to resolve issues related to enabling LinkedIn updates in Dynamics 365 Sales. 
author: udaykirang
ms.author: udag
ms.reviewer: udag
ms.topic: troubleshooting
ms.collection: 
ms.date: 10/03/2024
ms.custom: bap-template 
---

# Error in enabling LinkedIn updates

This article helps you resolve issue related to enabling LinkedIn updates in Dynamics 365 Sales.  

## Symptoms

When enabling the data validation option (**Enable LinkedIn updates**) in the **Sales Navigator Integration Settings** dialog box, you might see the status that data validation has failed. The possible errors are:  

- Data validation has failed because CRM sync is disabled in LinkedIn Sales Navigator.
- Data validation failed with some other error (for example, an "unexpected error").

:::image type="content" source="media/linkedin/lisn-update-error.png" alt-text="Screenshot of Error in enabling LinkedIn updates.":::

For more information about the data validation capability of LinkedIn Sales Navigator, see [Data validation](dynamics365/sales/linkedin/data-validation).

## Resolution

- If you get the data validation failure because CRM sync was disabled, verify the following:

    - CRM sync is enabled in LinkedIn Sales Navigator.  
    - The setting for data validation is enabled in LinkedIn Sales Navigator. If this setting isn't turned on, you'll see the CRM sync disabled status even though CRM sync is enabled. If you aren't able to see the data validation setting in LinkedIn Sales Navigator, ensure that you have an appropriate Sales Navigator license. More information: [Sales Navigator Data Validation - Overview](https://www.linkedin.com/help/sales-navigator/answer/a120992)  
    - If you've turned on both the settings, ensure that you've turned on the **Enable LinkedIn updates** setting at least once.

- If the error is due to something other than CRM sync, you can try restarting data validation by first disabling it from the **Sales Navigator Integration Settings** dialog box, and then enabling it again.