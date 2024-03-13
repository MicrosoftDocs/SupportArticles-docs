---
title: Fixed Asset Account Group not available
description: The Fixed Asset Account Group field is not available to be mapped in the eConnect Destination Adapter in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley, dlanglie
ms.topic: how-to
ms.date: 03/13/2024
---
# Fixed Asset Account Group not available to be mapped in eConnect Destination Adapter in Integration Manager

This article provides a resolution to make sure that the Fixed Asset Account Group field can be mapped in the eConnect Destination Adapter in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 971836

## Symptoms

The Fixed Asset Account Group data is not available to be mapped when you run the FA General eConnect Destination in Integration Manager for Microsoft Dynamics GP.

## Cause

The issue occurs because the **Account Group ID** field is not available to map data.

## Resolution

To work around this issue, use the data from the Fixed Asset setup information in Microsoft Dynamics GP. To do this, use either of the following methods.

### Method 1 - Set up the Fixed Asset Class ID to have a default Account Group ID field in Microsoft Dynamics GP

1. From the Microsoft Dynamics GP menu, select **Tools**, select **Setup**, select **Fixed Assets**, and then select **Class**
2. Set up a class for the new assets or select an existing class, and then enter **Account Group ID** from the lookup window
3. Select **Save**.
4. Map the **Class ID** field in the **Asset General Information** destination mapping folder in the Integration Manager Destination Mapping window

The **FA00400** table will be updated with the account group data that is associated with the **Class**.

### Method 2 - Set up the default accounts in the company Default Accounts window to have an Account Group ID in Microsoft Dynamics GP

1. From the Microsoft Dynamics GP menu, select **Tools**, select **Setup**, select **Fixed Assets**, select **Company**, and then select the **Default Accounts** expansion button.
2. Enter *Account Group ID* in the Default Accounts window.
3. Select **OK**.

    > [!NOTE]
    > You do not have to map any specific field within Integration Manager.

The **FA00400** table will be updated with the account group data that is associated with the default account information in the Fixed Asset company setup.
