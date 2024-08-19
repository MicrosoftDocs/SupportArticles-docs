---
title: HostedMigration fault when you move users from Online to on-premises
description: Describes an issue that triggers a Move-CsUser HostedMigration fault Error =(506) error when you move users from Skype for Business Online to on-premises Skype for Business Server.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: randw, edpeno, shravank, dahans, willfid
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Online
  - Skype for Business Server 2015
ms.date: 03/31/2022
---

# "HostedMigration fault: Error =(506)" when you move users from Skype for Business Online to on-premises Skype for Business Server

## Problem

Consider the following scenarios:

- Users were created and licensed for Skype for Business (formerly Lync) in the cloud. However, the users weren't migrated from on-premises to the cloud. Later, Skype for Business was enabled for Skype for Business on-premises for a single user by using the following cmdlet:

    ```powershell
    Enable-CsUser-Identity "username" -SipAddress "sip:username@contoso.com"-HostingProviderProxyFqdn "sipfed.online.lync.com"
    ```

    > [!NOTE]
    > This cmdlet updates the on-premises MSRtcSipDeploymentLocator attribute for the user to "sipfed.online.lync.com." After DirSync is complete, the HostingProvider attribute of the online user should change from SRV to sipfed.online.lync.com.    
- You configured identity synchronization to Microsoft Entra ID before Skype for Business on-premises was installed. Later, a hybrid environment was configured by installing Skype for Business on-premises, and the MSRtcSip* attributes of the on-premises users were updated correctly. Identity synchronization didn't sync the MSRtcSip* on-premises attributes to the cloud because it syncs only those attributes that existed in the on-premises schema at the time when identity synchronization was originally configured.   

When you try to move users from Skype for Business Online to Skype for Business on-premises in either of these scenarios, you receive the following error message:

```output
Exception: Microsoft.Rtc.Management.AD.MoveUserException: HostedMigration fault: Error=(506), Description=(The user could move be moved because there appears to be a problem with this user account. Please verify the attribute settings on the account and then try again.)
```

> [!NOTE]
> To verify that identity synchronization failed, inspect the attributes of the online users by running the Get-CsOnlineUser cmdlet. If the HostingProvider attribute for the user is SRV, DirSync sync failed to update the Skype for Business Online attributes for the user.

## Solution 

To fix this issue, rerun the configuration wizard for Directory Synchronization (DirSync) or Microsoft Entra Connect, depending on which appliance you're using. After the configuration wizard is completed and synchronization is performed, the Skype for Business Online HostingProvider attribute for the user will change from SRV to sipfed.online.lync.com.

## More Information 

Attributes that were added to your Active Directory environment after identity synchronization was set up won't be recognized until you rerun the configuration wizard for the Microsoft Entra identity synchronization appliance. For Skype for Business, the MSRtcSip* attributes were added. Because these are missing from the sync, Skype for Business Online will continue to believe that these users are Skype for Business Online and not Skype for Business on-premises users.

For more information, see [Migrating Lync Online users to Lync on-premises in Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-migrating-lync-online-users-to-lync-on-premises?f=255&mspperror=-2147217396).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
