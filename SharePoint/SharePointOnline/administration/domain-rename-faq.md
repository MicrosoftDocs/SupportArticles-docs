---
title: Frequently asked questions about SharePoint Domain renames
description: Answers questions about renaming a SharePoint domain.
author: helenclu
ms.reviewer: PramodBalusu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 158146
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
---

# Frequently asked questions about SharePoint Domain renames

This article has the answer to frequently asked questions about the SharePoint domain rename process.

In this article, 'contoso.onmicrosoft.com' is used as an example for the old domain name, while 'fabrikam.onmicrosoft.com' is used as an example for the new domain to which you want to change.

<details>
<summary><b>The new domain name is already taken by someone within my own organization. What can we do?</b></summary>

You need to contact that person in your organization and get the tenant deleted to free up the associated onmicrosoft domain.

</details>
<br/>
<details>
<summary><b>What are the steps to delete a tenant to free up a domain name that is already in use by another tenant? How long does it take?</b></summary>

For instructions and more information, see [Delete a tenant](/azure/active-directory/enterprise-users/directory-delete-howto).

</details>
<br/>
<details>
<summary><b>The new domain name is already in use and taken by a different organization. Is there any way we can use that domain name?</b></summary>

Microsoft doesn't disclose any information about the tenant that has your desired domain. Domains are taken on a first-come, first-serve basis. You'll need to choose a different domain name.  

</details>
<br/>
<details>
<summary><b>We already have 'fabikram.com' verified. Why do we need to verify 'fabikram.onmicrosoft.com' to rename our domain from 'contoso.sharepoint.com' to 'fabikram.sharepoint.com'? Can't you simply use fabikram.com to rename it?</b></summary>

To have all the SharePoint URLs renamed from 'contoso.sharepoint.com' to 'fabrikam.sharepoint.com', you must have the 'fabikram.onmicrosoft.com' domain verified.

</details>
<br/>
<details>
<summary><b>What happens to the old domain ('contoso.onmicrosoft.com') after the rename?</b></summary>

It's still tied to the tenant as the initial domain.  

</details>
<br/>
<details>
<summary><b>Can we change or remove the initial domain contoso.onmicrosoft.com from the tenant?</b></summary>

Currently, we don't support changing or removing the initial domain. It'll remain tied to the tenant.

</details>
<br/>
<details>
<summary><b>Can we roll back or rename back to our old name in case something goes wrong?</b></summary>

It's currently not supported. When the domain is renamed, we'll make sure issues are addressed and the SharePoint domain 'contoso.sharepoint.com' is renamed to the new name 'fabrikam.sharepoint.com'.

</details>
<br/>
<details>
<summary><b>Can we bypass the 24-hour minimum and 30 days maximum schedule time check?</b></summary>

No, you must schedule the rename for more than 24 hours and less than 30 days from the current time.  

</details>
<br/>
<details>
<summary><b>Can we rename a tenant more than once?</b></summary>

No, you can rename a tenant only once. If you need more renaming, submit a support request by selecting [Rename a Tenant more than once](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20more%20than%20once). 

</details>
<br/>
<details>
<summary><b>How long does the actual rename take?</b></summary>

It depends on the number of sites and how busy the service is at that time. A domain with 1,000 sites usually takes one to two hours to rename.

</details>
<br/>
<details>
<summary><b>How long does the site redirection last?</b></summary>

In the past, we haven't removed any redirected sites that were created as part of a tenant renaming, but this may change in the future. Site redirections will last for one year from the time your renaming is completed. Make sure to remove all URLs that use the old domain name during this time.

</details>
<br/>
<details>
<summary><b>What happens to our SharePoint and OneDrive data during the rename? Should we back everything up?</b></summary>

Backup of your data isn't required. We aren't making any changes to the actual data.

</details>
<br/>
<details>
<summary><b>Our third-party backup solutions are failing after the rename. How can we resolve this?</b></summary>

You'll need to contact the third-party backup providers to find out if they support the SharePoint Online Tenant rename action.

</details>
<br/>
<details>
<summary><b>Scheduling a rename using PowerShell isn't returning anything but zeros. What am I doing wrong?</b></summary>

The most common reason for this issue is that there are previous versions of SharePoint Online Management Shell installed on the machine and those assemblies cause this issue.

If you have any previous versions installed of the SharePoint Online Management Shell, uninstall them using the following command: 

'Uninstall-Module Microsoft.Online.SharePoint.PowerShell -Force -AllVersions'

Then install the latest version of the [SharePoint Online Management Shell](https://www.microsoft.com/download/details.aspx?id=35588).

</details>
<br/>
<details>
<summary><b>Should we tell the users to stop using SharePoint during the actual rename? When can they start using again?</b></summary>

The actual SharePoint Tenant rename doesn't lead to business downtime. However, it can cause brief interruptions if someone is trying to access an individual SharePoint site while it's being renamed as part of the domain rename. We recommend keeping user activity minimal while the rename is running.

</details>
<br/>
<details>
<summary><b>What happens to OneDrive sync during and after the domain rename?</b></summary>

While the rename is happening, the OneDrive sync might fail for a user if the rename process is renaming their OneDrive at the exact same time. We recommend stopping OneDrive sync before starting the rename, and then resume after. We understand it might not always be possible for all users to stop syncing their client during the rename.

</details>
<br/>
<details>
<summary><b>Some users are complaining that the OneDrive sync client is not working. What can we do?</b></summary>

If sync isn't stopped prior to the rename, there might be issues with OneDrive sync after the rename. This issue is due to the caching within the sync client. The users should sign out, and then sign back into OneDrive after the rename to resolve any sync issues. If that doesn't solve the problem, they should go to OneDrive > **Settings** > **Account** and select **Unlink this PC**, then re-link the PC. Unlinking and relinking doesn’t delete ay OneDrive data.

</details>
<br/>
<details>
<summary><b>I have more than 10,000 sites. When will my tenant be eligible for Tenant rename?</b></summary>

We're working on increasing the limits. We appreciate your patience.  

</details>
<br/>
<details>
<summary><b>What types of sites are considered when determining the total number of sites?</b></summary>

All sites are considered, including SharePoint, OneDrive, Teams, Channel, and Group connected sites.

</details>
<br/>
<details>
<summary><b>Will Exchange be affected by SharePoint domain rename?</b></summary>

No, only SharePoint and OneDrive URLs are renamed.

</details>
<br/>
<details>
<summary><b>Can we prioritize some sites to be renamed first when the job starts?</b></summary>

Currently, there is no way to prioritize specific sites to finish renaming first. The rename process will rename all sites and OneDrive's in a non-deterministic order.  

</details>

## References

- [Errors when you rename a SharePoint domain](./errors-when-renaming.md)

- [Rename your SharePoint domain](/sharepoint/tenant-rename)
