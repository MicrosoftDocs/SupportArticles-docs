---
title: Cannot create a DLP policy
description: Resolves an issue in which you receive an error message when you try to create a DLP policy in Exchange Server 2013.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jkabat, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# You cannot create a DLP policy in Exchange Server 2013

_Original KB number:_ &nbsp; 2769370

## Symptoms

In Exchange Server 2013, when you try to create a DLP policy from a template in some non-English locales (languages), you receive an error message that is similar to the following:

> Error while executing a script policy DLP. Most often, this error occurs because of an attempt to create more than one policy, based on the same template: crash when running the cmdlet New-TransportRule-name "Name": check letters of administration. Outside is great. number of "-DlpPolicy" fgddfgdfg "-SentToScope NotInOrganization-MessageContainsDataClassifications @ {Name =" Credit Card Number "; minCount =" 10 "}, @ {Name =" U.S. Bank Account Number "; minCount =" 10 "}, @ {Name =" U.S. your Individual Identification Number (ITIN); minCount = "10"}, @ {Name = "U.S. Social Security Number (SSN) minCount =" "; 10}-SetAuditSeverity High-NotifySender RejectUnlessExplicitOverride-RejectMessageReasonText" unable to deliver your message. To override this setting, add the word "override" in the subject line. " A positional parameter cannot be found that the argument ' override accepts in the subject line."

Additionally, the Chinese (Simplified and Traditional) and Norwegian locales are not localized correctly. These locales incorrectly contain English language text in DLP policy templates, descriptions, transport rule names, and content. This issue does not affect the classification definitions that are used in these locales. This issue only affects the data that is displayed in the EAC.

The following table contains more information about the affected languages:

|Language|Code|Number of affected templates|Number of affected templates that cannot be used to create DLPs|
|---|---|---|---|
|Arabic|ar-SA|40|All|
|Catalan|ca-ES|40|All|
|Croatian|hr-HR|40|All|
|Danish|da-DK|40|All|
|Estonian|et-EE|40|All|
|Persian|fa-IR|40|All|
|Hebrew|he-IL|8|U.S. Federal Trade Commission (FTC) Consumer Rules<br/><br/>U.S. Financial Data<br/><br/>U.S. Gramm-Leach-Bliley Act (GLBA)<br/><br/>U.S. Health Insurance Act (HIPAA)<br/><br/>U.S. Patriot Act<br/><br/>U.S. Personally Identifiable Information (PII) Data<br/><br/>U.S. State Breach Notification Laws<br/><br/>U.S. State Social Security Number Confidentiality Laws|
|Hungarian|hu-HU|40|All|
|Kannada|kn-IN|2|France Data Protection Act<br/><br/>Germany Personally Identifiable Information (PII) Data|
|Korean|ko-KR|1|All|
|Latvian|lv-LV|40|All|
|Lithuanian|lt-LT|40|All|
|Polish|pl-PL|40|All|
|Portuguese|pt-BR|1|Australia Personally Identifiable Information (PII) Data|
|Romanian|ro-RO|40|All|
|Russian|ru-RU|40|All|
|Slovak|sk-SK|40|All|
|Kiswahili|sw-KE|40|All|
|Swedish|sv-SE|40|All|
|Tamil|ta-IN|40|All|
|Ukrainian|uk-UA|40|All|
|Chinese (Simplified, PRC)|cn-ZH|40|All|
|Portuguese (Portugal)|pt-PT|40|All|
|Amharic (Ethiopia)|am-ET|40|All|

## Cause

This issue occurs because there are invalid characters in the localized part of the DLP policy templates.

> [!NOTE]
> The DLP content detection functionality is not affected by the invalid characters in the DLP policy templates.

## Resolution

To resolve this issue, follow these steps:

1. Install the updated DLP policy templates.
2. Run the following commands from Exchange Management Shell to import template. (In these commands, the file is saved to C:\Temp\KB12321321-OOB-dlpPolicyTemplates.xml.)

    ```powershell
    Get-dlppolicytemplate | foreach { Remove-DlpPolicyTemplate $_.Name -Confirm:$false}

    $template = Get-Content -Encoding byte -ReadCount 0 -Path C:\Temp\KB12321321-OOB-dlpPolicyTemplates.xml

    Import-DlpPolicyTemplate -FileData $template
    ```

> [!NOTE]
> This procedure first removes all the existing DLP policy templates from Exchange Server. If you have any custom DLP policy templates, you must save them and then reimport them to Exchange Server after you follow the procedure in this section.

## Workaround

To work around this issue, use a locale that is not listed in the table in the Symptoms section, such as English. This workaround creates templates that have English names, descriptions, and transport rules. However, this workaround does not affect the DLP content detection functionality. After you create the DLP policies from the templates, you can revert to the language that you want. After you revert to your original language, the template data remains in English.
