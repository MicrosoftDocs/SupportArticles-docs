---
title: Can't sign in to a domain controller and the LSASS process stops responding
description: Helps to fix the issue in which you can't sign in to a domain controller, and the Local Security Authority Subsystem Service (LSASS) process stops responding.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom: sap:User Logon and Profiles\Service Account and Interactive User Logon Issues and Credential Providers, csstroubleshoot, ikb2lmc
---
# Can't sign in to a domain controller, and the LSASS process stops responding

This article helps fix the issue in which you can't sign in to a domain controller, and the Local Security Authority Subsystem Service (LSASS) process stops responding.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 3144809

You can't sign in to a domain controller after reboot, and you experience the following scenarios:

- You can type the username and password in the sign-in screen, but when you press <kbd>Enter</kbd>, nothing happens.
- The sign-in doesn't proceed without errors.
- If you disconnect the network interface card (NIC), you can sign in with cached credentials.
- The LSASS process stops responding or has stopped responding recently.
- Many services can't start due to a sign-in failure.

When this issue occurs, the system event log may contain one or more of the following events:

|Event log  |Event source  |ID  |Message text  |
|---------|---------|---------|---------|
|System     |LsaSrv         |5000         |The security package NTLM generated an exception. The exception information is the data.<br/>OR<br/>The security package MICROSOFT_AUTHENTICATION_PACKAGE_V1_0 generated an exception. The exception information is the data.<br/><br/>The extended error is E0010014|
|System     |LsaSrv         |6038         |Microsoft Windows Server has detected that NTLM authentication is presently being used between clients and this server. This event occurs once per boot of the server on the first time a client uses NTLM with this server.         |
|System     |Application Popup         |26         |Application popup: lsass.exe - Application Error : The exception unknown software exception (0xe0010004) occurred in the application at location 0x90cf8b9c.         |
|System     |User32         |1074         |The process wininit.exe has initiated the restart of computer \<DC\> on behalf of user for the following reason:<br/><br/>No title for this reason could be found.<br/><br/>Reason Code: 0x50006<br/><br/>Shutdown Type: restart<br/><br/>Comment: The system process 'C:\Windows\system32\lsass.exe' terminated unexpectedly with status code -536805372. The system will now shut down and restart.|
|System     |Service Control Manager         |7038         |The \<Service Name\> service was unable to log on as NT AUTHORITY\\SYSTEM with the currently configured password due to the following error: The RPC server is unavailable.         |
|System     |Service Control Manager         |7000         |The \<Service Name\> service failed to start due to the following error: The service did not start due to a logon failure.         |
|System     |Microsoft-Windows-Time-Service         |46         |The time service encountered an error and was forced to shut down. The error was: 0x80070721: A security package specific error occurred.         |
|System     |Service Control Manager         |7023         |The IPsec Policy Agent service terminated with the following error: The authentication service is unknown.         |
|System     |Netlogon         |5774         |The dynamic registration of the DNS record '\<DNS Record\>' failed on the following DNS server: DNS server IP address: \<DNS ServerIP\> Returned Response Code (RCODE): 5 Returned Status Code: 9017 ... ADDITIONAL DATA Error Value: DNS bad key.         |

You may also find errors in the event trace log (ETL) or the memory dump analysis:

|Error  |Log and comment  |
|---------|---------|
|DSA_DB_EXCEPTION<br/>Error code: 0xfffff9bf (4294965695):<br/>JET_errRecordNotFound - esent.h: /* The key was not found */|LSASS exception crash dump         |
|C:\tools>err -536805372<br/>\# for decimal -536805372 / hex 0xe0010004<br/>DSA_DB_EXCEPTION dsexcept.h|User32 Event status code         |
|[1]035C.0160::02/23/16-13:26:11.0878836 [Microsoft-Windows-Shell-AuthUI-Common/Diagnostic ] DWORD1=2147943515, DWORD2=0     |Shell-AuthUI ETL<br/>Error code: (HRESULT) 0x8007045b (2147943515) - A system shutdown is in progress.<br/>"This error is coming from this global setting and I see this set in all the dumps.<br/>0: kd> dt lsasrv!ShutdownBegun"|
|NetLogon:LogonSAMPauseResponseEX (SAM Response when Netlogon is paused): 24 (0x18)     |Network trace         |

## The Password Settings Container is moved or missing

In Windows Server 2012 and later versions, the authentication process makes a function call to determine fine-grained password policies, and it looks for the Password Settings Container. If it isn't present under *cn=system,dc=\<domain\>,dc=\<com\>* in the Active Directory domain naming context, or it's in an incorrect location, the sign-in fails.

> [!NOTE]
> The Password Settings Container is a default system container that should always be present. This container is created as part of Adprep for Windows Server 2008 and later versions' domain controllers to support [fine-grained password policies](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770394(v=ws.10)).

## Move the container to the correct location or rerun Adprep

If the Password Settings Container is in the incorrect location, follow these steps:

1. Run the following command to search for the container:

    ```console
    repadmin /showattr . ncobj:domain: /filter:"(objectclass=msds-PasswordSettingsContainer)" /subtree
    ```

    > [!NOTE]
    > You can run the `repadmin /showobj` command to check when the container was last modified.
2. Open the LDP tool and select **Browse** > **Modify RDN** to move the object to the correct location under the system container.

If the Password Settings Container doesn't exist, follow these steps:

1. Sign in to the Infrastructure master as a domain admin.
2. Create a .txt file with the following text:

    ```output
    dn: CN=ActiveDirectoryUpdate,CN=DomainUpdates,CN=System,DC=contoso,dc=com
    changetype: modify
    replace: revision
    revision: 1
    ```

3. Open an elevated command prompt, and run the `ldifde` command to import the file.

    ```console
    ldifde -i -f <File Name>
    ```

4. In the LDP tool or the Active Directory Service Interface (ADSI) Editor tool, delete the containers of the operations you need to rerun. For example:

    cn=71482d49-8870-4cb3-a438-b6fc9ec35d70,cn=Operations,cn=DomainUpdates,cn=System,DC=fia,DC=local.
5. Run the `adprep /domainprep` command.

You can check the *ADPrep.log* file (*C:\\Windows\\debug\\adprep\\logs\\\<Date Time\>\\ADPrep.log*) to verify the result.

> [!NOTE]
> Windows Server 2019 and later versions have an update that prevents the LSASS process from stopping responding.
