---
title: How to troubleshoot Azure Information Protection policy issues
description: Discusses how to troubleshoot Azure Information Protection policy issues.
ms.date: 04/07/2022
ms.service: information-protection
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: 
ms.custom: sap:Protecting and opening content
---
# How to troubleshoot Azure Information Protection policy issues

Most policy issues in Microsoft Azure Information Protection are caused by configuration problems. The articles that are referenced in this troubleshooter can help you configure policies correctly.

_Original product version:_ &nbsp; Azure Information Protection  
_Original KB number:_ &nbsp; 4516523

## Service policy issues

### Recommended methods

- Check whether you are using scoped policies that aren't configured correctly. For more information, see [How to configure the Azure Information Protection policy for specific users by using scoped policies](/azure/information-protection/configure-policy-scope).
- If you still experience the issue after you review the recommended documentation, please [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), and attach a screenshot of the problem.

### Recommended documents

- [Review Azure Information Protection documentation](/azure/information-protection/what-is-information-protection)
- [How-to guides for common scenarios that use Azure Information Protection](/azure/information-protection/how-to-guides)
- [Configuring the Azure Information Protection policy](/azure/information-protection/deploy-use/configure-policy)
- [The default Azure Information Protection policy](/azure/information-protection/deploy-use/configure-policy-default)
- [How to create a new label for Azure Information Protection](/azure/information-protection/deploy-use/configure-policy-new-label)
- [How to configure a label for Rights Management protection](/azure/information-protection/deploy-use/configure-policy-protection)
- [Review Azure Information Protection subscriptions and features](https://azure.microsoft.com/services/information-protection/)
- [Requirements for Azure Information Protection](/azure/information-protection/get-started/requirements)
- [Quick start tutorial for Azure Information Protection](/azure/information-protection/get-started/infoprotect-quick-start-tutorial)

## Client policy issues

- If you have issues that affect visual markings, see [When visual markings are applied](/azure/information-protection/configure-policy-markings#when-visual-markings-are-applied).
- If you have issues that affect automatic labeling, see [How to configure conditions for automatic and recommended classification for Azure Information Protection](/azure/information-protection/configure-policy-classification)  and [What the sensitive information types look for](/office365/securitycompliance/what-the-sensitive-information-types-look-for).
- If you have issues that affect Native or Pfile protection, see [File API configuration](/azure/information-protection/develop/file-api-configuration).
- Check whether you are using scoped policies that aren't configured correctly. For more information, see [How to configure the Azure Information Protection policy for specific users by using scoped policies](/azure/information-protection/configure-policy-scope).
- If automatic labeling isn't working for Microsoft Outlook when you attach a labeled document, verify that **DRMEncryptProperty** isn't defined as described in the following article: [IRM registry settings for security](/deployoffice/security/protect-sensitive-messages-and-documents-by-using-irm-in-office#office-2016-irm-registry-key-options).
- If you still experience issues after you troubleshoot, please collect Azure Information Protection client logs, and then [create a support request](https://go.microsoft.com/fwlink/?linkid=2083458).

### Export Azure Information Protection logs

To export Azure Information Protection logs, follow these steps:

1. Open an Office document or create an email message in Outlook.
2. Select **Sensitivity**  > **Help and feedback**.
3. Select **Export Logs**.
4. Save the logs to the location of your choice in case you have to attach them to any service request.

- [Review Azure Information Protection documentation](/azure/information-protection/what-is-information-protection)
- [Review Azure Information Protection subscriptions and features](https://azure.microsoft.com/services/information-protection/)
- [Requirements for Azure Information Protection](/azure/information-protection/get-started/requirements)
- [Quick start tutorial for Azure Information Protection](/azure/information-protection/get-started/infoprotect-quick-start-tutorial)
- [Download Azure Information Protection client](https://www.microsoft.com/download/details.aspx?id=53018)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
