---
title: HTTP 500 error connecting to the OpsMgr web console
description: Fixes an issue in which you receive HTTP 500 error when you remotely connect to a stand-alone Operations Manager web console.
ms.date: 01/17/2023
ms.prod-support-area-path: 
---
# HTTP 500 error when you connect to the Operations Manager web console

This article provides a resolution to solve the HTTP 500 error that occurs when you remotely connect to the Operations Manager web console.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 4487099

## Symptoms

You install a stand-alone Operations Manager web console on a server. When you connect to the web console at `http://<web_host>/OperationsManager` from a remote computer, you receive the following error message:

> 500 - Internal server error.

This issue doesn't occur if you connect to the web console from the web console server.

## Resolution

To fix the issue, verify the following settings, and then connect to the web console again:

1. The SDK (Data Access) Service Principal Names (SPNs) are registered correctly.

   The SPNs must be registered to the account under which the SDK service is running.

    - If the SDK service is running under a domain account, SPNs must be registered to this domain account. To check whether SPNs are registered correctly, run the following command:

         ```console
         setspn -L DOMAIN\sdkdomainaccount
         ```

      Here is sample output in which there are two management servers, *SCOM1* and *SCOM2*, and the SDK service is running under domain service account *CONTOSO\SCOMSdk*:

      > Registered ServicePrincipalNames for CN= SCOMSdk,OU=SCOMAccounts,DC= CONTOSO,DC=COM:  
      > MSOMSdkSvc/SCOM1  
      > MSOMSdkSvc/SCOM1.CONTOSO.COM  
      > MSOMSdkSvc/SCOM2  
      > MSOMSdkSvc/SCOM2.CONTOSO.COM

       In the output, `MSOMSdkSvc` SPN is registered for both management servers. For each management server, there's one entry for the NetBIOS name and another entry for the fully qualified domain name (FQDN).

       Additionally, when you run the following command for each management server, the output mustn't contain any SPN for MSOMSdkSvc:

         ```console
         setspn -L servername
         ```

    - If the SDK service is running under LocalSystem account, the SPNs must be registered to the computer account of the management server.

      To check whether SPNs are registered correctly, repeat the following command for each management server:

        ```console
        setspn -L servername
        ```

        The output for each management server must contain the following entries:

        > MSOMSdkSvc/serverNETBIOSname  
        > MSOMSdkSvc/serverFQDN

2. The SPN for the HTTP service is registered for the web console server.

    When you use default settings for the web console application pools, run the following commands to register the HTTP service SPN for the web console server computer account:

    ```console
    setspn -S HTTP/serverFQDN serverAccount
    setspn -S HTTP/serverNETBIOSname serverAccount
    ```

    *serverFQDN* and *serverNETBIOSname* are the FQDN and NetBIOS name of the web console server. And *serverAccount* is the computer account of the web console server.

    To check whether the SPNs are registered correctly, run the following command:

    ```console
    Setspn -L webconsoleservername
    ```

    The output must contain the following entries:

    > HTTP/serverFQDN  
    > HTTP/serverNETBIOSname

3. The delegation for the web console is configured correctly in Active Directory. To do this, follow these steps:

      1. Start the **Active Directory Users and Computers** MMC.
      2. In the console tree, select **Computers**.
      3. In the details pane, right-click the computer on which the web console is installed, and then select **Properties**.
      4. Select the **Delegation** tab.
      5. Select **Trust this computer for delegation to specified services only**, select **Use any authentication protocol**, and then select **Add**.

          :::image type="content" source="media/http-500-error-connecting-to-web-console/delegation.png" alt-text="Screenshot of the options on the Delegation tab.":::

      6. In the **Add Services** dialog box, select **Users or Computers**.

      7. In the **Select Users or Computers** dialog box, specify the domain account that the SDK service is running under, and then click **OK**.
  
      8. In the **Add Services** dialog box, select service type `MSOMSdkSvc`, and then click **OK**.
  
      9. If you have multiple management servers, verify that MSOMSdkSvc SPNs for all management servers are listed.
  
     10. Select **Expanded**, and then verify that there are two entries for each management server (both NetBIOS name and FQDN).
  
     11. Click **OK** to close the **Properties** dialog box.

Listed below are the details to assist in the guide (replace with the name you have)

### Demo Names

- `SCOMMS.Lab.Local` - Management Server Name FQDN
- `SCOMWeb.Lab.Local` - SCOM Web console Server FQDN
- `Lab\SDKSvc` - SCOM Data Access Service Account (Optional)
- `Lab\SCOMAppPool` - SCOM Application Pool Identity Account (Optional)
- Https://mySCOM.Lab.Local/OperationsManager - URL used to access Operations Manager Web console (If there is no URL, substitute this with the Operations Manager Web console server name)
 
### Register the SDK SPNs

To registerthe SDK SPNs, run the below commands based on the scenario:

**Scenario 1**: The SDK runs as a Local System

`Setspn.exe -S MSOMSdkSvc/SCOMMS SCOMMS`
`Setspn.exe -S MSOMSdkSvc/SCOMMS.Lab.Local SCOMMS`
 
**Scenario 2**: The SDK runs as a Domain Account (SDKSvc)

`Setspn.exe -S MSOMSdkSvc/SCOMMS SDKSvc`
`Setspn.exe -S MSOMSdkSvc/SCOMMS.Lab.Local SDKSvc`
 
To verify if the service was registered, enter the command `SetSpn.exe -L SDKSvc`
 
### Register the HTTP SPNs

To register the HTTP SPNs, run the below commands based on the scenario:

**Scenario 1**: The Web console application pool runs under the default identity (ApplicationPoolIdentity).

`Setspn.exe -S HTTP/mySCOM SCOMWeb`
`Setspn.exe -S HTTP/mySCOM.Lab.Local SCOMWeb`
 
**Scenario 2**: The Web console application pool runs under a custom identity (Lab\SCOMAppPool).
 
`Setspn.exe -S HTTP/mySCOM SCOMAppPool`
`Setspn.exe -S HTTP/mySCOM.Lab.Local SCOMAppPool`
 
To verify if the service was registered, enter the command `SetSpn.exe -L SCOMAppPool`
 
### Configure constraint delegations

To configure constraint delegations, follow these steps:

1.	Open **Active Directory Users and Computers**.
2.	In the console tree, select **Computers**.
3.	Open the properties based on the below scenarios:
    1. **Scenario 1**: The Operations Manager web application pool runs under default Identity (ApplicationPoolIdentity)
        -	Right-click the computer where the web console is installed on (SCOM Web) and select **Properties**.
    2. **Scenario 2**: The Operations Manager web application pool runs under custom Identity (Lab\SCOMAppPool)
	      - Right-click the user which is configured on the Web Application Pool identity (Lab\SCOMAppPool) and select **Properties**.
4.	In the details pane, select **Delegation**.
5.	On the **Delegation** tab, select **Trust this computer for delegation to specified services only.** and choose **Use Kerberos only**.
6.	Select **Add**.
7.	In the **Add Services** dialog, select **Users and Computers**.
8.	In the **Select Users or Computers** dialogue, specify the following, based on the scenario:
    - **Scenario 1**: If the SDK is running as a Local System, select the computer account of the SCOM management server (SCOMMS) and select **OK**.
    - **Scenario 2**: If the SDK is running as Domain Account (SDKSvc), select the domain account that the SDK service is running under (SDKSvc) and select **OK**.
9.	In the **Add Services** dialog, select the service type **MSOMSdkSvc** and select **OK**.
10.	Select **OK** to close the Properties dialog. 
 
### Verify end user account options

To verify that the user logging into the web console doesn't have the **Account is sensitive and cannot be delegated** checkbox selected, follow these steps:

1.	Open **Active Directory Users and Computers**.
2.	Right-click the UserAccount, and then select **Properties**. The UserAccount is the account used to connect to the web console. 
3.	Select **Account**.
4.	In the Account options box, confirm that it is not selected.