---
title: Enable the Copy button in the Sales Transaction Entry window, Purchase Order Entry window, and Item Maintenance window
description: Describes how to enable the Copy button in the Sales Transaction Entry window, in the Purchase Order Entry window, and in the Item Maintenance window in Microsoft Dynamics GP.
ms.topic: how-to
ms.date: 03/13/2024
ms.reviewer: theley
ms.custom: sap:Financial - Receivables Management
---
# How to enable the "Copy" button in the Sales Transaction Entry window, Purchase Order Entry window, and Item Maintenance window in Microsoft Dynamics GP

This article describes how to enable the **Copy** button in the Sales Transaction Entry window, in the Purchase Order Entry window, and in the Item Maintenance window in Microsoft Dynamics GP. To use the **Copy** button, you must grant access to certain fields. This article describes how to grant access to these fields.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936563

## Introduction

In versions that are earlier than Microsoft Business Solutions-Great Plains 8.0, if the **Copy** button is not enabled, you must install a chunk file to enable the **Copy** button in specific windows. In Microsoft Business Solutions-Great Plains 8.0, in Microsoft Dynamics GP 9.0, and in Microsoft Dynamics GP 10.0, the Copier Series is integrated with the code. Therefore, you do not have to install the chunk file. However, you must grant access to the Copier Series for the **Copy** button for specific windows in Sales Order Processing, in Purchase Order Processing, and in Inventory.

## More information

To determine the fields that have to be enabled, follow these steps.

### Microsoft Dynamics GP 10.0

1. Determine whether the Copier Series is enabled. To do this, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Customization Status**.

2. Determine whether access is granted for the Copier Series. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.
    2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
    3. In the **User** field, click the magnifying glass icon, and then select the User ID that must have the **Copy** button enabled.
    4. In the **Company** list, click the company that must have the **Copy** button enabled.
    5. Double-click the security role ID that must have the **Copy** button enabled.
    6. In the **Security Role Setup** window, double-click the security task ID that is created for the user.
    7. In the **Security Task Setup** window, double-click the security task ID that is created for the user.
    8. In the **Product** list, click **Copier Series**.
    9. In the **Type** list, click **Windows**.
    10. In the **Series** list, click **Sales** to enable the **Copy** button in the **Sales Transaction Entry** window.
    11. Under **Access List**, click the box next to **Copy a Sales Order**.
    12. In the **Series** list, click **Purchasing** to enable the **Copy** button in the Purchase Order Entry window.
    13. Under **Access List**, click the box next to **Copy a Purchase Order**.
    14. In the **Series** list, click **Inventory** to enable the **Copy** button in the Item Maintenance window.
    15. Under **Access List**, click the box next to **Item Copy**.

### Microsoft Dynamics GP 9.0 and earlier versions

1. Determine whether the Copier Series is enabled. To do this, point to **Customize** on the **Tools** menu, and then click **Customization Status**.
2. Determine whether access is granted for the Copier Series. To do this, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.

    2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.

        If you receive the following message, click **No**:

        > Security and Advanced Security are both installed. You should use only the Security Setup window or Advanced Security window to change user security settings. Would you like to open Advanced Security?
    3. In the **Company** list, click the company that must have the **Copy** button enabled.
    4. In the **User ID** list, click the ID of the user who must have the **Copy** button enabled.
    5. In the **Product** list, click **Copier Series**.
    6. In the **Type** list, click **Windows**.
    7. In the **Series** list, click **Sales** to enable the **Copy** button in the Sales Transaction Entry window.
    8. Under **Access List**, double-click **Copy a Sales Order**.
    9. In the **Series** list, click **Purchasing** to enable the **Copy** button in the **Purchase Order Entry** window.
    10. Under **Access List**, double-click **Copy a Purchase Order**.
    11. In the **Series** list, click **Inventory** to enable the **Copy** button in the **Item Maintenance** window.
    12. Under **Access List**, double-click **Item Copy**.
    13. Click **OK**.

> [!NOTE]
> An asterisk appears next to the option that you selected under **Access List**.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
