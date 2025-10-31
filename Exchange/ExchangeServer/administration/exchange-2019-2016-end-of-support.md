---
title: Exchange Server 2019 and 2016 End of Support Roadmap
description: A planning roadmap to prepare for upgrading to Exchange Online or a later version of Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
  - sap:migration
appliesto:
  - Exchange Server 2016
  - Exchange Server 2019
  - Exchange Server Subscription Edition
  - Microsoft 365 Enterprise
  - Office 365 Enterprise
ms.reviewer: ninob, johage, v-kccross
search.appverid: MET150
ms.date: 10/21/2025
---

# Exchange Server 2019 and 2016 end of support roadmap

Support for Exchange Server 2019 and 2016 ended on **October 14, 2025**. If you haven't already migrated from Exchange Server 2019 or 2016 to Microsoft 365, Office 365, or Exchange Server Subscription Edition (SE), now's the time to start planning.

## What does end of support mean?

Most Microsoft products have a support lifecycle during which they receive new features, bug fixes, security fixes, and so on. This lifecycle lasts for 7-10 years from the product's initial release.

The end of this lifecycle is known as the product's *end of support*. Because support for Exchange Server 2019 and 2016 ended on October 14, 2025, Microsoft no longer provides the following support for those products:

- Technical support for problems that might occur
- Bug fixes for issues that might affect the stability and usability of the server
- Security fixes for vulnerabilities that might make the server vulnerable to security breaches
- Time zone updates

Although your installation of Exchange Server 2019 or 2016 continues to run, we strongly recommend that you migrate from those versions as soon as possible.

## What are my options?

Upgrade your on-premises servers from Exchange Server 2019 or 2016 to Exchange Server SE. You have the following options:

- Migrate to Microsoft 365. Migrate mailboxes, public folders, and other data by using cutover, minimal hybrid, or full hybrid migration. Then, remove on-premises Exchange servers and Active Directory. For more information, see [How and when to decommission your on-premises Exchange servers in a hybrid deployment](/exchange/decommission-on-premises-exchange).

- Upgrade to a newer version of Exchange Server without transferring the source of authority to Microsoft 365. For more information, see [Manage recipients in Exchange Hybrid environments using Management tools](/exchange/manage-hybrid-exchange-recipients-with-management-tools).

> [!IMPORTANT]
> If your organization chooses to migrate mailboxes to Microsoft 365 but plans to keep using Microsoft Entra Connect to manage user accounts in Active Directory, you have to keep at least one Exchange server. If you remove all Exchange servers, you can't make changes to Exchange recipients in Exchange Online because the source of authority is your on-premises Active Directory. In this scenario, you have the following options:
>
> - (Recommended) Migrate your mailboxes to Microsoft 365 and upgrade your environment to Exchange Server SE. Use Exchange Server 2019 or 2016 to connect to Microsoft 365 and migrate the mailboxes. Next, upgrade from Exchange Server 2019 or 2016 to Exchange Server SE. Then, decommission servers that run Exchange Server 2019 or 2016.
>
> - Upgrade from Exchange Server 2019 or 2016 to Exchange Server SE. Then, use Exchange Server SE to migrate mailboxes to Microsoft 365.

The following sections discuss upgrade paths from Exchange Server 2019 or 2016.

## What are the advantages of migrating to Microsoft 365?

Migrating to Microsoft 365 is the best and simplest option to help you retire your Exchange Server 2019 or 2016 deployment. When you migrate to Microsoft 365, you make a single hop away from old technology, and benefit from new features, such as these:

- Larger mailboxes that have greater data resilience
- Security capabilities, such as anti-spam and anti-malware protection
- Compliance capabilities, such as Data Loss Prevention, Retention Policies, In-Place and Litigation Hold, In-Place eDiscovery, and so on
- Integration with SharePoint, OneDrive, Teams, Power BI, and other Microsoft 365 services
- Focused Inbox
- Advanced analytics and Viva Insights

Microsoft 365 also gets new features and experiences first, so your organization can start to use them right away. Also, you don't have to worry about any of the following items:

- Purchasing and maintaining hardware
- Paying to run and cool your servers
- Keeping servers up to date on security, product, and time-zone fixes
- Maintaining server storage and software to support compliance requirements
- Upgrading to a new version of Exchange, because you're always on the latest version with Microsoft 365

### How should I migrate to Microsoft 365?

Depending on your organization, you have a few options to get to Microsoft 365. You should consider a the following factors:

- The number of mailboxes that you want to move
- How long you want the migration to last
- Whether you want a seamless integration between your on-premises environment and Microsoft 365 during the migration

For guidance to choose the appropriate migration path for your organization, see [Decide on a migration path](https://support.office.com/article/Decide-on-a-migration-path-0d4f2396-9cef-43b8-9bd6-306d01df1e27).

## Why should I upgrade to a newer version of Exchange Server?

We strongly believe that you get the best value and user experience by migrating fully to Microsoft 365. But we understand that some organizations have to keep some  on-premises Exchange servers. You might have to maintain an on-premises environment for the following reasons:

- Regulatory requirements
- To guarantee that data isn't stored in a foreign datacenter
- Because you have unique settings or requirements that can't be met in the cloud
- Because you need Exchange Server to manage cloud mailboxes while you still use Active Directory on-premises

If you keep Exchange Server on-premises, you should upgrade your Exchange Server 2019 or 2016 deployment.

For the best experience, we recommend that you upgrade your remaining on-premises environment to Exchange Server SE.

- Your Exchange 2019 servers can be directly upgraded to Exchange SE "in place." Exchange SE is a cumulative upgrade to Exchange 2019. See the following Exchange Team Blog article: [Why "in-place upgrade" from Exchange 2019 to Exchange SE is low risk](https://techcommunity.microsoft.com/blog/exchange/why-%E2%80%9Cin-place-upgrade%E2%80%9D-from-exchange-2019-to-exchange-se-is-low-risk/4410173).
- Before Exchange SE CU2 releases, you can join an Exchange SE server to your Exchange 2016 servers or mixed 2019 and 2016 organization, and then upgrade or migrate in that manner.

The following Exchange Team Blog article discusses the exact migration paths for your on-premises servers to Exchange SE: [Upgrading your organization from current versions to Exchange Server SE](https://techcommunity.microsoft.com/blog/exchange/upgrading-your-organization-from-current-versions-to-exchange-server-se/4241305).

## What if I need help?

If you're migrating to Microsoft 365, you might be eligible to use our Microsoft FastTrack service. FastTrack provides best practices, tools, and resources to make your migration to Microsoft 365 as seamless as possible. Best of all, a support engineer walks you through from planning and design to migrating your last mailbox. For more information about FastTrack, see [Microsoft FastTrack](https://fasttrack.microsoft.com/).

If you don't use FastTrack, or you're migrating to a newer version of Exchange Server, here are some resources to help you resolve any issues that you might encounter during your migration to Microsoft 365:

[Technical community](https://social.technet.microsoft.com/Forums/office/home?category=exchangeserver)

[Customer support for small businesses](https://support.microsoft.com/gp/support-options-for-business)

## References

- [Exchange Deployment Assistant](/exchange/exchange-deployment-assistant)
- [Active Directory schema changes for Exchange Server SE](/exchange/plan-and-deploy/active-directory/ad-schema-changes)
- [System requirements for Exchange Server SE](/exchange/plan-and-deploy/system-requirements)
