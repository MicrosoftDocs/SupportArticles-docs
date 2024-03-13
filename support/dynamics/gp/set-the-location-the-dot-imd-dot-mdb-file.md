---
title: Set the location of the .imd or .mdb file
description: Describes how to set the location of the .imd or .mdb file without opening Integration Manager.
ms.reviewer: kvogel
ms.topic: how-to
ms.date: 03/13/2024
---
# How to set the location of the .imd or .mdb file by using the Microsoft.Dynamics.GP.IntegrationManager.ini file in Integration Manager in Microsoft Dynamics GP 10.0

This article describes how to set the location of the .imd or .mdb file that you want to use for all users.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 953217

## Introduction

To do it, you can use the Microsoft.Dynamics.GP.IntegrationManager.ini file in Integration Manager in Microsoft Dynamics GP 10.0.

## More information

You can set the location of the .imd or .mdb file by adding a switch within the Microsoft.Dynamics.GP.IntegrationManager.ini file. To do it, follow these steps:

1. Browse to the Integration Manager installation directory, and then open the Microsoft.Dynamics.GP.IntegrationManager.ini file.
2. In this file, locate the following switch:  
    `[IMBaseProvider]`

3. Directly under this switch, type the following line:

    > DBPath= **path**

    > [!NOTE]
    > In this line, the placeholder *path* represents the path of the file that you want to use. For example:  
    > `DBPath=C:\Integrations\IM.mdb`

Integration Manager now looks to this path every time that Integration Manager is opened, in spite of the setting in the Options window in Integration Manager.

> [!NOTE]
> The setting in the Options window is not updated to reflect the new override setting in the Microsoft.Dynamics.GP.IntegrationManager.ini file.

> [!NOTE]
> The location of the database path is no longer stored in the registry for Integration Manager 10.0. The location is now stored in the IMUser_Data.xml file. You can find this file in the following location:

- Windows XP and Windows Server 2003

    `C:\Documents and Settings\%userid%\Application Data\Microsoft Corporation\Microsoft Dynamics GP\10.0.0.0\IMUser_Data.xml`

- Windows Vista C:

    `\Users\%userid%\AppData\Roaming\Microsoft Corporation\Microsoft Dynamics GP\10.0.0.0\IMUser_Data.xml`

    > [!NOTE]
    > The *%userid%* placeholder represents your user profile.
