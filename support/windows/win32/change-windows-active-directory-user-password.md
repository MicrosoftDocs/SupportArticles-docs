---
title: Change Windows Active Directory user password through LDAP
description: This article describes how to change a Windows Active Directory and LDS user password through LDAP.
ms.date: 01/04/2021
ms.prod-support-area-path: Windows Administration and Management Development
ms.reviewer: RRANDALL
ms.topic: how-to
---
# Change a Windows Active Directory and LDS user password through LDAP

This article describes how to change a Windows Active Directory and LDS user password through LDAP.

_Applies to:_ &nbsp; Windows Active Directory  
_Original KB number:_ &nbsp; 269190

## Summary

You can set a Windows Active Directory and LDS user's password through the Lightweight Directory Access Protocol (LDAP) given certain restrictions. This article describes how to set or change the password attribute.

These steps also apply to ADAM and LDS users and userProxy objects in the same way as done with AD users.

This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

## More information

The password is stored in the AD and LDS database on a user object in the unicodePwd attribute. This attribute can be written under restricted conditions, but it cannot be read. The attribute can only be modified; it cannot be added on object creation or queried by a search.

In order to modify this attribute, the client must have a 128-bit Transport Layer Security (TLS)/Secure Socket Layer (SSL) connection to the server. An encrypted session using SSP-created session keys using NTLM or Kerberos are also acceptable as long as the minimum key length is met.

For this connection to be possible using TLS/SSL:

- The server must possess a server certificate for a 128-bit RSA connection.
- The client must trust the certificate authority (CA) that generated the server certificate.
- Both client and server must be capable of 128-bit encryption.

The syntax of the unicodePwd attribute is octet-string; however, the directory service expects that the octet-string will contain a UNICODE string (as the name of the attribute indicates). This means that any values for this attribute passed in LDAP must be UNICODE strings that are BER-encoded (Basic Encoding Rules) as an octet-string. In addition, the UNICODE string must begin and end in quotes that are not part of the desired password.

There are two possible ways to modify the unicodePwd attribute. The first is similar to a normal **user change password** operation. In this case, the modify request must contain both a delete and an add operation. The delete operation must contain the current password with quotes around it. The add operation must contain the desired new password with quotes around it.

The second way to modify this attribute is analogous to an administrator resetting a password for a user. In order to do this, the client must bind as a user with sufficient permissions to modify another user's password. This modify request should contain a single replace operation with the new desired password surrounded by quotes. If the client has sufficient permissions, this password becomes the new password, regardless of what the old password was.

The following two functions provide examples of these operations:

```javascript
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
    wprintf(L"\nPassword succesfully changed!\n");
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

## Applies to

- Microsoft Windows Server 2003 Enterprise Edition (32-bit x86)
- Microsoft Windows Server 2003 Enterprise Edition for Itanium-based Systems
- Microsoft Windows Server 2003 Enterprise x64 Edition
- Microsoft Windows Server 2003 Standard Edition (32-bit x86)
- Microsoft Windows Server 2003 Standard x64 Edition
- Windows Server 2008 Enterprise
- Windows Server 2008 Standard
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 R2 Standard
- Windows Server 2012 Datacenter
- Windows Server 2012 Standard
- Windows Server 2012 R2 Datacenter
- Windows Server 2012 R2 Standard
- Microsoft Windows XP Professional
- Windows Vista Business, Windows Vista Enterprise
- Windows Vista Ultimate
- Windows 7 Enterprise
- Windows 7 Professional
- Windows 7 Ultimate
- Windows 8 Enterprise
- Windows 8 Pro
- Windows 8.1 Enterprise
- Windows 8.1 Pro
