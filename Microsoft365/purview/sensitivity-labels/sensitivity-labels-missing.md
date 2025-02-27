---
title: Sensitivity labels are missing
description: Sensitivity labels are missing or the Sensitivity button isn't available when you try to apply the sensitivity labels.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sensitivity Labels
  - CI 165933
  - CI 193195
  - CSSTroubleshoot
ms.reviewer: sathyana, lindabr, gbratton, meerak, v-shorestris
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 08/01/2024
---

# Sensitivity labels are missing in Outlook, Outlook on the web, and other Office apps

<!-- This article has been reviewed and approved for the specific use of global admin perms.  -->

## Symptoms

You have configured sensitivity labels in the [Microsoft Purview compliance portal](https://compliance.microsoft.com/) to classify and protect user documents and email messages in your organization. When your users try to [apply the sensitivity labels](https://support.microsoft.com/office/apply-sensitivity-labels-to-your-files-and-email-in-office-2f96e7cd-d5a4-403b-8bd7-4cc636bae0f9) in Outlook, Outlook on the web, or other Office apps, the sensitivity labels are missing, or the **Sensitivity** button isn't available. 

For issues related to sensitivity labels, [run an automated diagnostic for sensitivity labels](#run-the-diagnostic-for-sensitivity-labels) in the Microsoft 365 admin center. The diagnostic analyzes the sensitivity labels, identifies any issues, and provides resolutions.

## Run the diagnostic for sensitivity labels

> [!NOTE]
> You must be a Microsoft 365 global administrator to run the diagnostic.

To run the diagnostic, follow these steps:

1. Select the following button to open the diagnostic in the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Sensitivity labels](https://aka.ms/PillarMipLabelDiag)

2. Enter the following information:

   - Label name
   - User principal name (UPN) or email address of the user

3. Select **Run Tests**.

If you ran the diagnostic but your issue isn't resolved, check the following article sections that provide resolutions for different clients.

## Outlook

This issue occurs for one or more of the following reasons:

- The user account that's signed in to Outlook isn't a Microsoft 365 subscriber.
- The security labels aren't [published](/microsoft-365/compliance/sensitivity-labels#what-label-policies-can-do) in the Microsoft Purview compliance portal.
- [The Outlook version](/microsoft-365/compliance/sensitivity-labels-office-apps#sensitivity-label-capabilities-in-outlook) doesn't support the built-in labeling.
- The label policy distribution process isn't successful.

### Resolution

To resolve this issue, use one or more of the following methods:

- Verify that the user account that's signed in to Outlook is a Microsoft 365 subscriber.
- Verify that the [sensitivity labels are published](/microsoft-365/compliance/create-sensitivity-labels#publish-sensitivity-labels-by-creating-a-label-policy) in the Microsoft Purview compliance portal.
- Verify that the Outlook version meets the requirements that are listed in [Sensitivity label capabilities in Outlook](/microsoft-365/compliance/sensitivity-labels-office-apps#sensitivity-label-capabilities-in-outlook).
- Verify that the label policy distribution is successful. To do this, run the following PowerShell cmdlet:

   ```powershell
   Get-labelpolicy -identity "Label_policy_name" | fl 
   ```

    If you see the following result in the output, this indicates that the distribution is successful.  

    ```output
    DistributionStatus      : Success
    ```

- Verify that the Outlook client is using built-in labeling. To do this, check the following registry subkey on the client computer:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Security\Labels`

    If the registry subkey is present, and the `UseOfficeForLabelling` value is set to **0**, this indicates that Outlook is using the AIP client instead of the built-in support for sensitivity labels. In this case, set the `UseOfficeForLabelling` value to **1** so that Outlook uses the built-in support for sensitivity labels.

- Reset Office built-in labeling by following these steps:

    1. Exit Outlook and all other Office apps.
    1. Navigate to the *%localappdata%\Microsoft\Office\CLP* directory. In this directory, the *\<domain.com>.policy.xml* file contains the information about the sensitivity labels that are assigned to the user profile.
    1. Rename the **CLP** folder. For example, rename it as *CLP_old*.
    1. Restart Outlook. Then, Outlook will connect or authenticate to the Microsoft Information Protection services and download the labels or policies.

## Outlook on the web

This issue occurs if the sensitivity labels are configured incorrectly. You can investigate this issue by using a [Fiddler or network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace) while you reproduce the issue. Here's an example of a Fiddler response. In the response, check whether the label policies are retrieved from the server.

:::image type="content" source="media/sensitivity-labels-missing/fiddler-trace-sample.png" alt-text="Screenshot of an example of a Fiddler response in which the label information is highlighted.":::

### Resolution 

Run the following cmdlets to check the sensitivity label configuration:

- ```powershell
  Get-label -identity "Label_name" | fl
  ```

  In the output, verify that the following properties are configured correctly:

  - `ContentType` contains **File** and **Email**.
  - `Disabled` is set to **False**.

- ```powershell
  Get-labelpolicy -identity "Label_policy_name" | fl
  ```

  In the output, verify that the following properties are configured correctly:

  - `Workload` contains **Exchange**.
  - `Mode` is set to **Enforce**.
  - One of the following properties is set:

    - `ExchangeLocation`
    - `ExchangeLocationException`
    - `ModernGroupLocation`
    - `ModernGroupLocationException`

    If `ExchangeLocation` is a distribution list or group, or if `ModernGroupLocation` is specified, make sure that the affected user is a member of the specified group.

If the sensitivity labels are configured incorrectly, you can reconfigure them by running the [Set-Label](/powershell/module/exchange/set-label) or [Set-LabelPolicy](/powershell/module/exchange/set-labelpolicy) PowerShell cmdlet or by following the steps in [create and configure sensitivity labels and their policies](/microsoft-365/compliance/create-sensitivity-labels).

## Other Office apps

This issue occurs for one or more of the following reasons:

- The user account that's signed in to the Office apps isn't a Microsoft 365 subscriber.
- The security labels aren't [published](/microsoft-365/compliance/sensitivity-labels#what-label-policies-can-do) in the Microsoft Purview compliance portal.
- There's no valid subscription to the Office edition.
- Office file types aren't supported.
- Office built-in labeling is turned off through Group Policy.
- The licenses aren't assigned to the affected users.

### Resolution

To resolve this issue, use one or more of the following methods:

- Verify that the user account that's signed in to the Office apps is a Microsoft 365 subscriber.
- Verify that the [sensitivity labels are published](/microsoft-365/compliance/create-sensitivity-labels#publish-sensitivity-labels-by-creating-a-label-policy) in the Microsoft Purview compliance portal.
- Verify that the Office app version meets the requirements that are listed in [Sensitivity label capabilities in Word, Excel, and PowerPoint](/microsoft-365/compliance/sensitivity-labels-office-apps#sensitivity-label-capabilities-in-word-excel-and-powerpoint).
- Verify that Office file types are supported for built-in labeling.
- Verify that the Office apps are using built-in labeling by checking the following registry subkeys:

  - `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Security\labels`
  - `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Common\Security\Labels`

  If these registry subkeys are present, and the `UseOfficeForLabelling` value is set to **0**, this indicates that the Office apps are prevented from using built-in labeling. In this case, set the `UseOfficeForLabelling` value to **1** to enable the Office apps to use built-in labeling.

- Verify that the appropriate licenses are assigned to the affected users per [Microsoft 365 guidance for security & compliance](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance).
- Check whether there are any [known issues that affect sensitivity labels in the Office apps](https://support.microsoft.com/office/known-issues-with-sensitivity-labels-in-office-b169d687-2bbd-4e21-a440-7da1b2743edc).
