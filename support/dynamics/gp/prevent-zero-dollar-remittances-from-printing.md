---
title: How to prevent zero dollar remittances from printing in Payables Management in Microsoft Dynamics GP
description: Describes how to prevent zero dollar remittances from printing in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# How to prevent zero dollar remittances from printing in Payables Management in Microsoft Dynamics GP

This article discusses steps to prevent zero dollar remittances from printing in Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855957

## Introduction

This article discusses how to prevent zero dollar remittances from printing in Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

> [!NOTE]
> To prevent zero dollar remittances from printing, you must have administrator access to Microsoft Dynamics GP and the instance of Microsoft SQL Server.

For more information about how manual payments appear on the check stub and when they're removed from the PM20000 table and from the PM20100 table, see [Information about how manual payments, credit memos, and returns appear on the check stub when you run the Select Checks process in Microsoft Dynamics GP](/troubleshoot/dynamics/gp/how-manual-payments-credit-memos-appear).

For more information about how payments that have amounts of zero are treated in Payables Management, see [How payments that have amounts of zero are treated in Payables Management in Microsoft Dynamics GP](/troubleshoot/dynamics/gp/how-payments-that-have-zero-are-treated).

## Steps to prevent zero dollar remittances from printing

To prevent zero dollar remittances from printing, follow these steps.

> [!NOTE]
> The steps provided in this article will remove the zero-dollar remittances in the PM Remittance temporary table that were previously applied before the checkrun. Please note that these steps will not remove zero-dollar remittances that are created during the checkrun as a result of the auto-apply feature.
>
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **Purchasing**, and then click **Payables**.
2. In the Payables Management Setup window, click to clear the **Print Previously Applied Documents on Remittance** check box.
3. Start Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1: For SQL Server 2000**

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, click **Start** > **All Programs** > **Microsoft SQL Server** > **Query Analyzer**.

   **Method 2: For SQL Server 2005**

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, click **Start** > **All Programs** > **Microsoft SQL Server 2005** > **SQL Server Management Studio**.

    **Method 3: For SQL Server 2008**

    If you're using SQL Server 2008, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.  

4. Run the following statement against the company database to remove the zero dollar remittances in Payables Management.

    ```console
    /* The following code is used to remove zero dollar remittances for a specific vendor. */ 
    
    DELETE PM20100 
    WHERE VendorID = 'VendorID' 
    AND KeySourc = 'REMITTANCE'
    
    /* The following code is used to remove all zero dollar remittances. */ 
    
    DELETE PM20100 
    WHERE KeySourc = 'REMITTANCE'
    ```

    > [!NOTE]
    > In the code, the *VendorID* placeholder represents the actual vendor identifier.

    After you do it, the batches of checks that were created before you ran the statement are also updated.
