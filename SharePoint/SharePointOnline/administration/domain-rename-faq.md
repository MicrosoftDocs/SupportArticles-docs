---
title: Frequently asked questions about SharePoint Domain renames
description: Answers questions about renaming a SharePoint domain.
author: helenclu
ms.reviewer: PramodBalusu
ms.author: luche
manager: dcscontentpm
ms.date: 07/11/2024
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Domain Rename\Other
  - CSSTroubleshoot
  - CI 158146
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
---

# Frequently asked questions about SharePoint Domain renames

This article answers some frequently asked questions about the Microsoft SharePoint domain rename process.

In this article, "contoso.onmicrosoft.com" is used as an example of an old domain name, and "fabrikam.onmicrosoft.com" is used as an example of the new domain name that you want to change to.

<details>
<summary><b>The new domain name is already taken by someone within my own organization. What can we do?</b></summary>

Contact the other person to get the tenant deleted. This will free up the associated onmicrosoft domain name.

</details>
<br/>
<details>
<summary><b>How can I delete a tenant to free up a domain name that is already in use? How long does this take?</b></summary>

For instructions and more information, see [Delete a tenant](/azure/active-directory/enterprise-users/directory-delete-howto).

</details>
<br/>
<details>
<summary><b>The new domain name is already taken by a different organization. Can we still use that domain name?</b></summary>

Microsoft doesn't disclose any information about the tenant that has your desired domain name. Domains are taken on a first-come, first-served basis. You'll have to choose a different domain name.  

</details>
<br/>
<details>
<summary><b>We already have 'fabikram.com' validated. Why do we have to get 'fabikram.onmicrosoft.com' validated to be able to rename our domain from 'contoso.sharepoint.com' to 'fabikram.sharepoint.com'? Can't you simply use fabikram.com to rename it?</b></summary>

To have all the SharePoint URLs renamed from 'contoso.sharepoint.com' to 'fabrikam.sharepoint.com', you must have the 'fabikram.onmicrosoft.com' domain validated.

</details>
<br/>
<details>
<summary><b>What happens to the old domain ('contoso.onmicrosoft.com') after the rename?</b></summary>

The old domain remains tied to the tenant as the initial domain.  

</details>
<br/>
<details>
<summary><b>Can we change or remove the initial domain (contoso.onmicrosoft.com) from the tenant?</b></summary>

Currently, we don't support changing or removing the initial domain. It remains tied to the tenant.

</details>
<br/>
<details>
<summary><b>Can we roll back or revert to our old name in case something goes wrong?</b></summary>

This is currently not supported. As part of the renaming process, we make sure that any existing issues are addressed and the SharePoint domain 'contoso.sharepoint.com' is renamed to 'fabrikam.sharepoint.com' successfully.

</details>
<br/>
<details>
<summary><b>Can we bypass the 24-hour minimum and 30-day maximum rename schedule limits?</b></summary>

No, you must schedule the rename for more than 24 hours and less than 30 days from the current time.  

</details>
<br/>
<details>
<summary><b>Can we rename a tenant more than one time?</b></summary>

No, you can rename a tenant only one time. If you require an additional renaming, submit a support request by selecting [Rename a Tenant more than once](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20more%20than%20once). 

</details>
<br/>
<details>
<summary><b>How long does the actual renaming take?</b></summary>

It depends on the number of sites and how busy the service is at the time. An organization that has 1,000 sites usually takes one to two hours to rename. An organization that has 100,000 sites can take a few days to rename.

</details>
<br/>
<details>
<summary><b>How long does the site redirection last?</b></summary>

We haven't removed any redirected sites that were created as part of a tenant renaming. However, this may change in the future. Site redirections last for one year from the completion date of a renaming. During this period, make sure that you remove all URLs that use the old domain name.

</details>
<br/>
<details>
<summary><b>What happens to our SharePoint and OneDrive data during the renaming process? Should we back up all that data?</b></summary>

We don't make any changes to the actual data during a rename. Therefore, an additional backup isn't required.

</details>
<br/>
<details>
<summary><b>Our third-party backup solutions are failing after the rename. How can we resolve this?</b></summary>

Contact the third-party backup providers to determine whether they support the SharePoint Online Tenant rename action.

</details>
<br/>
<details>
<summary><b>Scheduling a rename by using PowerShell returns only zeros. What am I doing wrong?</b></summary>

The most common reason for this issue is that previous versions of SharePoint Online Management Shell are installed on the computer. In this case, uninstall any previous versions by running the following command: 

'Uninstall-Module Microsoft.Online.SharePoint.PowerShell -Force -AllVersions'

Then, install the latest version of the [SharePoint Online Management Shell](https://www.microsoft.com/download/details.aspx?id=35588).

</details>
<br/>
<details>
<summary><b>Should we tell users to stop using SharePoint during the renaming process? When can they start using SharePoint again?</b></summary>

The actual SharePoint Tenant rename doesn't cause business downtime. However, it can cause brief interruptions if someone is trying to access an individual SharePoint site while it's being renamed. We recommend that you take steps to minimize user activity while the rename is running.

</details>
<br/>
<details>
<summary><b>What happens to OneDrive sync during and after the domain rename?</b></summary>

During the rename, the OneDrive sync might fail for a user if the rename process is renaming their OneDrive site at the time of a resync operation. We recommend that all users stop syncing their clients during the rename, although we understand that this might not always be possible.

</details>
<br/>
<details>
<summary><b>Some users are complaining that the OneDrive sync client is not working. What can we do?</b></summary>

If OneDrive sync isn't stopped prior to the rename, issues might occur after the rename. This particular issue is caused by caching within the sync client. To resolve any sync issues, users should sign out and then sign back in to OneDrive after the rename. If this doesn't solve the issue, users should go to OneDrive > **Settings** > **Account**, select **Unlink this PC**, and then re-link the PC. Unlinking and relinking don't delete ay OneDrive data.

</details>
<br/>
<details>
<summary><b>I have more than 10,000 sites. When will my tenant be eligible for tenant rename?</b></summary>

If you have more than 10,000 sites, you must use Advanced Tenant Rename. This is available in SharePoint Advanced Management. Currently, Advanced Tenant Rename supports organizations that have up to 100,000 sites. We're working on increasing that limit further.

</details>
<br/>
<details>
<summary><b>What types of sites are considered in determining the total number of sites?</b></summary>

All sites are considered, including SharePoint, OneDrive, Teams, Channel, and Group-connected sites.

</details>
<br/>
<details>
<summary><b>Will Exchange Online be affected by a SharePoint domain rename?</b></summary>

No, only SharePoint and OneDrive URLs are renamed.

</details>
<br/>
<details>
<summary><b>Can we prioritize certain sites to be renamed first when the job starts?</b></summary>

If you want to prioritize some sites for the rename, you must use Advanced Tenant Rename. This is available in SharePoint Advanced Management. Advanced Tenant Rename enables you to prioritize up to 4,000 sites within your organization to be selected first for renaming when the job starts.

</details>

## References

- [Errors when you rename a SharePoint domain](./errors-when-renaming.md)
- [Change your SharePoint domain name](/sharepoint/tenant-rename)
