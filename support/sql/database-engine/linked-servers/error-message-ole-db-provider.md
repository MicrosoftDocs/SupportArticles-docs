---
title: Error message of OLE DB provider
description: This article provides workaround for the error message of OLE DB provider SQLOLEDB was unable to begin a distributed transaction. 
ms.date: 09/25/2020
ms.custom: sap:MDAC and ADO
ms.reviewer: rakguj
---
# Error message OLE DB provider SQLOLEDB was unable to begin a distributed transaction

This article helps you work around the problem that error message of **OLE DB provider SQLOLEDB was unable to begin a distributed transaction**.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 816701

## Symptoms

When you try to use Microsoft SQL Server to start a distributed transaction between linked servers that are running Windows Server, you may receive the following error message:

> OLE DB provider SQLOLEDB was unable to begin a distributed transaction

The following message may appear on the OLE DB provider computer:

> New transaction cannot enlist in the specified transaction coordinator.

## Cause

This behavior occurs if the Distributed Transaction Coordinator (DTS) service is disabled or if network DTC access is disabled. By default, network DTC access is disabled in Windows Server.

## Workaround

To work around this behavior, install network DTC access on both servers:

1. Click **Start**, and then click **Control Panel**.
2. Click **Add or Remove Programs**, and then click **Add/Remove Windows Components**.
3. In the **Components** box, click **Application Server**, and then click **Details**.
4. Click to select the **Enable network DTC access** check box, and then click **OK**.
5. Click **Next**, and then follow the instructions that appear on the screen to complete the installation process.
6. Stop and then restart the Distributed Transaction Coordinator service.
7. Stop and then restart any resource manager services that participates in the distributed transaction (such as Microsoft SQL Server or Microsoft Message Queue Server).
