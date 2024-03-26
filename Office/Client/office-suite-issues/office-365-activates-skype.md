---
title: This feature has been disabled by your Administrator
description: Fixes an issue in which Skype for Business activation fails if you install it from Microsoft 365 Apps for enterprise as a stand-alone application.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 03/31/2022
---

# "This feature has been disabled by your Administrator" when Microsoft 365 activates Skype for Business

## Symptoms

When you try to install Microsoft Skype for Business as a stand-alone application from a Microsoft Microsoft 365 Apps for enterprise suite, you receive one of the following error messages:

**Error message 1**

This feature has been disabled by your Administrator.

**Error message 2**

We are unable to connect right now. Please check your network and try again later.

## Resolution

> [!NOTE]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, check whether there is a value for the UseOnlineContent registry entry that is described in [Overview of identity, authentication, and authorization in Office 2013](https://technet.microsoft.com/library/jj683102.aspx). If the entry exists, the value must be set to **2**. To do this, follow these steps:

1. Click **Start**, click **Run**.   
2. Type regedit, and then press Enter.   
3. Locate and then click the following registry subkey:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet**

    > [!NOTE]
    > If the **UseOnlineContent** registry entry exists in this path, you can skip steps 4 and 5.

4. On the Edit menu, point to **New**, and then click **DWORD Value**.   
5. Type UseOnlineContent, and then press Enter.   
6. Right-click **UseOnlineContent**, and then click **Modify**.
7. In the **Value data** box, type 2, and then click **OK**.   
8. Exit Registry Editor.
