---
title: Cannot import trusted publishing domain from RMS Online
description: Describes an issue in which you receive an error message when you run try to import the trusted publishing domain from RMS Online. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: martinfu, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Unable to import a trusted publishing domain from RMS Online to Exchange Online

> [!NOTE]
> Microsoft Azure Information Protection was previously known as Microsoft Azure Rights Management.

_Original KB number:_ &nbsp; 3172063

## Symptoms

When you run the `Import-RMSTrustedPublishingDomain` command to import the trusted publishing domain (TPD) from RMS Online, you receive the following error message:

> InvalidLicense  
\+ CategoryInfo : NotSpecified: (:) [Import-RMSTrustedPublishingDomain], RightsManagementException  
\+ FullyQualifiedErrorId : [Server=*ServerName*,RequestId=*RequestId*,TimeStamp=\<Date>\<Time>] [Fa
ilureCategory=Cmdlet-RightsManagementException] 60EA2B3,Microsoft.Exchange.Management.RightsManagement.ImportRmsTrustedPublishingDomain  
\+ PSComputerName : `ps.outlook.com`

If you run the `Test-IRMconfiguration` command to test Information Rights Management (IRM) functionality and configuration, you receive the following error message:

> Results : Checking organization context ...  
> \- PASS: Organization context checked; running as tenant administrator.  
> Loading IRM configuration ...  
> \- PASS: IRM configuration loaded successfully.  
Checking RMS Online tenant prerequisites ...  
> \- PASS: RMS Online tenant prerequisites passed.  
Checking RMS Online authentication certificate ...  
> \- PASS: The RMS Online authentication certificate is valid.  
Checking that a Trusted Publishing Domain can be obtained from RMS Online ...  
> \- FAIL: Failed to obtain a Trusted Publishing Domain from RMS Online.  
> \----------------------------------------  
> Microsoft.Exchange.Security.RightsManagement.RightsManagementException: InvalidLicense  
at Microsoft.Exchange.Security.RightsManagement.Errors.ThrowOnErrorCode(Int32 hr, LocalizedString contextMessage)  
at Microsoft.Exchange.Security.RightsManagement.RmsTemplate.  GetTemplateNamesAndDescriptions(String template)  
at Microsoft.Exchange.Security.RightsManagement.RmsTemplate.ServerRmsTemplate.GetNameAndDescription(CultureInfo locale,
String& templateName, String& templateDescription)  
at Microsoft.Exchange.Security.RightsManagement.RmsTemplate.GetName(CultureInfo locale)  
at Microsoft.Exchange.Management.RightsManagement.RmsUtil.TemplateNamesFromTemplateArray(String[] templateXrMLArray)  
at Microsoft.Exchange.Management.RightsManagement.RMSOnlineValidator.ValidateTPDCanBeObtainedFromRMSOnline(RmsOnlineTpdI
mporter tpdImporter, TrustedDocDomain& tpd)  
\----------------------------------------  
OVERALL RESULT: FAIL

## Cause

This issue occurs if a template in Microsoft Azure Information Protection contains a semicolon (;) or colon (:).

## Resolution

Remove the semicolon or colon from the template in Azure Information Protection.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
