---
title: This feature has been disabled by your Administrator
description: Fixes an issue in which Skype for Business activation fails if you install it from Microsoft 365 Apps for enterprise as a stand-alone application.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Unable to connect
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 06/06/2024
---

# "This feature has been disabled by your Administrator" when Microsoft 365 activates Skype for Business

## Symptoms

When you try to install Microsoft Skype for Business as a stand-alone application from a Microsoft 365 Apps for enterprise suite, you receive one of the following error messages:

**Error message 1**

This feature has been disabled by your Administrator.

**Error message 2**

We are unable to connect right now. Please check your network and try again later.

## Resolution

> [!NOTE]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, check whether there's a value for the UseOnlineContent registry entry that is described in [Overview of identity, authentication, and authorization in Office 2013](https://technet.microsoft.com/library/jj683102.aspx). If the entry exists, the value must be set to **2**. To do so, follow these steps:

1. Select **Start**, select **Run**.
2. Type regedit, and then press Enter.
3. Locate and then select the following registry subkey:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet**

    > [!NOTE]
    > If the **UseOnlineContent** registry entry exists in this path, you can skip steps 4 and 5.

4. On the Edit menu, point to **New**, and then select **DWORD Value**.
5. Type UseOnlineContent, and then press Enter.
6. Right-click **UseOnlineContent**, and then select **Modify**.
7. In the **Value data** box, type 2, and then select **OK**.
8. Exit Registry Editor.
