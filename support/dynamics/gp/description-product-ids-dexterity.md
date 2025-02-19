---
title: Description of product IDs for Dexterity
description: Describes product IDs for Dexterity add-in products and custom products in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Description of product IDs for Dexterity in Microsoft Dynamics GP

This article discusses product IDs for Dexterity in Microsoft Dynamics GP. This article also discusses why you must obtain a unique product ID for each Dexterity add-in product.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 914899

## Overview

A product ID is a unique integer that identifies a Dexterity add-in product or a Dexterity dictionary. A product ID is sometimes referred to as a dictionary ID. When you're ready to distribute a new product that you developed, you must obtain a product ID. You enter this product ID in the Product Information window in Dexterity when you create a chunk (.cnk) file.

Dexterity uses a chunk file to distribute add-in products to end users. A chunk file extracts itself into a dictionary and then updates the Dynamics.set file. The Dynamics.set file contains product information that is entered into the file when you add the new code from the chunk file.

The Dynamics.set file contains a product ID for each dictionary. The following list contains sample product IDs from the Dynamics.set file:

- 0 Microsoft Dynamics GP
- 1493Smartlist
- 3104 Advanced Security

The product ID is used by Microsoft Great Plains and by Dexterity to define path locations, to define the user interface, and to define application security. The product ID is also used when the chunk file extracts itself to control the dictionary files that are updated.

Microsoft Sales Operations assigns a unique product ID to every product. If two products that have the same product ID are installed together with Microsoft Great Plains or together with Dexterity, the dictionaries and the data could become corrupted.

## Product IDs for custom products

If you develop a custom product for a specific customer, you can obtain a single product ID. If you later decide to distribute the custom product to other customers, you can reuse this product ID for each customer. Although you use a single product ID, a different dictionary is used for each customer. When a different dictionary is used for each customer, the product ID remains unique at that customer site.

If you want to include a functionality from one custom product in another custom product, copy the code to the dictionary for the new custom product. Or, create a separate dictionary for that functionality, and then obtain a new product ID for the functionality. For more information about how to create a chunk file, see [How to create a chunk file in Dexterity in Microsoft Dynamics GP](https://support.microsoft.com/help/894700)

For more information, see [How to request a new Dexterity Product ID for my product](https://support.microsoft.com/help/867102)
