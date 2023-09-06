---
title: The given key wasn't present in dictionary
description: Provides a solution to an error that occurs when you track an email in Microsoft Dynamics 365 for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# The given key was not present in the dictionary error occurs when you track an email in Microsoft Dynamics 365 for Outlook

This article provides a solution to an error that occurs when you track an email in Microsoft Dynamics 365 for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4010462

## Symptoms

When you attempt to track an email in Dynamics 365 for Outlook, you receive the following error:  

> "The given key was not present in the dictionary."  

If you select details, you see the following other details:  

> "The given key was not present in the dictionary.  
   at System.Collections.Generic.Dictionary2.get_item(Tkey key)  
   at Microsoft.Crm.AppIication.SMWrappers.AttachmentForOutIook.Get... clientOrganizationContext, IDynamicEntityCoIIectionForOutIook dynamicEntityCoIIectionAttachments)  
   atMicrosoft.Crm.AppIicationSMWrappers.EmaiIForOutIook.Microsoft.... messageld, String subject, String from, String to, String cc, String bcc, Double receivedon, String submitted8y, String importance, String body, IDynamicEntityCoIIectionForOutIook attachments, Int32 attachmentCount, IDynamicEntityForOutIook extraProperties, String entityXmI, String regardingld, Int64 regardingObjectType, String crmld, Int32& notification)"

## Cause

This error can occur for one of the following conditions:

1. The email includes an attachment that is larger than the size allowed in Dynamics 365.
2. The email includes an attachment with a file extension that is blocked by Dynamics 365.  

## Resolution

**Resolution 1**  
If the email includes an attachment that is over the size limit, either remove the attachment or increase the size of attachments that is allowed in Dynamics 365. The default maximum size is 5 MB.

If you have the System Administrator role in Dynamics 365, you can view and modify this setting by navigating to **Settings**, **Administration**, and then selecting **System Settings**. Select the **Email** tab, and locate the **Maximum file size (in kilobytes)** setting under the Set file size limit for attachments heading.

**Resolution 2**  
If the email includes an attachment with an extension that is blocked by Dynamics 365, either remove the attachment or modify which file extension is blocked by Dynamics 365.

If you have the System Administrator role in Dynamics 365, you can view and modify this setting by navigating to **Settings**, **Administration**, and then selecting **System Settings**. On the **General** tab, locate the setting **Set blocked file extensions for attachments**.
