---
title: Intune Enterprise Mode site list not deployed
description: Describes an issue in which Intune Enterprise Mode site list isn't deployed to co-managed Windows 10 devices.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\Device restrictions
ms.reviewer: kaushika
---
# Intune Enterprise Mode site list not deployed to co-managed Windows 10 devices

This article provides a solution for the issue that the Enterprise Mode web sites specified in the device configuration profile aren't deployed to co-managed Windows 10 devices.

## Symptoms

Consider the following scenario:

- You use both Microsoft Intune and Configuration Manager to manage your Windows 10 devices.
- You use the application catalog in your Configuration Manager environment.
- You create a device configuration profile in Intune and assign the profile to your Windows 10 devices.
- In the device configuration profile, you specify the **Enterprise mode site list location (Desktop only)** setting to open a list of web sites in [Enterprise Mode](/internet-explorer/ie11-deploy-guide/what-is-enterprise-mode#what-is-enterprise-mode) on Internet Explorer 11.

  :::image type="content" source="media/enterprise-mode-site-list-not-deployed-win10/enterprise-mode-site-list-location.png" alt-text="Screenshot of Enterprise Mode site list location setting in Start experience page.":::

In this scenario, when you type `about:compat` in either Microsoft Edge or Internet Explorer 11 to view the Enterprise Mode site list, the sites specified in the device configuration profile aren't displayed.

## Cause

The application catalog website must be viewed by using Internet Explorer 11 Enterprise Mode, while Microsoft Edge is the default browser in Windows 10.

If you don't have the [Configure the Enterprise Mode Site List](/microsoft-edge/deploy/group-policies/interoperability-enterprise-guidance-gp#configure-the-enterprise-mode-site-list) Group Policy configured, Configuration Manager clients add the application catalog website URL to Microsoft Edge Site List file `C:\Windows\CCM\MSEdgeSiteList.xml`, and create the following registry entry:

> Subkey: **HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main\EnterpriseMode**  
> Value name: **SiteList**  
> Value type: **REG_SZ**  
> Value Data: **C:\Windows\CCM\MSEdgeSiteList.xml**

When the Intune device configuration profile is deployed to the Windows 10 device, it creates the following registry entry:

> Subkey: **HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Browser**  
> Value name: **EnterpriseModeSiteList**  
> Value type: **REG_SZ**  
> Value Data: **\<the Enterprise Mode Site List XML file>**

However, because the registry value `HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main\EnterpriseMode\SiteList` already exists, the Windows 10 device ignores the site list assigned by Intune.

## Solution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To fix this issue, follow these steps:

1. Open Registry Editor.
1. Locate `HKLM\SOFTWARE\Policies\Microsoft\CCM`, and then create the following registry value:

    > Value name: **AllowConfigureMicrosoftEdge**  
    > Value type: **REG_DWORD**  
    > Value Data: **0**

    This disables the Configuration Manager clients from creating the `HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main\EnterpriseMode\SiteList` registry value.

1. Delete the `HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main\EnterpriseMode\SiteList` registry value.
