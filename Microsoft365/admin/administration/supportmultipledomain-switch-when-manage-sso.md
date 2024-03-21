---
title: SupportMultipleDomain switch when managing single sign-on (SSO) to Microsoft 365
description: SupportMultipleDomain switch when managing SSO to Microsoft 365.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.reviewer: 
appliesto: 
  - Microsoft 365
search.appverid: 
  - MET150
ms.date: 03/31/2022
---

# SupportMultipleDomain switch when managing SSO to Microsoft 365

## Summary

### Use of SupportMultipleDomain switch, when managing SSO to Microsoft 365 using ADFS

When an SSO is enabled for O365 via ADFS, you should see the Relying Party (RP) trust created for O365.

:::image type="content" source="media/supportmultipledomain-switch-when-manage-sso/relying-party-trust-created-for-o365.png" alt-text="Screenshot shows the Relying Party trust created for O365.":::

### Commands that would create the RP trust for O365 are below

```PowerShell
New-MsolFederatedDomain -DomainName<domain>
Update-MSOLFederatedDomain -DomainName <domain>
Convert-MsolDomainToFederated -DomainName <domain>
```

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

The RP trust created above came with two claims rules

`Get-MsolFederationProperty -DomainName <domain>` on the federated domains shows that the "FederationServiceIdentifier" was the same for source ADFS and O365,  which is `http://stsname/adfs/Services/trust`.

Earlier before the ADFS [Rollup 1](https://support.microsoft.com/kb/2607496) and [Rollup 2](https://support.microsoft.com/kb/2681584) updates, Microsoft 365 customers who utilize single sign-on (SSO) through AD FS 2.0 and have multiple top-level domains for users' user principal name (UPN) suffixes within their organization (for example, @contoso.com or @fabrikam.com) are required to deploy a separate instance of AD FS 2.0 Federation Service for each suffix.  There is now a rollup for AD FS 2.0 ([https://support.microsoft.com/kb/2607496](https://support.microsoft.com/kb/2607496)) that works in conjunction with the "SupportMultipleDomain" switch to enable the AD FS server to support this scenario without requiring additional AD FS 2.0 servers.

### With the ADFS rollup 1 update, we added the following functionality

#### Multiple Issuer Supports

"Previously, Microsoft 365 customers who require single sign-on (SSO) by using AD FS 2.0 and use multiple top-level domains for users' user principal name (UPN) suffixes within their organization (for example, @contoso.us or @contoso.de) are required to deploy a separate instance of AD FS 2.0 Federation Service for each suffix. After you install this Update Rollup on all the AD FS 2.0 federation servers in the farm and follow the instructions of using this feature with Microsoft 365, new claim rules will be set to dynamically generate token issuer IDs based on the UPN suffixes of the Microsoft 365 users. As a result, you don't have to set up multiple instances of AD FS 2.0 federation server to support SSO for multiple top-level domains in Microsoft 365."

#### Support for Multiple Top-Level Domains

"Currently, Microsoft 365 customers who use single sign-on (SSO) through AD FS 2.0 and have multiple top-level domains for users' user principal name (UPN) suffixes within their organization (for example, @contoso.com or @fabrikam.com) are required to deploy a separate instance of AD FS 2.0 Federation Service for each suffix.  There is now a rollup for AD FS 2.0 ([https://support.microsoft.com/kb/2607496](https://support.microsoft.com/kb/2607496)) that works in conjunction with the "SupportMultipleDomain" switch to enable the AD FS server to support this scenario without requiring additional AD FS 2.0 servers."

### Commands that would create the RP trust for O365 are below

```powershell
New-MsolFederatedDomain -DomainName<domain>-SupportMultiDomain

Update-MSOLFederatedDomain -DomainName <domain>-SupportMultipleDomain

Convert-MsolDomainToFederated -DomainName <domain>-supportMultipleDomain
```

`Get-MsolFederationProperty -DomainName <domain>` on the federated domains now shows that the "FederationServiceIdentifier" is different for ADFS and O365. Every federated domain will have the "FederationServiceIdentifier" as
`http://<domainname>/adfs/services/trust/`, whereas the ADFS configuration still has `http://STSname/adfs/Services/trust`.

Due to this mismatch in configuration, we need to ensure that when a token is sent to O365 the issuer mentioned in it, is the same as one configured for the Domain in O365. Otherwise you will get the error below:

So when adding or updating RP trust with SupportMultipleDomain switch, a third claim rule is automatically added to the RP trust for O365.

Default third rule:

c:[Type == "`http://schemas.xmlsoap.org/claims/UPN](http://schemas.xmlsoap.org/claims/UPN`"]
=> issue(Type = "`https://schemas.microsoft.com/ws/2008/06/identity/claims/issuerid`", Value = regexreplace(c.Value, .`+@(?<domain>.+`), `http://${domain}/adfs/services/trust/`));

This rule uses the suffix value of user's UPN and uses that to generate a new claim called "Issuerid." Example `http://contoso.com/adfs/services/trust/`.

Using [fiddler](https://www.fiddler2.com/fiddler2/), we can trace the token being passed to login.microsoftonline.com/login.srf. After copying the token passed in `wresult`, paste the content in notepad and save that file as .xml.
Later you can open the token saved as .xml file using IE and see its content.

:::image type="content" source="media/supportmultipledomain-switch-when-manage-sso/fidder-wresult.png" alt-text="Screenshot to copy the security token passed in wresult.":::

It's interesting to note that the rule issues "Issuerid" claim, we don't see this claim in the response token, in fact we see the "Issuer" attribute modified to the newly composed value.

```adoc
<saml:Assertion MajorVersion="1" MinorVersion="1" AssertionID="_2546eb2e-a3a6-4cf3-9006-c9f20560097f"Issuer="[http://contoso.com/adfs/services/trust/](http://contoso.com/adfs/services/trust/)" IssueInstant="2012-12-23T04:07:30.874Z" xmlns:saml="urn:oasis:names:tc:SAML:1.0:assertion">
```

**NOTE**

- SupportMultipleDomain is used without the ADFS rollup 1 or 2 installed. You will see that the response token generated by ADFS has BOTH the Issuer="`http://STSname/adfs/Services/trust`" and the claim "Issuerid" with the composed value as per the third claim rule.

    ```adoc
    <saml:Assertion MajorVersion="1" MinorVersion="1" AssertionID="_2546eb2e-a3a6-4cf3-9006-c9f20560097f"Issuer=`http://STS.contoso.com/adfs/services/trust/` IssueInstant="2012-12-23T04:07:30.874Z" xmlns:saml="urn:oasis:names:tc:SAML:1.0:assertion">
    
    …
    
    <saml:Attribute AttributeName="issuerid" AttributeNamespace="[http://schemas.microsoft.com/ws/2008/06/identity/claims](http://schemas.microsoft.com/ws/2008/06/identity/claims)"><saml:AttributeValue>[http://contoso.com/adfs/services/trust/</saml:AttributeValue](http://contoso.com/adfs/services/trust/%3c/saml:AttributeValue)></saml:Attribute>
    - This will again lead to error "Your organization could not sign you in to this service"
    ```

#### Support for Sub domains

"It's important to note that the"SupportMultipleDomain" switch isn't required when you have a single top-level domain and multiple sub domains. For example, if the domains used for upn suffixes are @sales.contoso.com, @marketing.contoso.com, and @contoso.com, and the top-level domain (contoso.com in this case) was added first and federated then you don't need to use the "SupportMultipleDomain" switch. These sub domains are effectively managed within the scope of the parent, and a single AD FS server can be used to handle this already."

If however, you have multiple top-level domains (@contoso.com and @fabrikam.com), and these domains also have sub domains (@sales.contoso.com and @sales.fabrikam.com), the "SupportMultipleDomain" switch will not work for the sub domains and these users will not be able to log in.

#### Why will this switch not work, in the above scenario?

Answer:

- For child domain, sharing the same namespace, we don't federate them separately. The federated root domain covers the child as well, which mean that the
federationServiceIdentifier value for the child domain will also be the same as that of parent, that is `https://contoso.com/adfs/services/trust/`.

- But the third claim rule, which ends up picking the UPN suffix for the user to compose the Issuer value ends up with `https://Child1.contoso.com/adfs/services/trust/`, again causing a mismatch and hence the error "Your organization could not sign you in to this service."

  To resolve this issue, modify the third rule such that it ends up generating an Issuer value that matches "FederationServiceIdentifier" for the domain at O365 end. Two different rules that can work in this scenario is below. This rule just picks up the root domain from the UPN suffix to compose the Issuer value. For a UPN suffix child1.contoso.com, it will still generate an Issuer value of `https://contoso.com/adfs/services/trust/` instead of `https://Child1.contoso.com/adfs/services/trust/` (with default rule)

:::image type="content" source="media/supportmultipledomain-switch-when-manage-sso/claim-rule.png" alt-text="Screenshot of selecting the Edit Rule option to modify the third rule." border="false":::

#### Customized third rule

Rule 1:

```adoc
c:[Type == `http://schemas.xmlsoap.org/claims/UPN`]
=> issue(Type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/issuerid", Value = regexreplace(c.Value, "^((.*)([.|@]))?(?<domain>[^.]*[.].*)$", "http://${domain}/adfs/services/trust/"));
```

Rule 2:

```adoc
c:[Type == `http://schemas.xmlsoap.org/claims/UPN`]
=> issue(Type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/issuerid", Value =regexreplace(c.Value, "^((.*)([.|@]))?(?<domain>[^.]*.(com|net|co|org)(.\w\w)?)$", "[http://${domain}/adfs/services/trust/](http://$%7bdomain%7d/adfs/services/trust/)"));
```

**NOTE**

The rules above may not apply to all scenarios, but can be customized to ensure that the "Issuerid" value matches "FederationServiceIdentifier" for the domain added/federated at O365 end.

The mismatch of federationServiceIdentifier between ADFS and O365 for a domain can also be corrected by modifying the "federationServiceIdentifier" for the domain at O365 end, to match the "federationServiceIdentifier" for ADFS. But the federationServiceIdentifier can only be configured for ONE federated domain and not all.

Set-MSOLDomainFederationSettings -domain name  Contoso.com –issueruri `http://STS.contoso.com/adfs/services/trust/`

### More information that should help you write your own claim rules.**

- [The Role of the Claim Rule Language](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd807118(v=ws.10))
- [Understanding Claim Rule Language in AD FS 2.0](https://social.technet.microsoft.com/wiki/contents/articles/4792.understanding-claim-rule-language-in-ad-fs-2-0.aspx#General_Syntax_of_the_Claim_Rule_Language)
- [Regular Expressions](/previous-versions/system-center/system-center-2012-R2/hh440535(v=sc.12))
