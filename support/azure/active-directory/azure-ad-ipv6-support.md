--- 
title: IPv6 Support in Azure AD
description: Bringing IPv6 support to Azure Active Directory
ms.service: active-directory
ms.subservice: aad-general
ms.date: 11/22/2022
ms.author: v-kegui
author: kelleyguiney22
ms.reviewer: lhuangnorth, gautama, amycolannino, joflore
ms.collection: M365-identity-device-management
---

# IPv6 Support in Azure Active Directory

We're excited to bring IPv6 support to Azure Active Directory (Azure AD), to support customers with increased mobility, and help reduce spending on fast-depleting, expensive IPv4 addresses. For more information about how this change might affect Microsoft 365, see [IPv6 support in Microsoft 365 services](/microsoft-365/enterprise/ipv6-support).

If your organization's networks don't support IPv6 today, you can safely ignore this information until such time that they do.

## When will IPv6 be supported in Azure AD?

We'll begin introducing IPv6 support to Azure AD in late March 2023.

We know that IPv6 support is a significant change for some organizations. We're publishing this information now so that customers can make plans to ensure readiness.

## Support

If you have questions about this change or need help, we invite you to create a support request, or ask Azure community support.

## What does my organization have to do?

As Microsoft plans the rollout of IPv6 into Azure AD, we want to share changes that you might notice. These changes include some advantages and some changes you must make.

Customers who use Conditional Access location-based policies to restrict and secure access to their apps from specific networks have to:

- Identify egress IPv6 addresses in use in your organization
- [Create or update named locations, to include their identified IPv6 addresses](/azure/active-directory/conditional-access/location-condition#ip-address-ranges)

Customers who have invested in Azure AD Identity Protection, using user and sign-in risk policies, will automatically benefit from the introduction of IPv6 to Azure AD.

### Azure AD B2C

Customers who [add Conditional Access to user flows in Azure Active Directory B2C](/azure/active-directory-b2c/conditional-access-user-flow?pivots=b2c-user-flow#add-a-conditional-access-policy) can follow the same process to [create or update named locations to include their identified IPv6 addresses](/azure/active-directory/conditional-access/location-condition#ip-address-ranges).

## Next steps

We'll keep this article updated. Here's a short link you can use to come back for updated and new information: [https://aka.ms/azureadipv6](https://aka.ms/azureadipv6).

- [Using the location condition in a Conditional Access policy](/azure/active-directory/conditional-access/location-condition)
- [Conditional Access: Block access by location](/azure/active-directory/conditional-access/howto-conditional-access-policy-location)
- [Find help and get support for Azure Active Directory](/azure/active-directory/fundamentals/how-to-get-support)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)] 

