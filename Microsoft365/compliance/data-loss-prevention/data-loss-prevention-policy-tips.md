---
title: Issues with DLP policy tips
description: Describes how to troubleshoot some issues that occur if DLP policy tips are not working as expected.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-maqiu
ms.reviewer: chgary, lindabr, sathyana
ms.custom: 
- CSSTroubleshoot
- CI 100086
- CI 160472
appliesto:
- Microsoft 365 Data Loss Prevention
---

# Resolve issues with DLP policy tips

This article describes common scenarios in which Data Loss Prevention (DLP) policy tips don't work as expected, and it provides resolutions that you can try.

- There are policy configuration errors.
- Policy configurations are not supported (client only).
- All policy conditions are not met.
- MailTips are not enabled (client only).
- Policy tips are configured in both Exchange admin center and Microsoft 365 compliance center.
- The `GetDLPPolicyTip` call isn't found and the rule match is empty in the Fiddler Trace.
- The client doesn't support MailTips (Mac only).
- The file-system configuration is not supported (PDFs on Windows 7 only).
- There is invalid test data.

## Policy configuration errors

Policy is configured by using **User notifications**, but the status of the policy doesn't match the settings in the rule (Figure 1). A policy configuration error may also occur if the policy is configured by using two or more rules that detect the same sensitive data types that have the same **Instance count** value and confidence level (Figure 2). This kind of setup is unnecessary and problematic. Only one rule is required.

### Resolution

For these scenarios, create only one rule, and use detecting parameters that are based on the same sensitive data types.

**Figure 1:** Policy configuration by using **User notifications**

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/user-notifications.png" alt-text="Screenshot of User notifications.":::

Policy status

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/policy-status.png" alt-text="Screenshot of the option where test or turn on the policy you want to select.":::

**Figure 2:** Multiple rules configured to have the same detection based on Sensitive info types that share **Instance count** value and confidence level.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/ssn-rule.png" alt-text="Screenshot of SSN rule that is configured to have the detection based on Sensitive info types.":::

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/ssn-content-rule.png" alt-text="Screenshot of SSN Content rule that is configured to have the detection based on Sensitive info types.":::

## Policy configurations are not supported (Outlook 2013 and later clients only)

A policy is configured by using conditions and actions that are currently not supported in Outlook 2013 or later clients.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/policy-configurations.png" alt-text="Screenshot shows policy configurations aren't supported.":::

> [!NOTE]
> All these conditions and actions work in Outlook. They will match content and enforce protective actions on content. However, policy tips are not yet supported.

### Resolution

In Outlook, test conditions and actions that are supported in Outlook. Content matching and enforcement will still work.

## All policy conditions are not met

This reason primarily occurs if policy tips are not working as expected in SharePoint Online and OneDrive for Business because there's an external sharing condition that's configured in a policy.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/external-sharing-condition.png" alt-text="Screenshot shows an external sharing condition is configured in a policy.":::

> [!NOTE]
> Currently, content is not indexed as shared externally until an external party that's located outside the organization accesses the content for the first time.

## MailTips are not enabled (Outlook 2013 and later clients only)

For Outlook 2013 and later clients, make sure that MailTips are enabled. To enable MailTips in Outlook, make sure that policy tips are enabled. To do this, follow these steps:

1. In Outlook, select **File** > **Options** > **Mail**.
1. Scroll to the **MailTips** section, and then select **MailTips Options**.
1. In the **Select MailTips to be displayed selection** dialog box, make sure that the **Policy tip notification** option is selected.
1. Under **MailTip bar display options**, make sure that the **Display automatically when MailTips apply** option is selected.
1. Select **OK** two times to close the File window.
1. Restart Outlook.

    :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/mail-tips-options.png" alt-text="Screenshot of steps that enables MailTips in Outlook.":::

## Policy tips are configured in multiple locations

Policy tips don't work as expected if they're configured in multiple locations. You should configure or enable policy tips in only one of the following locations:

- Exchange admin center
- Microsoft 365 compliance center

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/rule-configuration.png" alt-text="Screenshot of Policy tip that sets notify a policy in Exchange admin center rule with the Action.":::

To view unified DLP policy tips in the Microsoft 365 compliance center, remove the **Notify the sender with a Policy Tip** action from all Transport rules in the Exchange admin center.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/remove-notify-sender.png" alt-text="Screenshot to remove the Notify the sender with a Policy Tip action.":::

> [!NOTE]
> If you have DLP policies in both the Exchange admin center (EAC) and the Microsoft 365 compliance center, it is recommended that you [migrate your DLP policies to Compliance Center](/microsoft-365/compliance/dlp-migrate-exo-policy-to-unified-dlp).

For more information about how to edit a DLP policy in the Exchange admin center, follow these steps:

1. In the Exchange admin center, locate **compliance management**, and then select **data loss prevention**.
1. Select the policy that requires editing, and then select the pencil icon or double-click the policy that has to be changed.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/open-policy-window.png" alt-text="Screenshot shows steps to open the policy window in the Exchange admin center.":::

1. In the window that opens, select the rule, and then select the pencil icon or double-click the rule that has to be changed.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/rules-section.png" alt-text="Screenshot to select pencil icon in rules section.":::

1. In the next window that opens, you can edit the rule.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/detailed-fields.png" alt-text="Screenshot to edit the detailed fields.":::

## The `GetDLPPolicyTip` call isn't found in Fiddler Trace

If DLP policy tips don't work as expected, Fiddler Trace is a useful tool to help you diagnose the issue. Here's how to use Fiddler Trace to troubleshoot DLP policy tips.

1. Collect the Fiddler Trace file when you reproduce the issue. Here's an example in which the DLP policy tip is triggered as expected.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/policy-tip-working.png" alt-text="A screenshot of DLP policy tip working example when sending an email message.":::

1. In the POST request, check if the `GetDLPPolicyTip` call is made in the Trace file. For the above example, you can see the `GetDLPPolicyTip` call.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/request.png" alt-text="A screenshot of POST request in which the GetDLPPolicyTip call is highlighted.":::

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/request-headers.png" alt-text="A screenshot of POST request headers in which the GetDLPPolicyTip call is highlighted.":::

1. In the Response, check the `DetectedClassificationIds` value. If the value isn't empty, it indicates that the DLP policy matches the policy rule.

   :::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/response.png" alt-text="A screenshot of Response in which the DetectedClassificationIds value is highlighted.":::

If you don't find the `GetDLPPolicyTip` call, and if the `DetectedClassificationIds` value is empty in the response, follow these steps to resolve this issue:

1. Check if the DLP policy is enabled and configured correctly.
2. Check if your users enter the proper sensitive information and valid recipients or senders to trigger the policy.

## Client doesn't support MailTips

There are several Outlook client licenses that don't support policy tips. [Outlook license requirements for Exchange features](https://support.microsoft.com/office/outlook-license-requirements-for-exchange-features-46b6b7c5-c3ca-43e5-8424-1e2807917c99) lists the Outlook client licenses that support DLP policy tips.

> [!NOTE]
> Policy tips are currently not supported for Outlook for Mac iOS clients. Although our Product Engineering teams know about this functionality gap between the Windows Outlook and Outlook for Mac clients, there's currently no set timeframe to add this functionality to a future release of Outlook for Mac. As a workaround, you can add text to the NDR response for your DLP policy rule that tells users to re-create their messages in the OWA client if they originally submitted the message by using Outlook for Mac. Use OWA client to expose the policy tips functionality to users and enable them to override, report a false positive, or enter a business justification (depending on the "Notify" action that's specified in the DLP Policy rule). Users can then submit messages for delivery.

## Windows 7 and Adobe PDF

No policy tip is displayed if the following conditions are true:

- You are running Outlook 2013 or later clients on Windows 7.
- You try to attach a file of Adobe PDF version 10 or later versions to an email message that should trigger a DLP policy tip.

### Resolution

To resolve this issue, carefully follow the steps in the "Resolution" section of [Outlook doesn't display DLP policy tips for PDF attachments in Windows 7](https://support.microsoft.com/help/3001881/outlook-doesn-t-display-dlp-policy-tips-for-pdf-attachments-in-windows).

## Invalid test data

When you evaluate the **Instance count** and confidence level of the DLP policy rule, the test data that's being used is not valid based on the information in [Sensitive information type entity definitions](/microsoft-365/compliance/sensitive-information-type-entity-definitions). Make sure the test data being used is valid.

:::image type="content" source="media/troubleshooting-data-loss-protection-policy-tips/invalid-test-data.png" alt-text="Screenshot of invalid Instance count value.":::

## References

- [Data loss prevention reference](/microsoft-365/compliance/data-loss-prevention-policies)
- [Send email notifications and show policy tips for DLP policies](/microsoft-365/compliance/use-notifications-and-policy-tips)
- [Migrate Exchange Online data loss prevention policies to Compliance center](/microsoft-365/compliance/dlp-migrate-exo-policy-to-unified-dlp)
