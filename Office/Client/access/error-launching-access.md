---
title: Unable to start Access
description: Fixes an issue in which you can't launch Access because of a permissions issue in the registry.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# "Access can't start because there is no license for it on this machine" error when launching Access

## Symptoms

You receive the following error when launching Access 2007 or Access 2010:

> Microsoft Access can't start because there is no license for it on this machine.

## Cause

There is a permissions issue in the registry that is preventing Access from opening correctly.

## Resolution

Follow the steps below to assign the appropriate permissions:

1. Select the **Start** button and then select **Run**.
2. Type Regedit, and then press Enter.
3. Navigate to the following registry key:

   **Access 2007**

   `HKEY_CLASSES_ROOT\Licenses\73A4C9C1-D68D-11d0-98BF-00A0C90DC8D9\12.0\Retail`

   **Access 2010**

   `HKEY_CLASSES_ROOT\Licenses\73A4C9C1-D68D-11d0-98BF-00A0C90DC8D9\14.0\Retail`

   > [!NOTE]
   > You may run into the permissions issue anywhere from the GUID to the Retail key. If you run into the permissions issue on the GUID, you also need to repeat steps 4 – 10 on the 12.0 or 14.0 key as well as the Retail key.

4. Right-click the key and then choose **Permissions**.
5. Select **Advanced**.
6. Select the **Owner** tab.
7. Change the owner to **Administrators**.
8. Select **Apply** and then select **OK**.
9. Select **Add**, type Everyone, and then select **Ok**.
10. Ensure that **Full Control** is checked, and then select **Ok**.
