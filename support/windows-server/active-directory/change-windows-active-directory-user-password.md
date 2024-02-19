---
title: Change Windows Active Directory and LDS user password through LDAP
description: This article describes how to change a Windows Active Directory and LDS user password through LDAP.
ms.date: 45286
ms.custom: sap:active-directory-lightweight-directory-services-ad-lds-and-active-directory-application-mode-adam, csstroubleshoot
ms.reviewer: RRANDALL, HerbertMauerer, v-jayaramanp
ms.topic: how-to
---
# Change a Windows Active Directory and LDS user password through LDAP

This article describes how to change a Windows Active Directory and LDS user password through LDAP.

_Applies to:_ &nbsp; Windows Active Directory  
_Original KB number:_ &nbsp; 269190

## Summary

Based on certain restrictions, you can set a Windows Active Directory and Lightweight Directory Services (LDS) password through the Lightweight Directory Access Protocol (LDAP). This article describes how to set or change the password attribute.

These steps also apply to Active Directory Application Mode (ADAM) and LDS users and userProxy objects in the same way as done with AD users. See additional hints at the end of the article for details.

## More information

The password is stored in the AD and LDS database on a user object in the **unicodePwd** attribute. This attribute can be written under restricted conditions but can't be read. The attribute can only be modified; it can't be added on object creation or queried by a search.

To modify this attribute, the client must have a 128-bit Transport Layer Security (TLS)/Secure Socket Layer (SSL) connection to the server. An encrypted session using SSP-created session keys using Windows New Technology LAN Manager (NTLM) or Kerberos are also acceptable as long as the minimum key length is met.

For this connection to be possible using TLS/SSL:

- The server must possess a server certificate for a 128-bit RSA connection.
- The client must trust the certificate authority (CA) that generated the server certificate.
- Both client and server must be capable of 128-bit encryption.

The syntax of the **unicodePwd** attribute is octet-string; however, the directory service expects that the octet-string will contain a UNICODE string (as the name of the attribute indicates). This means that any values for this attribute passed in LDAP must be UNICODE strings that are BER-encoded (Basic Encoding Rules) as an octet-string. In addition, the UNICODE string must begin and end in quotes that aren't part of the desired password.

There are two possible ways to modify the **unicodePwd** attribute. The first is similar to a regular user change password operation. In this case, the modify request must contain both delete and an add operation. The delete operation must contain the current password with quotes around it. The add operation must contain the desired new password with quotes around it.

The second way to modify this attribute is analogous to an administrator resetting a password for a user. To do this, the client must bind as a user with sufficient permissions to modify another user's password. This modify request should contain a single replace operation with the new desired password surrounded by quotes. If the client has sufficient permissions, this password becomes the new password, regardless of what the old password was.

The following two functions provide examples of these operations:

```cpp
ULONG ChangeUserPassword(WCHAR* pszUserDN, WCHAR* pszOldPassword,WCHAR* pszNewPassword)
{
    ULONG err = 1;
    LDAPMod modNewPassword;
    LDAPMod modOldPassword;
    LDAPMod *modEntry[3];
    BERVAL newPwdBerVal;
    BERVAL oldPwdBerVal;
    BERVAL *newPwd_attr[2];
    BERVAL *oldPwd_attr[2];
    WCHAR pszNewPasswordWithQuotes[1024];
    WCHAR pszOldPasswordWithQuotes[1024];
    
    // Build an array of LDAPMod.
    
    // For setting unicodePwd, this MUST be a double op.
    modEntry[0] = &modOldPassword;
    modEntry[1] = &modNewPassword;
    modEntry[2] = NULL;
    
    // Build mod struct for unicodePwd Add.
    modNewPassword.mod_op = LDAP_MOD_ADD | LDAP_MOD_BVALUES;
    modNewPassword.mod_type =L"unicodePwd";
    modNewPassword.mod_vals.modv_bvals = newPwd_attr;
    
    // Build mod struct for unicodePwd Delete.
    modOldPassword.mod_op = LDAP_MOD_DELETE | LDAP_MOD_BVALUES;
    modOldPassword.mod_type =L"unicodePwd";
    modOldPassword.mod_vals.modv_bvals = oldPwd_attr;
    
    // Password will be single valued, so we only have one element.
    newPwd_attr[0] = &newPwdBerVal;
    newPwd_attr[1]= NULL;
    oldPwd_attr[0] = &oldPwdBerVal;
    oldPwd_attr[1]= NULL;
    
    // Surround the passwords in quotes.
    wsprintf(pszNewPasswordWithQuotes,L"\"%s\"",pszNewPassword);
    wsprintf(pszOldPasswordWithQuotes,L"\"%s\"",pszOldPassword);
    
    // Build the BER structures with the UNICODE passwords w/quotes.
    newPwdBerVal.bv_len = wcslen(pszNewPasswordWithQuotes) * sizeof(WCHAR);
    newPwdBerVal.bv_val = (char*)pszNewPasswordWithQuotes;
    oldPwdBerVal.bv_len = wcslen(pszOldPasswordWithQuotes) * sizeof(WCHAR);
    oldPwdBerVal.bv_val = (char*)pszOldPasswordWithQuotes;
    
    // Perform single modify.
    err = ldap_modify_s(ldapConnection,
    pszUserDN,
    modEntry
    );
    
    if (err == LDAP_SUCCESS )
    wprintf(L"\nPassword successfully changed!\n");
    else
    wprintf(L"\nPassword change failed!\n");
    
    return err;
}
    
ULONG SetUserPassword(WCHAR* pszUserDN, WCHAR* pszPassword)
{
    ULONG err = 1;
    LDAPMod modPassword;
    LDAPMod *modEntry[2];
    BERVAL pwdBerVal;
    BERVAL *pwd_attr[2];
    WCHAR pszPasswordWithQuotes[1024];
    
    // Build an array of LDAPMod.
    // For setting unicodePwd, this MUST be a single op.
    modEntry[0] = &modPassword;
    modEntry[1] = NULL;
    
    // Build mod struct for unicodePwd. 
    modPassword.mod_op = LDAP_MOD_REPLACE | LDAP_MOD_BVALUES;
    modPassword.mod_type =L"unicodePwd";
    modPassword.mod_vals.modv_bvals = pwd_attr;
    
    // Password will be single valued, so we only have one element.
    pwd_attr[0] = &pwdBerVal;
    pwd_attr[1]= NULL;
    
    // Surround the password in quotes.
    wsprintf(pszPasswordWithQuotes,L"\"%s\"",pszPassword);
    
    // Build the BER structure with the UNICODE password.
    pwdBerVal.bv_len = wcslen(pszPasswordWithQuotes) * sizeof(WCHAR);
    pwdBerVal.bv_val = (char*)pszPasswordWithQuotes;
    
    // Perform single modify.
    err = ldap_modify_s(ldapConnection,
    pszUserDN,
    modEntry
    );
    
    if (err == LDAP_SUCCESS )
    wprintf(L"\nPassword succesfully set!\n");
    else
    wprintf(L"\nPassword set failed!\n");
    
    return err;
}
```
> [!Tip]
> - To configure LDS instances using UserProxy objects for password resets, you have to allow constrained delegation of the LDS service account (default: LDS computer account) to the domain controllers in case the user logon uses Kerberos.
> - If you are using LDAP simple bind, you have to use Windows Server 2022 or a newer version and set a registry entry to forward the admin LDAP session credentials to the Active Directory Domain Controller:\
**Registry Key**: _HKLM\system\currentcontrolset\services\<LDS Instance>\Parameters_\
**Registry Entry**: Allow ClearText Logon Type\
**Type**: REG_DWORD\
**Data**: **0**: Don't allow forwarding of credentials (Default)\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **1**: Allow  forwarding of credentials for password reset
> - Note that the change in both cases means that the LDS server should be considered a Tier-0 device as it can start security-sensitive tasks on the Domain Controller.

## Applies to

- Windows Server 2012 Datacenter
- Windows Server 2012 Standard
- Windows Server 2012 R2 Datacenter
- Windows Server 2012 R2 Standard
- Windows Server 2016
- Windows Server 2019
- Windows Server 2022
- Windows 8.1 Enterprise
- Windows 8.1 Pro
- Windows 10
- Windows 11
