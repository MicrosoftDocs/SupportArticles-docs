---
title: User object is missing or filtered from the Microsoft Entra connector in Azure Active Directory Sync
description: Describes an issue that blocks synchronization between a user object and Azure. A resolution is provided.
ms.date: 05/11/2020
ms.reviewer: elvinf
ms.service: entra-id
ms.subservice: users
---
# User object is missing or filtered from the Microsoft Entra connector in Azure Active Directory Sync

This article describes an issue that blocks synchronization for a user object from on-premises to Azure. A workaround is provided.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3066176

## Symptoms

When you try to sync a user object to Microsoft Entra ID, the operation is unsuccessful.

When you search for the user object in the metaverse objects, you see only the Active Directory connector listed on the **Connectors** tab. The Windows Microsoft Entra connector is not listed. Additionally, no error is returned for this particular user.

You may also notice that the `msExchRecipientTypeDetails` value for the user object that's not synchronized correctly is 2. This corresponds with the Linked Mailbox type, and the user does not have this value.

> [!NOTE]
> The following value is the only value that triggers filtering of a user object:
> `msExchRecipientTypeDetails == (0x1000 OR 0x2000 OR 0x4000 OR 0x400000 OR 0x800000 OR 0x1000000 OR 0x20000000)`.

For more information about user objects that are filtered, see
 [How directory synchronization determines what isn't synced from the on-premises environment to Windows Azure AD](https://social.technet.microsoft.com/wiki/contents/articles/19901.dirsync-list-of-attributes-that-are-synced-by-the-azure-active-directory-sync-tool.aspx#how_directory_synchronization_determines_what_isn_t_synced_from_the_on-premises_environment_to_windows_azure_ad).

## Cause

This issue occurs because there is a rule for the sourceAnchor attribute. The rule is used to determine whether the value of `msexchRecipientTypeDetails` is **2**.

> [!NOTE]
> You can view this rule in the following location: _Sync Rules Configuration Editor\Inbound\In From AD\Common\Transformation_. You can also see the target sourceAnchor attribute and the expression rule as follows:
> _IIF(IsPresent([msExchRecipientTypeDetails]),IIF([msExchRecipientTypeDetails]=2,NULL,IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID])))_

If `msExchRecipientTypeDetails` has a value of **2**, the value of sourceAnchor is set to NULL. However, if the value of sourceAnchor is NULL, the user will be filtered.

## Workaround

To work around this issue, do one of the following:

- Make sure that the Master user account (in Account forest) is synchronized first.
- Change the attribute value of msExchRecipientTypeDetails to 1. Use any value that's not supposed to be filtered by either of the rules.

## More information

According to [DirSync: List of attributes that are synced by the Azure Active Directory Sync Tool](https://social.technet.microsoft.com/wiki/contents/articles/19901.dirsync-list-of-attributes-that-are-synced-by-the-azure-active-directory-sync-tool.aspx), one reason a user object is filtered is because of the following:

```console
msExchRecipientTypeDetails == (0x1000 OR 0x2000 OR 0x4000 OR 0x400000 OR 0x800000 OR 0x1000000 OR 0x20000000)
```

It's an assumption that if the `msExchRecipientTypeDetails` attribute on a user is set to a value of 2, the AADSync server will filter  this object. This is not true. AADSync is not filtering this user object, it's just waiting for the master account  (from account forest) to join to the object because it's needed for the UPN and the sourceAnchor.

A value of 2  for the `msExchRecipientTypeDetails` attribute indicates that the mailbox type is a "linked mailbox". A linked mailbox is found in an account-resource forest topology and the user object in account forest must be synchronized before these resource objects will be provisioned to Microsoft Entra ID.

Therefore, with the `msExchRecipientTypeDetails` set to 2  the object is not filtered. However, when this flag is set, the AADSync waits for the master account (from account forest) to be synced so that it could join the two objects and create a cloud connector for the final user object in AADSync.

In the scenario that you do not have an account-resource forest topology, and a user has `msExchRecipientTypeDetails` value is 2, changing the value to a value that is similar to a usual object will sync the user object.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
