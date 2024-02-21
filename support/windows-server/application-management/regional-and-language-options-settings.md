---
title: How the Regional and Language Options settings in Windows Server 2003 are applied
description: Describes the user-specific and computer-wide settings in Regional and Language Options in Control Panel, the implications of configuring Regional and Language Options during Windows Setup, and the effects on Window Server 2003 Terminal Server.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: markreno, kaushika
ms.custom: sap:multilingual-user-interface-mui-and-input-method-editor-ime, csstroubleshoot
---
# How the Regional and Language Options settings in Windows Server 2003 are applied

This article describes the user-specific and computer-wide settings in **Regional and Language Options** in Control Panel, the implications of configuring **Regional and Language Options** during Windows Setup, and the effects on Window Server 2003 Terminal Server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 924852

## Introduction

This article describes how the **Regional and Language Options** settings in Windows Server 2003 are applied. Some of the settings vary from user profile to user profile. Other settings are computer wide. This article also discusses the effects of configuring the **Regional and Language Options** settings during Windows Setup.

## Regional options settings

The **Regional and Language Options** settings are located in Control Panel on a Windows Server 2003-based computer.

The **Regional Options** tab contains the following settings:

- **Standards and formats**  
    These are user-specific settings and are stored as part of the user profile.
- **Location**  
    This is a user-specific setting and is stored as part of the user profile.

## Language settings

The **Languages** tab contains the following settings:

- **Default input language**  
    This is a user-specific setting and is stored as part of the user profile.

- **Installed services**  
    This is a computer-wide setting.

> [!NOTE]
> To access these language settings, click **Details** in **Text services and input languages**.

## Advanced settings

The **Advanced** tab contains the following settings:

- **Language for non-Unicode programs**  
    This is a computer-wide setting.
- **Default user account settings**  
    Click to select the **Apply all settings to the current user account and to the default user profile** check box to apply changes to the default user profile.

## Configure Regional and Language Options during Windows Setup

You're prompted to configure **Regional and Language Options** during Windows Setup. Computer-wide settings affect all users who log on to the system. User-specific settings affect only the default user profile. New user profiles inherit the user-specific settings that you specified during Setup.

You can change the user-specific settings for the default user profile by selecting the **Apply all settings to the current user account and to the default user profile** check box on the **Advanced** tab.

## Considerations for Windows Server 2003 Terminal Server

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

The first time that a user uses a Remote Desktop Connection to log on to a server that has Terminal Server enabled, a new profile is created. The new profile inherits the **Regional and Language Options** settings from the default user profile. The profile may be local to the terminal server or may reside on a network share. However, the **Default input language** setting is obtained from the client computer that initiated the Remote Desktop Connection.

To change the default behavior to obtain the **Default input language** setting from the default user profile, you must set a registry entry value on the terminal server. To do this, follow these steps:

1. On the terminal server, click **Start** > **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout`
3. On the **Edit** menu, click **Add Value**, and then add the following registry information:

    Value name: IgnoreRemoteKeyboardLayout  
    Data type: REG_DWORD  
    Value data: 1  

When the **IgnoreRemoteKeyboardLayout** entry is set to **1**, new user profiles inherit the **Default input language** setting from the default user profile that the user account uses.

> [!NOTE]
> This registry entry may not work if you're not running Windows Server 2003 Service Pack 1.

## Existing user profiles

If a user profile already exists, the **Regional and Language Options** settings in the existing user profile are applied to new users.
