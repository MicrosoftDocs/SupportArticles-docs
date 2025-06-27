---
title: Authentication issues in SharePoint Designer 2013
description: Provides a resolution for authentication issues in SharePoint Designer 2013.
ms.author: luche
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Identity and Authentication\App Authentication
  - CSSTroubleshoot
  - CI 191383
ms.reviewer: salarson, prbalusu, meerak
appliesto: 
  - SharePoint Online
search.appverid: 
  - MET150
ms.date: 06/19/2024
---

# Authentication issues in SharePoint Designer 2013

## Symptoms

When you try to sign in to SharePoint Designer 2013, one of the following issues occurs:

- You receive the error: "We are unable to connect right now."

- You receive the error: "We are unable to sign you in to \<your organization, such as Contoso\>."

- You receive the error: "Can't connect right now. Please check your network and try again later."

- You're repeatedly prompted to enter credentials.

## Cause

These issues occur if you disabled the authentication method which uses the Identity Client Runtime Library (IDCRL) to use modern authentication instead. Modern authentication uses the Azure Active Directory Authentication Library (ADAL) while SharePoint Designer 2013 natively uses the IDCRL for authentication. SharePoint Designer 2013 can't use modern authentication without meeting additional requirements.

## Resolution

To resolve the authentication errors, use the following steps to enable SharePoint Designer 2013 to use modern authentication:

1. Verify that you're using the 32-bit version of SharePoint Designer 2013. If you're using the 64-bit version, the steps in this resolution might not work correctly. 
You can uninstall the 64-bit version of SharePoint Designer 2013 and install the [32-bit version of SharePoint Designer 2013](https://www.microsoft.com/download/details.aspx?id=35491) to continue.

2. Open the Registry Editor and then locate the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common`

3. Select **View** > **Refresh**, or press **F5** to refresh the registry.

4. Select **Identity** under the **Common** subkey and check the value of the **EnableADAL** entry.

   If that entry doesn't exist, follow these steps:
  
   1. Right-click **Identity**, select **New** > **DWORD (32-bit) Value**, and then enter **EnableADAL** as the name.
  
   2. Double-click **EnableADAL**, enter `1` in the **Value data** field, and then select **OK**.
  
   If the value of that entry isn't `1`, double-click **EnableADAL**, enter `1` in the **Value data** field, and then select **OK**.

5. Exit the Registry Editor.

6. Install the 32-bit version of [Service Pack 1 (SP1) for SharePoint Designer 2013](https://support.microsoft.com/topic/description-of-microsoft-sharepoint-designer-2013-service-pack-1-sp1-54240f09-085c-1e3d-f41e-d53d1784e9ed), and then restart your computer.

7. Install the 32-bit version of [August 2, 2016, update for SharePoint Designer 2013 (KB3114721)](https://support.microsoft.com/topic/august-2-2016-update-for-sharepoint-designer-2013-kb3114721-058c4eeb-c588-ec34-3737-e7b94d501a71), and then restart your computer.

8. Install the 32-bit version of [Security update for Office 2013: September 10, 2019](https://support.microsoft.com/topic/description-of-the-security-update-for-office-2013-september-10-2019-0d171ba2-2eba-a2ca-a54d-c0f568de6bcc), and then restart your computer.

9. If the authentication issue persists, install the 32-bit version of the following updates, and then restart your computer:

   - [July 11, 2017, update for Office 2013 (KB3172545)](https://support.microsoft.com/topic/july-11-2017-update-for-office-2013-kb3172545-d6b47054-04d5-5154-40ba-3436d1e0efdb)

   - [July 5, 2016, update for Office 2013 (KB3085565)](https://support.microsoft.com/topic/july-5-2016-update-for-office-2013-kb3085565-1d1a6d24-fbd4-1bae-242f-a35e0e2aba40)
  
10. If you still see authentication issues, clear the SharePoint Designer 2013 cache:

  - Close SharePoint Designer 2013.
  - On the local computer, navigate to the following folders and remove all the files in each folder:

   - `%APPDATA%\Microsoft\Web Server Extensions\Cache`
   - `%APPDATA%\Microsoft\SharePoint Designer\ProxyAssemblyCache`
   - `%USERPROFILE%\AppData\Local\Microsoft\WebsiteCache`


Modern authentication should now be enabled for SharePoint Designer 2013 and you shouldn't see any authentication issues.

