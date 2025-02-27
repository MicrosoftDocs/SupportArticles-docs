---
title: Mail contacts lose access to encrypted content
description: A known issue in groups causes mail contacts to lose access or have intermittent access to encrypted content.
ms.date: 05/05/2022
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sensitivity Labels
  - CI 162121
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.reviewer: cabailey
appliesto: 
  - Microsoft 365 (Enterprise, Business, Government, Education)
search.appverid: MET150
---

# Mail contacts in groups have intermittent access to encrypted content

## Symptoms

Consider the following scenario:  

- You're working with some content that's encrypted by the Azure Information Protection service.
- Usage rights are assigned to a group that contains mail contacts.

In this scenario, the mail contacts lose access to the encrypted content or have only intermittent access to the content.

**Note:** A typical way to apply this encryption is to use sensitivity labels that are created and published from the Microsoft Purview compliance portal.

## Cause

This issue occurs because of a known issue that affects mail contacts in groups that are assigned usage rights.  

In this case, the mail contacts are users outside your organization who have a Microsoft Entra object type of **Contact** instead of **User**. In the Exchange admin center, these contacts display a **Contact Type** of **MailContact**.

To verify the object type for group members, run the following [Get-AzureADGroupMember](/powershell/module/azuread/get-azureadgroupmember) cmdlet:

```powershell
Get-AzureADGroupMember -ObjectId <ObjectID>| fl
```

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

**Note:** In this cmdlet, replace \<_ObjectID_> with the affected group ID. To obtain the group ID, open the group from the [Azure portal](https://portal.azure.com/). In the output, check whether the `ObjectType` attribute displays **User** or **Contact** for each group member.

## Workaround

Add users who are outside your organization as [guest users](/azure/active-directory/external-identities/add-users-administrator#add-guest-users-to-a-group) instead of as mail contacts in the existing group that you have granted usage rights and access to. Alternatively, specify the affected mail contacts directly instead of using the existing group.
