---
title: Error occurs when you install Dynamics GP Data Mart provider
description: Describes an error message that you may receive when you install the Dynamics GP Data Mart if a functional currency is not set up in Dynamics GP. Provides a resolution.
ms.reviewer: kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "You must set up a functional currency for the following companies..." error when installing Dynamics GP Data Mart provider

This article provides a resolution for the error that may occur when you try to install the Dynamics GP Data Mart provider for Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2831801

## Symptoms

The Microsoft Dynamics GP Data Mart provider installation may fail with the following error shown in the Deployment log:

> You must set up a functional currency for the following companies before the integration can continue

## Cause

The Microsoft Dynamics GP Data Mart provider requires a Functional Currency be set for each GP company and an ISO code defined for each of these currencies.

## Resolution

A functional currency will need to be set for all Microsoft Dynamics GP companies. To set the functional currency in Microsoft Dynamics GP, follow these steps.

1. Start Microsoft Dynamics GP and sign in as an administrator user.
2. Select **Microsoft Dynamics GP** on the menu bar.
3. Point to **Tools**, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
4. Select a currency in the **Functional Currency** field.

An ISO code for each currency must be defined. This is a system-wide setting, and only has to be completed once. You can find these settings at:

1. Select **Microsoft Dynamics GP** on the menu bar.
2. Point to **Tools**, point to **Setup**, point to **System**, and then select **Currency**.
3. Select a currency from the **Currency ID** lookup.
4. Verify that the currency has an **ISO Code**.
5. Repeat steps 3 and 4 for each currency.

The currency indexes in the MC40000 and MC40200 do not match.

1. Run the following query against the Dynamics database:

    ```sql
    select * from MC40200
    ```

2. Make note of the value in the CURRNIDX column.
3. Run the following query against the company databases that were listed in the error message:

    ```sql
    select * from MC40000
    ```

4. Make note of the value in the FUNCRIDX column.

If the values do not match, you will need to contact Microsoft Dynamics GP support for assistance with updating the index so that it is the same in both tables.
