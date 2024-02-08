---
title: Cannot configure a language pack for Windows Server 2019 Desktop Experience
description: Describes an issue in which you cannot install language packs by using the Language page in the Settings app in Windows Server 2019. Provides a resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, garrmc, estalin, v-jesits
ms.custom: sap:desktop-shell, csstroubleshoot
ms.subservice: shell-experience
---
# Cannot configure a language pack for Windows Server 2019 Desktop Experience

This article provides solutions to an issue where you cannot configure a language pack for Windows Server 2019 Desktop Experience.

_Applies to:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4466511

## Symptoms

When you use the Desktop Experience in Windows Server 2019, you cannot install language packs by using the **Language** page in the **Settings** app.

## Resolution

### Method 1: Install KB4476976

To resolve this issue, install the [January 22, 2019-KB4476976 (OS Build 17763.292)](https://support.microsoft.com/help/4476976) update.

Then, follow the steps in [Configure the display language.](#configure-the-display-language)

### Method 2: Use LPKSetup

Alternatively, you can add a new Windows display language without installing update 4476976. To do this, you must get the desired language pack CAB file, install the CAB file by using LPKSetup.exe, and then use the **Language** page to set your preferred language.

To use LPKSetup.exe, follow these steps:

1. Download an ISO image that contains the language packs [here](https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVERLANGPACKDVD_OEM_MULTI.iso).
2. Either mount the ISO image or burn the image to a DVD.
3. Press the Windows logo key+R to open the **Run** dialog box. Type *lpksetup.exe*, and then select **OK**.
4. Step through the wizard to install the language pack. Or, you can also use the [Lpksetup Command-Line Options](/previous-versions//dn898585(v=vs.85)) to install the language pack by using an elevated command prompt.

Then, follow the steps in [the next section.](#configure-the-display-language)

### Configure the display language

To  configure a new Windows display language, follow these steps:

1. Start the **Settings** application, select **Time & Language**, and then select **Language**.
2. On the **Language** page, under the **Preferred languages** heading, select **Add a language**.
3. In the **Choose a language to install** dialog box, select an entry that matches the language pack language, and then select **Next**.
4. In the **Install language features** dialog box, select **Install**. The **Windows display language**  box should now include the newly added language.
5. To switch to the new language, select it from the **Windows display language** box, sign out of the current Windows session, and then sign back in.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
