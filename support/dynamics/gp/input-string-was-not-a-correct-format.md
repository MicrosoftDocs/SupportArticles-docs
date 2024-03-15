---
title: Input string was not in a correct format 
description: Provides a solution to an error that occurs in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley, grwill, dlanglie
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Input string was not in a correct format" Error message in Integration Manager for Microsoft Dynamics GP

This article provides a solution to an error that occurs in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2012471

## Symptoms

You receive the error message in the following scenarios:
> Input string was not in a correct format

**Scenario 1**  
When you run an integration in Integration Manager for Microsoft Dynamics GP that uses the eConnect Destination adapters.

**Scenario 2**  
When you don't have sufficient permissions on the machine running the integration

## Cause

**Scenario 1**  
This error occurs after you upgrade to Integration Manager for Microsoft Dynamics GP 2010 or for Microsoft Dynamics GP 10.0 from an earlier version and the **Shift Decimal Point** property on a numeric field didn't upgrade correctly and leaves the value blank. It can occur on any integration that uses an eConnect destination adapter that contains a numeric field that has the **Shift Decimal Point** property. For example, the **Debit Amount**, **Credit Amount** or **Quantity** fields.

**Scenario 2**  
When you install Integration Manager, you didn't install as an Administrator and run the first integration. It allows the required .xml files to get created on the machine.

## Resolution

**Scenario 1**  
To resolve this problem, open the **Destination Mapping** window and check the **Debit Amount**, **Credit Amount** and **Quantity** fields for the destination adapter that you're using. Select one field at a time and look in the properties window in the lower-left corner of the **Destination Mapping** window. Make sure that the **Shift Decimal Point** property isn't blank. In most cases, the value for this property is zero ('0'). If you find a field where this property is blank, type a zero and then save the integration.

**Scenario 2**  
To resolve this problem, log into the machine as Administrator and run the integration. Once the integration is run the first time, you can run integrations as another user. The user must have full control to the following registry keys:

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.  

1. Select **Start**, select **Run**, type **Regedt32** in the **Open** dialog box, and then select **OK**. It will open Registry Editor.
2. The four registry keys that must have the security changed are:

    32-bit  
    `HKEY_CLASSES_ROOT\Interface`  
    `HKEY_CLASSES_ROOT\CLSID`  
    `HKEY_CLASSES_ROOT\TypeLib`  
    `HKEY_LOCAL_MACHINE\Software\Classes\CLSID`

    64-bit

    `HKEY_CLASSES_ROOT\Wow6432Node\Interface`  
    `HKEY_CLASSES_ROOT\ Wow6432Node\CLSID`  
    `HKEY_CLASSES_ROOT\ Wow6432Node\TypeLib`  
    `HKEY_LOCAL_MACHINE\Software\Classes\Wow6432Node\CLSID`  
    `HKEY_LOCAL_MACHINE\Software\Classes\CLSID`

3. Select one of the folders listed in step 2, select **Security** from the menu and then select **Permissions**.
4. Make sure the user groups that use Integration Manager have Read and Full Control marked.
5. Repeat steps 3 and 4 for all four registry entries listed in step 2.
