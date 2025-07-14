---
title: How to install a second Office KMS host in Windows
description: Volume license editions Office 2010 support KMS activation. This article describes the guidance on installing a second KMS host for Office in an environment that has an existing KMS host for Windows.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - sap:office-experts
  - CSSTroubleshoot
ms.reviewer: ericspli
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# How to install a second KMS host for Office in an environment that has an existing KMS host for Windows

This article was written by Sean Francis, Technical Specialist.

Volume license editions of Microsoft Office support Key Management Service (KMS) activation. If your environment has an existing KMS host for activating Windows, you have the following ways of activating Office by using a KMS host:

- Option 1: Use your existing Windows KMS host and add Office KMS support to it, if Windows KMS host is running a supported version of Windows (recommended).
- Option 2: Migrate your Windows KMS host to a version of Windows that supports Office KMS, and then add Office KMS support to the version of Windows (recommended).
- Option 3: Install Office KMS support on a different computer, and then configure your environment for the KMS support.

Adding Office KMS support to an existing Windows KMS host is your best option, because doing this requires no work being done outside installing the Office KeyManagementServiceHost.exe and installing/activating your Office KMS host key. You must run Windows KMS on an operating system that supports the version of the Office KMS host that you try to deploy.

This article focuses on Option 3 to install Office KMS support on a second computer in an environment that already has a Windows KMS host running. You should notice that this is not the recommended way to add Office KMS support. We recommend only having a single KMS host for both Windows and Office. Having more than one KMS host on a network is not necessary and it adds more administration work to implement. The additional work involves preparing DNS to let multiple computers manage _VLMCS records.

When you install a KMS host and install a key, your KMS host registers itself in DNS by adding a _VLMCS record to DNS. The first KMS server to do this owns all rights for _VLMCS records. When you bring a second KMS host online, it cannot register itself in DNS. Your KMS host works, but client computers cannot find the KMS host because the _VLMCS record for the KMS host does not exist in DNS. There are two methods to fix this issue:

- Method 1: Manually add a _VLMCS record to DNS for the second KMS host.
- Method 2: Create a global security group that contains the accounts for your KMS hosts, and grant that group control over _VLMCS records in DNS (recommended).

You can follow the steps in [this article](https://technet.microsoft.com/library/ff793405.aspx) to configure DNS for multiple KMS hosts. Be aware that the SRV resource record that you want to edit permissions in DNS is the _VLMCS record of your KMS host. Editing this record's permissions to grant the global security control will enable additional _VLMCS records to be created by the other KMS hosts as needed.

We recommend Method 2 here to keep future administrative tasks to a minimum. If you ever change the host name, DNS will be updated automatically. Stale _VLMCS records in DNS can cause long delays in launching Office applications if they are requesting activation.
