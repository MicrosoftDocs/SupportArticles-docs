---
title: How to renew Windows Azure Pack authentication sites certificates
description: Describes an issue in which Windows Azure Pack sites certificates expire and authentication fails.
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.reviewer: 
---
# How to renew Windows Azure Pack authentication sites certificates

_Original product version:_ &nbsp; Windows Azure Pack  
_Original KB number:_ &nbsp; 3070790

## Symptoms  

Assume that the default installation of Windows Azure Pack uses self-signed certificates. If the self-signed certificates of the admin authentication site (WindowsAuthSite) and of the tenant authentication site (AuthSite) are not replaced for a long time, the certificates expire, and authentication fails.

## Workaround

To work around this issue, renew Windows Azure Pack authentication sites certificates. To do this, run a Windows PowerShell script file on the servers where the WindowsAuthSite and the AuthSite roles are installed. The script commands are executed in the script file as in the following example:

```
# Make sure that you run the command on the server where you have WindowsAuthSite or the AuthSite installed.
# Note: You will have to update the $Server, $userid, $password, and $PassPhrase variables. 

# SQL Server DNS name
# Add the instance name if you are using a named instance
# Examples:
# sqlserver.contoso.com
# sqlserver.contoso.com\InstanceName

$Server = "sqlserver.contoso.com"

# SQL user and password
$userid = "sa"
$password = "MyPassword"

# PassPhrase that you defined during the installation of WAP.
$PassPhrase = "MyWindowsAzurePackPassPhrase"

$ConfigconnectionString = [string]::Format('Data Source={0};Initial Catalog=Microsoft.MgmtSvc.Config;User Id={1};Password={2};Integrated Security=false', $server, $userid, $password)

# Set Namespace to AuthSite or WindowsAuthSite
$NameSpace = "AuthSite" 
 Try
{
 # 1. Obtain the current signing certificate thumbprint.
 $setting = Get-MgmtSvcSetting -Namespace $NameSpace -Name Authentication.SigningCertificateThumbprint
 $oldThumbprint = $setting.Value

# 2. Remove the old certificate from the global config store.
 $Result = Set-MgmtSvcDatabaseSetting -Namespace $NameSpace -Name Authentication.SigningCertificate -Value $Null -ConnectionString $ConfigconnectionString -PassPhrase $PassPhrase -Force -confirm:$false

# 3. Reinitialize the authentication service to generate a new signing certificate, and reconfigure.
 Initialize-MgmtSvcFeature -Name $NameSpace -Passphrase $PassPhrase -ConnectionString $ConfigconnectionString -Verbose

}
Catch
{
 $ErrorMessage = $_.Exception.Message
 $FailedItem = $_.Exception.ItemName
 write-host @([string]::Format("Error creating a new signing certificate for {0}.", $NameSpace)) -ForegroundColor red
 write-host ($FailedItem) -ForegroundColor red
 write-host ($ErrorMessage) -ForegroundColor red
 exit 1
}

Try
{
 # 4. (optional) Remove the old signing certificate that is no longer being used.
 Get-Item Cert:\LocalMachine\My\$oldThumbprint | Remove-Item -Force -Verbose
}
Catch
{
 $ErrorMessage = $_.Exception.Message
 $FailedItem = $_.Exception.ItemName
 write-host @([string]::Format("Error deleting old signing certificate.")) -ForegroundColor red
 write-host ($FailedItem) -ForegroundColor red
 write-host ($ErrorMessage) -ForegroundColor red
 exit 1
}

# 5. Reset services to update any (old) cached configuration.
Iisreset
```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

### Scenarios that are experienced in this issue

- Federation between AdminSite and WindowsAuthSite (default configuration).
- Federation between TenantSite and AuthSite (default configuration).
- Federation between TenantSite and Active Directory Federation Services (AD FS) by using AuthSite as Identity Store.For information about AD FS for Windows Azure Pack, see [Configure Active Directory Federation Services for Windows Azure Pack](https://technet.microsoft.com/library/dn296436.aspx).

After you run the script file that is mentioned in the "Workaround" section to create new certificates, you must reestablish trust between the portal and the authentication sites and then update AD FS metadata for AuthSite.

Notes

- For more information about how to reestablish trust between the portal and the authentication sites, see [Reconfigure FQDNs and Ports in Windows Azure Pack](https://technet.microsoft.com/library/dn528551.aspx).
- To update AD FS metadata for AuthSite, open AD FS management, and then select the **Update From Federation Metadata** option.

### Scenarios that are not experienced in this issue

- Federation between TenantSite and AD FS by using Active Directory as Identity Store
- Federation between TenantSite and AD FS by using a third-party program as Identity Store in AD FS or federation with another federation partner

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
