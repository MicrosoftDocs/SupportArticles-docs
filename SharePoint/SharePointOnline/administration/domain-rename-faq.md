---
title: "SharePoint Domain Rename FAQ: OneDrive, 404 Errors"
description: "SharePoint domain rename FAQ: Get answers about validating onmicrosoft.com domains, OneDrive sync, rename scheduling, and fixing 404 errors after a rename."
ms.reviewer: prbalusu
ms.date: 07/09/2026
audience: Admin
ms.topic: troubleshooting
ai-usage: ai-assisted
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

# Frequently asked questions about SharePoint domain renames

## Summary

This article answers frequently asked questions about the Microsoft SharePoint domain rename process. It covers topics such as validating the new onmicrosoft.com domain, deleting a tenant to free up a domain name, the effect on OneDrive and Exchange Online URLs, prioritizing sites with Advanced Tenant Rename, and 404 (Page Not Found) errors caused by cached bookmarks, Quick Access shortcuts, and shared links after a rename.

In this article, "contoso.onmicrosoft.com" is used as an example of an old domain name, and "fabrikam.onmicrosoft.com" is used as an example of the new domain name that you want to change to.

<details>
<summary><b>The new domain name is already taken by someone within my own organization. What can we do?</b></summary>

Contact the other person to get the tenant deleted. This action frees up the associated onmicrosoft domain name.

</details>
<br/>
<details>
<summary><b>How can I delete a tenant to free up a domain name that is already in use? How long does this take?</b></summary>

For instructions and more information, see [Delete a tenant in Microsoft Entra ID](/entra/identity/users/directory-delete-howto).

</details>
<br/>
<details>
<summary><b>The new domain name is already taken by a different organization. Can we still use that domain name?</b></summary>

Microsoft doesn't disclose any information about the tenant that has your desired domain name. Domains are taken on a first-come, first-served basis. You must choose a different domain name.  

</details>
<br/>
<details>
<summary><b>We already have 'fabikram.com' validated. Why do we have to get 'fabikram.onmicrosoft.com' validated to be able to rename our domain from 'contoso.sharepoint.com' to 'fabikram.sharepoint.com'? Can't you simply use fabikram.com to rename it?</b></summary>

To rename all the SharePoint URLs from 'contoso.sharepoint.com' to 'fabrikam.sharepoint.com', you must validate the 'fabikram.onmicrosoft.com' domain.

</details>
<br/>
<details>
<summary><b>What happens to the old domain ('contoso.onmicrosoft.com') after the rename?</b></summary>

The old domain remains tied to the tenant as the initial domain.  

</details>
<br/>
<details>
<summary><b>Can we change or remove the initial domain (contoso.onmicrosoft.com) from the tenant?</b></summary>

Currently, Microsoft doesn't support changing or removing the initial domain. It remains tied to the tenant.

</details>
<br/>
<details>
<summary><b>Can we roll back or revert to our old name in case something goes wrong?</b></summary>

This action is currently not supported. As part of the renaming process, Microsoft ensures that any existing issues are addressed and the SharePoint domain 'contoso.sharepoint.com' is renamed to 'fabrikam.sharepoint.com' successfully.

</details>
<br/>
<details>
<summary><b>Can we bypass the 24-hour minimum and 30-day maximum rename schedule limits?</b></summary>

No, you must schedule the rename for more than 24 hours and less than 30 days from the current time.  

</details>
<br/>
<details>
<summary><b>Can we rename a tenant more than one time?</b></summary>

No, you can rename a tenant only once. If you need to rename the tenant again, submit a support request by selecting [Rename a Tenant more than once](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20more%20than%20once). 

</details>
<br/>
<details>
<summary><b>How long does the actual renaming take?</b></summary>

The time depends on the number of sites and how busy the service is at the time. An organization that has 1,000 sites usually takes one to two hours to rename. An organization that has 100,000 sites can take a few days to rename.

</details>
<br/>
<details>
<summary><b>How long does the site redirection last?</b></summary>

The process doesn't remove any redirected sites that were created as part of a tenant renaming. However, this behavior might change in the future. Site redirections last for one year from the completion date of a renaming. During this period, make sure that you remove all URLs that use the old domain name.

</details>
<br/>
<details>
<summary><b>What happens to our SharePoint and OneDrive data during the renaming process? Should we back up all that data?</b></summary>

The rename process doesn't make any changes to the actual data. Therefore, an additional backup isn't required.

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

`Uninstall-Module Microsoft.Online.SharePoint.PowerShell -Force -AllVersions`

Then, install the latest version of the [SharePoint Online Management Shell](https://www.microsoft.com/download/details.aspx?id=35588).

</details>
<br/>
<details>
<summary><b>Should we tell users to stop using SharePoint during the renaming process? When can they start using SharePoint again?</b></summary>

The actual SharePoint Tenant rename doesn't cause business downtime. However, it can cause brief interruptions if someone is trying to access an individual SharePoint site while it's being renamed. Take steps to minimize user activity while the rename is running.

</details>
<br/>
<details>
<summary><b>What happens to OneDrive sync during and after the domain rename?</b></summary>

During the rename, the OneDrive sync might fail for a user if the rename process is renaming their OneDrive site at the time of a resync operation. All users should stop syncing their clients during the rename, although this action might not always be possible.

</details>
<br/>
<details>
<summary><b>Some users complain that the OneDrive sync client isn't working. What can we do?</b></summary>

If you don't stop OneDrive sync before the rename, problems might occur after the rename. This problem happens because of caching within the sync client. To fix any sync problems, users should sign out and then sign back in to OneDrive after the rename. If this step doesn't fix the problem, users should go to OneDrive > **Settings** > **Account**, select **Unlink this PC**, and then re-link the PC. Unlinking and relinking don't delete any OneDrive data.

</details>
<br/>
<details>
<summary><b>I have more than 10,000 sites. When will my tenant be eligible for tenant rename?</b></summary>

If you have more than 10,000 sites, you must use Advanced Tenant Rename. This feature is available in SharePoint Advanced Management. There's no upper limit on the number of sites. 

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

If you want to prioritize some sites for the rename, you must use Advanced Tenant Rename. This feature is available in SharePoint Advanced Management. Advanced Tenant Rename enables you to prioritize up to 4,000 sites within your organization to be selected first for renaming when the job starts.

</details>
<br/>
<details>
<summary><b>I'm receiving a 404 error when accessing bookmarks, Quick Access shortcuts, or shared file links that point to the old domain URL?</b></summary>

After a domain rename, some bookmarks, Quick Access entries, and shared links might continue to reference the old domain URL because of cached information. It can take up to 48 hours for these caches to refresh automatically. During this period, you might encounter a 404 **(Page Not Found)** error. As a workaround, try accessing the content by using the new domain URL. Once the updated URL is accessed, the cache is typically refreshed and subsequent access should work as expected.

</details>
<br/>

## References

- [Errors when you rename a SharePoint domain](./errors-when-renaming.md)
- [Change your SharePoint domain name](/sharepoint/tenant-rename)
