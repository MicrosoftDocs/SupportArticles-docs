---
title: How to enable network DTC access
description: Describes the procedures that you follow to enable network Distributed Transaction Coordinator (DTC) access
ms.date: 04/12/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dtc-startup-configuration-connectivity-and-cluster, csstroubleshoot
ms.technology: windows-server-application-compatibility
---
# How to enable network DTC access

This article describes the procedures that you follow to enable network Distributed Transaction Coordinator (DTC) access.  

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 817064

## Summary

> [!NOTE]
> The following procedure is for Windows Server 2003. It does not apply to Microsoft Windows 2000 Server.

By default, network DTC access is disabled on the Windows Server 2003 products that are mentioned in the "Applies To" section. When you do not enable network DTC access on the server, applications can only use transactions that stay on the local computer. For example, transactions cannot flow from a local computer to a database that runs on a separate computer if network DTC access is disabled.

When network DTC access is disabled, clients that try to gain access to DTC on the server may receive the following error message:  
> error 0x8004D025 (XACT_E_PARTNER_NETWORK_TX_DISABLED)  

## More information

### Steps to enable network DTC access

1. Click **Start**, point to
 **Control Panel**, and then click **Add or Remove Programs**.
2. Click **Add/Remove Windows Components**.
3. Select **Application Server**, and then click
 **Details**.
4. Select **Enable network DTC access**, and then click **OK**.
5. Click **Next**.
6. Click **Finish**.  

If you are running Windows Server 2003 Service Pack 1 (SP1), you must follow these additional steps:  

1. Click **Start**, click **Run**, type *comexp.msc*, and then click **OK** to open Component Services.  
2. Expand **Component Services**, expand **Computers**, right-click **My Computer**, and then click **Properties**.
3. On the **MSDTC** tab, click **Security Configuration** under **Transaction Configuration**, click to select the **Network DTC Access** check box under **Security Settings**, and then click to select the following check boxes under **Transaction Manager Communication**:
   - **Allow Inbound**  
   - **Allow Outbound**  
4. On Microsoft Cluster Server (MSCS) clusters, you cannot select **Mutual Authentication Required**. Therefore, click to select one of the following check boxes:
    - **Incoming Caller Authentication Required**  
    - **No Authentication Required**  
    > [!NOTE]
    > For more information about these options, click the following article number to view the article in the Microsoft Knowledge Base:  
   [899191](https://support.microsoft.com/help/899191) New functionality in the Distributed Transaction Coordinator service in Windows Server 2003 Service Pack 1 and in Windows XP Service Pack 2  

5. Make sure that the **Logon Account** is set to NTAUTHORITY\NetworkService.
6. Click **OK**. A message box explains that the MS DTC Service will be stopped and restarted, and that all dependent services will also be stopped and restarted. Click **Yes**.

   > [!NOTE]
   > If this is a Majority Node Set (MNS) cluster, do not use the MNS resource as the storage device for MS DTC. MS DTC requires a storage resource such as a physical disk.

## References

For more information about what is new in Microsoft COM+ 1.5, visit the following Microsoft Developer Network (MSDN) Web site:  
[What's New in COM+ 1.5](/windows/win32/cossdk/what-s-new-in-com--1-5)
