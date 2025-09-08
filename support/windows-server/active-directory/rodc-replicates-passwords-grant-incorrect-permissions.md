---
title: RODC replicates passwords of all users incorrectly in Windows Server
description: Address an issue in which RODC replicates passwords of users that are not members of Allowed RODC Password Replication Group or are not listed in the RODC account's msDS-RevealOnDemandGroup attribute.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-jeffbo
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# RODC replicates passwords when it's granted incorrect permissions in Windows Server

This article addresses an issue in which RODC replicates passwords when it's granted incorrect permissions in Windows Server.

_Original KB number:_ &nbsp; 4050867

## Symptom

Normally, Read Only Domain Controllers (RODCs) only replicate user passwords for user accounts that are a member of the **Allowed RODC Password Replication Group** or are listed in the RODC account's msDS-RevealOnDemandGroup attribute.

However, for some user accounts that are not members of **Allowed RODC Password Replication Group** or are not listed in the RODC account's msDS-RevealOnDemandGroup attribute, you may find that passwords for those accounts that are authenticated by the RODC may be cached by the RODC.

For example, when you compare the output of the **Advanced Password Replication Policy** property by using Active Directory Users and Computers and the output of `repadmin /prp view RODC_name reveal`, the entries listed differ between the two.

## Cause

This problem is caused by incorrect permission configuration.

By default, the **Enterprise Domain Controllers** group that contains only writeable DCs has the permission [Replicating Directory Changes All](/windows/win32/adschema/r-ds-replication-get-changes-all) on the domain partition. For example, on "DC=contoso,DC=com" in Active Directory.  

However, when the issue occurs, the problem RODC also has the **Replicating Directory Changes All** permission on the domain because it was granted by an administrator either to the **Enterprise Read-only Domain Controllers** group or to the RODC object directly or indirectly via some other group membership.

Normally, RODCs will only replicate user passwords if the user accounts are a member of the **Allowed RODC Password Replication Group** or are listed in the RODC account's msDS-RevealOnDemandGroup attribute.

With the **Replicating Directory Changes All** permission, all user attributes, including passwords, are replicated from the source DC to the RODC as if the RODC were a normal Read Write DC (RWDC).

## Resolution

To resolve this issue, change the **Replicating Directory Changes All** permission that is granted to the **Enterprise Read-only Domain Controllers** object to [Replicating Directory Changes](/windows/win32/adschema/r-ds-replication-get-changes).

## More information

Follow these steps to help validate the permissions and determine where the wrong permissions are coming from.

### Step 1

Use LDP to view the "control access" permissions on the domain. To do this, following these steps:

1. Run the *LDP.exe* command on a domain controller.
2. Connect to the tree (for example, DC=contoso,DC=com).
3. Right-click the **DC=contoso,DC=com** node, select **Advanced**, and then select **Security Descriptor**.
4. Choose the option **Text dump** for a text view of the permissions or leave it unchecked to get a GUI security editor.
5. Verify the permissions to make sure that the **Enterprise Read-only Domain Controllers** group only has permission **Replicating Directory Changes.**

### Step 2

Verify the group memberships of the RODC to determine whether **Replicating Directory Changes All** is being granted through another group.

To obtain the true membership of the RODC, you can use a query for the **TokenGroups** attribute to retrieve the effective group list of the user by using the LDP tool.

:::image type="content" source="media/rodc-replicates-passwords-grant-incorrect-permissions/query-for-the-tokengroups-attribute.png" alt-text="Screenshot of the Search window filled with a query for the TokenGroups attribute.":::

Make sure that you select **Base** scope and add the required attribute. When you are scoping the search on an individual user, you get the list for that user. If the user is in many groups, you must extend the amount of data that LDP prints into the window on the right, select **Options\General** from the menu, and adjust the **Chars per**  field to a higher value:
  
:::image type="content" source="media/rodc-replicates-passwords-grant-incorrect-permissions/general-options-adjust-chars-per.png" alt-text="Screenshot of the General Options window with a Chars per box which can be adjust.":::

### Step 3

On Windows Server 2008 R2, Windows 7, Windows Server 2008, or Windows Vista, check whether you encounter the issue that is outlined in the following article:  
[The "Active Directory Users and Computers" MMC snap-in does not list all the accounts that have passwords cached on the RODC in Windows](https://support.microsoft.com/topic/the-active-directory-users-and-computers-mmc-snap-in-does-not-list-all-the-accounts-that-have-passwords-cached-on-the-rodc-in-windows-948c0ecc-9b60-f4f8-6cd8-fb61c8812a5b)

### Step 4

Confirm the consistency of the RODC's computer account properties on all domain controllers in the domain.

One method is to use `repadmin` to export the replication metadata of the RODC's computer account from all domain controllers. To do this, use the following command:

```console
repadmin /showobjmeta *<dn of RODC account>' > rodc_meta.txt
```

### Step 5

Similarly to step 4, confirm the consistency of the **Allowed RODC Password Replication** **Group**  and any other group configured on the **msDS-RevealOnDemandGroup** attribute to see if the incorrectly cached user passwords can be explained by inconsistent group membership on different DCs that may be caused by a replication problem.

### Step 6

Verify that users who have their passwords cached by the RODC aren't accidentally a member of a group that is configured to have their passwords cached.

> [!Note]
> The MMC will gather the password replication policy information from any domain controller (even the RODC itself), while the `repadmin /prp` command will always interrogate a read-write domain controller.

If there are any replication inconsistencies between the RODC and an RW DC, this may explain the difference in output of these two utilities/methods.
