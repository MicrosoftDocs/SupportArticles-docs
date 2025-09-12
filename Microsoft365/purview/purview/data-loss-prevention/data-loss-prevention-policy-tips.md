---
title: Resolve issues that affect DLP policy tips
description: Provides diagnostic information and resolutions for issues that cause DLP policy tips to not work.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: chgary, lindabr, sathyana, meerak, v-trisshores
ms.custom: 
  - sap:Data loss prevention (DLP)
  - CSSTroubleshoot
  - CI 100086
  - CI 160472
  - CI 191994
appliesto: 
  - Microsoft Purview Data Loss Prevention
ms.date: 05/05/2025
---

# Resolve issues that affect DLP policy tips

<!-- This article has been reviewed and approved for the specific use of global admin perms.  -->

If you encounter an issue that's related to Microsoft Purview Data Loss Prevention (DLP) policy tips, [run an automated diagnostic for DLP policy tips](#run-the-diagnostic-for-dlp-policy-tips) in the Microsoft 365 admin center. The diagnostic analyzes the DLP policy and rule configuration for policy tips, identifies any issues, and suggests resolutions.

## Run the diagnostic for DLP policy tips

> [!NOTE]
> To run the diagnostic, you must be a Microsoft 365 global administrator.

To run the diagnostic, follow these steps:

1. Select the following button to open the diagnostic in the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: DLP policy tips](https://aka.ms/PillarDLPPolicyTipsDiag)

2. Enter the following information:

   - User principal name (UPN) or email address of the user
   - DLP rule name or GUID
   - **Outlook** or **OWA** (Outlook on the web)

3. Select **Run Tests**.

If you ran the diagnostic but your issue isn't resolved, check the following sections of this article.

## DLP policies in Exchange Online

DLP policy tip settings are configured in DLP policies. If you created DLP policies in Exchange Online, we recommend that you [migrate them to the Microsoft Purview compliance portal](/microsoft-365/compliance/dlp-migrate-exo-policy-to-unified-dlp) because legacy Exchange Online data loss prevention in the Exchange admin center is being deprecated. For policies that aren't migrated, you might see unexpected results, such as no display of policy tips.

For more information, see [Policy tips in the Exchange admin center vs. the Microsoft Purview compliance portal](/purview/dlp-use-notifications-and-policy-tips#policy-tips-in-the-exchange-admin-center-vs-the-microsoft-purview-compliance-portal).

## Policy configuration errors

Policy is configured by using **User notifications**, but the status of the policy doesn't match the settings in the rule. Here's an example in which the policy is turned on but the policy status shows **Test it out first**.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/user-notifications.png" alt-text="Screenshot of user notifications.":::

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/policy-status.png" alt-text="Screenshot of the window titled Test or turn on the policy. The status titled Test it out first is highlighted in the policy status.":::

A policy configuration error might also occur if the policy is configured by using two or more rules that detect the same sensitive data types that have the same **Instance count** value and confidence level.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/ssn-rule.png" alt-text="Screenshot of SSN rule that is configured to have the detection based on sensitive info types.":::

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/ssn-content-rule.png" alt-text="Screenshot of SSN Content rule that is configured to have the detection based on sensitive info types.":::

This kind of setup is unnecessary and problematic. Only one rule is required.

### Resolution

For these scenarios, create only one rule, and use detecting parameters that are based on the same sensitive data types.

## Policy configurations not supported in Outlook 2013 and later versions

See [Outlook 2013 and later supports showing policy tips for only some conditions and exceptions](/microsoft-365/compliance/dlp-policy-tips-reference#outlook-2013-and-later-supports-showing-policy-tips-for-only-some-conditions-and-exceptions).

## Not all policy conditions are met

This scenario occurs primarily if policy tips don't work as expected in SharePoint in Microsoft 365 and Microsoft OneDrive for work or school because there's an external sharing condition that's configured in a policy.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/external-sharing-condition.png" alt-text="Screenshot shows that an external sharing condition is configured in a policy.":::

> [!NOTE]
> Currently, content is not indexed as shared externally until an external party that's located outside the organization accesses the content for the first time.

## MailTips aren't enabled (Outlook 2013 and later version clients only)

For Outlook 2013 and later version clients, make sure that MailTips are enabled. To enable MailTips in Outlook, first make sure that policy tips are enabled. To do this, follow these steps:

1. In Outlook, select **File** > **Options** > **Mail**.
1. Scroll to the **MailTips** section, and then select **MailTips Options**.
1. In the **Select MailTips to be displayed selection** dialog box, make sure that the **Policy tip notification** option is selected.
1. Under **MailTip bar display options**, make sure that the **Display automatically when MailTips apply** option is selected.
1. Select **OK** two times to close the File window.
1. Restart Outlook.

    :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/mail-tips-options.png" alt-text="Screenshot of steps that enable MailTips in Outlook.":::

## GetDLPPolicyTip call not found in Fiddler trace

If DLP policy tips don't work as expected, use a Fiddler trace to troubleshoot DLP policy tips.

1. Collect the Fiddler trace file when you reproduce the issue. Here's an example in which the DLP policy tip is triggered as expected.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/policy-tip-working.png" alt-text="Screenshot of a DLP policy tip working example when sending an email message.":::

1. In the POST request, check whether the `GetDLPPolicyTip` call is made in the trace file. For the previous example, you can see the `GetDLPPolicyTip` call.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/request.png" alt-text="Screenshot of a POST request in which the GetDLPPolicyTip call is highlighted.":::

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/request-headers.png" alt-text="Screenshot of POST request headers in which the GetDLPPolicyTip call is highlighted.":::

1. In the response, check the `DetectedClassificationIds` value. If the value field isn't empty, this indicates that the DLP policy matches the policy rule.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/response.png" alt-text="A screenshot of Response in which the DetectedClassificationIds value is highlighted.":::

If you don't find the `GetDLPPolicyTip` call, and if the `DetectedClassificationIds` value field is empty in the response, follow these steps to resolve this issue:

1. Check whether the DLP policy is enabled and configured correctly.
2. Check whether your users enter the correct sensitive information and valid recipients or senders to trigger the policy.

## Client doesn't support MailTips

There are several Outlook client licenses that don't support policy tips. [Outlook license requirements for Exchange features](https://support.microsoft.com/office/outlook-license-requirements-for-exchange-features-46b6b7c5-c3ca-43e5-8424-1e2807917c99) lists the Outlook client licenses that support DLP policy tips.

> [!NOTE]
> Policy tips are currently not supported for Outlook for Mac iOS clients. As a workaround, you can add text to the NDR response for your DLP policy rule that tells users to re-create their messages in the OWA client if they originally submitted the message by using Outlook for Mac. Use the OWA client to expose the policy tips functionality to users and enable them to override, report a false positive, or enter a business justification (depending on the "Notify" action that's specified in the DLP Policy rule). Users can then submit messages for delivery.

## File-system configuration not supported

No policy tip is displayed if the following conditions are true:

- You're running Outlook 2013 or later version clients on Windows 7.
- You try to attach a file that's formatted as Adobe PDF version 10 or later versions to an email message that should trigger a DLP policy tip.

### Resolution

To resolve this issue, carefully follow the steps in the "Resolution" section of [Outlook doesn't display DLP policy tips for PDF attachments in Windows 7](https://support.microsoft.com/help/3001881/outlook-doesn-t-display-dlp-policy-tips-for-pdf-attachments-in-windows).

## Invalid test data

When you evaluate the **Instance count** and confidence level of the DLP policy rule, the test data that's being used isn't valid based on [Sensitive information type entity definitions](/microsoft-365/compliance/sensitive-information-type-entity-definitions). Make sure that the test data that you use is valid.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/invalid-test-data.png" alt-text="Screenshot of an invalid instance count value.":::
