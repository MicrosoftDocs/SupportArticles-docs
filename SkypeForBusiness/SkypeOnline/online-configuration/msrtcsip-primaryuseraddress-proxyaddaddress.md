---
title: Error in the Office 365 portal
description: Describes a problem in which administrators receive an error message in the Office 365 portal that states that the value of msRTCSIP-PrimaryUserAddress or the SIP address isn't unique. Provides a resolution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto:
- Skype for Business Online
---

# "Value of msRTCSIP-PrimaryUserAddress or the SIP address in the ProxyAddresses field in your local Active Directory is not unique" in the Office 365 portal

## Problem 

Administrators may receive the following error message in the Office 365 portal:

```adoc
For this user the value of msRTCSIP-PrimaryUserAddress or the SIP address in the ProxyAddresses field in your local Active Directory is not unique. Correct the value in your Active Directory.The users who have duplicate msRTCSIP-PrimaryUserAddress won't be able to sign in to Skype for Business Online (formerly Lync Online) or chat with other contacts.
```

## Solution

If you're using directory synchronization, locate and correct the duplicate attributes. To do this, follow these steps:

1. Search Active Directory Domain Services (AD DS) for the duplicate msRTCSIP-PrimaryUserAddress attributes. To do this, follow these steps:
   1. On a domain controller, open Active Directory Service Interfaces (ADSI) Edit. To do this, click **Start**, click **Run**, type adsiedit.msc, and then click **OK**.   
   2. Create a new query in the AD DS domain in which the users reside. To do this, follow these steps:
       1. In ADSI Edit, in the console tree, click **Default naming context**, point to **New** on the **Action** menu, and then click **Query**.   
       2. Type a name for the query, click **Browse** under **Root of Search**, and then select the top-level domain.   
       3. Type the following text as the query, and then click **OK**.

           msRTCSIP-PrimaryUserAddress=sip:joe@contoso.com
    
          > [!NOTE]
          > Replace joe@contoso.com with the value of the duplicate email address.

          Any users who have duplicate msRTCSIP-PrimaryUserAddress attributes are listed in the query results.       
   3. The results are listed under **Default naming context** in the ADSI Edit console tree.   
   4. Right-click the user, and then click **Properties**.   
   5. Edit the msRTCSIP-PrimaryUserAddress attributes of the users so that the values are unique within the organization.

        > [!NOTE]
        > If you currently have Lync Server deployed on-premises, you'll want to change the user's SIP address through the Lync Server Control Panel or the Lync Server Management Shell by using the Set-CsUser cmdlet. For more information, see [Modify the SIP Address of an Enabled Lync Server User](https://techcommunity.microsoft.com/t5/skype-for-business-blog/modify-the-sip-address-of-an-enabled-lync-server-user/ba-p/619467).   
   6. Force directory synchronization. Wait approximately 15 minutes for the changes to take full effect.   
   
2. Search AD DS for duplicate SIP proxies in the proxyAddresses attributes. To do this, follow these steps: 
   1. On a domain controller, open Active Directory Service Interfaces (ADSI) Edit. To do this, click **Start**, click **Run**, type adsiedit.msc, and then click **OK**.   
   2. Create a new query in the AD DS domain in which the users reside. To do this, follow these steps:
      1. In ADSI Edit, in the console tree, click **Default naming context**, point to **New** on the **Action** menu, and then click **Query**.   
      2. Type a name for the query, click **Browse** under **Root of Search**, and then select the top-level domain.   
      3. Type the following text as the query, and then click **OK**.

         proxyAddresses=sip:joe@contoso.com

         > [!NOTE]
         > Replace joe@contoso.com with the value of the duplicate email address.

         Any users who have duplicate SIP proxyAddresses attributes are listed in the query results.       
  3. The results are listed under **Default naming context** in the ADSI Edit console tree..   
  4. Right-click the user, and then select **Properties**.   
  5. Edit the proxyAddresses attributes of the users so that the values are unique within the organization.

     > [!NOTE]
     > If you currently have Exchange Server deployed on-premises, you can make these changes in the Exchange Management Console (EMC) or the Exchange Management Shell.   
  6. Force directory synchronization. Wait approximately 15 minutes for the changes to take full effect.   

If you don't use directory synchronization, contact Office 365 technical support.

## More Information

This problem occurs if the value of the msRTCSIP-PrimaryUserAddress attribute or the value of the Session Initiation Protocol (SIP) proxy address is the same for two users in Office 365.

> [!NOTE]
> Even though the error message specifically states that the value in the local Active Directory isn't unique, you may experience this issue even though you aren't using the Microsoft Azure Active Directory Sync Tool. If you don't use Directory Synchronization, contact Office 365 technical support for help with resolving the issue. 

## References

For more information about how to detect duplicate or invalid attributes that might prevent synchronization, see the following Microsoft Knowledge Base article:

[2643629 ](https://support.microsoft.com/help/2643629) One or more objects don't sync when using the Azure Active Directory Sync tool 

For more information about ADSI Edit, go to the following Microsoft website: [https://technet.microsoft.com/en-us/library/cc731547(WS.10).aspx](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731547(v=ws.10))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).