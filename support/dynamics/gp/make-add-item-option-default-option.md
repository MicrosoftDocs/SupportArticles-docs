---
title: Make the Add Item option a default option in the Sales Order Processing and Purchase Order Processing modules in Microsoft Dynamics GP
description: Steps to make the Add Item option a default option in the Sales Order Processing and Purchase Order Processing modules in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# How to make the Add Item option a default option in the Sales Order Processing and Purchase Order Processing modules in Microsoft Dynamics GP

This article describes how to make the **Add Item** option a default option in the Sales Order Processing and Purchase Order Processing modules in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 891215

## Introduction

You can download a file that makes the **Add Item** option a default option in the following windows:

- The Sales Transaction Entry window in the Sales Order Processing module
- The following dialog boxes in the Purchase Order Processing module:
  - **Receivings Transaction Entry**
  - **Purchasing Invoice Entry**  
  - **Purchase Order Entry**

When the **Add Item** option is selected in these windows and you enter an inventory item that's not currently in the system, you can create a new inventory item or you can enter a non-inventoried item.

## About the "Add Item" option

The **Add Item** option is available when you're entering a transaction in the Sales Order Processing or Purchase Order Processing modules. To select this option in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, click **Extras**, point to **Options**, and then click **Add Item**. To select this option in Microsoft Great Plains 7.x, click **Options**, and then click **Add Item**.

If the **Add Item** option is selected, you can take any one of the following actions every time that you enter a new item in the Purchase Order Processing or Sales Order Processing modules:

- Create a new inventory item
- Create a new vendor item
- Enter a non-inventoried item

If the **Add Item** option isn't selected, all the new items that you enter are recorded as non-inventoried items.

By default, the **Add Item** option isn't selected in Microsoft Dynamics GP. If you want the **Add Item** option to be a default option, you can install the Additem.cnk file onto each workstation where Microsoft Dynamics GP is installed. After you install this file, you won't have the option to use a non-inventoried item unless you first clear the **Add New Item** check box.

## Install the AddItem.cnk file

To install the Additem.cnk file, follow these steps:

1. Download the 891215AddItem.zip file to each workstation. Save the file to the folder where Microsoft Dynamics GP is installed.
1. Extract the contents of the 891215AddItem.zip file to the same folder.
1. Start Microsoft Dynamics GP.
1. When you receive the following message, click **Yes**:

    Do you want to include new code?
