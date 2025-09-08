---
title: How to implement MS DTC with eConnect
description: Introduces how to implement Microsoft Distributed Transaction Coordinator (MS DTC) with eConnect for Microsoft Dynamics GP.
ms.reviewer: theley, dclauson
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to implement Microsoft Distributed Transaction Coordinator with eConnect for Microsoft Dynamics GP

This article describes how to implement Microsoft Distributed Transaction Coordinator (MS DTC) for eConnect for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 907668

Follow these steps on a computer that is running Microsoft Windows XP Service Pack 2 (SP2) or Windows Server 2003 Service Pack (SP1):

1. Make sure that the eConnect object is running under a specific account:

    1. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Component Services**.

    2. Expand **Component Services**, expand **Computers**, expand **My Computer**, and then expand **COM+ Applications**.
    3. Right-click **eConnect 8 for Great Plains**, and then select **Properties**.
    4. Select the **Identity** tab.
    5. In the **Account** list, select **This User**.
    6. Specify a Windows user account that has the following characteristics:

        - The user account has access to the computer that is running Microsoft SQL Server.
        - The user account has been added to SQL logins.
        - The user account has at least DYNGRP permissions.

        > [!NOTE]
        > This user account must be at least a local administrator. Make sure that you specify a user account where the administrator is the only person who knows the logon information. This approach lets users start the eConnect methods, but the users cannot use the account to gain access to all the Microsoft Dynamics GP tables.

2. The DTC Service must use the NT AUTHORITY\NetworkService account, and the **Network DTC Access** check box must be selected. To make sure that the DTC service uses this account, follow these steps:

    1. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Component Services**.

    2. Expand **Component Services**, and then expand **Computers**.
    3. Right-click **My Computer**, and then select **Properties**.
    4. Select the **MSDTC** tab, and then select **Security Configuration**.
    5. Make sure that the following check boxes are selected:
        - **Network DTC Access**
        - **Allow Remote Clients**
        - **Allow Remote Administration**
        - **Allow Inbound**
        - **Allow Outbound**
        - **No Authentication Required**
    6. Make sure that the DTC Logon Account is set to **NT AUTHORITY\NetworkService**.

3. Add MSDTC.exe as an exception in Windows Firewall.

For all these changes to take effect, you must restart MS DTC and SQL Server.
