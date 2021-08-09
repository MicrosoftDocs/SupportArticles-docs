---
title: How to manage subdomains and parent domains in different organizations in Office 365, Azure, or Intune
description: Discusses how to manage subdomains and parent domains that are located in different organizations in Office 365, Azure, or Intune.
ms.date: 05/11/2020
ms.prod-support-area-path: 
ms.reviewer: vweiner
---

# How to manage subdomains and parent domains in different organizations in Office 365, Azure, or Intune

This article discusses how to manage subdomains and parent domains that are located in different organizations in Office 365, Azure, or Intune.

_Original product version:_ &nbsp; Azure Active Directory, Cloud Services (Web roles/Worker roles), Microsoft Intune  
_Original KB number:_ &nbsp; 3070341

## Summary

Consider the following scenario:

- You have one organization (for example, `Contoso.onmicrosoft.com`) in which you want to verify and federate a parent domain (for example, `Contoso.com`).
- You have another organization (for example, `Fabrikam.onmicrosoft.com`) in which you want to verify and federate a subdomain (for example, `Sales.contoso.com`) of the parent domain.

To manage the domains in this scenario, follow these steps in the order in which they're given:

1. Submit a support request to break the inheritance at [Azure Customer Support](https://ms.portal.azure.com/).
2. Verify and federate the subdomain.
3. Verify and federate the parent domain.

## More information

For more information, see the following resources:

- [Verify your custom domain in Azure AD](https://docs.microsoft.com/previous-versions/azure/jj151788(v=azure.100))
- [Verify your domain in Office 365](https://docs.microsoft.com/microsoft-365/admin/setup/add-domain?view=o365-worldwide&preserve-view=true)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums) website.
