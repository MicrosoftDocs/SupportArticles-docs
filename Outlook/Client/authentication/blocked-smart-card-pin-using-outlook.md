---
title: Smart card PIN is blocked when using Outlook
description: By default, Microsoft Outlook 2010 and Outlook 2013 are not configured to work with saved smart card credentials. This article explains how to use the EnableSmartCard registry value to configure Outlook correctly.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: randyto, aruiz
appliesto: 
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# Unexpected behavior with smart card credentials in Outlook 2013 and 2010

_Original KB number:_ &nbsp; 2829595

## Symptoms

Your smart card PIN is blocked when you use Outlook 2013 or Outlook 2010 to connect to a mailbox on Exchange Server.

## Cause

The Outlook client is not properly configured to work with saved smart card credentials.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, remove any existing certificate-based credentials from the Credential Manager and use the `EnableSmartCard` registry setting.

### Remove existing certificate-based credentials

The first step to prevent a PIN lockout is to delete any existing certificate-based credentials that were saved by Outlook.

1. Open **Control Panel**.
2. Double-click **Credential Manager**.
3. See whether there is a Certificate-Based credential similar to the following:

    @@BSUgiZQZ54Pf6cEtxKflWHH

    Also, see whether there is a Generic credential similar to one of the following:

    `MS.Outlook.14:user@domain.com:PUT`  
    `MS.Outlook.15:user@domain.com:PUT`

    > [!NOTE]
    > 14 indicates Outlook 2010 saved the credential and 15 indicates Outlook 2013.

4. If these are both present and were created or changed at the same time, they are likely smart card credentials saved from Outlook. Select the first credential to expand it and to show the details. Then, select **Remove** to delete the credential from **Credential Manager**.

5. Repeat step 4 for each one of the credentials listed in step 3.
6. When you are finished, close **Credential Manager**.

### Configure the EnableSmartCard registry setting

The second step to prevent a PIN lockout is to create the `EnableSmartCard` registry setting.

#### Outlook 2010

For Outlook 2010, the `EnableSmartCard` registry setting was introduced with the Microsoft Outlook 2010 hotfix package dated December 13, 2011 (KB2597028). We recommend that you install the most recent build of Outlook 2010. For more information about the latest applicable updates for Outlook, see [How to install the latest applicable updates for Microsoft Outlook (US English only)](/outlook/troubleshoot/deployment/install-outlook-latest-updates).

To create the `EnableSmartCard` registry value, follow these steps:

1. Exit Outlook.
2. Start Registry Editor.
3. Create the following registry values at the specified locations:

    > [!NOTE]
    > Manually create any registry keys or values if they do not exist.

    Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\RPC`  
    DWORD: `EnableSmartCard`  
    Value: **1**

4. Exit Registry Editor.

#### Outlook 2013

To create the `EnableSmartCard` registry value, follow these steps:

1. Exit Outlook.
2. Start Registry Editor.
3. Create the following registry values at the specified locations:

    > [!NOTE]
    > Manually create any registry keys or values if they do not exist.

    Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\RPC`  
    DWORD: `EnableSmartCard`  
    Value: **1**

4. Exit Registry Editor.

## More information

The `EnableSmartCard` registry setting adds the following functionality:

- Presents a credentials dialog that supports smart card credentials.
- Unpacks the authentication package from the credentials dialog so that the credentials can be used correctly.

The `EnableSmartCard` registry value was introduced in the Outlook 2010 hotfix package dated December 13, 2011. For more information about the hotfix package, see [Description of the Outlook 2010 hotfix package (x64 Outlook-x-none.msp; x86 Outlook-x-none.msp): December 13, 2011](https://support.microsoft.com/help/2597011).
