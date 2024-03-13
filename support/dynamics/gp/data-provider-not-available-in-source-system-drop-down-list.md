---
title: Data Provider not available in Source System drop-down list
description: Describes a problem in Microsoft Management Reporter where the Data Provider is not available.
ms.reviewer: kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The Data Provider is not available in the Source System drop-down list in Microsoft Management Reporter

This article provides resolutions for the issue that the Data Provider isn't available in the Source System drop-down list in Microsoft Management Reporter.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2588576

## Symptoms

When you create a company in Management Reporter, the Data Provider is not available in the Source System drop-down list.

## Cause 1

Management Reporter is installed on Windows Server 2008 64-bit and the **Enable 32-Bit Applications** is set the **True** in the Application Pool.

## Cause 2

The Data Provider has not been installed.

## Resolution 1

Check that the **Enable 32-bit Applications** option is set to **False**.

1. Open Internet Information Services (IIS) Manager.
2. Expand the server.
3. Select **Application Pools**.
4. Right-click Management Reporter and then select **Advanced Settings**.
5. Change **Enable 32-Bit Applications** from **True** to **False**.
6. Select **OK**.
7. Restart IIS.

## Resolution 2

Check that the Data Provider is installed. By default, the provider will be installed at **C:\Program Files\Microsoft Dynamics ERP\Management Reporter\2.0\Providers**. The Provider folder will have a subfolder for the Data Provider that is installed. Within that folder, there will be a file that is named **Microsoft.Dynamics.Performance.DataProvider.GeneralLedger.nn.dll**, where *nn* is the name of the Dynamics ERP you have installed.
