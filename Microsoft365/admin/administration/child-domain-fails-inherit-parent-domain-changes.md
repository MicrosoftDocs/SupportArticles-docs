---
title: A child domain doesn't inherit parent domain changes
description: Describes an issue in which changes that are made to a parent domain aren't inherited by the child domain in Office 365, Azure, or Microsoft Intune. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# A child domain doesn't inherit parent domain changes in Office 365, Azure, or Intune

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## PROBLEM

When you make a change to a parent (top-level) domain that's verified in Office 365, Microsoft Azure, or Microsoft Intune, a child domain that's also verified doesn't inherit the changes. This issue may occur when you do one of the following:

- Change the domain from standard to federated
- Change the domain from federated to standard
- Set domain authentication or federation configurations
- Update the domain Active Directory Federation Services (AD FS) relying party trust
- Verify domain ownership

## SOLUTION

To resolve this issue, delete the child domain, add and verify the parent domain, and then re-add the child domain.

> [!NOTE]
> After the parent domain is verified and the child domain is added, you don't have to verify the child domain because it inherits the settings (verification, authentication, and federation) from its parent.

## MORE INFORMATION

This issue may occur if the child domain is verified before the parent domain is verified. When the child domain is verified first, verification and its settings are managed independently of the parent domain.

For example, you verify the **corp.constoso.com** domain. Later, you verify the **contoso.com** domain. When you verify **corp.contoso.com**, and ownership is proven, the namespace is created in Office 365 as a domain that's completely independent of **contoso.com**. Therefore, when you later verify **contoso.com**, any changes that are made to this new domain don't affect **corp.contoso.com**.

In certain cases, you may want to manage the child domain properties independent of the parent domain.

## REFERENCES

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.