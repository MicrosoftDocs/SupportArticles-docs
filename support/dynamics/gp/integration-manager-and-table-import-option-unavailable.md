---
title: Integration Manager option and Table Import option are unavailable in Microsoft Dynamics GP
description: Provides solutions to an issue where the Integration Manager option and the Table Import option are not available in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.reviewer: theley
---
# The Integration Manager option and the Table Import option are not available in Microsoft Dynamics GP

This article provides solutions to an issue where the **Integration Manager** option and the **Table Import** option are not available in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2018994

## Symptoms

The **Integration Manager** and **Table Import** options are grayed out within Microsoft Dynamics GP.

## Cause 1

The incorrect registration keys for Microsoft Dynamics GP were entered, or **Integration Site Enabler** is not selected.

## Cause 2  

Security has not been granted to these menu options.

## Cause 3

Microsoft Dynamics GP does not recognize that Integration Manager is installed.  

## Cause 4  

The Dex.ini file does not contain the path to Integration Manager.

## Resolution 1: Verify that Integration Site Enabler is selected

1. On the **Help** menu (the blue circle with a question mark in the upper-right), click **About Microsoft Dynamics GP**, and then click **Options**.

2. In the Module section, locate Integration Site Enabler and verify the Registered column shows a check mark for this item.

    > [!NOTE]
    > If you do not see this option checked, you may have the incorrect keys entered for you GP system. Check online through CustomerSource to verify that you have the correct keys entered.

3. As soon as you are at the CustomerSource Web site, mouse pointer over **My Account** and select **Product & Service Summary** from the pop-up menu.

4. When the new page loads, click the **Registration Keys** link for Microsoft Dynamics GP.

5. On the next page, select the version that you are looking up your registration keys for from the dropdown labeled "Display License Keys For Version".

6. Verify that "License Holder" on this page matches "Site Name" in the GP Registration window and that the Registration Keys on this page match those entered in the GP Registration window.

## Resolution 2: Grant access to Integration Site Enabler  

1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**. Note the role(s) that are selected.

2. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Security Roles**.

3. Select the Role noted from step 1.

4. In the list of Security Task IDs, select **ADMIN_SYSTEM_012.**  

5. Save the Role.

Alternatively, you can create a new role and assign **ADMIN_SYSTEM_012** to this role also. In this case, you would use the Security Setup window to grant access to this new role for users in addition to the role(s) they already have assigned.

## Resolution 3: Verify Integration Manager is listed in your Dynamics.set file

If it is not, locate the IM.cnk and then put this in the GP code folder then restart GP. The IM.cnk can be located in the following areas:  

- Integration Manager 2010

    C:\\Program Files\\Common Files\\Integration Manager 11
- Integration Manager 10.0

    C:\\Program Files\\Common Files\\Integration Manager 10

## Resolution 4

1. Open the Dex.ini file in notepad. This file is found in the following default locations:

    - Microsoft Dynamics GP 10.0: C:\\Program Files\\Microsoft Dynamics\\GP\\Data
    - Microsoft Dynamics GP 2010: C:\\Program Files\\Microsoft Dynamics\\GP\\Data

2. Verify that the following lines exist:

    - IMPath=
    - IMExecPath=  

The lines will point to:  

- Microsoft Dynamics GP 2010

  - C:\\Program Files\\Microsoft Dynamics\\Integration Manager 11\\Microsoft.Dynamics.GP.IntegrationManager.exe
  - C:\\Program Files\\Microsoft Dynamics\\Integration Manager 11\\Microsoft.Dynamics.GP.IntegrationManager.IMRun.exe

- Microsoft Dynamics GP 10.0

  - C:\\Program Files\\Microsoft Dynamics\\Integration Manager 10\\Microsoft.Dynamics.GP.IntegrationManager.exe  
  - C:\\Program Files\\Microsoft Dynamics\\Integration Manager 10\\Microsoft.Dynamics.GP.IntegrationManager.IMRun.exe  

## More information

In order to access Integration Manager Conversions from within Microsoft Dynamics GP, you must create a shortcut in the Navigation area or use the shortcut created in the Start Menu.  

To create a shortcut in the Navigation Area, follow these steps:

1. Right-click the upper-left section of the navigation area.

2. Select **Add**, and then click **Add External Shortcut**.

3. Click **Browse** and locate IM.exe or Microsoft.Dynamics.GP.IntegrationManager.exe, that can be found in the following default locations:

    - Microsoft Dynamics GP 2010:

        C:\\Program Files\\Microsoft Dynamics\\Integration Manager 10\\Microsoft.Dynamics.GP.IntegrationManager.exe  

    - Microsoft Dynamics GP 10.0:

        C:\\Program Files\\Microsoft Dynamics\\Integration Manager 10\\Microsoft.Dynamics.GP.IntegrationManager.exe

4. Click **Add** and then click **Done**.

    You will now be able to start Integration Manager on the Shortcut Menu in Microsoft Dynamics GP.
