---
title: Process that you must complete before you post multicurrency intercompany transactions in Microsoft Dynamics GP
description: Description of the process that you must complete before you post multicurrency intercompany transactions in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, ryanklev
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# Description of the process that you must complete before you post multicurrency intercompany transactions in Microsoft Dynamics GP

This article describes a process that you must complete before you post intercompany transactions in Microsoft Dynamics GP when each company has a different functional currency.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917720

Consider the following scenario. You want to post an intercompany transaction. The companies are the TWO originating company and the TEST destination company. The Z-US$ currency is the functional currency for the TWO originating company. The Z-C$ currency is the functional currency for the TEST destination company.

Before you post the multicurrency intercompany transactions, follow these steps:

1. Grant both of the companies access to the different currencies and exchange tables by following these steps:
    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Multicurrency Access**.
    1. In the **Currencies** area, click **Z-US$**.
    1. In the table next to the **Currencies** area, click to select the **Access** check box for both the TWO originating company and the TEST destination company.
    1. In the **Exchange Table IDs** area, click an exchange table identifier, and then click to select the **Access** check box in the table next to the **Exchange Table IDs** area for both the TWO originating company and the TEST destination company.
    1. Repeat step 1d for each exchange table identifier.
    1. In the **Currencies** area, click **Z-C$**.
    1. In the table next to the **Currencies** area, click to select the **Access** check box for both the TWO originating company and the TEST destination company.
    1. In the **Exchange Table IDs** area, click an exchange table identifier, and then click to select the **Access** check box in the table next to the **Exchange Table IDs** area for both the TWO originating company and the TEST destination company.
    1. Repeat step 1 for each exchange table identifier.
    1. Click **OK** to close the Multicurrency Access Setup window.

1. Use the Intercompany Setup window to establish an intercompany relationship between the two companies by following these steps:
    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Intercompany**.
    1. Click the lookup button next to the **Originating Company ID** field, click **TWO** in the Companies window, and then click **Select**.
    1. In the **Destination Company Name** area, click **TEST**.|
    1. In the **Originating Company** area, click the lookup button next to the **Due to** field, click an account that you want to use in the Intercompany Accounts window, and then click **Select**.
    1. In the **Originating Company** area, click the lookup button next to the **Due From** field, click an account that you want to use in the Intercompany Accounts window, and then click **Select**.
    1. In the **Destination Company** area, click the lookup button next to the **Due to** field, click an account that you want to use in the Intercompany Accounts window, and then click **Select**.
    1. In the **Destination Company** area, click the lookup button next to the **Due From** field, click an account that you want to use in the Intercompany Accounts window, and then click **Select**.
    1. Click **Save**.
    1. Close the Intercompany Setup window.
     > [!NOTE]
    > The accounts will be posted in their respective functional currencies. Therefore, you do not have to assign currencies to these accounts.

1. Use the Multicurrency Exchange Rate Table Setup window to set up an exchange table identifier for the Z-US$ currency by following these steps:
    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Exchange Table**.
    1. In the Multicurrency Exchange Rate Table Setup window, set up an exchange table identifier for the Z-US$ currency.
    1. Click **Save**.
    > [!NOTE]
    > You can complete step 3 in either the originating company or the destination company.

1. Use the Select Multicurrency Rate Types window to assign rate types to the exchange table identifier by following these steps:
    1. On the **Tools** menu, point to **Setup** > **Financial**, and then click **Rate Types**.
    1. Click the lookup button next to the **Exchange Table ID** field, select an exchange table identifier in the Exchange Tables window, and then click **Select**.
    1. In the Select Multicurrency Rate Types window, click the appropriate rate type in the **Available Rate Types** area, and then click **Insert**.
    1. Click **Save**.
   > [!NOTE]
    > You must complete step 4 in the destination company.

After you complete this process, you can post an intercompany transaction in the originating company.
