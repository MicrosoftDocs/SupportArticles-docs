---
title: ADFS 2.0 service fails to start
description: Provides troubleshooting steps for ADFS service configuration and startup problems.
ms.date: 12/09/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, abizerh, maweeras, fszita, timccu
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# AD FS 2.0 service fails to start

This article provides troubleshooting steps for ADFS service configuration and startup problems.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3044973

## Summary

Most of ADFS 2.0 problems belong to one of the following main categories. This article contains the step-by-step instructions to troubleshoot ADFS service problems.

- [Connectivity problems](https://support.microsoft.com/help/3044971)
- ADFS service problems (KB 3044973)
- [Certificate problems](https://support.microsoft.com/help/3044974)
- [Authentication problems](adfs-error-401-requested-resource-requires-authentication.md)
- [Claim rules problems](adfs-2-error-access-is-denied.md)

## Symptoms

- The AD FS service does not start.

- The AD FS service starts, but the following errors are logged in the AD FS Admin log after a restart:
  - Event ID: 220  
    The Federation Service configuration could not be loaded correctly from the AD FS configuration database.
  - Event ID: 352  
    A SQL Server operation in the AD FS configuration database with connection string *%1* failed.
  - Event ID: 102  
    There was an error in enabling endpoints of the Federation Service.

## Resolution

To resolve this problem, follow these steps, in the order given. These steps will help you determine the cause of the problem. Make sure that you check whether the problem is resolved after every step.

### Step 1: Check whether the AD FS service times out during startup

If the AD FS service times out when it tries to start, you receive the following error message:

> The service did not respond to the start or control request in a timely fashion.

#### Fix AD FS service times

Change the value data for the **ServicesPipeTimeout** DWORD value to **60000** in the **Control** key. To do this, follow these steps:

1. On the AD FS server, open Registry Editor.
2. Locate and then click the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet`
3. Click the **Control** subkey.
4. Right-click the **ServicesPipeTimeout** DWORD value, and then click **Modify**. If there is no **ServicesPipeTimeout** value, create it.
5. Click **Decimal**.
6. Type *60000*, and then click **OK**. For more information about this time-out error, see [AD FS 2.0: The Service Fails to Start: "The service did not respond to the start or control request in a timely fashion"](https://social.technet.microsoft.com/wiki/contents/articles/1437.ad-fs-2-0-the-service-fails-to-start-the-service-did-not-respond-to-the-start-or-control-request-in-a-timely-fashion.aspx).

### Step 2: Check whether the AD FS configuration database is running

- If you are using Windows Internal Database (WID) as an AD FS configuration database, open services.msc, and check whether the Windows Internal Database service is running.

- If you are using the SQL Server service as an AD FS configuration database, open services.msc. Check whether the SQL Server service is running. You can also create a Test.udl file and populate the connection string to test connectivity to Microsoft SQL Server.

#### How to fix

Open Services.msc, and then start the Windows Internal Database service or SQL Server service.

For an AD FS server that uses SQL Server as configuration database, you must also check two security settings, as follows:

1. Connect to the server that is running SQL Server by using SQL Management Studio.

2. Check whether the AD FS 2.0 Windows service identity exists on the SQL Server console on the **Security** > **Logins** node. If it doesn't, add it.

3. Check whether the AD FS 2.0 Windows service identity exists under **Databases** > **AdfsConfiguration** > **Security** > **Users**, and that it owns the **IdentityServerPolicy** schema. If it doesn't, add it.

### Step 3: Check the AD FS Service account

1. Check whether the AD FS service and the IIS AppPool are running under a valid service account. If you changed the password of the service account, make sure that the new password is updated in the AD FS service and in the IIS AppPool.

    1. Open Services.msc, right-click **AD FS 2.0 Service**, and then click **Properties**. On the **Log on** tab, make sure that the new AD FS service account is listed in the **This account** box.

    2. Open IIS Manager, navigate to **Application Pools**, right-click **ADFSAppPool**, and then click **Advanced Settings**. In **Process Model** section, make sure that the new AD FS service account is listed as **Identity**.

2. Check whether the service account has sufficient permissions in the AD FS database. You should be concerned about the permission if you have changed the service account the ADFS is running under.

    If you are using SQL Server as configuration server, follow these steps to reset the permission for service account:
  
    1. At a command prompt, run the following command:

        ```console
        fsconfig.exe /CreateSQLScripts /ServiceAccount <ADFS service account> /ScriptDestinationFolder <path to create scripts>
        ```

    2. Copy the script that you created to the server that is running SQL Server.
    3. Run the script on the server.

3. Check whether the service account has read and modify permissions on the (**CN=\<GUID>,CN=ADFS,CN=Microsoft,CN=Program Data,DC=\<Domain>,DC=\<COM>**) Certificate Sharing container.

    1. On a domain controller, open ADSIEDIT.msc.
    2. Connect to the Default naming context.
    3. Navigate to **CN=\<GUID>,CN=ADFS,CN=Microsoft,CN=Program Data,DC=\<Domain>,DC=\<COM>**. An example of a GUID is 62b8a5cb-5d16-4b13-b616-06caea706ada.
    4. Right-click the GUID, and then click **Properties**. If there is more than one GUID, follow these steps to find the GUID for the server that is running the AD FS service.

        1. On the server that is running the AD FS service, start Windows PowerShell.
        2. Run the following commands:

            ```powershell
            Add-PSSnapin microsoft.adfs.powershell

            Get-ADFSProperties
            ```

        3. The GUID is listed under **CertificateShareingContainer**.

4. Check whether the new service account has the Read permission on the AD FS service communication certificate's private key.

    1. Create a Microsoft Management Console (MMC) by using the Certificates snap-in that targets the Local Machine certificate store.
    2. Expand the MMC, and then select **Manage Private Keys**.
    3. On the **Security**  tab, add the AD FS service account, and grant the Read permission to this account.

5. Check whether the AD FS Service Principal Name (SPN) HOST/ADFSServiceName was added under the service account and was removed from the previous account (in case the service account changed).

    1. Right-click **Command Prompt**, and then click **Run as administrator**.
    2. Type `SetSPN -f -q host/ <Federation service name>`, and then press Enter.

    In this command, \<Federation service name> represents the fully qualified domain name (FQDN) service name of the AD FS service endpoint. You can find the service name in the **Federation Service Properties** dialog box:

    :::image type="content" source="media/adfs-2-service-fails-to-start/federation-service-name.png" alt-text="Screenshot of the Federation Service Properties window showing the Federation Service name.":::

    To add or remove the SPN from the account, follow these steps:

    1. On a domain controller, open ADSIEDIT.msc.
    2. Connect to the Default naming context.
    3. Expand to **CN=Users,CN=Microsoft,CN=Program Data,DC=\<Domain>,DC=\<COM>**.
    4. Locate the service account. Right-click the service account, and then click **Properties**.
    5. Locate the **servicePrincipalName** attribute, and then click **Edit**.
    6. Add or remove the AD FS service SPN. Here is an example of an AD FS service SPN:  

        HOST/newadfs.contoso.com

6. If you change the password of the service account, make sure that the new password is updated in the AD FS service and in IIS AD FS AppPool.

7. Check whether the AD FS service account is in the local Admin group. To avoid any potential issues, grant the AD FS service account local administrator rights.

### Step 4: Update the AD FS service to the latest version

Check whether the following updates are installed. If they are not, install them.

- [Rollup Update 2 for ADFS 2.0](https://support.microsoft.com/help/2681584)
- [Rollup update 3 for ADFS 2.0](https://support.microsoft.com/help/2790338)
- [Update is available to fix several issues after you install security update 2843638 on an AD FS server](https://support.microsoft.com/help/2896713)

### Step 5: Fix an intermittent AD FS service failure

If you encounter an intermittent AD FS service failure, check whether the problem started after security update 2894844 was applied. In such a situation, AD FS fails and generates a reference number when it is accessed from an external network or through a form-based communication.

If the problem did start after security update 2894844 was applied, you may be experiencing the problem that is described in the **Cause 1: The web application is running in a farm (multi-server environment)** section in [Resolving view state message authentication code (MAC) errors](https://support.microsoft.com/help/2915218).

To fix this problem, set the same static machine key on all the AD FS servers and the AD FS proxy:

1. In IIS Manager, locate and then open the adfs/ls folder.
2. In the ASP.NET section, click **Machine Key**.
3. Clear the **Automatically generate at runtime** and **Generate a unique key for each application** check boxes for both the **Validation** key and the **Decryption** key.
4. Click **Generate Keys**.
5. Click **Apply**.
6. Copy the validation and decryption keys from the first AD FS server, and then paste these keys to all the other servers.

### Step 6: Make sure that the ADFS service communication, token-signing, and token-decrypting certificates are configured correctly

For more information, see [ADFS 2.0 certificate error: An error occurred during an attempt to build the certificate chain](https://support.microsoft.com/help/3044974).
