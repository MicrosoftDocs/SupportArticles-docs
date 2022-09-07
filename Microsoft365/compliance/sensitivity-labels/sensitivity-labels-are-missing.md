---
title: Sensitivity labels are missing
description: Sensitivity labels are missing or the Sensitivity button is grayed out when you try to apply the sensitivity labels.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 165933
  - CSSTroubleshoot
ms.reviewer: sathyana, lindabr, gbratton
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 9/7/2022
---
# Sensitivity labels are missing in Outlook, Outlook on the web, and other Office apps

You have configured sensitivity labels in the [Microsoft Purview compliance portal](https://compliance.microsoft.com/) to classify and protect users' documents and email messages in your organization. When your users try to [apply the sensitivity labels](https://support.microsoft.com/office/apply-sensitivity-labels-to-your-files-and-email-in-office-2f96e7cd-d5a4-403b-8bd7-4cc636bae0f9) in Outlook, Outlook on the web, or other Office apps, the sensitivity labels are missing, or the **Sensitivity** button is grayed out. This article provides resolutions that you can try for different clients.

## Outlook

This issue occurs for one or more of the following reasons:

- The user account that's signed in to Outlook isn't a Microsoft 365 subscriber.
- The security labels haven't been [published](/microsoft-365/compliance/sensitivity-labels#what-label-policies-can-do) in the Microsoft Purview compliance portal.
- [The Outlook version](/microsoft-365/compliance/sensitivity-labels-office-apps#sensitivity-label-capabilities-in-outlook) doesn't support the built-in labeling
- The label policy distribution status isn't successful.

### Resolution

To resolve this issue, use one or more of the following methods:

- Verify that the user account that's signed in to Outlook is a Microsoft 365 subscriber.
- Verify that the [sensitivity labels are published](/microsoft-365/compliance/create-sensitivity-labels#publish-sensitivity-labels-by-creating-a-label-policy) in the Microsoft Purview compliance portal.
- Verify that the Outlook version meets the requirements that are listed in [Sensitivity label capabilities in Outlook](/microsoft-365/compliance/sensitivity-labels-office-apps#sensitivity-label-capabilities-in-outlook).
- Verify that the label policy distribution status is successful by running the following PowerShell cmdlet:

   ```powershell
   Get-labelpolicy -identity "Label_policy_name" | fl 
   ```

    If you see the following result in the output, it indicates that the distribution status is successful.  

    ```output
    DistributionStatus      : Success
    ```

- Verify that the Outlook client is using built-in labeling by checking the following registry key on the client computer:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Security\Labels`

    If the registry key is present and the `UseOfficeForLabelling` value is set to **0**, it indicates that Outlook is using the AIP client instead of the built-in support for sensitivity labels. In this case, set the `UseOfficeForLabelling` value to **1** so that Outlook uses the built-in support for sensitivity labels.

- Reset Office built-in labeling by following these steps:

    1. Exit Outlook and all other Office apps.
    1. Navigate to the *%localappdata%\Microsoft\Office\CLP* directory. In this directory, the *\<domain.com>.policy.xml* file contains the information of the sensitivity labels that are assigned to the user profile.
    1. Rename the **CLP** folder to a different name, such as *CLP_old*.
    1. Restart Outlook. Then, Outlook will connect or authenticate to the Microsoft Information Protection services and download the labels or policies.

## Outlook on the Web

This issue occurs if the sensitivity labels are configured incorrectly.

### Resolution 

Before you proceed, collect a Fiddler trace or [network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace) while you reproduce the issue. In the response, check whether the label policies are retrieved from the server. See the [sample Fiddler response](#sample-fiddler-response-working-trace) for more information.

Run the following cmdlet to check the sensitivity label configuration:

```powershell
Get-labelpolicy -identity "Label_policy_name" | fl
```

In the output, verify that the following properties are configured correctly:

- `ContentType` contains **File** and **Email**.
- `Workload` contains **Exchange**.
- `Disabled` is set to **False**.
- `Mode` is set to **Enforce**.
- One of the following properties must be set:

  - ExchangeLocation
  - ExchangeLocationException
  - ModernGroupLocation
  - ModernGroupLocationException

  If `ExchangeLocation` is a distribution list or group, or if `ModernGroupLocation` is specified, make sure that the affected user is a member of the specified group.

If the sensitivity labels are configured incorrectly, you can reconfigure them by running the [Set-LabelPolicy](/powershell/module/exchange/set-labelpolicy) PowerShell cmdlet or following the steps in [create and configure sensitivity labels and their policies](/microsoft-365/compliance/create-sensitivity-labels).

## Other Office apps

This issue occurs for one or more of the following reasons:

- The user account that's signed in to the Office apps isn't a Microsoft 365 subscriber.
- The security labels haven't been [published](/microsoft-365/compliance/sensitivity-labels#what-label-policies-can-do) in the Microsoft Purview compliance portal.
- There's no valid subscription to the Office edition.
- Office file types aren't supported.
- Office built-in labeling is turned off through a group policy.
- The licenses aren’t assigned to the affected users.

### Resolution

To resolve this issue, use one or more of the following methods:

- Verify that the user account that's signed in to the Office apps is a Microsoft 365 subscriber.
- Verify that the [sensitivity labels are published](/microsoft-365/compliance/create-sensitivity-labels#publish-sensitivity-labels-by-creating-a-label-policy) in the Microsoft Purview compliance portal.
- Verify that the Office app version meets the requirements that are listed in [Sensitivity label capabilities in Word, Excel, and PowerPoint](/microsoft-365/compliance/sensitivity-labels-office-apps#sensitivity-label-capabilities-in-word-excel-and-powerpoint).
- Verify that Office file types are supported for built-in labeling.
- Verify that the Office apps are using built-in labeling by checking the following registry keys:

  - `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Security\labels`
  - `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Common\Security\Labels`

    If these registry keys are present and the `UseOfficeForLabelling` value is set to **0**, it indicates that the Office apps are prevented from using built-in labeling. In this case, set the `UseOfficeForLabelling` value to **1** to enable the Office apps to use built-in labeling.

- Verify that the appropriate licenses are assigned to the affected users as per [Microsoft 365 guidance for security & compliance](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance).
- Check whether there are any [known issues with sensitivity labels in the Office apps](https://support.microsoft.com/office/known-issues-with-sensitivity-labels-in-office-b169d687-2bbd-4e21-a440-7da1b2743edc).

## Sample Fiddler response (working trace)

```http
{"Header":{"ServerVersionInfo":{"MajorVersion":15,"MinorVersion":20,"MajorBuildNumber":5566,"MinorBuildNumber":21,"Version":"V2018_01_08"}},"Body":{"__type":"CreateItemResponse:#Exchange","ResponseMessages":{"Items":[{"__type":"ItemInfoResponseMessage:#Exchange","Items":[{"__type":"Message:#Exchange","Sender":{"Mailbox":{"Name":"Testuser","EmailAddress":"Testuser@contoso.onmicrosoft.com","RoutingType":"SMTP","MailboxType":"Mailbox","SipUri":"sip:Testuser@contoso.onmicrosoft.com"}},"ItemId":{"__type":"ItemId:#Exchange","ChangeKey":"CQAAABYAAABrBOxWHHe9Sq2IXdyGrMCyAAUXau1X","Id":"AQMkAGNkNDI1ZjEzLTliNGQtNDY5Yy04OTQzLTQ5NjE2YWU2OGI1MABGAAADkY0PaoJBq0yBZ9Iz/yrNMwcAawTsVhx3vUqtiF3chqzAsgAAAgEPAAAAawTsVhx3vUqtiF3chqzAsgAFGI42aAAAAA=="},"ParentFolderId":{"__type":"FolderId:#Exchange","Id":"AQMkAGNkNDI1ZjEzLTliNGQtNDY5Yy04OTQzLTQ5NjE2YWU2OGI1MAAuAAADkY0PaoJBq0yBZ9Iz/yrNMwEAawTsVhx3vUqtiF3chqzAsgAAAgEPAAAA","ChangeKey":"AQAAAA=="},"ItemClass":"IPM.Note","IsReadReceiptRequested":false,"Subject":"","IsDeliveryReceiptRequested":false,"Sensitivity":"Normal","Importance":"Normal","Body":{"BodyType":"HTML","Value":"<html><head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><style type=\"text/css\" style=\"display:none\">\r\n<!--\r\np\r\n\t{margin-top:0;\r\n\tmargin-bottom:0}\r\n-->\r\n</style></head><body dir=\"ltr\"><div style=\"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)\"><br></div></body></html>","IsTruncated":false},"From":{"Mailbox":{"Name":"Testuser","EmailAddress":"Testuser@contoso.onmicrosoft.com,"RoutingType":"SMTP","MailboxType":"Mailbox","SipUri":"sip:Testuser@contoso.onmicrosoft.com"}},"IsDraft":true,"IsGroupEscalationMessage":false,"ExtendedProperty":[{"ExtendedFieldURI":{"__type":"ExtendedPropertyUri:#Exchange","PropertyTag":"0xe1d","PropertyType":"String"},"Value":""},{"ExtendedFieldURI":{"__type":"ExtendedPropertyUri:#Exchange","PropertyTag":"0x1016","PropertyType":"Integer"},"Value":"3"},{"ExtendedFieldURI":{"__type":"ExtendedPropertyUri:#Exchange","DistinguishedPropertySetId":"Common","PropertyName":"AppendOnSend","PropertyType":"String"},"Value":"[]"},{"ExtendedFieldURI":{"__type":"ExtendedPropertyUri:#Exchange","DistinguishedPropertySetId":"Common","PropertyName":"ComposeType","PropertyType":"String"},"Value":"newMail"},{"ExtendedFieldURI":{"__type":"ExtendedPropertyUri:#Exchange","DistinguishedPropertySetId":"InternetHeaders","PropertyName":"msip_labels","PropertyType":"String"},"Value":"MSIP_Label_495946ac-a8bb-4851-a0a3-900f24f28468_Enabled=True;MSIP_Label_495946ac-a8bb-4851-a0a3-900f24f28468_SiteId=c3de5e2d-b382-4e2a-94aa-91ffa28e58cc;MSIP_Label_495946ac-a8bb-4851-a0a3-900f24f28468_SetDate=2022-08-29T11:48:46.033Z;MSIP_Label_495946ac-a8bb-4851-a0a3-900f24f28468_Name=LabelLab;MSIP_Label_495946ac-a8bb-4851-a0a3-900f24f28468_ContentBits=0;MSIP_Label_495946ac-a8bb-4851-a0a3-900f24f28468_Method=Privileged;"}],"LastModifiedTime":"2022-08-29T17:18:48+05:30","ConversationId":{"__type":"ItemId:#Exchange","Id":"AAQkAGNkNDI1ZjEzLTliNGQtNDY5Yy04OTQzLTQ5NjE2YWU2OGI1MAAQACOQP/M7q6lDu7Us5hRMeaI="},"Apps":[]}],"ResponseCode":"NoError","ResponseClass":"Success"}]}}} 
```
