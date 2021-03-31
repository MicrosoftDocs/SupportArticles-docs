---
title: The remote server returned an error (440) Login Timeout error
description: Describes an error that occurs when you select Test Access in the Microsoft Dynamics CRM E-mail Router. Provides steps to disable Forms Based Authentication are provided.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 
---
# The remote server returned an error (440) Login Timeout error in Microsoft Dynamics CRM E-mail Router Configuration Manager

This article provides a resolution for the issue that you receive a **The remote server returned an error: (440) Login Timeout** error when selecting **Test Access** in the Microsoft Dynamics CRM E-mail Router Configuration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 954047

## Symptoms

You receive the following error when you select **Test Access** in the Microsoft Dynamics CRM Email Router Configuration Manager.

> Incoming Status: Failure - The remote server returned an error: (440) Login Timeout

## Cause

This error occurs because Forms Base Authentication is enabled.

## Resolution

For Exchange 2003

1. On the Exchange Server, select **Start**, select **All Programs**, select **Microsoft Exchange**, and then select **System Manager**.
2. Expand **First Organization (Exchange)**, expand **Servers**, expand the server name, expand **Protocols**, and then expand **HTTP**.
3. Right-click **Exchange Virtual Server** and then select **Properties**.
4. Select the **Settings** tab, and then unmarked **Enable Forms Based Authentication**.

For Exchange 2007

1. On the Exchange Server, select **Start**, select **Run**, type *inetmgr*, and then select **OK**.
1. Expand your server name, expand **Sites**, and then expand your website.
1. Select the **Exchange** virtual directory, double-click **Authentication** in the Security section of the Feature view, right-click **Form Authentication**, and then select **Disable**.
1. Perform step 3 for the **ExAdmin** virtual directory.
