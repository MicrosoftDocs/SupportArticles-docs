---
title: Outlook policy to control PST use and creation in Office 365 Import service
description: Describes how to use Outlook policy to prevent users from adding new items to a .pst file and to prevent users from creating new .pst files during the import process. This applies to the Office 365 Import service.
author: simonxjx
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Outlook 2013
- Microsoft Outlook 2010
- Microsoft Office Outlook 2007
---

# How to use Outlook policy to control PST use and creation in the Office 365 Import service

## Introduction 

When you use the Microsoft Office 365 Import service, you may want to control whether users can add new items to .pst files and how users use .pst files in Microsoft Outlook. This article describes how to prevent users from adding new items to an existing .pst file and how to prevent users from creating new .pst files during the import process.

## Procedure 

> [!IMPORTANT]
> Follow the steps in this article carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

### Prevent users from adding new data or content to an existing .pst file

To prevent users from adding new data or content to an existing .pst file, add the PSTDisableGrow registry entry, and then set the value to 1. To do this, follow these steps: 

1. Open Registry Editor.   
2. Locate, and then click the following registry subkey:

    **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<**x**>.0\Outlook\PST**

    > [!NOTE]
    > The <**x**>.0 placeholder represents the version of Outlook: for example, 15.0 is Outlook 2013, 14.0 is Outlook 2010, and 12.0 is Outlook 2007.
1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
1. Type PSTDisableGrow, and then press Enter.   
1. Right-click the **PSTDisableGrow** registry entry that you created, and then click **Modify**.  
1. In the **Value data** box, type 1, and then click **OK**.    

> [!NOTE]
> The PSTDisableGrow registry entry can be set to the following values:
> 
> |Value|Description|
>  |-|-|
>  |0|User can add new items to an existing .pst file. This is the default value.|
>  |1|Use cannot add new content or data to an existing .pst file|

### Prevent users from adding new .pst files

To prevent users from connecting a .pst file to Outlook, add the DisablePST registry entry, and then set the value to 1. To do this, follow these steps:

1. Open Registry Editor.   
2. Locate, and then click the following registry subkey:

    **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<**x**>.0\Outlook**

    > [!NOTE]
    > The \<**x**>.0 placeholder represents the version of Outlook: for example, 15.0 is Outlook 2013, 14.0 is Outlook 2010, and 12.0 is Outlook 2007.
1. On the **Edit **menu, point to **New**, and then click **DWORD Value**.    
1. Type DisablePST, and then press Enter.   
1. Right-click the DisablePST registry entry that you created, and then click **Modify**.    
1. In the **Value data** box, type 1, and then click **OK**.    

> [!NOTE]
> The DisablePST registry entry can be set to the following values: 
>
> |Value|Description|
> |-|-|
> |0|Users can add .pst files. This is the default value.|
> |1|Users cannot add .pst files. However, in scenarios where a .pst file was connected to Outlook before this registry value was added, the existing .pst file will still be connected. No new.pst files can be added. |
> |2|Users can only add exclusive sharing .pst files, such as SharePoint .pst files. |

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).