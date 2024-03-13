---
title: Configure Distributed Transaction Coordinator service to run eConnect on a Windows Vista-based computer
description: Describes how to configure the Distributed Transaction Coordinator service to run eConnect for Microsoft Dynamics GP 9.0 on a Windows Vista-based computer.
ms.topic: how-to
ms.reviewer: dclauson
ms.date: 03/13/2024
---
# How to configure the Distributed Transaction Coordinator service to run eConnect for Microsoft Dynamics GP 9.0 on a Windows Vista-based computer

This article provides the steps to correctly configure the Distributed Transaction Coordinator service (MS DTC) to run eConnect for Microsoft Dynamics GP 9.0 on a Windows Vista-based computer.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933931

1. Click **Start**, type *run* in the **Start Search** box, and then click **Run** under **Programs**.
2. Type *dcomcnfg* in the **Open** box, and then click **OK**.
3. Expand **Component Services**, expand **Computers**, expand **My Computer**, and then click **Distributed Transaction Coordinator**.
4. Right-click **Local DTC**, click **Properties**, and then click the **Security** tab.
5. Make sure that the following check boxes are selected:

    - **Network DTC Access**
    - **Allow Remote Clients**
    - **Allow Remote Administration**
    - **Allow Inbound**
    - **Allow Outbound**
    - **No Authentication Required**

6. Make sure that the DTC Logon Account is set to **NT AUTHORITY\\NetworkService**.
7. Add the Msdtc.exe file as an exception in Windows Firewall. To do this, follow these steps:

    1. Click **Start**, click **Control Panel**, click **Security**, and then click **Windows Firewall**.
    2. Click **Change Settings**, click the **Exceptions** tab, click **Add program**, and then click **Browse**.
    3. Locate the Windows\\System32 folder, and then click **msdtc.exe**.
    4. Click **Open**, and then click **OK** two times.

8. Restart the Distributed Transaction Coordinator service. To do this, follow these steps:

    1. Click **Start**, type services in the **Start Search** box, and then click **Services** in the **Programs** list.
    2. In the list of services, right-click **Distributed Transaction Coordinator**, and then click **Restart**.

9. Restart the computer that is running Microsoft SQL Server.
