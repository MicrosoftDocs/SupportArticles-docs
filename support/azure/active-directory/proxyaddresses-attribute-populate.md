---
title: How the proxyAddresses attribute is populated in Microsoft Entra ID
description: Describes how the proxyAddresses attribute is populated in Microsoft Entra ID. Provides example scenarios.
ms.date: 11/06/2023
ms.reviewer: "willfid,riantu,nualex,reviei"
ms.service: active-directory
ms.subservice: enterprise-users
---

# How the proxyAddresses attribute is populated in Microsoft Entra ID

This article describes how the proxyAddresses attribute is populated in Microsoft Entra ID and discusses common scenarios to help you understand how the proxyAddresses attribute is populated in Microsoft Entra ID.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3190357

[!INCLUDE [Feedback](../../includes/feedback.md)]

The proxyAddresses attribute in Active Directory is a multi-value property that can contain various known address entries. For example, it can contain SMTP addresses, X500 addresses, SIP addresses, and so on. When an object is synchronized to Microsoft Entra ID, the values that are specified in the mail or proxyAddresses attribute in Active Directory are copied to a shadow mail or proxyAddresses attribute in Microsoft Entra ID, and then are used to calculate the final proxyAddresses of the object in Microsoft Entra according to internal Microsoft Entra ID rules. The logic that populates mail, mailNickName and proxyAddresses attributes in Microsoft Entra ID is called proxy calculation and it takes into account many different aspects of the on-premises Active Directory data, such as:

- Set or update the Primary SMTP address and additional secondary addresses based on the on-premises ProxyAddresses or UserPrincipalName. 
- Set or update the Mail attribute based on the calculated Primary SMTP address.
- Set or update the MailNickName attribute based on the on-premises MailNickName or Primary SMTP address prefix.
- Discard on-premises addresses that have a reserved domain suffix, e.g. @\*.onmicrosoft.com, @\*.microsoftonline.com;
- Discard on-premises ProxyAddresses with legacy protocols like MSMAIL, X400, etc;
- Discard malformed on-premises addresses or not compliant with RFC 5322, e.g. missing protocol prefix "SMTP:", containing a space or other invalid character;
- Remove ProxyAddresses with a non-verified domain suffix, if the user is assigned an Exchange Online license.

Therefore, the values of the Mail and ProxyAddresses attributes for the object in Active Directory may not be the same as the values of the ProxyAddresses attribute in Microsoft Entra ID.

## Terminology

The following terminology is used in this article:

- Initial domain: The first domain provisioned in the tenant. For example, `Contoso.onmicrosoft.com`.
- Microsoft Online Email Routing Address (MOERA): The address constructed from the user's userPrincipalName prefix, plus the initial domain suffix, which is automatically added to the proxyAddresses in Microsoft Entra ID. For example, `smtp:john.doe@Contoso.onmicrosoft.com`.
- UserPrincipalName (UPN): The sign-in address of the user.
- Primary SMTP address: The primary email address of an Exchange recipient object, including the SMTP protocol prefix. For example, `SMTP:john.doe@Contoso.com`.
- Secondary smtp address: Additional email address(es) of an Exchange recipient object. For example, `smtp:john.doe@Contoso.com`.
- Mail attribute: Holds the primary email address of a user, without the SMTP protocol prefix. For example, `john.doe@Contoso.com`.
- MailNickName attribute: Holds the alias of an Exchange recipient object. For example, `john.doe`.

## Scenario 1: User doesn't have the mail, mailNickName, or proxyAddresses attribute set

You created an on-premises user object that has the following attributes set:

```
AD:mail              : \<not set>
AD:mailNickName      : \<not set>
AD:proxyAddresses    : {\<not set>}
AD:userPrincipalName : user1upn@Contoso.com
```

Next, it's synchronized to Microsoft Entra ID and only the mailNickName attribute is populated by using the prefix of the UPN, because it's a mandatory attribute:

```
AAD:mailNickName      : user1upn
AAD:UserPrincipalName : user1upn@Contoso.com
```

Then, it's assigned an Exchange Online license. In this scenario, the following operations are performed due to proxy calculation:

- Set the primary SMTP address in the proxyAddresses attribute by using the UPN value.
- Populate the mail attribute by using the primary SMTP address.
- Add the MOERA as a secondary smtp address in the proxyAddresses attribute, by using the format of mailNickName@initial domain.

The following attributes are set in Microsoft Entra ID on the synchronized user object with Exchange Online license:

```
AAD:mail              : user1upn@Contoso.com
AAD:mailNickName      : user1upn
AAD:proxyAddresses    : {smtp:user1upn@Contoso.onmicrosoft.com; SMTP:user1upn@Contoso.com}
AAD:userPrincipalName : user1upn@Contoso.com
```

> [!NOTE]
> When the user has an Exchange license assigned or the user is an Exchange Online recipient, such as a shared mailbox, the `userPrincipalName` is always added as a proxy address.



## Scenario 2: User doesn't have the mailNickName or proxyAddresses attribute set

You created an on-premises user object that has the following attributes set:

```
AD:mail              : user2mail@Contoso.com
AD:mailNickName      : \<not set>
AD:proxyAddresses    : {\<not set>}
AD:userPrincipalName : user2upn@Contoso.com
```

Next, it's synchronized to Microsoft Entra ID and the following operations are performed due to proxy calculation:

- Set the primary SMTP using the same value of the mail attribute.
- Populate the mailNickName attribute by using the primary SMTP address prefix.
- Populate the mail attribute by using the primary SMTP address.

The following attributes are set in Microsoft Entra ID upon initial user provisioning:

```
AAD:mail              : user2mail@Contoso.com
AAD:mailNickName      : user2mail
AAD:proxyAddresses    : {SMTP:user2mail@Contoso.com}
AAD:userPrincipalName : user2upn@Contoso.com
```

Then, it's assigned an Exchange Online license. In this scenario, the following operation is performed as a result of proxy calculation:

- Add the UPN as a secondary smtp address in the proxyAddresses attribute.
- Add the MOERA as a secondary smtp address in the proxyAddresses attribute, by using the format of mailNickName@initial domain.

The following attributes are set in Microsoft Entra ID on the synchronized user object with Exchange Online license:

```
AAD:mail              : user2mail@Contoso.com
AAD:mailNickName      : user2mail
AAD:proxyAddresses    : {smtp:user2upn@Contoso.com; smtp:user2mail@Contoso.onmicrosoft.com; SMTP:user2mail@Contoso.com}
AAD:userPrincipalName : user2upn@Contoso.com
```

## Scenario 3: You change the proxyAddresses attribute values of the on-premises user

You created an on-premises user object that has the following attributes set:

```
AD:mail              : \<not set>
AD:mailNickName      : \<not set>
AD:proxyAddresses    : {smtp:user3pa3@Fabrikam.microsoftonline.com, smtp:user3pa2@Contoso.onmicrosoft.com, SMTP:user3pa1@Contoso.com}
AD:userPrincipalName : user3upn@Contoso.com
```

Next, it's synchronized to Microsoft Entra ID and assigned an Exchange Online license. In this scenario, the following operation is performed as a result of proxy calculation:

- Discard addresses that have a reserved domain suffix. In this example, the following addresses are skipped:
  - `smtp:user3pa2@Contoso.onmicrosoft.com`
  - `smtp:user3pa3@Fabrikam.microsoftonline.com`
- Set the primary SMTP using the same address that's specified in the on-premises proxyAddresses attribute.
- Populate the mailNickName attribute by using the primary SMTP address prefix.
- Populate the mail attribute by using the primary SMTP address.
- Add the MOERA as a secondary smtp address in the proxyAddresses attribute, by using the format of mailNickName@initial domain.
- Add the UPN as a secondary smtp address in the proxyAddresses attribute.

The following attributes are set in Microsoft Entra ID on the synchronized user object:

```
AAD:mail              : user3pa1@Contoso.com
AAD:mailNickName      : user3pa1
AAD:proxyAddresses    : {smtp:user3upn@Contoso.com; smtp:user3pa1@Contoso.onmicrosoft.com; SMTP:user3pa1@Contoso.com}
AAD:userPrincipalName : user3upn@Contoso.com
```

Then, you change the values of the on-premises proxyAddresses attribute to the following ones:

```
AD:mail              : \<not set>
AD:mailNickName      : \<not set>
AD:proxyAddresses    : {smtp:user3new3@Fabrikam.microsoftonline.com, smtp:user3new2@Contoso.onmicrosoft.com, SMTP:user3new1@Contoso.com}
AD:userPrincipalName : user3upn@Contoso.com
```

In this scenario, the following operation is performed as a result of proxy calculation:

- Discard addresses that have a reserved domain suffix. For example, the following addresses are skipped:
  - `smtp:user3new2@Contoso.onmicrosoft.com`
  - `smtp:user3new3@Fabrikam.microsoftonline.com`
- Replace the new primary SMTP address that's specified in the proxyAddresses attribute.
- Update the mail attribute by using the value of the new primary SMTP address specified in the proxyAddresses attribute.
- Keep the old mailNickName since the on-premises mailNickName is not set nor its value have changed.
- Keep the old MOERA as a secondary smtp address in the proxyAddresses attribute.
- Keep the UPN as a secondary SMTP address in the proxyAddresses attribute.

The following attributes are set in Microsoft Entra ID on the synchronized user object:

```
AAD:mail              : user3new1@Contoso.com
AAD:mailNickName      : user3pa1
AAD:proxyAddresses    : {SMTP:user3new1@Contoso.com; smtp:user3upn@Contoso.com; smtp:user3pa1@Contoso.onmicrosoft.com}
AAD:userPrincipalName : user3upn@Contoso.com
```

## Scenario 4: Exchange Online license is removed

You created an on-premises user object that has the following attributes set:

```
AD:mail              : \<not set>
AD:mailNickName      : \<not set>
AD:proxyAddresses    : {\<not set>}
AD:userPrincipalName : user4upn@Contoso.com
```

Next, it's synchronized to Microsoft Entra ID and assigned an Exchange Online license. In this scenario, the following operation is performed as a result of proxy calculation:

- Set the primary SMTP address in the proxyAddresses attribute by using the UPN value.
- Populate the mailNickName attribute by using the primary SMTP address prefix.
- Populate the mail attribute by using the primary SMTP address.
- Add the MOERA as a secondary smtp address in the proxyAddresses attribute, by using the format of mailNickName@initial domain.

The following attributes are set in Microsoft Entra ID on the synchronized user object:

```
AAD:mail              : user4upn@Contoso.com
AAD:mailNickName      : user4upn
AAD:proxyAddresses    : {smtp:user4upn@Contoso.onmicrosoft.com; SMTP:user4upn@Contoso.com}
AAD:userPrincipalName : user4upn@Contoso.com
```

Then, you remove the Exchange Online license and the following operation is performed as a result of proxy calculation:

- Remove the primary SMTP address in the proxyAddresses attribute corresponding to the UPN value.
- Promote the MOERA from secondary to Primary SMTP address in the proxyAddresses attribute.
- Update the mail attribute by using the primary SMTP address in the proxyAddresses attribute(MOERA).

```
AAD:mail              : user4upn@Contoso.onmicrosoft.com
AAD:mailNickName      : user4upn
AAD:proxyAddresses    : {SMTP:user4upn@Contoso.onmicrosoft.com}
AAD:userPrincipalName : user4upn@Contoso.com
```

Then, you add a secondary smtp address in the on-premises proxyAddresses attribute:

```
AD:mail              : \<not set>
AD:mailNickName      : \<not set>
AD:proxyAddresses    : {smtp:user4new@Contoso.com}
AD:userPrincipalName : user4upn@Contoso.com
```

When the object is synchronized to Microsoft Entra ID, the following operation is performed as a result of proxy calculation:

- Add the secondary smtp address in the proxyAddresses attribute.
- Add the UPN as a secondary smtp address in the proxyAddresses attribute.

The following attributes set in Microsoft Entra ID on the synchronized user object:

```
AAD:mail              : user4upn@Contoso.onmicrosoft.com
AAD:mailNickName      : user4upn
AAD:proxyAddresses    : {smtp:user4upn@Contoso.com; smtp:user4new@Contoso.com; SMTP:user4upn@Contoso.onmicrosoft.com}
AAD:userPrincipalName : user4upn@Contoso.com
```

## Scenario 5: The mailNickName attribute value is changed

You created an on-premises user object that has the following attributes set:

```
AD:mail              : \<not set>
AD:mailNickName      : \<not set>
AD:proxyAddresses    : {\<not set>}
AD:userPrincipalName : user5upn@Contoso.com
```

Next, it's synchronized to Microsoft Entra ID and assigned an Exchange Online license. In this scenario, the following operation is performed as a result of proxy calculation:

- Set the primary SMTP address in the proxyAddresses attribute by using the UPN value.
- Populate the mailNickName attribute by using the primary SMTP address prefix.
- Populate the mail attribute by using the primary SMTP address.
- Add the MOERA as a secondary smtp address in the proxyAddresses attribute, by using the format of mailNickName@initial domain.

The following attributes are set in Microsoft Entra ID on the synchronized user object:

```
AAD:mail              : user5upn@Contoso.com
AAD:mailNickName      : user5upn
AAD:proxyAddresses    : {smtp:user5upn@Contoso.onmicrosoft.com; SMTP:user5upn@Contoso.com}
AAD:userPrincipalName : user5upn@Contoso.com
```

Then, you change the value of the on-premises mailNickName attribute to the following:

```
mail              : \<not set>
AD:mailNickName      : user5new1
AD:proxyAddresses    : {\<not set>}
AD:userPrincipalName : user5upn@Contoso.com
```

In this scenario, the following operation is performed as a result of proxy calculation:

- Update the mailNickName attribute by using the same value as the on-premises mailNickName attribute.
- Keep the mail attribute unchanged.
- Keep the proxyAddresses attribute unchanged.

The following attributes are set in Microsoft Entra ID on the synchronized user object:

```
AAD:mail              : user5upn@Contoso.com
AAD:mailNickName      : user5new1
AAD:proxyAddresses    : {smtp:user5upn@Contoso.onmicrosoft.com; SMTP:user5upn@Contoso.com}
AAD:userPrincipalName : user5upn@Contoso.com
```

## Scenario 6: Two users have the same mailNickName attribute

You created two on-premises user objects that have the same mailNickName value:

```
AD:mail              : \<not set>
AD:mailNickName      : user6mnn
AD:proxyAddresses    : {\<not set>}
AD:userPrincipalName : user6a@Contoso.com
```

```
AD:mail              : \<not set>
AD:mailNickName      : user6mnn
AD:proxyAddresses    : {\<not set>}
AD:userPrincipalName : user6b@Contoso.com
```

Next, they are synchronized to Office 365 and assigned an Exchange Online license. In this scenario, the following operation is performed as a result of proxy calculation:

- Set the primary SMTP address in the proxyAddresses attribute by using the UPN value.
- Populate the mailNickName attribute by using the same value as the on-premises mailNickName attribute.
- Populate the mail attribute by using the primary SMTP address.
- For the first user provisioned - Add the MOERA as the secondary smtp address in the proxyAddresses attribute, by using the format mailNickName@initial domain.
- For the second user provisioned, MOERA is already in use by another object - Add the MOERA as the secondary smtp address, by appending 4 random digits to the mailNickName as a prefix, plus @initial domain suffix.

The following attributes are set in Microsoft Entra ID on the synchronized user object:

```
AAD:mail              : user6a@Contoso.com
AAD:mailNickName      : user6mnn
AAD:proxyAddresses    : {smtp:user6mnn@Contoso.onmicrosoft.com; SMTP:user6a@Contoso.com}
AAD:userPrincipalName : user6a@Contoso.com
```

```
AAD:mail              : user6b@Contoso.com
AAD:mailNickName      : user6mnn
AAD:proxyAddresses    : {smtp:user6mnn5236@Contoso.onmicrosoft.com; SMTP:user6b@Contoso.com}
AAD:userPrincipalName : user6b@Contoso.com
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

