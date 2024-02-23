---
title: Kerberos authentication for MAPI client connection to Client Access
description: Describes how to configure Kerberos authentication for MAPI clients that connect to  a Client Access server array in Exchange Server 2010 Service Pack 1 (SP1).
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
ms.date: 01/24/2024
ms.reviewer: v-six
---

# Kerberos authentication for MAPI client connection to a Client Access server array

## Summary

For Microsoft Exchange Server 2010 deployments that have more than one Client Access server in an Active Directory site, the topology frequently requires a Client Access server array and a load-balancing solution to distribute traffic among all the Client Access servers in the site. Because of changes in Exchange Server 2010, MAPI email clients can't use Kerberos authentication to connect to a mailbox when a Client Access server array is being used. To work around this behavior, Microsoft Exchange Server Service Pack 1 (SP1) includes new functionality that lets you configure Kerberos authentication for MAPI email clients in a Client Access server array. 

For more information about how Kerberos authentication worked in earlier versions of Exchange Server and about the changes in Exchange Server 2010 that prevent Kerberos authentication from working with MAPI email clients, see the following blog post on the Exchange Team blog:

[Recommendation: Enabling Kerberos Authentication for MAPI Clients](https://blogs.technet.com/b/exchange/archive/2011/04/15/recommendation-enabling-kerberos-authentication-for-mapi-clients.aspx)  

## More Information

The Microsoft Exchange Service Host service that runs on the Client Access server (CAS) role is extended in Exchange Server 2010 SP1 to use a shared alternate service account (ASA) credential for Kerberos authentication. This service host extension monitors the local computer. When credentials are added or removed, the Kerberos authentication package on the local system and the network service context is updated. As soon as a credential is added to the authentication package, all client access services can use it for Kerberos authentication. The Client Access server will also be able to authenticate service requests addressed directly in addition to being able to use the ASA credential. This extension, known as a servicelet, runs by default and requires no configuration or action to run. 

You may have to use Kerberos authentication for your Exchange Server 2010 organization for the following reasons: 

- Kerberos authentication is required for your local security policy.   
- You're encountering or expecting NTLM scalability issues, such as direct MAPI connectivity to the RPC Client Access service causing intermittent NTLM failures. 

    In large-scale customer deployments, NTLM can cause bottlenecks on Client Access servers. This can cause intermittent authentication failures. Services that use NTLM authentication are more sensitive to Active Directory latency issues. These lead to authentication failures when the rate of Client Access server requests increases.   

To configure Kerberos authentication, you must be familiar with Active Directory and how to set up Client Access server arrays. You must also have a working knowledge of Kerberos authentication. 

To deploy the ASA credential for Kerberos authentication, follow these steps.

### Create an account to use as the ASA credential

All computers in the Client Access server array must share the same service account. This includes any Client Access servers that may start as part of a datacenter switchover. Generally, one service account per forest is sufficient.

Create a computer account instead of a user account for the alternate service account (ASA), because a computer account doesn't allow interactive logon. Therefore, a computer account may have simpler security policies than a user account and is the preferred solution for the ASA credential. 

For more information about how to create a computer account, see [Create a new computer account](/previous-versions/windows/it-pro/windows-server-2003/cc781364(v=ws.10)). 

> [!NOTE]
> When you create a computer account, the password doesn't expire. However, we recommend that you update the password periodically. The local Group Policy can specify a maximum account age for computer accounts, and network administrators may schedule scripts to periodically delete computer accounts that don't meet current policies. To make sure that your computer accounts aren't deleted if they don't meet local policy, update the password for computer accounts periodically. Your local security policy will determine when you must change the password. 

> [!NOTE]
> The password that you provide when you create the account is never actually used. Instead, the script resets the password. When you create the account, you can use any password that meets your organization's password requirements.

There are no particular requirements for the name of the ASA credential. You can use any name that follows your naming scheme. The ASA credential doesn't need special security privileges. If you are deploying a computer account for the ASA credential, this means that the account only needs to be a member of the Domain Computers security group. If you are deploying a user account for the ASA credential, this means that the account only needs to be a member of the Domain Users security group.

### Determine the SPNs to associate with the alternate service account credential

After you create the alternate service account, you must determine the Exchange service principal names (SPNs) that will be associated with the ASA credentials. The SPN values must be configured to match the service name that is used on the network load balancer instead of on individual servers. The list of Exchange SPNs may vary based on your configuration, but the list should include at least the following:

- http Use this SPN for Exchange Web Services, Offline Address Book downloads, and the Autodiscover service.   
- exchangeMDB Use this SPN for RPC Client Access.   
- exchangeRFR Use this SPN for the Address Book service.   
- exchangeAB Use this SPN for the Address Book service.   

For a small business, you probably won't have anything larger than a single Active Directory site. For example, your single Active Directory site may resemble the following diagram.

:::image type="content" source="media/kerberos-authentication-for-mapi-client/small-business.png" alt-text="Screenshot of a small business that contains a single Active Directory site.":::

To determine the SPNs that you would use in this example, we must look at the fully qualified domain names (FQDNs) that are used by the internal Outlook clients in the previous illustration. In this example, you would deploy the following SPNs on the ASA credential:

- http/mail.corp.contoso.com   
- http/autod.corp.contoso.com   
- exchangeMDB/outlook.corp.contoso.com   
- exchangeRFR/outlook.corp.contoso.com   
- exchangeAB/outlook.corp.contoso.com   

> [!NOTE]
> External or Internet-based clients that use Outlook Anywhere won't use Kerberos authentication. Therefore, you don't have to add the FQDNs that these clients use as SPNs to the ASA credential. 

If your site is larger than a single Active Directory site, you can see more examples in the topic[ Configuring Kerberos Authentication for Load-Balanced Client Access Servers](/Exchange/architecture/client-access/kerberos-auth-for-load-balanced-client-access) .

### Convert the OAB virtual directory to an application

The offline address book (OAB) virtual directory is not a web application. Therefore, it is not controlled by the Microsoft Exchange Service Host service. As a result, the ASA credential can't decrypt Kerberos authentication requests to the OAB virtual directory. 

To convert the OAB virtual directory to an IIS web application, execute the ConvertOABVDir.ps1 script on each CAS member. The script will also create a new application pool named MSExchangeOabAppPool for the OAB virtual directory. To download the script, go to the [ ConvertOABDir.p​s1](https://gallery.technet.microsoft.com/scriptcenter/525fb1dc-b612-4998-a2d1-55f32a6c35ac) page on the Microsoft Script Center. 

### Deploy the ASA credential to the CAS members

Exchange Server 2010 SP1 includes a script to enable deployment of the ASA credential. The script is named RollAlternateServiceAccountPassword.ps1 and is located in the Scripts directory. 

To use the script to push the credential to all Client Access servers in the forest for first-time setup, follow these steps:

1. In the Exchange Management Shell, run the following command:

    ```powershell
    .\RollAlternateserviceAccountPassword.ps1 -ToEntireForest -GenerateNewPasswordFor "Your_Domain_Name\Computer_Account_Name$" -Verbose
    ```

2. Run the following command to schedule a once-a-month automated password roll scheduled task called "Exchange-RollAsa." This command-scheduled task will update the ASA credential for all Client Access servers in the forest with a new, script-generated password. The scheduled task is created, but the script is not run. When the scheduled task is run, the script runs in unattended mode.

    ```powershell
    .\RollAlternateServiceAccountPassword.ps1 -CreateScheduledTask "Exchange-RollAsa" -ToEntireForest -GenerateNewPasswordFor "Your_Domain_Name\Computer_Account_Name$"
    ```

For more information about how to use the RollAlternateserviceAccountPassword.ps1 script, see [ Using the RollAlternateserviceAccountPassword.ps1 Script in the Shell](/exchange/using-the-rollalternateserviceaccountcredential-ps1-script-in-the-shell-exchange-2013-help) .

### Verify the deployment of the ASA credential

In the Exchange Management Shell, run the following command to check the settings on the Client Access servers: `Get-ClientAccessServer -IncludeAlternateServiceAccountCredentialStatus | fl name,*alter*`

The result of this command will resemble this:

```AsciiDoc
Name : CASAAlternateServiceAccountConfiguration : Latest: 8/2/2010 3:48:38 PM, contoso\newSharedServiceAccountName$ Previous: <Not set>Name : CASBAlternateServiceAccountConfiguration : Latest: 8/2/2010 3:48:51 PM, contoso\newSharedServiceAccountName$ Previous: <Not set>
```

### Associate SPNs with the ASA credential

Before you configure the SPNs, make sure that the target SPNs aren't already configured on a different account in the forest. The ASA credential must be the only account in the forest with which these SPNs are associated. You can verify that no other account in the forest has the SPNs associated with it by opening a command prompt and running the **setspn** command with the **–q** and **–f** parameters. The following example shows how to run this command. The command should return nothing. If it returns a value, another account is already associated with the SPN that you want to use.

> [!NOTE]
> You can only use the duplicate-checking forest wide parameter (-f) together with the setspn command on computers that are running Windows Server 2008.

```powershell
Setspn -q -f exchangeMDB/outlook.**domain.domain.domain_root**
```

In this command, **exchangeMDB/outlook.domain.domain.domain_root** is the SPN of the SPN for RPC Client Access such as **exchangeMDB/outlook.corp.contoso.com**.

The following command shows how to set the SPNs on the shared ASA credential. You have to run the setspn command with this syntax one time for every target SPN that you identify. 

```powershell
Setspn -S exchangeMDB/outlook.corp.contoso.com contoso\newSharedServiceAccountName$
```

After you set the SPNs, verify that they were added by running the following command. 

```powershell
Setspn -L contoso\newSharedServiceAccountName
```

After you successfully configure Kerberos and deploy the RollAlternateServiceAccountPasswordl.ps1 script, verify that client computers can authenticate successfully. 

Verify that the Microsoft Exchange Service Host service is running

Make sure that you have installed Exchange Server 2010 SP1 Rollup 3 or a later version on all Client Access servers in your environment. The Microsoft Exchange Service Host service on the Client Access servers is responsible for managing the ASA credential. If this service isn't running, Kerberos authentication won't work. By default, the service is configured to start automatically when the computer starts. To verify that the service is running, follow these steps:

1. Open Services on the CAS. To open Services, click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Services**. 
2. In the list of services, locate Microsoft Exchange Service Host service.   
3. In the **Status** column, verify that the status is Started. If the service is not started, right-click **Microsoft Exchange Service Host service**, and then click **Start**. To configure the service to start automatically, right-click **Microsoft Exchange Service Host service**, click **Properties**, click **Automatic**in the **Startup type** list, and then click **OK**.   
Validate authentication from Outlook

To confirm that Outlook can use Kerberos authentication to connect to the Client Access servers, follow these steps:

1. Confirm that Outlook is configured to point to the correct load-balanced Client Access server array.    
2. Configure the email account server security settings to use logon network security Negotiate Authentication. 
NoteYou could configure the client to use Kerberos Password Authentication, but if the SPNs are ever removed, the client computers won't be able to authenticate until you change the authentication mechanism back to Negotiate Authentication.   
3. Make sure that Outlook Anywhere is not enabled for the client computer. If Outlook can't authenticate by using Kerberos Password Authentication, it will try to fall back to Outlook Anywhere, so Outlook Anywhere should be disabled for this test.    
4. Restart Outlook.   
5. If your desktop computer is running Windows 7, you can run klist.exe to see which Kerberos tickets are granted and are being used. If you aren't  running Windows 7, you can obtain klist.exe from the Windows Server 2003 Resource Kit.   

## Additional Resources 

For detailed information about this issue and its work around, see the following TechNet article:

[Using Kerberos with a Client Access Server Array or a Load-Balancing Solution](/previous-versions/office/exchange-server-2010/ff808313(v=exchg.141)) 

For more information about how to use Kerberos authentication on load-balanced client access servers, see the following TechNet article:

[Configuring Kerberos Authentication for Load-Balanced Client Access Servers](/Exchange/architecture/client-access/kerberos-auth-for-load-balanced-client-access)