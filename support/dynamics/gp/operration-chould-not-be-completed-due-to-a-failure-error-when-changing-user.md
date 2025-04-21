---
title: The operation could not be completed due to a failure on the server error when changing a user
description: Describes an error you receive when you change a user in Microsoft Management Reporter. Provides a resolution.
ms.reviewer: theley, erikjohn, kevogt
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# "The operation could not be completed due to a failure on the server" error when you change a user in Microsoft Management Reporter

This article provides a resolution for the issue that you can't change or add a user in Microsoft Management Reporter.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2689401

## Symptoms

When you try to change or add a user in Microsoft Management Reporter, you receive the following error message:

> The operation could not be completed due to a failure on the server

## Cause

Cause 1

The Active Directory user does not have a display name. See Resolution 1 in the Resolution section.

Cause 2 - only applies to Management Reporter 2012

The user account running the services is a Local System user.

## Resolution

Resolution 1

In Active Directory, the user does not have a display name. The user must have a display name for Management Reporter Security to work correctly.

Resolution 2

1. Open the Configuration Console for Management Reporter 2012.

2. Select Management Reporter Services in the left navigation pane.

    1. Select **Remove Application Service** and then choose **Yes**.
    2. Select **Remove Process Service** and then choose **Yes**.

3. To reinstall both services, select **File** and then select **Configure**.

    1. Mark only the Management Reporter Application Service and the Management Reporter Process Service, and then select **Next**.
    2. In the Service account section, select the **Account** drop-down, choose **NT AUTHORITY\NETWORK SERVICE** or use a dedicated domain\username account with the proper permissions.
    3. Complete the remaining sections and then select **Next**.
    4. Select **Configure** to add both services.
