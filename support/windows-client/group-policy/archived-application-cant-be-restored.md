---
title: Archived application can't be restored
description: Group Policy settings may block automatic application updates. Blocked on-demand applications must be updated by other means before they can be used.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, erwong
ms.custom: sap:applocker-or-software-restriction-policies, csstroubleshoot
---
# Archived application can't be restored because of app update policies

This article provides a solution to an issue that archived application can't be restored because of app update policies.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4571552

## Summary

To reduce disk space usage, Windows automatically archives applications that you don't use frequently. On a new Windows device, some applications are archived out-of-the-box. The first time you start an archived application, the application has to be restored. To do it, it connects to the internet to download and install the full version.

In some environments, Group Policy Objects (GPOs) may block applications from automatically downloading in this manner. When you start such a blocked application, you receive a message that resembles the following.

> Voice Recorder needs an update, but we're unable to apply the update right now.

:::image type="content" source="media/archived-application-cant-be-restored/gpo-preventing-app-updating.png" alt-text="Screenshot of the message that indicates a GPO is preventing an app from updating." border="false":::

In these cases, you have to contact your system administrator to obtain an updated version of the application. The information in this article helps you to do this.

## More information

The following GPOs prevent archived applications from restoring full versions:

- [UpdateServiceUrl](/windows/client-management/mdm/policy-csp-update#update-updateserviceurl)
- [AllowUpdateService](/windows/client-management/mdm/policy-csp-update#update-allowupdateservice)

If either or both of these GPOs are enabled in your environment, your system administrator can use one of the following methods to push the full version of the application to the device:

- If your organization uses [Microsoft Store for Business](https://businessstore.microsoft.com/store) to manage applications, the system administrator can push the application to the business store.
- If your organization uses [Microsoft Intune](/mem/intune/apps/apps-add) to manage devices, the system administrator can package the application and push the package to managed devices.
- If your organization uses custom Windows images to provision devices, the system administrator can use the [DISM App Package](/windows-hardware/manufacture/desktop/dism-app-package--appx-or-appxbundle--servicing-command-line-options) tool to add the full resource packages for the application to the image. By using `dism /StubPackageOption:installfull`, the system administrator can make sure that the device is provisioned by using the full version of the application instead of the archived version.
