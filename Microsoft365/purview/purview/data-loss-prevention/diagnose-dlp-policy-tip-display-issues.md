---
title: Diagnose DLP policy tip issues by using the HAR diagnostic
description: Describes the process to troubleshoot the issue when the confiured DLP policy tips don't appear.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: pramkum, meerak
ms.custom: 
  - sap:Data loss prevention (DLP)
  - CSSTroubleshoot
  - CI 8652
appliesto: 
  - Microsoft Purview Data Loss Prevention
ms.date: 01/29/2026
---

# Diagnose DLP policy tip issues by using the HAR diagnostic

## Summary

This article describes how to diagnose an issue that occurs if the DLP policy tips that you configure either appear sporadically or never appear, or if incorrect tips appear in Outlook on the web. The article discusses how you can use the HTTP Archive (HAR) diagnostic to extract relevant information from a HAR trace and identify further checks that can help resolve the issue.

## The HAR diagnostic

When you compose or edit an email message, Outlook on the web calls the GetDlpPolicyTips service. This service checks the following information, and returns the results to Outlook on the web to display the appropriate policy tips:

- The text that you typed
- The recipients of the email message
- The DLP policies that apply to the email message

If the expected policy tips don’t appear, run the [HAR diagnostic](https://purview.microsoft.com/datalossprevention/diagnostics) that’s available in the Microsoft Purview portal.

The diagnostic helps you identify and resolve the issue by determining whether the issue occurs because:

- Policy tips aren’t enabled in DLP policy settings.
- The content in the email message in Outlook on the web doesn’t have any of the Sensitive Information Types (SITs) that are configured in DLP policies.
- Outlook on the web didn’t send a request to the GetDlpPolicyTips service to evaluate the content of the email message against the configured DLP policies.

### Collect a HAR trace

To run the HAR diagnostic, use your browser’s developer tools to collect an HAR trace. Run the trace while the issue that affects the policy tip display is occurring in Outlook on the web. For information about how to collect the trace, see [How to collect a network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace?utm_source=chatgpt.com#microsoft-edge-chromium).

> [!IMPORTANT]
>
>- Before you try to trigger the policy tip, start recording the HAR trace.
>- The size of the HAR trace must be less than 100 MB. This is the maximum file size that the HAR diagnostic accepts.

## Output of the HAR diagnostic

After you upload the HAR trace, the diagnostic checks for calls to the GetDlpPolicyTips service to extract the following information:

- **Sender and Recipient Info**<br/>
  Confirms whether the email participants are within the policy’s scope.

- **Policy Evaluation Result**<br/>
  Indicates whether the policy check succeeded or failed.

- **Detected Sensitive Information Types (SITs)**<br/>
  Lists the SITs in the email message, the number of their occurrences, and the confidence level of the SITs that matched DLP policy rules.

- **Evaluated Policies and Rules**<br/>
  Lists the DLP rules that were checked, and whether they matched.

The diagnostic provides an explanation of the results, and guidance for what to check next.

Here’s an example of the HAR diagnostic results.

Policy tip evaluation for the OWA client completed successfully

**There were 2 GetDlpPolicyTips calls found in the HAR trace. Please find the details of each call below.**

**Sender:** `XXX@contoso.onmicrosoft.com`

**Recipients:** `YYY@contoso.onmicrosoft.com`

**Evaluation Result:** Success*

**Detected SIT:**

**Summary:**<br/> None of the rules defined in the policy matched.

| Policy Name / Rule Name  | Is Rule Matched  |
|----|----|
| External sharing / Sensitive Information DLP policy|False |
| Default Endpoint DLP Policy Rule / Low Volume-Default policy for devices | False  |

**Sender:** `XXX@contoso.onmicrosoft.com`

**Recipients:** `YYY@contoso.onmicrosoft.com`, `ZZZ@contoso.onmicrosoft.com`

**Evaluation Result:** Success*

**Detected SIT:** Credit Card Number (Unique Count: 1 Total Count: 1 Confidence: 65)

**Summary:** Expected Policy Tip to be shown: 'Your email message conflicts with a policy in your organization.' from the rule 'External sharing-Sensitive Information DLP policy'.

|Policy Name / Rule Name| Is Rule Matched |
|----|----|
| External sharing / Sensitive Information DLP policy  | True  |
| Adaptive Protection audit rule for Teams and Exchange DLP / Adaptive Protection policy for Teams and Exchange DLP | True  |

## Interpret the HAR diagnostic results

The following examples explain the summary information that’s provided by the HAR diagnostic, and the steps that you can take to continue diagnosing the issue.

### Scenario 1: No DLP evaluation request found

**Summary:** The input file does not contain any GetDlpPolicyTips API calls.

**Explanation**:
Outlook on the web didn’t send a request to evaluate the content of the email message against the configured DLP policies.

**Next steps**:
Recapture the HAR trace, and contact Microsoft Support for help to resolve the issue.

### Scenario 2: Service error during evaluation

**Summary**: The GetDlpPolicyTips API returned evaluation result 8.

**Explanation**:
The back-end service encountered an error when it processed the DLP request.

**Next steps**:

Contact Microsoft Support for help to resolve the issue.

### Scenario 3: No DLP rules were triggered or a policy tip was expected but not shown

**Summary**: No matching rules found.

**Explanation:**
The content doesn’t meet the conditions of any active DLP policy. It might be close to matching, but it doesn’t meet one or more rule requirements.

**Check the settings for all applicable DLP policies:**

- To check the settings, go to [Microsoft Purview portal](https://purview.microsoft.com/) > **Data Loss Prevention** > **Policies** > **Edit Policy**.

    - Check whether the SITs that are used in the policy match any that are used in the draft email message.
    - Check whether the confidence levels that are set for the rules in the policy are strict. If yes, then update them, as appropriate.
    - Check whether the threshold for a match is set to a high value. If yes, then lower it, as appropriate.

- Verify that the policy is correctly published and assigned.

**Next steps**:

Check whether the issue still occurs. If it does, contact Microsoft Support for help to resolve the issue.
