---
title: Timeout expired error when passing documents through eConnect
description: You may receive the Timeout expired error when you pass a document through eConnect in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: dclauson
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Timeout expired error when you pass a document through eConnect in Microsoft Dynamics GP

This article provides a resolution for the issue that you receive a **Timeout expired** error when trying to pass a document through eConnect in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936943

## Symptoms

When you pass a document through eConnect in Microsoft Dynamics GP, you receive the following error message:

> Microsoft.GreatPlains.eConnect Version=9.0.0.0 .Net SqlClient Data Provider The Microsoft Distributed Transaction Coordinator (MS DTC) has canceled the distributed transaction. at Microsoft.GreatPlains.eConnect.eConnectMethods.ExecStoredProcedures(String xml) at Microsoft.GreatPlains.eConnect.eConnectMethods.eConnect_EntryPoint(String ConnectionString, ConnectionStringType ConnectionType, String sXML, SchemaValidationType ValidationType, String eConnectSchema) For more information, see Help and Support Center at `https://go.microsoft.com/fwlink/events.asp`." or " Microsoft.GreatPlains.eConnect Version=9.0.0.0 .Net SqlClient Data Provider Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. at Microsoft.GreatPlains.eConnect.eConnectMethods.ExecStoredProcedures(String xml) at Microsoft.GreatPlains.eConnect.eConnectMethods.eConnect_EntryPoint(String ConnectionString, ConnectionStringType ConnectionType, String sXML, SchemaValidationType ValidationType, String eConnectSchema) For more information, see Help and Support Center at `https://go.microsoft.com/fwlink/events.asp`.

## Resolution

To resolve this problem, follow these steps:

1. Select **Start**, select **Settings**, select **Control Panel**, and then select **Administrative Tools**.
2. Double-click **Component Services**.
3. Expand **Component Services**, and then expand **Computers**.
4. Right-click **My Computer**, and then select **Properties**.
5. On the **Options** tab, enter *0* in the **Transaction timeout** box.

   > [!NOTE]
   > Zero is considered infinite.
6. Select **OK**.
7. Try to pass the document through eConnect.
