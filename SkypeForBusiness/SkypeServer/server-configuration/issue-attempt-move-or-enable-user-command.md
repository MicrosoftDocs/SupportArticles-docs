---
title: Insufficient access rights to perform the operation when move or enable user
description: Lync Server Control Panel returns that error Insufficient access rights move user or enable user command. This issue occurs when the user account t to perform the operation when attempting a hat needs to be enabled for Lync or moved to a Lync registrar pool is a member of a protected Windows security group.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
  - Lync Server 2013
ms.date: 03/31/2022
---

# Lync Server Control Panel returns that error "Insufficient access rights to perform the operation" when attempting a move user or enable user command

## Symptoms

When using the Lync Server Control Panel to enable or move an Active Directory, directory service domain user for use with Lync Server the following error is returned:

Active Directory operation failed on "DC1.contoso.com". You cannot retry this operation: "Insufficient access rights to perform the operation"

## Cause

The error that is described in the SYMPTOMS section of this article is caused by the combination of the following two reasons:

- The user account that is part of the Lync Server move or enable operation is a member of an Active Directory, directory service protected domain security group. Since the user account belongs to a Windows Server protected domain security group, it is unable to keep the RTCUniversalUserAdmins and RTCUniversalUserReadOnlyGroup Lync Server Universal Security groups and their permissions as Access Control Entries (ACEs) for the protected domain security group's default Access Control List (ACL).   
- The Lync Server Control Panel is not designed to delegate the permissions of RTCUniversalUserAdmins and RTCUniversalUserReadOnlyGroup Lync Server Universal Security groups that are needed to complete the user account move or enable operation.    

> [!NOTE]
> As an example, the Domain Admins global security group is a Windows Server protected group. For detailed information on the Windows Server protected security groups and the Active Directory, directory service processes that maintain their default Access Control list entries see the MORE INFORMATION section of this article. 

## Resolution

Use the Lync Server Management shell to administer the following Lync Server PowerShell cmdlets to perform the user account enable of move operations:

> [!NOTE]
> Permissions equivalent to the RTCUniversalUserAmins group are required to successfully use the Enable-CsUser, Move-CsUser, Move-CsLegacyuser Lync Server PowerShell cmdlets.

1. Enable-CsUser -Identity "Bill Anderson" -RegistrarPool "pool01.contoso.com" -SipAddressType EmailAddress -SipDomain contoso.com

    - To view a list of examples for the usage of the Enable-CsUser Lync Server PowerShell cmdlet use the Lync Management Shell and enter the following PowerShell cmdlet: Get-Help Enable-CsUser -Examples   
   
2. Move-CsUser -Identity "Bill Anderson" -Target "pool01.contoso.com"

    - To view a list of examples for the usage of the Move-CsUser Lync Server PowerShell cmdlet use the Lync Management Shell and enter the following PowerShell cmdlet: Get-Help Move-CsUser -Example   
   
3. Move-CsLegacyUser -Identity "Bill Anderson" -Target "pool01.contoso.com"

    - To view a list of examples for the usage of the Move-CsLegacyUser Lync Server PowerShell cmdlet use the Lync Management Shell and enter the following PowerShell cmdlet: Get-Help Move-LegacyCsUser -Examples   
   
## More Information

For more detailed information on the permissions needed to use the Lync Server Control Panel and how to use the Lync Server Control Panel to add Active Directory, directory service users to the Lync Server pool please review the following information:

[Enable or Disable Users for Lync Server](/previous-versions/office/lync-server-2013/lync-server-2013-disable-or-re-enable-user-account-for-lync-server)

Windows Server Active Directory, directory service security groups that are designated protected groups will block the inheritance of non-default Access Control Entries (ACEs) to their default Access Control List (ACL) as a security measure. Windows Server protected groups consist of the list of default administrative groups that are used to manage the Windows Server enterprise.

The link listed below provides the details of the processes that are used to manage the default level of security for the Windows Server protected security groups:

[AdminSDHolder, Protected Groups and SDPROP for Windows Server](/previous-versions/technet-magazine/ee361593(v=msdn.10))

For more detailed information on using the Enable-CsUser, Move-CsUser, and Move-CsLegacyUser Lync Server PowerShell cmdlets, please review the following Microsoft TechNet information:

- [Enable-CsUser](/powershell/module/skype/Enable-CsUser)

- [Move-CsUser](/powershell/module/skype/Move-CsUser)

- [Move-CsLegacyUser](/powershell/module/skype/Move-CsLegacyUser)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).