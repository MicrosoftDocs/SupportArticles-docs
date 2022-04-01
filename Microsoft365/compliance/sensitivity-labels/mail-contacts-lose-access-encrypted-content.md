---
title: Mail contacts lose access to encrypted content
description: A known issue for mail contacts in groups causes them to lose or have intermittent access to the encrypted content.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 162121
  - CSSTroubleshoot
ms.reviewer: cabailey
appliesto: 
  - Microsoft 365 (Enterprise, Business, Government, Education)
search.appverid: MET150
---

# Mail contacts in groups have intermittent access to encrypted content

## Symptoms

Consider the following scenario:  

- Content is encrypted by the Azure Information Protection service.
- Usage rights are assigned to a Microsoft 365 group that contains mail contacts.

In this scenario, these mail contacts might lose access to the content or have intermittent access to the content.

**Note:** A typical way to apply this encryption is to use sensitivity labels that are created and published from the Microsoft 365 compliance center.

## Cause

This issue occurs because there's a known issue for mail contacts in groups that are assigned usage rights.  

In this case, the mail contacts are users outside your organization and have an Azure Active Directory (AD) object type of **Contact** rather than **User**. In the Exchange admin center, these contacts display a **Contact Type** of **MailContact**.  

To confirm the object type for group members, use the following [Get-AzureADGroupMember](/powershell/module/azuread/get-azureadgroupmember) cmdlet:

```powershell
Get-AzureADGroupMember -ObjectId <ObjectID>| fl
```

**Note:** Replace \<ObjectID> with the affected group ID. To obtain the group ID, open the group from the [Azure portal](https://portal.azure.com/).

In the output, check if the `ObjectType` attribute displays **User** or **Contact** for each group member.

## Workaround

Add the users outside your organization as [guest users](/azure/active-directory/external-identities/add-users-administrator#add-guest-users-to-a-group) rather than mail contacts in the existing group that you have granted usage rights and access. Alternatively, specify the affected mail contacts directly rather than using the existing group.
