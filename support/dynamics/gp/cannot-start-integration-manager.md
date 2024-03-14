---
title: Cannot start Integration Manager
description: Provides a solution to an issue where you can't start Integration Manager or select Run Integration within Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Can't start Integration Manager or select Run Integration within Microsoft Dynamics GP

This article provides a solution to an issue where you can't start Integration Manager or select **Run Integration** within Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857395

## Symptoms

From the Microsoft Dynamics GP menu, point to **Tools** and then select **Integrate**, one of the following conditions is true:

- The options for Integration Manager or Run Integration are greyed out and aren't available to select
- Selecting the option to start Integration Manager doesn't start Integration manager

## Resolution 1

Verify Integration Manager is installed and able to be used without any registration errors, using one of the methods below:

**Method 1**: Select **Start**, point to **All Programs**, point to **Microsoft Dynamics GP**, point to **Integration Manager**, and then select **Integration Manager**. (If Integration Manager isn't listed, go to Method 2.)

**Method 2**: If Integration Manager isn't listed in Method 1, locate the Microsoft.Dynamics.GP.IntegrationManager.exe to start Integration Manager from the following location for example:

Microsoft Dynamics GP 2010:  
`C:\Program Files\Microsoft Dynamics\Integration Manager 11\Microsoft.Dynamics.GP.IntegrationManager.exe`

Microsoft Dynamics GP 10.0:  
`C:\Program Files\Microsoft Dynamics\Integration Manager 10\Microsoft.Dynamics.GP.IntegrationManager.exe`

**Method 3**: If Integration Manager isn't installed:

To resolve this issue, install Integration Manager in Microsoft Dynamics GP. To do it, use the following method:

Run setup.exe on the Microsoft Dynamics GP installation CD.  
Select to install Integration Manager under **Additional Products**.

## Resolution 2

If the Integration Manager or Run Integration menu options are grayed out, verify the registration keys are entered correctly in Integration Manager:

Verify the registration keys from Customer Source.

To verify registration keys in Integration Manager:

1. Select **Start**, point to **All Programs**, point to **Microsoft Dynamics GP**, point to **Integration Manager**, and then select **Integration Manager**. Select **Tools** and then select **Registration**.

## Resolution 3

If the Integration Manager or Run Integration menu options are grayed out, verify the registration keys are entered correctly in Microsoft Dynamics GP:

Verify the registration keys from Customer Source.

To verify registration keys in Microsoft Dynamics GP:

1. Select **Tools** under **Microsoft Dynamics GP**, point to **Setup**, point to **System**, and select **Registration**.
2. Mark the box next to Integration Site Enabler if it isn't marked.
3. Select **OK** when finished.

If you don't see Integration Site Enabler in the list of modules, you may not be registered for it.

> [!NOTE]
> If you're registered for the Integration Manager Conversion Package, see Resolution 4.

## Resolution 4

This problem occurs because the Tools menu options: Integration Manager or Run Integration are unavailable with the Integration Manager Conversion package.

To resolve this problem and to create new integrations or to edit an existing integration, use one of the following methods.

**Method 1**: Select **Start**, point to **All Programs**, point to **Microsoft Dynamics GP**, point to **Integration Manager**, and then select **Integration Manager**.

**Method 2**: If Integration Manager isn't listed in Method 1, Locate the Microsoft.Dynamics.GP.IntegrationManager.exe to start Integration Manager from the following location for example:

Microsoft Dynamics GP 2010:  
`C:\Program Files\Microsoft Dynamics\Integration Manager 11\Microsoft.Dynamics.GP.IntegrationManager.exe`

Microsoft Dynamics GP 10.0:  
`C:\Program Files\Microsoft Dynamics\Integration Manager 10\Microsoft.Dynamics.GP.IntegrationManager.exe`

**Method 3**: To access Integration Manager Conversions from within Microsoft Dynamics GP, you can create a shortcut in the Navigation area or use the shortcut created in the **Start** Menu.

To create a shortcut in the Navigation Area, follow these steps:

1. Right-click the upper-left section of the navigation area:

2. Select **Add**, and then select **Add External Shortcut**.

3. Select **Browse** and locate Microsoft.Dynamics.GP.IntegrationManager.exe, that can be found in the following default locations:

    Microsoft Dynamics GP 2010:  
    `C:\Program Files\Microsoft Dynamics\Integration Manager 10\Microsoft.Dynamics.GP.IntegrationManager.exe`

    Microsoft Dynamics GP 10.0:  
    `C:\Program Files\Microsoft Dynamics\Integration Manager 10\Microsoft.Dynamics.GP.IntegrationManager.exe`

4. Select **Add** and then select **Done**. You'll now be able to start Integration Manager on the Shortcut Menu in Microsoft Dynamics GP.

## Resolution 5

Verify the user has security to Integration Site Enabler:
To create a Security Task within Microsoft Dynamics GP, follow these steps:

1. On the Microsoft Dynamics GP menu, select **Tools**, point to **Setup**, point to **System**, and then select **Security Tasks**.

2. In the Security Task Setup window, specify the following settings:

    - Product: Microsoft Dynamics GP  
    - Type: Microsoft Dynamics GP Import
    - Series: Integration Site Enabler  
    - Category: Select the appropriate category (for example, select **Other** or **System**)

3. Select the **Integration Site Enabler** check box in the Access List area.

## Resolution 6

Next, make sure Integration Manager appears in the Dynamics.set file. Open the Dynamics.set file and see if Integration manager is in there. If it isn't continue with the following.

To resolve this issue, do the following steps:

1. Copy the IM.cnk file from the following folder:
    - For Integration Manager 2010: `C:\Program Files\Common Files\Integration Manager 11`
    - For Integration Manager 10.0: `C :\Program Files\Common Files\Integration Manager 10`

2. Paste the IM.cnk file into the following folder:
    - For Microsoft Dynamics GP 2010: `C:\Program Files\Microsoft Dynamics\GP2010`
    - For Microsoft Dynamics GP 10.0: `C:\Program Files\Microsoft Dynamics\GP 10`

    > [!NOTE]
    > If you didn't install to the default location, you'll need to paste this file in your Dynamics GP code folder.

3. Start Microsoft Dynamics GP.
4. Select **Yes** to include new code.
5. Start Integration Manager.
6. Run your integration.

Once you open start Microsoft Dynamics GP, it will ask to add new packages when it first starts, select **OK** past that screen and let it verify Integration Manager's installation. (If you don't have this IM.cnk file anywhere on your computer, copy it from another computer.)

## Resolution 7

1. Open the Dex.ini file in notepad. This file is found in the following default locations for example:

    Microsoft Dynamics GP 2010:  
    `C:\Program Files\Microsoft Dynamics\GP2010\Data`

    Microsoft Dynamics GP 10.0:  
    `C:\Program Files \Microsoft Dynamics\GP10\Data`

2. Verify that the following lines exist:
    IMPath=
    IMExecPath=

    The lines will point to:

    Microsoft Dynamics GP 2010  
    `C:\Program Files\Microsoft Dynamics\Integration Manager 11\Microsoft.Dynamics.GP.IntegrationManager.exe`
    `C:\Program Files\Microsoft Dynamics\Integration Manager 11\Microsoft.Dynamics.GP.IntegrationManager.IMRun.exe`

    Microsoft Dynamics GP 10.0
    `C:\Program Files\Microsoft Dynamics\Integration Manager 10\Microsoft.Dynamics.GP.IntegrationManager.exe`
    `C:\Program Files\Microsoft Dynamics\Integration Manager 10\Microsoft.Dynamics.GP.IntegrationManager.IMRun.exe`

If you're still meeting the issue, do a search for the Microsoft.Dynamics.GP.IntegrationManager.exe on your workstation. You'll need to change the path in your dex.ini to match the location of where your Microsoft.Dynamics.GP.IntegrationManager.exe and Microsoft.Dynamics.GP.IntegrationManager.IMRun.exe files are located.
