---
title: People Picker doesn't work in a trusted forest
description: Resolves an issue that occurs when you configure a forest trust between two Active Directory forests and the Windows Internet Name Service (WINS) isn't enabled for NetBIOS resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Authentication & User Profiles\People Picker
  - CSSTroubleshoot
ms.reviewer: joroar, mikedem
appliesto: 
  - SharePoint Server 2010
search.appverid: MET150
ms.date: 12/17/2023
---
# Users in any domain in the trusted forest receive No exact match was found People Picker error

_Original KB number:_ &nbsp; 2874332

## Symptoms

Assume that you configure a forest trust between two Active Directory forests and that the Windows Internet Name Service (WINS) isn't enabled for NetBIOS resolution. In this situation, People Picker in a Microsoft SharePoint Server 2010 site works fine for users in the local forest. However, for users in any domain in the trusted forest, People Picker doesn't work.

Additionally, People Picker finds the user account and seems to resolve it. However, when user clicks **OK** to post back to the site, the user receives the following error message:

> No exact match was found. Click the items that did not resolve for more options.

If you run `NLtest /dsgetdc`, you receive a similar error message. For example, if you run `NLtest /dsgetdc:ExternalContoso`, you receive the following error message:

> Getting DC name failed: Status = 1355 0x54b ERROR_NO_SUCH_DOMAIN

In the Unified Logging System (ULS) logs, you find errors that resemble the following:

> w3wp.exe (0x0E98) 0x1DC4 SharePoint Foundation General 72e1 High Unable to get domain DNS or forest DNS for domain ExternalContoso. ErrorCode=1355
>
> w3wp.exe (0x0E98) 0x1DC4 SharePoint Foundation General 72e9 Medium Error in resolving user 'ExternalContoso\UserName' : System.ArgumentException: Specified value is not supported for the {0} parameter. at Microsoft.SharePoint.Utilities.SPUserUtility.GetDomainControllerToSearch(SPWebApplication webApp, String domainName) at Microsoft.SharePoint.Utilities.SPActiveDirectoryPrincipalBySIDResolver.ResolvePrincipal(String input, Boolean inputIsEmailOnly, SPPrincipalType scopes, SPPrincipalSource sources, SPUserCollection usersContainer) at Microsoft.SharePoint.Utilities.SPUtility.ResolvePrincipalInternal(SPWeb web, SPWebApplication webApp, Nullable\`1 urlZone, String input, SPPrincipalType scopes, SPPrincipalSource sources, SPUserCollection usersContainer, Boolean inputIsEmailOnly, Boolean alwaysAddWindowsResolver).

## Cause

This issue occurs because, when you click **OK**, People Picker makes a NetBIOS call to try to resolve the domain name. Because the customer doesn't have WINS set up, a NetBIOS broadcast occurs. However, the broadcast cannot find the trusted domains because broadcasts are not enabled outside the subnet.

## Resolution

### Step 1: Download and install the hotfix

You can download and install [SharePoint hotfix package 2687339: August 2012](https://support.microsoft.com/help/2687339).

> [!NOTE]
> If you have a newer hotfix package installed that was released after August 28, 2012, or if you have SharePoint Server 2010 Service Pack 2, you don't have to install hotfix 2687339.

### Step 2: Enable the hotfix

In order to use People Picker without NETBIOS or WINS enabled, you have to specify the domains from which you want to resolve users by using Windows PowerShell explicitly on every web application.

After you install the hotfix, there are two properties that you must set in order to enable the new functionality.

- `$farm.Properties["disable-netbios-dc-resolve"]` is set at the Farm level
- `$wa.PeoplePickerSettings.SearchActiveDirectoryDomains` is set at the web application level.

Within `SearchActiveDirectoryDomains`, you create a mapping between the NetBIOS name and DNS name of each domain that you want People Picker to search.

This means that you must list each of your trusted domains and the local domain in the People Picker settings. You cannot just specify a forest name and then have People Picker resolve all domains from the forest.

By using Windows PowerShell, you can set the domain properties based on the following sample. Replace placeholders such as <*YourWebApplicationURL*> and the domain names with your own values.

```powershell
# --------------------------------------------------------------------------------------
Add-PSSnapin Microsoft.SharePoint.PowerShell -ea silentlycontinue
# Enable the global setting for the farm. You must do this part only once.
$farm = get-spfarm
$farm.Properties
$farm.Properties["disable-netbios-dc-resolve"] = 'true'
$farm.Properties
$farm.Update()

# --------------------------------------------------------------------------------------
# Set the SearchActiveDirectoryDomains property for a single web application. You should only do this part once per-web application.
# Note: SearchActiveDirectoryDomains is the PowerShell equivelent of peoplepicker-searchadforests
$wa = Get-SPWebApplication [http://](http://m1garand/)
# Save current PP settings to text file in case you need to refer to those
$wa.PeoplePickerSettings.SearchActiveDirectoryDomains | out-file pp_settings_before.txt
# Clear the PP settings.
$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.Clear()

# You must repeat the following example for all the domains for which you want People Picker to work on this particular web application.
# The following is an example of adding three domains from the same forest and one domain from a trusted forest:
# --------------------------------------------------------------------------------------
$newdomain = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain
$newdomain.DomainName ='oneDomain.corp.contoso.com'; # specify the DNS name
$newdomain.ShortDomainName ='oneDomain'; # Specify the netbios name.
$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.Add($newdomain)

$newdomain2 = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain
$newdomain2.DomainName ='corp.contoso.com'; # specify the DNS name
$newdomain2.ShortDomainName ='CORP'; # Specify the netbios name.
$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.Add($newdomain2)

$newdomain3 = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain
$newdomain3.DomainName ='contoso.com'; # specify the DNS name
$newdomain3.ShortDomainName ='CTSO'; # Specify the netbios name.
$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.Add($newdomain3)

$newdomain4 = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain
$newdomain4.DomainName ='fabrikam.com'; # specify the DNS name
$newdomain4.ShortDomainName ='FAB'; # Specify the netbios name.
$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.Add($newdomain4)
# --------------------------------------------------------------------------------------

# Once you have added all the required domains, save settings for the web app.
$wa.update()
# --------------------------------------------------------------------------------------
```

> [!NOTE]
> You must run your version of this example script for each web application individually to enable the hotfix.

#### One-way trust example

Use this example only if there is a one-way trust with the target domain and the application pool account doesn't have access.

It's similar to the above example, with the addition of specifying an account name and password to make the connection to the one-way trusted domain.

```powershell
# --------------------------------------------------------------------------------------
# First, you have to run setapppassword on every server in the farm.
# This sets the encryption key that is used with the password that you enter for the account that you specify for $newdomain.loginname
stsadm -o setapppassword -password <password>.
# Where <password> is any string that you want to use as an encryption key.
# This has to be run on every server by using the same value for <password>.

# Now add the one-way trusted domain:
Add-PSSnapin Microsoft.SharePoint.PowerShell -ea silentlycontinue
$wa = Get-SPWebApplication http://<YourWebApplicationURL>
$newdomain = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain
$newdomain.DomainName =<'oneDomain.corp.contoso.com'>; # specify the DNS name
$newdomain.ShortDomainName =<'oneDomain'>; # Specify the netbios name.
$newdomain.loginname = <'oneDomain\userName'> # Specify an account that has access to the remote domain.
# Do not change anything in the next two lines. It prompts you to enter the password.
[System.Security.SecureString]$secureStringValue = Read-Host "Enter the account password: " -AsSecureString
$newdomain.setpassword($secureStringValue)
$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.Add($newdomain) #Add the on-way trusted domain
$wa.update() #update the web app
# --------------------------------------------------------------------------------------
```

## Workaround

If you cannot install the hotfix or Service Pack 2, you can work around this issue by caching domain resolution information for the NetBIOS domain name in the Netlogon service. To do this, follow these steps:

1. Create a batch file that contains the following commands for each external domain:

    ```console
    Nltest /dsgetdc:ExternalDomainName.FQDN
    Nltest /dsgetdc:ExternalDomainName
    ```

    For example, create the following batch file:

    ```console
    Nltest /dsgetdc:external.contoso.com
    Nltest /dsgetdc:external
    Nltest /dsgetdc:domain2.contoso.com
    Nltest /dsgetdc:domain2
    ```

2. Run this batch file as a scheduled task every 15 minutes on each web front-end server. This should keep the Netlogon cache populated and should prevent the error.
