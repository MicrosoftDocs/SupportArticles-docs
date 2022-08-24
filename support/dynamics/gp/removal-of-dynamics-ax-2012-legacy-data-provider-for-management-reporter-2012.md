---
title: Removal of Dynamics AX 2012 Legacy Data Provider for Management Reporter 2012
description: Describes how to remove the Dynamics AX 2012 Legacy provider in Microsoft Management Reporter 2012.
ms.reviewer: ryansand, kevogt
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Removal of the Dynamics AX 2012 Legacy Data Provider for Management Reporter 2012

This article contains the information about how to remove the Microsoft Dynamics AX 2012 Legacy provider in Microsoft Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2755288

## Symptoms

A task might be displayed in the Management Reporter 2012 Configuration Console with one of the following messages:

> Action Required - Legacy company found

> Action Required - Legacy integration found

## Cause

The Microsoft Dynamics AX 2012 Legacy Data Provider is being discontinued in the Management Reporter 2012 Rollup 3 release. If you are using the legacy integration, we recommend that you move to the data mart integration. In the future, new integrations will not be supported for the Microsoft Dynamics AX 2012 Legacy provider, but existing legacy integrations and companies will remain until they are removed.

## Resolution

To migrate the companies and reports to the data mart, complete the following procedures.

> [!NOTE]
> If you have recently upgraded, verify that no other tasks are displayed. If a task is displayed to update the Management Reporter database, or if the Management Reporter application service or process service are not running, complete those tasks before you continue.

1. In the Management Reporter 2012 Configuration Console, create a new data mart integration to Microsoft Dynamics AX 2012.

    > [!NOTE]
    > Specific steps for creating a data mart are outlined in the Management Reoprter Integration Guide for Microsoft Dynamics AX available at [Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916)

2. In the Configuration Console, under **ERP Integrations**, select the new integration. Select **Enable Integration**.

3. In the Configuration Console, select **Import Companies**.

    > [!NOTE]
    > If a message is displayed that asks whether you want to overwrite the existing company information, select **Yes**. This changes the company information to use the new data mart instead of the legacy integration.

4. In the Configuration Console, select **Companies**, and then verify that all companies in the list use the Management Reporter data mart for the source system.

    If any companies use Microsoft Dynamics AX 2012 as the source system, open Report Designer, and then sign in to that company. Assign any building blocks for that company to the corresponding data mart company. When all building blocks are assigned to the new data mart company, select the legacy integration company in the Companies page of the Configuration Console, and then select **Delete** to remove the legacy integration company.

    > [!NOTE]
    > The DAT company may have to be removed using these steps.

5. In the Configuration Console, under **ERP Integrations**, right-click the Microsoft Dynamics AX 2012 Legacy integration and select **Remove**.
6. Close the Configuration Console and open it again to update the task list. Verify that no additional tasks are displayed in the task list.
