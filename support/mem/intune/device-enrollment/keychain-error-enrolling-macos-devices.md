---
title: Keychain error -25244 when enrolling macOS devices in Intune
description: Describes an issue in which you can't enroll a macOS device in Microsoft Intune because of stale or corrupted keychain entries.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:iOS/iPadOS enrollment
ms.reviewer: kaushika, luche
---
# Keychain error -25244 (errSecInvalidOwnerEdit) when you enroll a macOS device in Intune

This article fixes an issue in which you can't enroll a macOS device in Microsoft Intune because of stale or corrupted keychain entries.

## Symptoms

When you try to enroll a macOS device in Intune, the enrollment fails and you receive the following error:

> Your Mac cannot be enrolled at this time

In the Company Portal logs, you receive errors entries that resemble the following:

> 2018-06-07 18:13:42.795&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;INFO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; com.microsoft.ssp.workplaceJoinSdk&nbsp; &nbsp; &nbsp; TID=23&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WorkplaceJoinManager.swift: 796 (workplaceClient(\_:logMessage:)) INFO: -[WorkPlaceJoinUtil removeStringDataFromSharedAccessGroup:sharedAccesssGroup:] [Line 1546][2018-06-07 18:13:42 +0000]failed to delete workplace join item with identifier 'com.microsoft.workplacejoin.registeredUserPrincipalName' from keychain for shared access group: macOS.com.microsoft.workplacejoin with error code:-25244  
> 2018-06-07 18:13:42.795&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;INFO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; com.microsoft.ssp.workplaceJoinSdk&nbsp; &nbsp; &nbsp; TID=23&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WorkplaceJoinManager.swift: 796 (workplaceClient(\_:logMessage:)) ERROR: [errorCode:-400]-[WorkPlaceJoin clearWorkplaceJoinStateFromDevice:error:] [Line 1901][2018-06-07 18:13:42 +0000]failed to delete workplace join item with identifier 'com.microsoft.workplacejoin.registeredUserPrincipalName' from keychain for shared access group: macOS.com.microsoft.workplacejoin with error code:-25244  
> 2018-06-07 18:13:42.796&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;INFO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; com.microsoft.ssp.workplaceJoinSdk&nbsp; &nbsp; &nbsp; TID=23&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WorkplaceJoinManager.swift: 796 (workplaceClient(\_:logMessage:)) INFO: -[WorkPlaceJoinUtil removeStringDataFromSharedAccessGroup:sharedAccesssGroup:] [Line 1520][2018-06-07 18:13:42 +0000]macOS.com.microsoft.workplacejoin  
> 2018-06-07 18:13:42.797&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;INFO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; com.microsoft.ssp.workplaceJoinSdk&nbsp; &nbsp; &nbsp; TID=23&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WorkplaceJoinManager.swift: 796 (workplaceClient(\_:logMessage:)) INFO: -[WorkPlaceJoinUtil removeStringDataFromSharedAccessGroup:sharedAccesssGroup:] [Line 1541][2018-06-07 18:13:42 +0000]String data item with identifier 'com.microsoft.workplacejoin.registrationKey' was not found in shared access group 'macOS.com.microsoft.workplacejoin'  
> 2018-06-07 18:13:42.798&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;INFO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; com.microsoft.ssp.workplaceJoinSdk&nbsp; &nbsp; &nbsp; TID=23&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WorkplaceJoinManager.swift: 796 (workplaceClient(\_:logMessage:)) INFO: -[WorkPlaceJoinUtil removeStringDataFromSharedAccessGroup:sharedAccesssGroup:] [Line 1520][2018-06-07 18:13:42 +0000]macOS.com.microsoft.workplacejoin  
> 2018-06-07 18:13:42.824&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;INFO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; com.microsoft.ssp.workplaceJoinSdk&nbsp; &nbsp; &nbsp; TID=23&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WorkplaceJoinManager.swift: 796 (workplaceClient(\_:logMessage:)) INFO: -[WorkPlaceJoinUtil removeStringDataFromSharedAccessGroup:sharedAccesssGroup:] [Line 1546][2018-06-07 18:13:42 +0000]failed to delete workplace join item with identifier 'com.microsoft.workplacejoin.discoveryHint' from keychain for shared access group: macOS.com.microsoft.workplacejoin with error code:-25244  
> 2018-06-07 18:13:42.825&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;INFO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; com.microsoft.ssp.workplaceJoinSdk&nbsp; &nbsp; &nbsp; TID=23&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WorkplaceJoinManager.swift: 796 (workplaceClient(\_:logMessage:)) ERROR: [errorCode:-400]-[WorkPlaceJoin clearWorkplaceJoinStateFromDevice:error:] [Line 1927][2018-06-07 18:13:42 +0000]failed to delete workplace join item with identifier 'com.microsoft.workplacejoin.discoveryHint' from keychain for shared access group: macOS.com.microsoft.workplacejoin with error code:-25244

## Cause

This issue is caused by stale or corrupted keychain entries that are related to Intune enrollment in the macOS keychain.

## Resolution

> [!NOTE]
> Do the following steps only if you see error entries in the Company Portal logs that resemble the entries that are mentioned in the [Symptoms](#symptoms) section.

To fix this issue, follow these steps:

1. Log on to the device as a local administrator.
2. Open **Keychain Access** by typing **Keychain Access** in [Spotlight search](https://support.apple.com/HT204014), and then double-clicking **Keychain Access** in the search results.
3. In the **Search** box at the upper-right corner, type **workplace**.
4. Delete all keys in the results.
5. In the **Search** box at the upper-right corner, type **Microsoft**.
6. Locate and delete the following keys if present:

   - com.microsoft.CompanyPortal
   - com.microsoft.CompanyPortal.HockeySDK
   - enterpriseregistration.windows.net
   - <https://device.login.microsoftonline.com>
   - <https://device.login.microsoftonline.com/>
   - Microsoft Session Transport Key (public and private keys)

7. In the **Keychains** pane, select **login**, and then select **All Items** in the **Category** pane.
8. Click the **Kind** column header to sort the items.
9. Delete the items that meet any of the following conditions:

   - **Kind** is **Application password** and **Account** is `com.microsoft.workplacejoin.thumbprint`
   - **Kind** is **Application password** and **Account** is `com.microsoft.workplacejoin.registeredUserPrincipalName`
   - **Kind** is **Certificate** and **Issued by** is **MS-Organization-Access**
   - **Kind** is **Identity preference** and **Name** is the *ADFS STS URL*, such as `https://adfs<DNSName>.com/adfs/ls`
   - **Kind** is **Identity preference** and **Name** is `https://enterpriseregistration.windows.net`
   - **Kind** is **Identity preference** and **Name** is `https://enterpriseregistration.windows.net/`

10. In the **Keychains** pane, select **System**.
11. Delete the items that meet the following condition:

    **Kind** is **Certificate** and **Issued by** is **SC_Online_Issuing**

12. Uninstall the **Company Portal** app.
13. Exit **Keychain Access**.
14. Download the latest version of **Company Portal** from [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com/).
15. [Re-enroll](/mem/intune/user-help/enroll-your-device-in-intune-macos-cp) the device.
