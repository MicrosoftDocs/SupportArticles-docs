---
title: Analyze Endpoint DLP Diagnostic Logs
description: Discusses how to analyze the endpoint DLP diagnostic logs collected by the MDE Client Analyzer tool.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:EndPoint DLP
  - Microsoft Purview
  - CSSTroubleshoot
  - CI 1213
ms.reviewer: managrawal, sathyana, meerak, v-shorestris
appliesto:
  - Microsoft Purview
search.appverid: MET150
ms.date: 05/05/2025
---

# Analyze endpoint DLP diagnostic logs

You can troubleshoot common [endpoint data loss prevention](/purview/endpoint-dlp-learn-about) (DLP) issues by analyzing endpoint DLP diagnostic logs. This article provides step-by-step instructions for analyzing the endpoint diagnostic logs that are collected by the MDE Client Analyzer tool.

> [!TIP]
> For additional resources to troubleshoot endpoint DLP issues, see [Troubleshoot and manage DLP for endpoint devices](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/troubleshoot-and-manage-microsoft-purview-data-loss-prevention/ba-p/4077992).

## Prerequisite 

Follow the steps in [Collect endpoint DLP diagnostic logs](collect-endpoint-dlp-diagnostic-logs.md) to generate the **MDEClientAnalyzerResult_\<ID\>** folder that contains the diagnostic logs for the scenario that you're investigating.

## Analyze the diagnostic logs

Follow these steps:

1. Open the **MDEClientAnalyzerResult_\<ID\>\MDEClientAnalyzer.htm** file in your browser. The file contains the following information:

   - General device details
   - Device configuration details
   - Microsoft Defender antivirus component details
   - Endpoint detection and response (EDR) component details 

   The following screenshot shows an excerpt of the file contents.

   :::image type="content" source="media/analyze-endpoint-dlp-diagnostic-logs/results-html.png" border="true" alt-text="Screenshot of the MDE Client Analyzer results page." lightbox="media/analyze-endpoint-dlp-diagnostic-logs/results-html.png":::

2. Review the following information in **MDEClientAnalyzer.htm**:

   - Check for an outdated Windows build:

     1. Find the **OS build number** value in the **Device Information** \> **General Device Details** section.

     2. Extract the third and fifth numeric segments of the **OS build number** to generate a short build number. For example, if the **OS build number** value is `Microsoft Windows NT 10.0.22631.0.4249`, the short build number is `22631.4249`.

     3. Look up the short build number in [Windows 10 release information](/windows/release-health/release-information) or [Windows 11 release information](/windows/release-health/windows11-release-information) to determine when the build was released. If the build was released more than six months ago, update Windows.

   - Check whether the device is joined to the Exchange Online tenant. To do this, find the **Domain Joined**, **Azure AD Joined**, and **Workplace Joined** values in the **Device Information** \> **Device Configuration Management Details** section. For DLP to work, the value of **Azure AD Joined** or **Workplace Joined** must be `YES`. If only the value of **Domain Joined** is `YES`, the user isn't joined to the Exchange Online tenant and DLP can't function.

   - Check the **Device ID** value in the **Device Information** \> **Configuration Management Details** section. If the value is blank, then Microsoft Defender for Endpoint (MDE) isn't correctly installed on the device and you should reinstall MDE.

   - Check for other errors and warnings in the **Detailed Results** section. If you find errors or warnings, follow the instructions in that section to fix each issue.

     **Note**: You can ignore a `Stopped` value for **Defender Network Protection Service** and **Defender Network Protection Driver** because DLP doesn't use network protection.

3. In a text editor, open the **MDEClientAnalyzerResult_\<ID\>\DLP\FileEAs.txt** file. **FileEAs.txt** contains file classification information. The following screenshot shows an excerpt of the file content.

   :::image type="content" source="media/analyze-endpoint-dlp-diagnostic-logs/fileeas-enforce-policy-rules.png" border="true" alt-text="Screenshot of FileEAs.txt content that shows the Enforce PolicyRuleIds section." lightbox="media/analyze-endpoint-dlp-diagnostic-logs/fileeas-enforce-policy-rules-lrg.png":::

4. Check for **Enforce PolicyRuleIds** and **Test PolicyRuleIds** sections in **FileEAs.txt**. These sections list the policy rules that you, as a customer, created. The sections exist based on the following criteria:

   - The **Test PolicyRuleIds** section exists if one or more customer-created policy rules apply to the protected document, and those policies are in [simulation mode](/purview/dlp-simulation-mode-learn).

   - The **Enforce PolicyRuleIds** section exists if one or more customer-created policy rules apply to the protected document, and those policies are in enforced mode (not simulation mode).

   - The **Enforce PolicyRuleIds** and **Test PolicyRuleIds** sections aren't included if no customer-created policy rules apply to the protected document. For more information, see [No customer-created policy rules apply](#no-customer-created-policy-rules-apply).

   If the **Enforce PolicyRuleIds** or **Test PolicyRuleIds** section exists, perform the following checks on the DLP policy rules that are listed under each section:

   1. Verify that all customer-created DLP policy rules that you expected to run are listed. Each listed policy rule is represented by a set of **PolicyName**, **RuleName**, and **Actions** values.

   2. Verify the JSON-formatted **Actions** value for each policy rule. The following example is an excerpt of an **Actions** value:

      ```json
      "CopyToClipboard": {  
        "EnforcementMode": 0  
      },  
      "CopyToNetworkShare": {  
        "EnforcementMode": 1  
      },  
      "CopyToRemovableMedia": {  
        "EnforcementMode": 1,  
        "EnforcementOverrides": [ {  
              "EnforcementMode": 2,  
              "GroupId": "b2e7d50c-69f9-447d-b669-d1199a2c2fc4"  
          }, {  
              "EnforcementMode": 3,  
              "GroupId": "f94c6d6e-aa74-42f2-9ba1-e54cca015882"  
          } ]  
      },  
      "PasteToBrowser": {  
        "EnforcementMode": 0  
      },
      ```

      Use the following information to interpret an **Actions** value:

      - The numeric values for **EnforcementMode** are described in the following table.

        | | Mode | Description |
        |-|-|-|
        | **0** | Off | The user action isn't audited or blocked. |
        | **1** | Audit | The user action is only audited. End user activity isn't affected.  |
        | **2** | Warn | The user action is audited and blocked. The user receives a warning prompt that allows them to override the block. |
        | **3** | Block | The user action is audited and blocked. |
        | **4** | Allow | The user action is allowed. This mode is used only if [just-in-time (JIT) protection](/purview/endpoint-dlp-get-started-jit) is enabled and you enabled the JIT protection setting, **Allow users to complete action**, in Microsoft Purview. |

        For user actions in the **Actions** value that have an **EnforcementOverrides** section, the IDs of the groups that are affected by the **EnforcementMode** override are listed in that section. For more information about a group, search for the **GroupId** value in the following files:

        - **MDEClientAnalyzerResult_\<ID\>\DLP\dlpWebSitesPolicy.json**: This file defines any service domain groups.

        - **MDEClientAnalyzerResult_\<ID\>\DLP\dlpActionsOverridePolicy.json**: This file defines any printer, network share, or removable media groups.

        - **MDEClientAnalyzerResult_\<ID\>\DLP\dlpPolicy.json**: This file defines any other groups.

      - If multiple policy rules apply to a protected document, DLP enforces the most restrictive DLP actions across those rules.

   3. If a customer-created DLP policy rule that you expected to run isn't listed under the **Enforce PolicyRuleIds** or **Test PolicyRuleIds** section, check the following values in **FileEAs.txt**:

      - **RMS** status: If the **RMS** status value is `0x1`, the protected file has a password or is encrypted. DLP can't evaluate password-protected or encrypted files.

      - **InfoTypes**: The JSON-formatted **InfoTypes** value lists the sensitive information types (SITs) that DLP found in the protected file based on rules in Microsoft Purview. Each SIT has the following key parameters:

        - **DN**: The SIT name. For example, this might be `Credit card number`, `Diseases`, or a custom SIT.

        - **DI**: The SIT identifier (GUID).

        - **UC**: The number of unique instances of the SIT that DLP found in the file.

        - **CL**: [Confidence level](/purview/sit-sensitive-information-type-learn-about#more-on-confidence-levels).

        If the expected customer-created rule has a SIT condition, check whether the SIT is listed in the **InfoTypes** value. If the SIT isn't listed, run a [SIT test](/purview/sit-test-a-sit#test-the-effects-of-a-sensitive-information-type) on the protected file. Depending on the result of the SIT test, select one of the following options:

        - If the SIT test doesn't detect the expected SIT, [troubleshoot the SIT](/purview/sit-test-a-sit) instead of troubleshooting endpoint DLP.

        - If the SIT test detects the expected SIT, check the **Advanced Classification** value, as described in the next list item.

      - **Advanced Classification**: If the **Advanced Classification** value is `FALSE`, DLP doesn't use [advanced classification](/purview/dlp-configure-endpoint-settings#advanced-classification-scanning-and-protection). Therefore, it can't detect the following types of SITs:

        - [Exact data match](/purview/sit-learn-about-exact-data-match-based-sits)
        - [Trainable classifiers](/purview/trainable-classifiers-get-started-with#get-started-with-trainable-classifiers)
        - [Credential classifiers](/purview/sit-defn-all-creds#all-credentials-sensitive-information-types)
        - [Named entities](/purview/named-entities-learn)

        If the expected customer-created rule has a SIT condition that is one of these types, make sure that the **Advanced classification scanning and protection** endpoint setting is enabled in the Microsoft Purview portal.

        > [!IMPORTANT]
        > Advanced classification works on only .docx, .pptx, .xlsx, and .pdf files. For more information about supported file types and size limits, see [Advanced classification scanning and protection](/purview/dlp-configure-endpoint-settings#advanced-classification-scanning-and-protection).

      - **Labels**: The JSON-formatted **Labels** value lists the sensitivity labels that DLP found in the protected file based on rules in Microsoft Purview. If the expected customer-created rule has a sensitivity label condition, the label is listed in the **Labels** value. The following example shows a **Labels** value:

        ```json
        Labels: [ {  
            "ActionId": "121e3902-61a1-47b6-9eb7-92b0f4796c4f",  
            "Id": "0e8d6320-3c74-4ac7-80b2-e3c4602d117a",  
            "Name": "Confidential",  
            "SiteId": "f13af1ad-f604-40be-b63f-919c10918b35"  
          }, {  
            "ActionId": "fc03e59c-6586-4e0a-afc9-d6d67233020e",  
            "Id": "6cd985b2-09ac-46ff-9b9a-790b2ac26274",  
            "Name": "Confidential Anyone",  
            "SiteId": "f13af1ad-f604-40be-b63f-919c10918b35"  
          }, {  
            "ActionId": "c358ef44-e58c-4a3b-9723-19d9505ffcb9",  
            "Id": "7df4683d-45d4-4b3b-814b-bf379532ff4d",  
            "Name": "Confidential Recipients Only",  
            "SiteId": "06502b6a-8593-4b22-bee1-59e2eb260647"  
          } ]
          ```

      - **ClassificationTime**: The **ClassificationTime** value records the last time that DLP locally evaluated the protected file. If you haven't updated your DLP policies recently, edit the protected file to trigger a classification update.

### No customer-created policy rules apply

If no customer-created policy rules apply to a protected document, DLP activates one of the following built-in policy rules:

- **DefaultRule**: For file types that are [audited](/purview/endpoint-dlp-learn-about#files-audited-regardless-of-policy-match), DLP runs this rule. The **Actions** value for the `DefaultRule` is determined by the following criteria:

  - If the endpoint setting, **Always audit file activity for devices setting**, is enabled in Microsoft Purview, the **EnforcementMode** value for all user actions, except **PasteToBrowser**, is `1` (Audit). The **EnforcementMode** value for the **PasteToBrowser** action is `0` (Off).

  - If the endpoint setting **Always audit file activity for devices setting** is disabled in Microsoft Purview, the **EnforcementMode** value for all user actions is `0` (Off).

- **NoMatchRule**: For file types that aren't [audited](/purview/endpoint-dlp-learn-about#files-audited-regardless-of-policy-match), DLP runs this rule.

- **CandidateRule**: DLP runs this rule immediately after a user action on a protected file if [JIT protection](/purview/endpoint-dlp-get-started-jit) is enabled in Microsoft Purview. The rule blocks the user action until JIT protection evaluates the protected file to determine the applicable DLP policies. The **EnforcementMode** value for all user actions in the **Actions** value is `3` (Block).

If DLP activates a built-in policy rule, that rule is listed in the **Single Policy** section of **FileEAs.txt**, as shown in the following screenshot.

:::image type="content" source="media/analyze-endpoint-dlp-diagnostic-logs/fileeas-single-policy.png" border="true" alt-text="Screenshot of FileEAs.txt content that shows the Single Policy section." lightbox="media/analyze-endpoint-dlp-diagnostic-logs/fileeas-single-policy-lrg.png":::
