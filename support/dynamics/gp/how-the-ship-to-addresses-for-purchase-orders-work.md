---
title: How the ship-to addresses for purchase orders work
description: Describes how ship-to addresses for purchase orders work in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How the ship-to addresses for purchase orders work in Microsoft Dynamics GP

This article describes how the ship to address works in Microsoft Dynamics GP9.0 and later versions.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 887113

The ship-to address information in Microsoft Dynamics GP is located in the Purchasing Item Detail Entry window. The ship-to address that is printed on the purchase order depends both on the shipping method that is specified in the **Purchasing Item Detail Entry** window and on the purchase order type. The purchase order types are listed in the following table.

|Purchase order type|Shipping method for the purchase order line|Address that is used for this combination of purchase order type and shipping method|
|---|---|---|
|Standard|Delivery|The address that is contained in the **Site ID** field in the purchase order line|
|Standard|Pickup|The address that is contained in the vendor **Purchase Address ID** field in the purchase order line|
|Drop-ship|Delivery|The address that is contained in the customer **Ship To Address ID** field in the purchase order line|
|Drop-ship|Pickup|The address that is contained in the vendor **Purchase Address ID** field in the purchase order line|
  
> [!NOTE]
>
> - In Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, different line items can specify different shipping methods and ship-to addresses.
> - If no shipping method is specified, a ship-to address is not printed on the purchase order.
