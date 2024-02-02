---
title: DPAPI MasterKey backup failures
description: Helps solve DPAPI MasterKey backup failures that occur when RWDC isn't available.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# DPAPI MasterKey backup failures when RWDC isn't available

This article provides a solution to solve DPAPI MasterKey backup failures that occur when RWDC isn't available.

_Applies to:_ &nbsp; Windows 10, version 1809, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 3205778

## Symptoms

- The following behavior occurs in Windows 8.1 and Windows Server 2012 R2 after you install MS14-066, KB2992611, KB3000850, or newer updates that include these fixes.
- The same behavior also occurs in all versions of Windows 10 and later versions of Windows. Domain users who log on for the first time to a new computer in a site that's serviced by a read-only domain controller (RODC) experience the following errors and problems.  

### Generic problems

1. Opening Credential Manager fails with a 0x80090345 error, which maps to the following:

    |Hex|Decimal|Symbolic|Friendly|
    |---|---|---|---|
    |0x80090345|-2146892987|SEC_E_DELEGATION_REQUIRED|The requested operation cannot be completed. The computer must be trusted for delegation and the current user account must be configured to allow delegation.|

2. Saving an RDP password fails with no apparent error.
3. Password changes take longer than expected to complete.
4. Explorer hangs when you're encrypting a file.
5. In Office and Office 365, adding a new account in Windows Live Mail 2012 fails with error 0x80090345.
6. Outlook profile creation fails with the following error:

    An encrypted connection to your mail server is not available.

7. Signing into Lync and Skype hangs or experiences a long delay during the "Contacting server and signing in" stage.
8. SQL service fails to start under a domain account and triggers the following error:

    > Unable to initialize SSL encryption because a valid certificate could not be found, and it is not possible to create a self-signed certificate.

9. SQL Server installation fails with the following error:

    > Error(s): SQL server setup has encountered the following error: "generating the XML document error code 0x8410001.

10. Domain users can't manage SQL databases from SMSS. (SQL Server Management Studio). This issue occurs when the database is navigated from via **SSMS DataBases** -> **CustomerDatabase** -> **Tables** -> **Table name**.

    If you right-click the table and then select **Design**, the following error occurs:  

    > The requested operation cannot be completed. The computer must be trusted for delegation and the current user account must be configured to allow delegation.
    This exception originated from System_Security_ni!System.Security.Cryptography.ProtectedData.Protect(Byte[], Byte[], System.Security.Cryptography.DataProtectionScope)."

11. ADFS WAP installation fails to create a self-signed certificate and triggers the following error:

    > Exception: An error occurred when attempting to create the proxy trust certificate.

12. ADLDS installation in an RODC-only covered site fails with the following error:

    > Type a valid user and password for selected service account

    1. In this situation, the AdamInstall.log shows the following:

        > adamsetup D20.10F8 0255 15:30:22.002 Enter GetServiceAccountError  
        adamsetup D20.10F8 0256 15:30:22.002 Type a valid user name and password for the selected service account.  
        adamsetup D20.10F8 0257 15:30:22.002 ADAMERR_SERVICE_INVALID_CREDS

    2. A sample network trace taken during the failure shows that ADLDS is sending an incorrect password and Kerberos TGT request fails with KDC_ERR_PREAUTH_FAILED:

        |Source|Destination|Protocol|Description|
        |---|---|---|---|
        |ADLDS|RODC|KerberosV5|AS Request Cname: ADLDSSvc Realm: CONTOSO Sname: krbtgt/contoso {TCP:375, IPv4:7}|
        |RODC|ADLDS|KerberosV5|KerberosV5:KRB_ERROR - KDC_ERR_PREAUTH_FAILED (24) {TCP:376, IPv4:7}|

    3. Event ID 4625 is logged in the Security log of the ADLDS server, as follows:

        > Event ID: 4625  
        Keywords: Audit Failure  
        Description: An account failed to log on.  
        ..  
        Failure Information:  
        Failure Reason: Unknown user name or bad password.  
        Status: 0xC000006D  
        Sub Status: 0xC000006A  
        ..  
        Process Information:  
        Caller Process Name: C:\Windows\ADAM\adaminstall.exe  

    - Where the Status and Sub status translates to:

        | Hex| Decimal| Symbolic| Friendly |
        |---|---|---|---|
        | 0xc000006a|-1073741718|STATUS_WRONG_PASSWORD|When trying to update a password, this return status indicates that the value provided as the current password is not correct.|
        | 0xc000006d|-1073741715|STATUS_LOGON_FAILURE|The attempted logon is invalid. This is either due to a bad user name or authentication information.|

    - In all cases, the NETLOGON.LOG shows DsGetDcName request making calls for writable domain controllers:

        > [MISC] [3736] DsGetDcName function called: client PID=568, Dom:VS Acct:(null) Flags: DS WRITABLE NETBIOS RET_DNS  
        [CRITICAL] [3736] NetpDcMatchResponse: CON-DC4: `CONTOSO.COM`.: Responder is not a writable server.  
        >
        > [MISC] [2600] DsGetDcName function returns 1355 (client PID=564): Dom:VS Acct:(null) Flags: FORCE DS WRITABLE NETBIOS RET_DNS

        Where:

        | Hex| Decimal| Symbolic| Friendly |
        |---|---|---|---|
        | 0x54b|1355|ERROR_NO_SUCH_DOMAIN|The specified domain either does not exist or could not be contacted.|

## Cause

When a user logs on to a computer for the first time and tries to encrypt data for the first time, the operating system must create a preferred DPAPI MasterKey, which is based on the user's current password. During the creation of the DPAPI MasterKey, An attempt is made to back up this master key by contacting an RWDC. If the backup fails, the MasterKey cannot be created and a 0x80090345 error is returned.

This failure is new behavior, which was introduced by [KB2992611](https://support.microsoft.com/help/2992611). In older operating systems and on systems that don't have KB2992611 installed, if the client fails to contact an RWDC during backup of the MasterKey, the creation of the master key is still allowed, and a local backup is created.

That is, the legacy behavior performs a local backup of the master key if no RWDC is available.

Consistent with the design brief that RODCs don't store secrets, RODCs do not store or handle the backup of the MasterKey. Therefore, in sites where no RWDC is available, the issues that are described in the "Symptoms" section may occur.

> [!NOTE]
> When a preferred master key exists but has expired (expired password case), an attempt to generate a new master key is made. If it's not possible to create a domain backup of the new master key, the client falls back to the old one, and the behavior that's described in the "Symptoms" section does not occur.

The problem occurs only if there's no MasterKey present and when the user has not logged on to the computer before.

## Resolution

1. Verify that domain-joined workstations and servers where the issue occurs have access to RWDCs.

    Run the following command line to verify that an RWDC exists and is in a healthy state:

    ```console
    nltest /dsgetdc:<domain> /writable [/force]
    ```

    Use NETLOGON.LOG and a network trace with the provided log examples in this article to verify name resolution and connectivity to an RWDC.  
    To determine whether you're experiencing this issue, try opening CREDMAN in Control Panel. If the attempt fails with a 0x80090345 error, you have verified this.  
2. If possible, take the computer to a site where an RWDC exists and then log on there for the first time. After this, the DPAPI MasterKey will be created, and the issue will be resolved.
3. If you have no access to an RWDC and if the user will not be roaming between machines, the following registry entry can be used to resolve the issue.

    Setting this value to 1 causes DPAPI master keys to be backed up locally instead of using a domain backup. Additionally, any previously created keys do not trigger calls for a writable domain controller except in limited cases as explained below. This registry setting applies only to domain accounts. Local accounts always use local backups.

    | **Path**|HKEY_LOCAL_MACHINE\Software\Microsoft\Cryptography\Protect\Providers\df9d8cd0-1501-11d1-8c7a-00c04fc297eb|
    |---|---|
    | **Setting**|ProtectionPolicy|
    | **Data Type**|DWORD|
    | **Value**|1|
    | **OS restart requested**|Yes|
    | **Notes**|OS|

> [!Warning]
> Don't use this registry key if domain users log on to more than one computer! Because the keys are backed up locally, any non-local password change may trigger a situation in which all DPAPI master keys are wrapped using the old password, and then domain recovery is not possible. This registry key should be set only in an environment in which data loss is acceptable.

## More information

|Topic|Details|
|---|---|
|Windows Data Protection| [Windows Data Protection](https://msdn.microsoft.com/library/ms995355.aspx) <br/><br/>Key backup and restoration in DPAPI<br/>When a computer is a member of a domain, DPAPI has a backup mechanism to allow unprotection of the data. When a MasterKey is generated, DPAPI talks to a Domain Controller. Domain Controllers have a domain-wide public/private key pair, associated solely with DPAPI. The local DPAPI client gets the domain controller public key from a domain controller by using a mutually authenticated and privacy protected RPC call. The client encrypts the MasterKey with the domain controller public key. It then stores this backup MasterKey along with the MasterKey protected by the user's password. While unprotecting data, if DPAPI cannot use the MasterKey protected by the user's password, it sends the backup MasterKey to a Domain Controller by using a mutually authenticated and privacy protected RPC call. The domain controller then decrypts the MasterKey with its private key and sends it back to the client by using the same protected RPC call. This protected RPC call is used to ensure that no one listening on the network can get the MasterKey.|
|RODC Placement Considerations| [RODC Placement Considerations](https://technet.microsoft.com/library/cc732632%28v=ws.10%29.aspx) |
|Linked KB that changes the behavior/starts this issue.| [November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 (KB3000850)](https://support.microsoft.com/help/3000850) |
|Backup Key Remote Protocol doc|[Appendix B: Product Behavior](https://msdn.microsoft.com/library/cc224192.aspx) <br/> [Performing Client-Side Wrapping of Secrets](https://msdn.microsoft.com/library/cc448618.aspx) <br/><br/>A BackupKey Remote Protocol server does not actually perform remote backup of secrets. Instead, the server wraps each secret and returns it to the client. The client is responsible for storing the secret until it is needed again, at which point the client can request the server to unwrap the secret<br/><br/>See 3.1.4.1.3 BACKUPKEY_RETRIEVE_BACKUP_KEY_GUID|
  
