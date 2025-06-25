---
title: SharePoint Online Public Websites to be discontinued
description: This article contains information about changes to the SharePoint Online Public Websites feature in Microsoft 365.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Online Public Websites to be discontinued

## Introduction

This article contains information about changes to the SharePoint Online Public Websites feature in Microsoft 365. We will continue to update this article as more information becomes available.

## More information

On March 9, 2015, Microsoft made changes to the SharePoint Online Public Websites feature by removing the ability to create a public website after the changeover date of March 9, 2015. Customers who used this feature before March 9, 2015, were provided continued access to the feature for a minimum of two years. New customers who subscribed to Microsoft 365 after the changeover date of March 9, 2015, don't have access to this feature.

Moving forward, Microsoft 365 customers have access to industry-leading third-party offerings that let them have a public website that provides a complete online solution and presence. 

### What does this mean for existing Microsoft 365 customers?

The SharePoint Online Public Websites feature is primarily used by a small percentage of our Microsoft 365 customers for their own external-facing websites. Microsoft 365 customers who currently use the SharePoint Online Public Website feature will continue to have access to the feature for a minimum of two years after the changeover date of March 9, 2015.

**As of February 2017**, customers have had the ability in the SharePoint Admin Center to postpone the removal of their SharePoint Online public website, which would allow them to continue to use the site through March 31, 2018. Customers will continue to have the option of subscribing to third-party solutions for public website functionality. To postpone the site deletion through March 31, 2018, follow these steps:

1. Select Admin from the App Launcher.

1. Select Admin Centers.

1. Select SharePoint.

1. Select Settings.

1. Scroll to Postpone deletion of SharePoint Online public websites.

1. Select the I'd like to keep my public website until March 31, 2018 option.

   > [!NOTE]
   > Depending on your existing SharePoint experience, the steps may be slightly different. For example, you may not see the option to select Admin Centers.

   > [!NOTE]
   > Customers who have a Small Business subscription may not have access to the SharePoint Admin Center. Therefore, if a customer who has a Small Business subscription wants to postpone site deletion through March 31, 2018, they should contact Microsoft Support.

    - **Beginning May 1, 2017**, anonymous access for existing sites will no longer be available. If customers need more time to move their public website, they have a one-time postponement option for up to one year (March 31, 2018). Customers must select the postpone option by May 1, 2017.

       > [!IMPORTANT]
       > If your anonymous access was turned off but you want time for this functionality to remain, you first have to postpone deleting the SharePoint Online public websites by following the previous steps. Then, you can turn on anonymous access again by going to your public site (for example, http://\<DomainName>-public.sharepoint.com/_layouts/15/authenticate.aspx?Source=/) and then selecting **MAKE WEBSITE ONLINE** in the upper-right corner.
      >
      > If you can't postpone the deletion of the SharePoint Online public websites, you won't see the **MAKE WEBSITE ONLINE** button available in the upper-right corner.

       > [!NOTE]
       > In the URL path, replace \<DomainName> with your domain name.

     - On October 2, 2017, when Microsoft deletes the public site collection in SharePoint Online, customers will no longer have access to the content, images, pages, or any other files that reside on their public website. Before October 2, 2017, customers should make a backup copy of all their public website content, images, pages, and files, so that they don't lose this content permanently. 

       > [!NOTE]
       > Microsoft previously cited September 1, 2017, as the date when public site collections in SharePoint Online would be deleted. However, this has been postponed to October 2, 2017, and communicated to customers accordingly.

     - **On March 31, 2018**, Microsoft will delete all public sites that have been postponed.

     - Customers will see a banner at the top of their sites that states the following:

         "Reminder: this site will soon be unavailable. Click Here to learn more."
    
         The link in the banner points to this Knowledge Base article. The banner cannot be removed.

### What happens after your public website is deleted?

On October 2, 2017, when Microsoft deletes the public site collection in SharePoint Online, customers will no longer have access to the content, images, pages or any other files that reside on their public website. Customers can, however, recover their content through the Recycle Bin. To recover files from the Recycle Bin, follow [these instructions](https://support.office.com/article/6df466b6-55f2-4898-8d6e-c0dff851a0be).

> [!NOTE]
> When you delete an item from a site recycle bin, that item automatically goes into the [second-stage recycle bin](https://support.microsoft.com/office/manage-the-recycle-bin-of-a-sharepoint-site-8a6c2198-910e-42dc-9a9c-bc5bc4f327da) or site collection recycle bin, where it remains for approximately 30 days, after which it's completely purged from SharePoint.

### What does this mean for new Microsoft 365 customers?

After the changeover date of March 9, 2015, Microsoft no longer offers the SharePoint Online Public Website feature to new customers. New customers who subscribed to Microsoft 365 after the changeover date don't have access to this feature. Instead, there is an option to subscribe to third-party solutions by using links from within Microsoft 365.   

### How will this change be communicated to Microsoft 365 customers?

All Microsoft 365 administrators who have provisioned SharePoint Online received a notification of this change in the Microsoft 365 Message center. 

### Will Microsoft fix any new issues that affect existing public websites?

No.

### Why is Microsoft making this change?

As part of the evolution of the Microsoft 365 service, we periodically evaluate the capabilities of the service to make sure that we're delivering the utmost value to customers. After careful consideration, we concluded that for public websites, Microsoft 365 customers would be better served by third-party providers whose core competency is public websites. Therefore, we've made the difficult decision to discontinue the SharePoint Online Public Website feature so that we can focus our efforts and investments on delivering capabilities in Microsoft 365 that will bring more value to our customers.

### Overview of third-party offerings

You can migrate your SharePoint Online Public Website to a partner website. For more information, see [Switch from using a SharePoint Online public website to a partner-hosted website](https://support.office.com/article/cd0b5af5-d23f-4195-801e-145ec62604b3).

Please note that the process of migrating to an alternative solution is not supported by Microsoft support staff.

### Will customers or users lose any content while they make the transition?

All migration of content and data is a manual process and must be completed by the customer. To avoid disruption and data loss, customers should back up all content and data from the SharePoint Online Public Website feature before they switch to any new solution or service. This will minimize potential disruptions.

> [!NOTE]
> There are multiple ways to back up your public site data. One way is to follow steps 1-10 at [Switch from using a SharePoint Online public website to a partner-hosted website](https://support.office.com/article/cd0b5af5-d23f-4195-801e-145ec62604b3). These steps put a copy of your public website files in a specified location.

### Will Microsoft provide training content or documentation for these new offerings?

No. Content and documentation about these new offerings will be owned and managed by the third-party solution providers.

### Which countries/regions and languages are available?

Most of the Microsoft 365 customer base and underlying markets are supported.

### Whom do I contact for support for the third-party solutions?

Support is provided by the third-party solution providers and can be accessed by following your selected partner's existing support contact information. Review your selected partner's support page for contact details.

### Will the price for affected Microsoft 365 offers be reduced?

No. This change is aligned with our commitment to deliver a superior productivity experience in Microsoft 365 and won't affect the pricing of Microsoft 365. The third-party solutions are offered at discounted pricing rates for Microsoft 365 customers, where available.  

### Can I use other services, or do I have to use one of the third-party solution providers that Microsoft provides links for?

Customers can use any website hosting service and aren't limited to the third-party solutions that are provided in Microsoft 365. However, the third-party solutions that are available in Microsoft 365 are offered at discounted rates to Microsoft 365 customers, where available.  

### What if I'm using my Public Website to share content with anonymous users?

If you're using your Public Website for anonymous access to content and need an alternative solution for the future, go to [Share SharePoint files or folders](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) for more information about sharing content anonymously from your SharePoint Online sites.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
