---
title: How the proxyAddresses attribute is populated in Azure AD
description: Describes how the proxyAddresses attribute is populated in Azure AD. Provides example scenarios.
ms.date: 05/09/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# How the proxyAddresses attribute is populated in Azure AD

This article describes how the proxyAddresses attribute is populated in Azure Active Directory (Azure AD) and discusses common scenarios to help you understand how the proxyAddresses attribute is populated in Azure AD.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 3190357

The proxyAddresses attribute in Active Directory is a multi-value property that can contain various known address entries. For example, it can contain SMTP addresses, X500 addresses, SIP addresses, and so on. When an object is synchronized to Azure AD, the values that are specified in the proxyAddresses attribute in Active Directory are compared with Azure AD rules, and then the proxyAddresses attribute is populated in Azure AD. Therefore, the values of the proxyAddresses attribute for the object in Active Directory may not be the same as the values of the proxyAddresses attribute in Azure AD.

## Terminology

The following terminology is used in this article:

- Initial domain: It's the first provisioned domain in the tenant. For example, `contoso.onmicrosoft.com`.
- Microsoft Online Email Routing Address (MOERA): The MOERA is constructed from the user's userPrincipalName attribute in Active Directory and is automatically assigned to the cloud account during the initial sync. For example, `user@contoso.onmicrosoft.com`.
- Primary SMTP address: It's the primary email address of an Exchange recipient object. For example, SMTP:`user@contoso.com`.
- Secondary SMTP address: It's the secondary email address of an Exchange recipient object, which can have multiple secondary email addresses. For example, smtp:`user@contoso.com`.
- User principal name (UPN): The UPN can be the sign-in name of the user.
- mail attribute: It's an attribute in Active Directory, the value of which represents the email address of a user.
- mailNickName attribute: It's an attribute in Active Directory, the value of which represents the alias of a user in an Exchange organization.

## Scenario 1: User doesn't have the mail, mailNickName, or proxyAddresses attribute set

You created an on-premises user object that has the following attributes set:

> UPN: `onprema@contoso.com`  
> mail: \<not set>  
> mailNickName: \<not set>  
> proxyAddresses: \<not set>  

Next, it's synchronized to Office 365 and assigned an Exchange Online license. In this scenario, the following operations are performed because of system calculation:

- Populate the mailNickName attribute by using the user part of the UPN.
- Populate the MOERA by using the format mailNickName@initial domain.
- Populate the mail attribute by using the same value as the MOERA.
- Add the UPN as **the primary** SMTP address in the proxyAddresses attribute.
- Add the MOERA as **a secondary** SMTP address in the proxyAddresses attribute.

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `onprema@contoso.com`  
> mail: `onprema@contoso.com`  
> mailNickName: onprema  
> proxyAddresses: {smtp:`onprema@contoso.onmicrosoft.com`,SMTP:`onprema@contoso.com`}

## Scenario 2: User doesn't have the mailNickName or proxyAddresses attribute set

You created an on-premises user object that has the following attributes set:

> UPN: `onpremb@contoso.com`  
> mail: `newb@contoso.com`  
> mailNickName: \<not set>  
> proxyAddresses: \<not set>

Next, it's synchronized to Office 365 and assigned an Exchange Online license. In this scenario, the following operations are performed because of system calculation.

- Populate the mailNickName attribute by using the user's part of the mail attribute.
- Populate the MOERA by using the format of mailNickName@initial domain.
- Populate the mail attribute by using the same value as the mail attribute.
- Add the UPN as a secondary SMTP address in the proxyAddresses attribute.
- Add the mail attribute as the primary SMTP address in the proxyAddresses attribute.
- Add the MOERA as a secondary SMTP address in the proxyAddresses attribute.

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `onpremb@contoso.com`  
> mail: `newb@contoso.com`  
> mailNickName: newb  
> proxyAddresses: {SMTP:`newb@contoso.com`,`smtp:onpremb@contoso.com`,smtp:`newb@contoso.onmicrosoft.com`}

## Scenario 3: You change the proxyAddresses attribute values of the on-premises user

You created an on-premises user object that has the following attributes set:

> UPN: `us1@contoso.com`  
> mail: \<not set>  
> mailNickName: \<not set>  
> proxyAddresses: {smtp:`us1@contoso.onmicrosoft.com`,smtp:`us1@contoso.microsoftonline.com`,x500:/ o=MicrosoftOnline/ ou=External(FYDIBOHF25SPDLT)/ cn=Recipients/ cn=us1,SMTP:`us1@contoso.com`}

Next, it's synchronized to Office 365 and assigned an Exchange Online license. In this scenario, the following operations are performed because of system calculation:

- Populate the mailNickName  attribute by using the user's part of the UPN.
- Populate the MOERA by using mailNickName@initial domain.
- Add the mail attribute by using the same value of the primary SMTP address that's specified in the proxyAddresses attribute.
- Keep the MOERA as a secondary SMTP address in the proxyAddresses attribute.
- Keep the current primary SMTP address in the proxyAddresses attribute.
- Remove addresses that match the following pattern:
  - SMTP address suffix is `xxx.onmicrosoft.com`
  - SMTP address suffix is `xxx.microsoftonline.com`
  - The organization's part of X500 address is /o=MicrosoftOnline

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `us1@contoso.com`  
> mail: `us1@contoso.com`  
> mailNickName: us1  
> proxyAddresses: {smtp:`us1@contoso.onmicrosoft.com`,SMTP:`us1@contoso.com`}

Then, you change the values of the proxyAddresses attribute to the following ones:

> UPN: `us1@contoso.com`
> mail: \<not set>  
> mailNickName: \<not set>  
> proxyAddresses: {smtp:`newus1@contoso.onmicrosoft.com`,smtp:`newus1@contoso.microsoftonline.com`,x500:/o=MicrosoftOnline/ou=External (FYDIBOHF25SPDLT)/cn=Recipients/cn=us1,SMTP:`newus1@contoso.com`}

In this scenario, the following operations are performed because of system calculation:

- Add the primary SMTP address that's specified in the proxyAddresses attribute.
- Update the mail attribute by using the value of primary SMTP address specified in the proxyAddresse s attribute.
- Keep the UPN as a secondary SMTP address in the proxyAddresses attribute.

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `us1@contoso.com`  
> mail: `newus1@contoso.com`  
> mailNickName: us1  
> proxyAddresses: {smtp:`us1@contoso.onmicrosoft.com`,SMTP:`newus1@contoso.com`,smtp:`us1@contoso.com`}

## Scenario 4: Exchange Online license is removed

You created an on-premises user object that has the following attributes set:

> UPN: `us2@contoso.com`  
> mail: \<not set>  
> mailNickName: \<not set>  
> proxyAddresses: \<not set>

Next, it's synchronized to Office 365 and assigned an Exchange Online license. In this scenario, the following operations are performed because of system calculation:

- Populate the mailNickName attribute by using the user part of the UPN.
- Populate the MOERA  by using the format mailNickName@initial domain.
- Populate the mail attribute by using the same value as the MOERA.
- Add the UPN as a secondary SMTP address in the proxyAddresses attribute.
- Add the MOERA as the primary SMTP address in the proxyAddresses attribute.

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `us2@contoso.com`  
> mail: `us2@contoso.onmicrosoft.com`  
> mailNickName: us2  
> proxyAddresses: {smtp:`us2@contoso.com`,SMTP:`us2@contoso.onmicrosoft.com`}

Then, you remove the Exchange Online license. Nothing changes in Azure AD. All attributes remain the same.

Then, you change the values of the proxyAddresses attribute to the following ones:

> UPN: `us2@contoso.com`  
> mail: \<not set>  
> mailNickName: \<not set>  
> proxyAddresses: {smtp:`newus2@contoso.com`}

In this scenario, the following operation is performed as a result of system calculation:

- Add new SMTP address in the proxyAddresses attribute.

The following attributes set in Azure AD on the synchronized user object:

> UPN: `us2@contoso.com`  
> mail: `us2@contoso.onmicrosoft.com`  
> mailNickName: us2  
> proxyAddresses: {smtp:`us2@contoso.com`,SMTP:`us2@contoso.onmicrosoft.com`,smtp:`newus2@contoso.com`}

## Scenario 5: The mailNickName attribute value is changed

You created two on-premises user objects that have the following attributes set:

> UPN: `us4@contoso.com`  
> mail: \<not set>  
> mailNickName: \<not set>  
> proxyAddresses: \<not set>

Next, it's synchronized to Office 365 and assigned an Exchange Online license. In this scenario, the following operations are performed because of system calculation:

- Populate the mailNickName attribute by using the user's part of the UPN.
- Populate the MOERA  by using the format mailNickName@initial domain.
- Populate the mail attribute by using the same value as the MOERA.
- Add the UPN as a secondary SMTP address in the proxyAddresses attribute.
- Add the MOERA as the primary SMTP address in the proxyAddresses attribute.

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `us4@contoso.com`  
> mail: `us4@contoso.onmicrosoft.com`  
> mailNickName: us4
> proxyAddresses: {smtp:`us4@contoso.com`,SMTP:`us4@contoso.onmicrosoft.com`}

Then, you change the values of the proxyAddresses attribute of the on-premises user to the following ones:

> UPN: `us4@contoso.com`  
> mail: \<not set>  
> mailNickName: newus4  
> proxyAddresses: \<not set>

In this scenario, the following operations are performed because of system calculation:

- Update the mailNickName attribute by using the same value as the mailNickName attribute.
- Keep the mail attribute unchanged.
- Keep the proxyAddresses attribute unchanged.

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `us4@contoso.com`  
> mail: `us4@contoso.onmicrosoft.com`  
> mailNickName: newus4  
> proxyAddresses: {smtp:`us4@contoso.com`,SMTP:`us4@contoso.onmicrosoft.com`}

## Scenario 6: Two users have the same mailNickName attribute

You created two on-premises user objects that have the following attributes set:

> UPN: `us5@contoso.com`  
> mail: \<not set>  
> mailNickName: samenick  
> proxyAddresses: \<not set>  
> UPN: `us6@contoso.com`  
> mail: \<not set>  
> mailNickName: samenick  
> proxyAddresses: \<not set>

Next, they are synchronized to Office 365 and assigned an Exchange Online license. In this scenario, the following operations are performed because of system calculation:

- Duplicate mailNickName  values are detected.
- Populate the mailNickName attribute by appending four random digits.
- Populate the MOERA  by using the format mailNickName@initial domain.
- Add the mail attribute by using the same value as the MOERA.
- Add the UPN as a secondary SMTP address in the proxyAddresses attribute.
- Add the MOERA as the primary SMTP address in the proxyAddresses attribute.

The following attributes are set in Azure AD on the synchronized user object:

> UPN: `us5@contoso.com`  
> mail: `samenick@contoso.onmicrosoft.com`  
> mailNickName: samenick  
> proxyAddresses: {smtp:`us5@contoso.com`,SMTP:`samenick@contoso.onmicrosoft.com`}  
> UPN: `us6@contoso.com`  
> mail: `samenick0209@contoso.onmicrosoft.com`  
> mailNickName: samenick0209  
> proxyAddresses: {smtp:`us6@contoso.com`,SMTP:`samenick0209@contoso.onmicrosoft.com`}

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums) website.
