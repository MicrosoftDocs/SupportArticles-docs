---
title: People Picker doesn't resolve users from other domains
description: Fixes an issue in which you receive the No match found error when you try to resolve users from other domains from People Picker.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Authentication & User Profiles\People Picker
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2007
search.appverid: MET150
ms.date: 12/17/2023
---
# SharePoint People Picker stops resolving users from other domains with one-way trust

_Original KB number:_ &nbsp; 2384424

## Symptoms

On a SharePoint site, users from other domains don't get resolved from People Picker. Additionally, You receive the error message "No match found."

With the installation of Service Pack 2 (SP2), suddenly the People Picker would not resolve users from other domains even if one-way trust was enabled.

## Cause

The SharePoint farm was recently upgraded to SP2 and this changes the `peoplepicker` functionality to respect the `peoplepicker-searchadforests` property.

SP2 enforces the security features with respect to People Picker and the `peoplepicker-searchadforests` property.

## Resolution

You need to set the `peoplepicker-searchadforests` property for each one-way trusted domain from a SharePoint perspective. The following command was delivered to have the people picker look up users in all domains that are in trust relationship with the SharePoint local domain.

```console
stsadm -o setproperty -propertyname peoplepicker-searchadforests
```

Details to select people and groups from multiple forests are available in [Peoplepicker-searchadforests: Stsadm property (Office SharePoint Server)](/previous-versions/office/sharepoint-2007-products-and-technologies/cc263460(v=office.12)).

Use this procedure to enable selection of people and groups from multiple forests or domains that have a one-way trust relationship from the farm.

### Enable selection of people and groups from multiple forests

If you want to search from a one-way trusted forest or a one-way trusted domain, you must run the `setapppassword` operation.

On every front-end Web server on a farm, at a command prompt, type the following command, and then press Enter:

```console
STSADM.exe -o setapppassword -password key
```

The syntax for the setproperty operation is:

```console
stsadm -o setproperty

-propertyname peoplepicker-searchadforests

-propertyvalue <valid list of forests or domains>

[-url] <URL>
```

### Example

SharePoint is in *fabrikam* domain. Users from *Contoso* domain need to be resolved from People Picker. There is a one-way trust between domain *fabrikam* (resource domain) and *Contoso* (user domain) where *fabrikam* trusts *Contoso*, that is, *Contoso* users can access *fabrikam* resources like SharePoint but not vice versa.

We need to run

```console
stsadm -o setproperty -url http://<server:port> -pn peoplepicker-searchadforests -pv "forest:contoso.corp.com, contoso\<account>, <Password>;domain:bar.contoso.corp.com, contoso\<account>, <Password>"
```

Here the \<LoginName> and \<Password> refer to an account with read permissions to the user domain. Typically it's a user account from the trusted (user) domain, such as contoso\account.

If there are multiple domains from which users need to be resolved, they need to be entered in a single `stsadm` command and not separate.

For example, If you have two domains *contoso* and *adatum* from which users need to be resolved.

#### Correct way - single stsadm command

```console
stsadm -o setproperty -url http://<server:port> -pn peoplepicker-searchadforests -pv "forest:contoso.corp.com, contoso\<account>, <Password>;domain:bar.contoso.corp.com, contoso\<account>, <Password>;forest:adatum.corp.com, adatum\<account>, <Password>;domain:bar.adatum.corp.com, adatum\<account>, <Password>"
```

#### Wrong way - multiple stsadm commands

```console
stsadm -o setproperty -url http://<server:port> -pn peoplepicker-searchadforests -pv "forest:contoso.corp.com, contoso\<account>, <Password>;domain:bar.contoso.corp.com, contoso\<account>, <Password>"
stsadm -o setproperty -url http://<server:port> -pn peoplepicker-searchadforests -pv "forest:adatum.corp.com, adatum\<account>, <Password>;domain:bar.adatum.corp.com, adatum\<account>, <Password>"
```

The second `stsadm` command that sets the property for *adatum* domain would toggle off the property for *contoso* domain. As a result, users from *Contoso* domain will no longer be resolved from the People Picker.

## More information

People Picker **Check Names** function respects the `peoplepicker-searchadforests` property after SP2. This was not the case prior to SP2.

After SP2, you will not be able to look up users in an external domain that's in a one-way trust relationship with the SharePoint local domain.

Prior to SP2, the People Picker **Check Names** function didn't respect the `peoplepicker-searchadforests` property. Users could be resolved from other domains, even if there was only a one-way trust.

The **Check Names** function used LSAT and LDAP to search and display a match prior to the build 12.0000.6520.5000.

The **Check Names** function could use the Local Security Authority Translation (LAST) methods to resolve names from Windows NT 4.0 domains and other Active Directory domains connected to the SharePoint local domain.
