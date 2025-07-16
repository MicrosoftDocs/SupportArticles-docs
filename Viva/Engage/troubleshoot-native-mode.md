---
title: Resolve issues with your Viva Engage network in Native Mode
description: Provides a resolution for issues when using the Viva Engage network in Native Mode.
ms.reviewer: ethli
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: viva-engage
search.appverid:
 - MET150
ms.date: 08/08/2024
---

# Resolve issues with your Viva Engage network in Native Mode

## What is Native Mode?

Viva Engage is in Native Mode when users, groups, and content are compatible with and mapped to their counterparts in Microsoft Entra ID and Microsoft 365.

### What benefits are new to Native Mode?

Viva Engage premium functionality is only available to networks in Native Mode. Networks in Native Mode can [perform eDiscovery](/viva/engage/overview-native-mode) on their home network through the Security & Compliance Portal, just like they do for other Microsoft 365 products. Also, administrators and users both benefit from an experience that's more consistent within Viva Engage and within the Microsoft 365 ecosystem.

 > [!NOTE]
> Native Mode is strongly recommended for reasons of security, compliance, and Microsoft 365 integration.

### What's required for me to be in Native Mode for Microsoft 365 in Viva Engage?

While all networks provisioned after January 2020 are in Native Mode by default, existing networks need to use our Alignment Tool to have their network enter Native Mode. To use the tool, your network must enforce Microsoft 365 Identity. There must also only be one (primary) home network on the Microsoft 365 tenant. If a network satisfies those two criteria, the Alignment Tool can help you address any incompatibilities between the network and a Native Mode network.

#### Are there more licensing requirements when moving to native mode?

Native Mode doesn't have any licensing requirements beyond the requirements for [Microsoft 365 and Microsoft 365 plans that include Groups](/viva/engage/configure-your-viva-engage-network/viva-engage-and-office-365).

### What features aren't supported in Native Mode, and why aren't they supported?

- *Native Mode doesn't support private unlisted groups*: Microsoft Entra ID and Microsoft 365 Groups don't support this feature, so we can't offer it in Native Mode networks. The downloadable Alignment Tool Report can provide information about the quantity and use of private unlisted groups in your network.

- *Native Mode doesn't support external communities*: Hybrid and non-native mode external collaboration capabilities, including external communities, aren't compatible with [Azure B2B](/azure/active-directory/external-identities/). Native Mode networks can host B2B guests in Microsoft 365 Groups-backed communities. Users from Native Mode networks can collaborate in external communities in other Viva Engage networks that aren't in Native Mode your Viva Engage Security Settings allow this functionality. In addition, external networks are supported for Native Mode Viva Engage networks in the US geo.

Microsoft Entra business-to-business (B2B) collaboration lets you securely share your company's applications and services with guests from any other organization while you maintain control over your own corporate data.

The downloadable Alignment Report provides information about the quantity and use of external groups in your network.

- *Native Mode doesn't support network-level guests*: For greater network security, guests can't be given access to an entire Viva Engage network. The downloadable Alignment Report provides information about the quantity and activity of guests in your network.

- *External participants*: Viva Engage currently allows users to add external participants to individual threads. This feature isn't available for Viva Engage networks that are in Native Mode or in the [EU geo](/viva/engage/manage-security-and-compliance/manage-data-compliance). This feature isn't compatible with the Azure B2B guest model, so it's not supported in Native Mode networks.

- *File uploads in Viva Engage Private messages*: To be in Native Mode, all files uploaded in Viva Engage must be stored in SharePoint. Because Viva Engage private messages don't store files in SharePoint or OneDrive for Business, the Alignment Tool deletes any previously uploaded private message files. Users can no longer upload files in private messages. The downloadable Alignment Report provides information about the quantity of files previously uploaded in private messages.

### What's the main difference between Native Mode and eDiscovery?

- *Native Mode* is a state in which all the users, groups, and content from your network are compatible with, and mapped to, their counterparts in Microsoft Entra ID and Microsoft 365.

- *eDiscovery* is a Viva Engage feature Microsoft provides to customers through the [Microsoft Purview compliance portal](https://sip.compliance.microsoft.com/homepage).  

Viva Engage can offer eDiscovery to customers when all their users, groups, and content are discoverable through the compliance portal. To facilitate this process, Viva Engage must ensure that all Groups are Microsoft 365-connected because eDiscoverable content must be saved in the group mailbox. Similarly, users must have a Microsoft Entra account.

### What can you include in communications to your users?

When you're ready to communicate upcoming changes to your organization, modify the following communication to meet your organization's needs:

------------------------------

*Hello NAME OF EMPLOYEE,*

*We're preparing our Viva Engage network to support required compliance and security policies for our organization.*

*Here are some changes we're rolling out over the next few weeks:*

*- All unlisted private groups become private listed groups on DATE. Nonmembers can see the group in search results and other areas, but only members can access the content. If you don't want your group to be visible to nonmembers, you must delete it before that date. You can also change the name of the group if the concern is that people can identify the purpose of the group based on the name.*

*- All network, group, and conversation-level guests from our Viva Engage network will be removed on DATE. If you work with people outside our Viva Engage network, you should figure out an alternate way to communicate with them.*

*- All Viva Engage group files will be stored in SharePoint beginning on DATE. This means that previously uploaded group files will be migrated to SharePoint, and all new group file uploads will be saved to SharePoint.*

*- All files that were previously uploaded on Viva Engage private messages will be deleted on DATE. No new files can be uploaded in Viva Engage private messages.*

*- Beginning DATE, users need to have Microsoft 365 Group creation rights to create a group in Viva Engage. If you don't currently have Microsoft 365 Group creation rights, you'll no longer be able to create groups in Viva Engage. Contact your manager if you don't have Microsoft 365 Group creation rights but think you need them to perform your job.*

*Your IT team*

## Migration

### What can end users expect during migration?

Most end users won't see any change in their Viva Engage experience while the tool runs. If end users create communities in Viva Engage, they'll need Microsoft 365 group creation rights to continue doing that during migration. We recommend that you communicate the expected process changes to your end users early in the migration planning process.

### How do I check the status of my network's migration to Native Mode?

Any Yammer Administrator from your tenant can check the status of your network's alignment to Native Mode by accessing the Viva Engage admin center. On the **Setup & configuration** tab, they can access **Configure tenant**, which will then route them to the Viva Engage admin center. In the Viva Engage admin center, they can select **native mode** to see their progress.

## Networks

### Should I align my network to be in Native Mode?

Yes. Hybrid and non-native networks will be migrated to Native Mode automatically throughout 2023. We strongly recommend that you initiate the process on your own when you're ready. All Viva Engage premium functionality requires that your networks are in Native mode.

### Can a network that's in Native Mode get out of Native Mode?

No. Once a network is in Native Mode, it can't get out of Native Mode. We recommend that administrators carefully review the documentation we provide about Native Mode before beginning the process because *it's unstoppable and irreversible*.  

### How does a network enter Native Mode for Microsoft 365?

**New Networks:**
All new networks provisioned after January 2020 are in Native Mode by default.

**Existing Networks:**
Existing networks can upgrade to Native Mode by using the Microsoft 365 Alignment Tool.

## Files

### How does Viva Engage in Native Mode handle file migration?

After a Viva Engage group is connected, the Alignment Tool migrates all files previously uploaded to Viva Engage to SharePoint. When files are moved to the SharePoint document library, only the latest version is moved over, and the version history isn't copied.

### Why does the Alignment Tool delete messages and files from deleted groups and deleted users?

Deleted groups and deleted users don't typically have a mailbox, which means content associated with that group or user wouldn't be available for eDiscovery. Therefore, we need to remove that content from Native Mode networks to offer an eDiscovery solution in the compliance portal that includes all conversations and files in your Native Mode network.

### How does Viva Engage in Native Mode handle file name conflicts?

Files previously uploaded to Viva Engage may not comply with SharePoint filename restrictions. When migration completes, the IT admin gets a report of file name conflicts. Update the file names and make sure there are no file names that contain any of the following invalid characters before you run the tool again:

- `"`
- `*`
- `:`
- `<`
- `>`
- `?`
- `/`
- `\`
- `|`

You can't take your network to Native Mode for Microsoft 365 until you resolve name issues for any files left behind.

## Error codes

If you receive errors in the report generated by the Alignment Tool, follow the steps in this table to troubleshoot. If you encounter an error code that isn't listed here, [contact the Microsoft support team](/microsoft-365/admin/contact-support-for-business-products?tabs=online).

|**Code** |**Description** | **Migration** |
|:--------|:-------------- |:------------- |
|CannotOpenFile--2147024816 |Can't open a file |Remove file |
|FilealreadyExists--2130575257 |File is in SharePoint already |Rename/remove |
|FileNameCharactersNotPermitted—2130575245 |[Characters not permitted in SharePoint exist in file name](https://support.office.com/article/invalid-file-names-and-file-types-in-onedrive-onedrive-for-business-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa)|Rename/remove|
|InvalidCharactersInPath--2147024809|[Characters not permitted in SharePoint exist in file name](https://support.office.com/article/invalid-file-names-and-file-types-in-onedrive-onedrive-for-business-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa)|Rename/remove|
|PathTooLong---2147024690---2130575338|[Filepath is too long](https://support.office.com/article/invalid-file-names-and-file-types-in-onedrive-onedrive-for-business-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa)|Rename/remove|
|SpFileDeleted---2130575338|File deleted in SharePoint|Upload again to SharePoint/ delete file|
|Unknown||Remove file/ [contact support](/microsoft-365/admin/contact-support-for-business-products?tabs=online)|

> [!NOTE]
> If you have many files with disallowed characters, you can [contact Microsoft support](/microsoft-365/admin/contact-support-for-business-products?tabs=online) to obtain a script that renames files in a bulk process.

### What happens to the conversations and files from deleted Microsoft 365 Groups that are within their 30-day recovery window?

When the Alignment Tool runs, it removes the conversations and Viva Engage-hosted files for all deleted groups, whether the group is in a hard-deleted or soft-deleted state. This means that if there are Viva Engage Microsoft 365-connected groups that are in the soft-delete period when the Alignment Tool runs, those groups would be restored without conversations and without any files that had been uploaded to Viva Engage. Group metadata and files that were uploaded to SharePoint would continue to be restored as they are in non-Native Mode scenarios.

## Users and guests

### Network guests

- *Why aren't network guests supported in Native Mode?*

  Network guests in Viva Engage aren't currently Azure B2B guests, so their user IDs aren't associated with an account in Microsoft Entra ID for your Microsoft 365 tenant. Because eDiscovery requires all users to be in Microsoft Entra ID, the network-level guest feature can't be supported in Native Mode. You can invite B2B guests to collaborate at the community level in Native Mode networks.

- *What should I do about my existing network guests?*

  Most networks have never had any network guests. If your network had network guests in the past, it's likely that most of those guests no longer have access due to your network enforcing Microsoft 365 Identity.

  The downloadable Alignment Report provides information about the network guests in your network and their activity within the network. We recommend you use the information in the report to help decide whether these users should continue to have access to the network. If you want these users to have access to the network when your network is in Native Mode, you need to give them Microsoft Entra account credentials.

### What happens to users who don’t have Microsoft 365 Group creation rights?

If your network enforces Microsoft 365 Group creation rights, users who lack those rights won't be able to create communities in Viva Engage. We recommend that all users be able to create Viva Engage communities so that your entire organization can enjoy the benefits of an open, collaborative network.

### What about users who aren't in Microsoft Entra ID?

- *Why would I have users not in Microsoft Entra ID in my network if I enforce Microsoft 365 Identity?*

  Enforcing Microsoft 365 Identity doesn't remove users from your network who left your organization before your organization enforced Microsoft 365 identity. Most customers who have users in their Viva Engage network who aren't in Microsoft Entra ID determine that these users haven't been active in the network since Microsoft 365 Identity was enforced for the network or earlier.

- *Why would some of these users have recent activity?*

   When a network chooses to enforce Microsoft 365 Identity, the administrator can choose whether or not to log out all logged-in users of the network. If your network didn't force all users to log out, it's possible that some of these users have stayed active enough that they've remained logged in.

- *What should I do about users who aren't in Microsoft Entra ID?*

   The downloadable Alignment Report provides information about which users in your Viva Engage network aren't in or mapped to an account in Microsoft Entra ID. We recommend that you use the report to help you decide whether these users should continue to have access to the network. If you want to provide continued Viva Engage access to users who don't currently have a Microsoft Entra account, you need to create a new Microsoft Entra account for them or invite them as a B2B guest. In some cases, these accounts may be service accounts or bots, rather than specific end users.

- *Why would a user not be in Microsoft Entra ID?*
  
  There are several possible reasons:

  - In some cases, the user was invited to the network but has never logged into Viva Engage. These users are "pending" users.

  - The user hasn't needed to log in to Viva Engage since the network started enforcing Microsoft 365 identity. That is, they're using Viva Engage regularly enough and with the same client that they've remained logged in since the network began enforcing identity.

  - The user could be a network-level guest in the network. Network-level guests aren't supported in Microsoft Entra ID.

- *What does the tool do for pending users?*
  The tool first tries to associate the pending user with an account in Microsoft Entra ID for your Microsoft 365 tenant. If that works, the user remains in the network. If the tool can't associate the pending user with a Microsoft Entra account on your tenant, the user is deleted from Viva Engage.  

### Why aren't external participants in individual conversations supported in Native Mode?

 This feature isn't currently compatible with the Azure B2B guest model. This feature isn't available for Viva Engage  networks that are in Native Mode or the [EU geo](/viva/engage/manage-security-and-compliance/manage-data-compliance).

## Groups

### What happens to my existing Yammer groups that are supported in Native Mode?

Existing Yammer groups will be connected to newly created M365 groups. These new Microsoft 365 groups won't follow any existing naming policy for Microsoft 365 group creation.

### What do I need to do to prepare my All Company community to be Microsoft 365 connected?

There's no preparation required to make your All Company community Microsoft 365 connected. The tool connects the community and assigns the Verified Admins for the network community as owners of the All Company community in Microsoft Entra ID. As community owners, they can post announcements in the All Company community, as they could before All Company was Microsoft 365 connected.

- *How is All Company different than other Microsoft 365-connected Groups?*

  The All Company community is different than other Viva Engage communities in that all users in the network are treated as members of the group whether or not they are actually a member of the group. Once All Company is connected, you can add members to the group from Microsoft Entra ID. However, we don't recommend that you add users as members because it won't change the behavior of the community in Viva Engage for those users.

- *Can I delete All Company once it's connected?*

  We don't recommend that you delete All Company, as it's an important channel for your users to communicate broadly across your organization. But after All Company is Microsoft 365 connected, you can delete the Microsoft 365 Group from the Microsoft 365 admin center or the Microsoft Entra admin center. In that case, Viva Engage will honor the deletion and not show All Company in your network.

- *Can I make All Company private once it's connected?*
  
   A private All Company is an unsupported state in Viva Engage. Also, we don't recommend that you make All Company private because it's an important channel for your users to communicate across your organization. After All Company is Microsoft 365 connected, you can make it private through the Microsoft 365 admin center or the Microsoft Entra admin center. In that case, Viva Engage won't show All Company in your network to anyone regardless of group membership.

### Why aren't external groups supported in Native Mode?

Because Viva Engage external groups aren't compatible with Azure B2B, guests in external groups in Viva Engage aren't associated with an account in Microsoft Entra ID for your Microsoft 365 tenant.

- *What should I do about my external groups?*

  The downloadable Alignment Report provides information about the use of external groups in your enterprise network so you can determine the best path forward for your organization. Many organizations already block creation of external groups in their network. Those companies won't be affected by this change.

  If your network has external groups, we recommend that you use the downloadable Alignment Report to see whether there are any external guests in the group, whether those guests had any recent activity, and whether the group itself had any recent activity. You can then assess what actions to take on the group. If the group has no external members but has had recent activity by internal members, you might decide to let the tool make that group an internal only group. If the group has external members but hasn't had any activity for some time, you might decide to delete the group before you run the tool.

  Whichever path you choose, we recommend that you communicate clearly to the owners of these groups what changes are coming so that they can alert you of possible problems. In some cases, these groups might be owned by senior leaders within your organization, so be sure to choose the appropriate communication channel when reaching out to group owners.

### How do unlisted private groups work?

- *Why can't I have unlisted private groups in Native Mode?*
  
   Microsoft Entra ID and Microsoft 365 Groups don't currently support unlisted private groups. If Viva Engage continued to support this feature in a Native Mode network, groups would be unlisted in Viva Engage. However, these groups would be exposed through other Microsoft 365 products. The downloadable Alignment Report provides information about the quantity and use of private unlisted groups in your network.

- *What should I do about my unlisted private groups?*
  
   The downloadable Alignment Report provides information about the use of private unlisted groups in your enterprise network so you can determine the best path forward for your organization.

  If your network has private unlisted groups, we recommend that you use the Alignment Report to see whether there are any users or guests in the group and whether those users or guests had any recent activity in the group. You can then assess what actions to take on the group. If the group has had recent activity but the group name doesn't contain any confidential or sensitive information, you might decide to let the tool make that group internal only. If the group hasn't had any activity for some time, you might decide to delete the group before you run the tool.

  Whichever path you choose, we recommend that you communicate clearly to the owners of these groups what changes are coming so that they can alert you of any problems. In some cases, these groups may be owned by senior leaders within your organization, so be sure to choose the appropriate communication channel when reaching out to group owners.  

### What happens to groups without owners who have Microsoft 365 group creation rights?

- *Why do you need to add the Yammer administrator who runs the Alignment Tool as a group owner in groups that have no owner with Microsoft 365 group creation rights?*

  This change is done for groups without any owners or groups with owners but none of whom have Microsoft 365 Group creation rights. To make a Viva Engage community or group a Microsoft 365-connected group, at least one group owner must have Microsoft 365 Group creation rights. Because Yammer administrators have Microsoft 365 Group creation rights, adding the Yammer administrator as a group owner helps ensure that the group can become Microsoft 365 connected.

- *What do I do about my groups without owners who have Microsoft 365 group creation rights?*

  The downloadable Alignment Report identifies groups in your enterprise network that don't have group owners who have group creation rights so that you can determine the best path forward for your organization. These groups include:

  - Groups that have no owners.
  - Groups whose owners don't have Microsoft 365 group creation rights.

  If your network has many of these groups, you have a few options available to you.

  - You can allow the tool to add the Yammer administrator who runs the tool to each group as an owner so that the group can become Microsoft 365 connected. After a group is connected, you can remove the Yammer Administrator from ownership of the group.
  
  - You can also review the impacted groups from the downloadable Alignment Report and see if they have any recent activity or active group members. If they don't, you might decide to delete those groups before you run the tool. After those groups have been deleted, you can run the tool. If you delete inactive groups before you run the tool, you reduce the number of groups to which you as a Yammer administrator need to be added to in order to achieve Native Mode.  

  - You can grant Microsoft 365 Group creation rights to all users in your organization or at least to the users that are owners of unconnected groups in Viva Engage, so that those groups can be connected without adding the Yammer administrator as an owner. After those groups are connected, you can choose whether to revoke group creation rights from those users who you granted access.

Whichever option you choose, we recommend that you communicate clearly to the users in your network of the changes that are coming so that they can alert you of any concerns or potential issues.
