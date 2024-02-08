---
title: Change the location of CSC folder
description: Microsoft doesn't support using the Cachemov.exe tool to move the offline files folder in Windows Vista onwards. This article describes an alternative method for moving the offline files folder. This method involves the CacheLocation registry value.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-dehaas, waltere, lseri
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
---
# How to change the location of the CSC folder by configuring the CacheLocation registry value in Windows

This article describes how to change the location of the client-side caching (CSC) folder by configuring the CacheLocation registry value.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 937475

## Introduction

You can't use the Cachemov.exe tool to move the client-side caching (CSC) folder in Windows Vista. However, you can change the location of the CSC folder by configuring the CacheLocation registry value.

> [!NOTE]
> The CSC folder is the folder in which Windows stores offline files.  

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To change the location of the CSC folder, follow these steps.

> [!NOTE]
> There is only one cache folder in Windows Vista. Therefore, you don't have to repeat these steps for additional users.

1. Click **Start**, type **regedit** in the **Search** box, and then press ENTER.
2. Locate the following registry subkey, and then and right-click it:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\CSC`  

3. Point to **New**, and then click **Key**.
4. Type Parameters in the name box for the new key.
5. Right-click the **Parameters** key, point to **New**, and then click **String Value**.
6. To name the new value, type CacheLocation, and then press ENTER.

7. Right-click **CacheLocation**, and then click **Modify**.

8. In the **Value data** box, type the name of the new folder in which you want to create the cache.

    > [!NOTE]
    > Use the Microsoft Windows NT format for the folder name.

    For example, if you want the cache location to be _d:\csc_, type the following: _\\??\d:\csc_  

9. Exit Registry Editor, and then restart the computer.

> [!NOTE]
> The network administrator can set this value before the computer is on the network or before this value is given to the end-user. In this situation, no content is put in the default location. Additionally, you can set the location of the CSC folder by using a script.

The information and the solution in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft doesn't specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article doesn't describe. Because Microsoft must respond to changing market conditions, this information shouldn't be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.  
For more information about how to move the offline files cache in Windows Vista, visit the following Web site: [Storage at Microsoft](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB)
