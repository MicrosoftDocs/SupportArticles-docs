---
title: Information about what ship-to address is used
description: This article describes information about what ship-to address is used when you create a purchase order by using Purchase Order Generator in Microsoft Dynamics GP.
ms.reviewer: 
ms.date: 03/13/2024
---
# Information about what ship-to address is used when you create a purchase order by using Purchase Order Generator in Microsoft Dynamics GP

This article describes information about what ship-to address is used when you create a purchase order by using Purchase Order Generator in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 909722

## Introduction

This article discusses what ship-to address is used on a purchase order when you use Purchase Order Generator in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains to create a purchase order.

## More information

The ship-to address that is used on your purchase order is the address for the site that you entered for the purchase order line item. To see the address for your site, click **Cards**, point to **Inventory**, click **Site**, and then type your site ID.

If an address does not exist for the site that is used on the purchase order, the company address that is assigned in the **Company Setup** dialog box is used. To see the company address, use one of the following methods:

- In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then click **Company**.

- In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Setup** on the **Tools** menu, point to **Company**, and then click **Company**.

You may assign a specific address ID to the **Site ID** field in Purchase Order Generator. To do this, follow these steps:

1. In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Purchasing**, and then click **Purchase Order Generator Map Sites**.</br></br>In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Setup** on the **Tools** menu, point to **Purchasing**, and then click **Purchase Order Generator Map Sites**.
2. Click your site ID in the **Site ID** list, and then type your address ID in the **Address** box.
3. Click **OK**.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
