---
title: Unable to start Access
description: Fixes an issue in which you can't launch Access because There is a permissions issue in the registry.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- CI 114797
- CSSTroubleshoot
ms.reviewer: 
appliesto:
- Access 2010
- Microsoft Office Access 2007
search.appverid: MET150
---
# "Access can't start because there is no license for it on this machine" error when launching Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_ &nbsp; 2656028

## Symptoms

You receive the following error when launching Access 2007 or Access 2010:

> Microsoft Access can't start because there is no license for it on this machine.

## Cause

There is a permissions issue in the registry that is preventing Access from opening correctly.

## Resolution

Follow the steps below to assign the appropriate permissions:

1. Click the **Start** button and then click **Run**.
2. Type Regedit, and then press Enter.
3. Navigate to the following registry key:

   **Access 2007**

   `HKEY_CLASSES_ROOT\Licenses\73A4C9C1-D68D-11d0-98BF-00A0C90DC8D9\12.0\Retail`

   **Access 2010**

   `HKEY_CLASSES_ROOT\Licenses\73A4C9C1-D68D-11d0-98BF-00A0C90DC8D9\14.0\Retail`

   > [!NOTE]
   > You may run into the permissions issue anywhere from the GUID to the Retail key. If you run into the permissions issue on the GUID, you will then also need to repeat steps 4 – 10 on the 12.0 or 14.0 key as well as the Retail key.

4. Right click the key and then choose **Permissions**.
5. Click **Advanced**.
6. Select the **Owner** tab.
7. Change the owner to **Administrators**.
8. Click **Apply** and then click **OK**.
9. Click **Add**, type Everyone, and then click **Ok**.
10. Ensure that **Full Control** is checked, and then click **Ok**.
