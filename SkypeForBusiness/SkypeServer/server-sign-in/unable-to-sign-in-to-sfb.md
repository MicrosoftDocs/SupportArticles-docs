---
title: How to troubleshoot being unable to sign in to Skype for Business | Microsoft Docs
description: This article fixes an issue in which you cannot sign in to Skype for Business.
author: simonxjx
ms.author: v-six
ms.reviewer: corbinm
manager: dcscontentpm
localization_priority: Normal
audience: Admin
search.appverid: 
  - MET150
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.date: 04/17/2019
appliesto: 
  - Skype for Business
---

# How to troubleshoot being unable to sign in to Skype for Business

## Overview

Microsoft Skype for Business caches files locally on your computer. This may prevent you from being able to sign in to Skype for Business. 

## Resolution

To delete cached sign in credentials, use the Skype for Business scenario in the [Microsoft Support and Recovery Assistant](https://diagnostics.office.com) (SaRA) tool or manually clear the cached information.

To manually fix this issue, follow these steps.

### Step 1: Delete your Skype for Business sign-in info

1. In Skype for Business, click the down arrow next to the gear icon, select **File**, and then **Sign Out**.
2. Click **Delete my sign-in info**.

   :::image type="content" source="./media/unable-to-sign-in-to-sfb/delete-sign-in-info.png" alt-text="Screenshot that shows the Delete my sign-in info option in the Sign in page.":::
3. Click **Sign In**.

If the issue persists, continue to remove the cache.

### Step 2: Remove Skype for Business cache

1. Exit Skype for Business. For example, click the down arrow next to the gear icon, select **File**, and then **Exit**.
2. Start Registry Editor. To do this, right-click **Start**, click **Run**, type *regedit* in the **Open** box, and then press **OK**.
3. Locate the following subkey:

   - Skype for Business 2016: **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Lync**
   - Lync 2013/Skype for Business 2015: **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Lync**

4. Delete the registry key with the name matching your sip address. For example: user@contoso.com.
5. Start File Explorer and locate the Local application data folder:
   
   - Skype for Business 2016: **%LocalAppData%\Microsoft\Office\16.0\Lync**
   - Lync 2013/Skype for Business 2015: **%LocalAppData%\Microsoft\Office\15.0\Lync**

6. Delete the folder with the name matching your SIP address. For example: sip_user@contoso.com.
7. Delete the Tracing folder. In case of error, verify Skype for Business and Outlook processes are stopped before deleting the folder.
8. Locate the Roaming application data folder:
   - Skype for Business 2016: **%UserProfile%\AppData\Roaming\Microsoft\Office\16.0\Lync**
   - Lync 2013/Skype for Business 2015: **%UserProfile%\AppData\Roaming\Microsoft\Office\15.0\Lync**

9. Delete the AccountProfiles.dat file.
10. Restart Skype for Business and sign-in.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
