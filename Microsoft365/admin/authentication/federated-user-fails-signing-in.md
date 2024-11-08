---
title: A federated user has trouble signing in with error code 80048163
description: Describes an issue in which a federated users receive an error message when they try to sign in to Microsoft 365, Azure, or Microsoft Intune from a sign-in webpage whose URL starts with "https://login.microsoftonline.com."
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft 365
  - Microsoft Intune
  - CRM Online via Office 365 E Plans
  - Azure Backup
ms.date: 03/31/2022
---

# Error 80048163 when a federated user tries to sign in to Microsoft 365, Azure, or Intune

## Problem

When a federated user tries to sign in to a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune from a sign-in webpage whose URL starts with https://login.microsoftonline.com, authentication for that user is unsuccessful. The user gets the following error message:

```output
Sorry, but we're having trouble signing you in

Please try again in a few minutes. If this doesn't work, you might want to contact your admin and report the following error:
80048163
```

## Cause

This issue may occur if one of the following conditions is true:

- A user's UPN was updated, and old sign-in information was cached on the Active Directory Federation Services (AD FS) server. When the SAM account of the user is changed, the cached sign-in information may cause problems the next time that the user tries to access services.
- The claims that are set up in the relying party trust with Microsoft Entra ID return unexpected data. This behavior may occur when the claims that are associated with the relying party trust are manually edited or removed.

## Solution

### Resolution 1: Disable Local Security Authority (LSA) credential caching on the AD FS server

You can update the LSA cache time-out setting on the AD FS server to disable caching of Active Directory credential info. Use this method with caution. It may put an additional load on the server and Active Directory.

> [!IMPORTANT]
> This method contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more info about how to back up and restore the registry, click the following article number to view the article [How to back up and restore the registry in Windows](https://support.microsoft.com/help/2535191/).

To resolve this issue, follow these steps:

1. Make sure that the changes to the user's UPN are synced through directory synchronization.
1. Direct the user to log off the computer and then log on again.
1. If steps 1 and 2 don't resolve the issue, follow these steps:

   1. Open Registry Editor, and then locate the following subkey:

      **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa**

   1. Right-click **Lsa**, click **New**, and then click **DWORD Value**.
   1. Type **LsaLookupCacheMaxSize**, and then press ENTER to name the new value.
   1. Right-click **LsaLookupCacheMaxSize**, and then click **Modify**.
   1. In the **Value data** box, type **0**, and then click **OK**.
   1. Exit Registry Editor.

LsaLookupCacheMaxSize reconfiguration can affect sign-in performance, and this reconfiguration isn't needed after the symptoms subside. This method should be used only temporarily, and we strongly recommend that you delete the LsaLookupCacheMaxSize value after the issue is resolved. To do this, follow these steps:

1. Open Registry Editor, and then locate the following subkey:

   **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa**

1. Right-click **LsaLookupCacheMaxSize**, and then click **Delete**.
1. Exit Registry Editor.

<a name='resolution-2-update-the-relying-party-trust-with-azure-ad'></a>

### Resolution 2: Update the relying party trust with Microsoft Entra ID

To update the relying party trust, see the "How to update the configuration of the Microsoft 365 federated domain" section of the following Microsoft article:

[How to update or repair the settings of a federated domain in Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2647048/)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
