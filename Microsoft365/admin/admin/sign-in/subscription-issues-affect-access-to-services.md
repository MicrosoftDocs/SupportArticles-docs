---
title: SharePoint service access affected by Microsoft 365 subscription issues
description: Describes and provides resolutions for issues that you might encounter when you access the SharePoint service in Microsoft 365.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365
ms.date: 06/26/2026
---

# SharePoint service access affected by Microsoft 365 subscription issues

## Summary

This article describes issues that might cause you to lose access to the SharePoint service. The issues might be related to your Microsoft 365 subscription. The article also provides resolutions to fix those issues.

## Symptoms

Your users see a banner on their SharePoint site that resembles the following example:

> **Your organization has been suspended.** All OneDrive and SharePoint content will be set to read-only on \<date\>. Please contact your IT department for more information.

As a SharePoint administrator, you see the following message in the SharePoint admin center:

> **Your organization has been suspended.** All OneDrive and SharePoint content will be set to read-only on \<date\>. Learn more about reasons that cause suspension and how to fix them.

After the date that’s specified in the banner, all the SharePoint sites in your organization become read-only, and you encounter the following issues:

- You can’t add or edit SharePoint sites and their files, or your OneDrive for work or school files.
- You can’t create SharePoint sites.
- You can’t share SharePoint and OneDrive files.
- You can’t sync files to the SharePoint service.

## Cause

Your SharePoint service is part of your Microsoft 365 subscription. Any change such as a missed payment, an expired license, a cancellation, or a security concern might affect your subscription. In this situation, your subscription is put into an **Expired** or **Disabled** state.

Most issues that affect the SharePoint service occur due to one of the following categories of changes that are related to your Microsoft 365 subscription:

- Payment or billing issues

  - The payment doesn’t go through.
  - Your credit card expires.
  - You have an unpaid invoice.

- Expired subscription

  - The subscription ends and isn’t renewed.

- Canceled subscription

  - An administrator cancels the subscription.
  - Recurring billing is turned off.
  - Licenses are unassigned.

- Subscription under security or compliance review

  - Fraudulent activity is suspected on the account.
  - The account is compromised.
  - Trade or export compliance checks are required.
  - The subscription is being abused.

If your Microsoft 365 subscription is in a suspended state for up to 90 days, SharePoint might delete your data permanently. Therefore, it’s important to take action as soon as possible. For information about Microsoft 365 data retention policies, see [Data retention, deletion, and destruction in Microsoft 365](/compliance/assurance/assurance-data-retention-deletion-and-destruction-overview).

## Resolution

To identify the cause of your specific issue, check the status of your subscription, and then follow the resolution steps that are provided for the issue. To access information about billing and invoices, you must be assigned at least the Billing administrator role.  
  
> [!IMPORTANT]
>
> If you don’t resolve the issue, your subscription will be deleted within 180 days after it’s suspended. After the subscription is deleted, it can’t be recovered, and your SharePoint and OneDrive data is removed permanently.

### Check subscription status

1. In the [Microsoft 365 admin center](https://admin.microsoft.com), navigate to **Billing** > **Your products**.
1. On the **Products** tab, select your subscription, and check the value in the **Subscription status** column.
1. Select the subscription to view detailed information about why it's expired or disabled.

After you identify the cause of the issue, resolve it by using the information in the appropriate section.

### Payment or billing issues

Subscriptions might enter a suspended state for nonpayment. Suspended subscriptions become limited in functionality, but they can still be restored. For more information, see [Manage Microsoft 365 payment information and billing for your business](https://support.microsoft.com/office/manage-microsoft-365-payment-information-and-billing-for-your-business-2cee1b18-51ed-4809-9b3c-2054199342d1).

To fix the issue, following these steps:

1. In the [Microsoft 365 admin center](https://admin.microsoft.com), navigate to **Billing** > **Bills & payments**.
1. Check whether you have an outstanding invoice or a payment method that’s out of date:
   - If you have an outstanding invoice, pay the outstanding balance.
   - If your payment method is out of date, update the payment method.

### Expired subscription

If your Microsoft 365 subscription ends and isn’t renewed, it might first be put into an **Expired** state, and then into a **Disabled** state. As a SharePoint administrator you can still access data from SharePoint sites during this time. That data is retained for up to 90 days after administrators lose access to the SharePoint service.

If you purchase the same product during this period, and assign at least one user to a SharePoint or OneDrive license, your SharePoint data, and license assignments might be restored automatically. For more information, see [What happens to my data and access when my Microsoft 365 for business subscription ends?](/microsoft-365/commerce/subscriptions/what-if-my-subscription-expires)

To fix the issue, follow these steps:

1. In the [Microsoft 365 admin center](https://admin.microsoft.com), navigate to **Billing** > **Your products**.
1. Select the subscription that's expired, and take one of the following actions:

- Turn on autorenew.
- Renew your subscription manually.
- Repurchase the same subscription.

Or, you can [reactivate your Microsoft 365 subscription](/microsoft-365/commerce/subscriptions/reactivate-your-subscription).

### Canceled subscription

After a Microsoft 365 subscription is canceled, it's put into the **Disabled** state for up to 60 days. During this time, your data is still accessible, administrators can back up SharePoint data, and you can restore the Microsoft 365 subscription by repurchasing the same product.

However, if you don’t act during this period, your subscription is deleted permanently within 180 days.

To fix the issue, follow these steps:

1. Repurchase the same Microsoft 365 subscription within 60 days of cancellation.
1. Reassign licenses to users.

### Security or compliance issue

If your Microsoft 365 subscription is under a security or compliance review, billing might be turned off, SharePoint access might be blocked, or we might require account verification before we restore access.

To fix the issue, use the following steps:

1. [Contact Microsoft Support](/microsoft-365/admin/get-help-support) by selecting **Help & support** at the bottom-right of the Microsoft 365 admin center page.
1. Complete the identity and compliance checks that Microsoft Support requests.

**Note**

If your organization has a dedicated account manager, work with your Microsoft account team.
