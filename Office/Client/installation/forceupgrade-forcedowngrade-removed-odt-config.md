---
title: Information about the deprecated ODT attributes ForceUpgrade and ForceDowngrade
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 06/06/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Office 365 ProPlus 2016
  - Microsoft Office 365 ProPlus 2013
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\AdvancedConfiguration\OfficeDeploymentTool
  - CI 121610
  - CSSTroubleshoot
ms.reviewer: balram, jalalb, vikkarti, bcorob
description: Describes why the ForceUpgrade and ForceDowngrade attributes were deprecated from O365 ProPlus 2016 and 2013, and how to initiate them.
---

# Deprecated attributes in the ODT configuration file

The **ForceUpgrade** and **ForceDowngrade** attributes were removed from the Office Deployment Tool (ODT) configuration file. These attributes were used to force an upgrade or downgrade between Microsoft Office 365 ProPlus versions 2016 and 2013.

This article discusses how to restore the attributes to force or revert an upgrade.


## The ForceUpgrade attribute

The **ForceUpgrade** attribute in the ODT enables you to upgrade Office 365 ProPlus 2013 to Office 365 ProPlus 2016. This attribute was released in September 2015 together with Office 365 ProPlus 2016. 

In [Config.xml](/deployoffice/configuration-options-for-the-office-2016-deployment-tool) configure mode, if **ForceUpgrade** is set to **True**, ForceUpgrade automatically upgrades Office 365 ProPlus 2013 to Office 365 ProPlus 2016 without prompting you for input. This attribute is often used together with the **Display** element to hide the user interface during installation.

The only supported scenario for the **ForceUpgrade** attribute is to upgrade from Office ProPlus 365 2013 to Office 365 ProPlus 2016. Because support for Office 365 ProPlus 2013 ended in February 2017, the **ForceUpgrade** attribute is no longer supported. 

### How to initiate the ForceUpgrade attribute 

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

> [!Note]
> This section applies to customers who are using Office 365 ProPlus 2013.

If you are running Office 365 ProPlus 2013 and **Office Updates** is enabled in the registry (**UpdatesEnabled=True**), you will receive an in-app upgrade notification to upgrade to Office 365 ProPlus 2016.  

> [!note]
> The “Force Upgrade” notification appears at the initial startup of any Office app. 

:::image type="content" source="media/forceupgrade-forcedowngrade-removed-odt-config/force-upgrade-notification-2016.png" alt-text="Screenshot of the Force Upgrade notification at O365 ProPlus 2016 startup.":::

This is the “Force Upgrade” notification if you use Office 365 ProPlus 2013.

:::image type="content" source="media/forceupgrade-forcedowngrade-removed-odt-config/force-upgrade-notification-2013.png" alt-text="Screenshot of the Force Upgrade notification at O365 ProPlus 2013 startup.":::

> [!important]
> The “enableautomaticupgrade” registry entry and corresponding group policy are no longer listed in the Administrative Template XML-based file (ADMX). We recommend that you occasionally revise the ADMX in your environment. You can download the latest ADMX from the Microsoft Download Center. 
 

## ForceDowngrade attribute 

The **ForceDowngrade** attribute is used in rollback scenarios to revert the Office client to a previous version. This attribute is used in conjunction with the **Version** attribute. 

> [!note]
> If **ForceDowngrade** is set to **True** in the registry, and a **Version** attribute is specified, Office downloads the files for the specified version. If **ForceDowngrade** is not set, it is interpreted as **False**. 

### How to initiate the ForceDowngrade attribute

To initiate the **ForceDowngrade** attribute and revert to an older version of Office, follow these steps:

1.	Type the following text into a text editor (such as Notepad), and save it as Config.xml.

    ```config
    <Configuration>
    <Updates Enabled="TRUE" TargetVersion="16.0.xxxxx.yyyyy" />
    </Configuration>
    ```

2.	Open an elevated Command Prompt window.
3.	At the command prompt, change to the directory in which you saved Config.xml, type **setup.exe /configure config.xml**, and then press Enter.

## Related articles

- [Support for 2013 versions of Office 365 ProPlus ended on February 28, 2017](/office/troubleshoot/support/2013-versions-of-office-365)
- [Configuration options for the Office Deployment Tool](/deployoffice/configuration-options-for-the-office-2016-deployment-tool)
- [How to revert to an earlier version of Office](https://support.microsoft.com/help/2770432/how-to-revert-to-an-earlier-version-of-office-2013-or-office-2016-clic)


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
