---
title: HTTP 500 error connecting to the OpsMgr web console
description: Fixes an issue in which you receive HTTP 500 error when you remotely connect to a stand-alone Operations Manager web console.
ms.date: 02/06/2023
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

To fix the issue, verify the following settings, and then connect to the web console again. Following are the sample names to further clarify the configuration steps:

### Demo Names

- `SCOMMS1.Lab.Local` - Management Server Name FQDN
- `SCOMMS2.Lab.Local` - Management Server Name FQDN
- `SCOMWeb.Lab.Local` - System Center Operations Manager Web console Server FQDN
- `Lab\SDKSvc` - System Center Operations Manager Data Access Service Account (Optional)
- `Lab\SCOMAppPool` - System Center Operations Managers Application Pool Identity Account (Optional)
- https://mySCOM.Lab.Local/OperationsManager - The URL used to access Operations Manager Web console. If there is no URL, substitute this with the Operations Manager Web console server name.

1. The SDK (Data Access) Service Principal Names (SPNs) are registered correctly.

   The SPNs must be registered to the account under which the SDK service is running.

    - **Scenario 1**: If the SDK service is running under a domain account, SPNs must be registered to this domain account. To check whether SPNs are registered correctly, run the following command:

         ```console
         setspn -L sdkdomainaccount	(setspn -L SDKSvc)
         ```

      Here is the sample output based on the above demo names and the SDK service is running under domain service account *Lab\SDKSvc*:

      > Registered ServicePrincipalNames for CN= SDKSvc,CN=Users,DC= Lab,DC=Local:  
      > MSOMSdkSvc/SCOMMS1  
      > MSOMSdkSvc/SCOMMS1.Lab.Local  
      > MSOMSdkSvc/SCOMMS2  
      > MSOMSdkSvc/SCOMMS2.Lab.Local

       In the output, `MSOMSdkSvc` SPN is registered for both the management servers. For each management server, there's one entry for the NetBIOS name and another entry for the fully qualified domain name (FQDN).

       Additionally, when you run the following command for each management server, the output mustn't contain any SPN for MSOMSdkSvc:

         ```console
         setspn -L servername		(setspn -L SCOMMS1) or (setspn -L SCOMMS2)
         ```

    - **Scenario 2**: If the SDK service is running under LocalSystem account, the SPNs must be registered to the computer account of the management server.

      To check whether SPNs are registered correctly, repeat the following command for each management server:

        ```console
        setspn -L servername		(setspn -L SCOMMS1) or (setspn -L SCOMMS2)
        ```

        The output for each management server must contain the following entries:

        > MSOMSdkSvc/serverNETBIOSname  
        > MSOMSdkSvc/serverFQDN

2. The SPN for the HTTP service is registered to the account under which the IIS application pool is running.

    - Scenario 1: When you use default settings for the web console application pools where the web console application pool is running under the default identity (ApplicationPoolIdentity), run the following commands to register the HTTP service SPN for the web console server computer account:

    ```console
    setspn -S HTTP/serverFQDN serverAccount	(setspn -S HTTP\SCOMWeb.Lab.Local SCOMWeb)
    setspn -S HTTP/serverNETBIOSname serverAccount	(setspn -S HTTP\SCOMWeb SCOMWeb)
    ```

    *serverFQDN* and *serverNETBIOSname* are the FQDN and NetBIOS names of the web console server and *serverAccount* is the computer account of the web console server.

    To check whether the SPNs are registered correctly, run the following command:

    ```console
    Setspn -L webconsoleservername	(setspn -L SCOMWeb)
    ```

    The output must contain the following entries:

    > HTTP/serverFQDN  
    > HTTP/serverNETBIOSname

    - Scenario 2: When the web console application pool is running under a custom identity (Lab\SCOMAppPool), run the following commands to register the HTTP service SPN for the domain account:

    ```console
    setspn -S HTTP/serverFQDN APPidentityDomainAccount	(setspn -S HTTP/SCOMWeb.Lab.Local SCOMAppPool)
    setspn -S HTTP/serverNETBIOSname APPidentityDomainAccount	(setspn -S HTTP/SCOMWeb SCOMAppPool)
    ```
    To check whether the SPNs are registered correctly, run the following command:

    ```console
    Setspn -L APPidentityDomainAccount	(setspn -L SCOMAppPool)
    ```

    The output must contain the following entries:

    > HTTP/serverFQDN  
    > HTTP/serverNETBIOSname

3. The delegation for the web console is configured correctly in Active Directory. To do this, follow these steps:

    1. Start the **Active Directory Users and Computers** MMC.
    2. **Scenario 1**: If the Web console application pool is running under the default Identity (ApplicationPoolIdentity):    
         1. In the console tree, select **Computers**.
         2. In the details pane, right-click the computer on which the web console is installed, and then select **Properties**.
    3. **Scenario 2**: If the Web console application pool is running under a domain account (SCOMAppPool):
         1. In the console tree, select the OU that contains the Domain user.
         2.	In the details pane, right-click the **Domain Account used for the Application Pool**, and select **Properties**.

    4. Select the **Delegation** tab.
    5. Select **Trust this computer for delegation to specified services only**, select **Use any authentication protocol**, and then select **Add**.

          :::image type="content" source="media/http-500-error-connecting-to-web-console/delegation.png" alt-text="Screenshot of the options on the Delegation tab.":::

      6. In the **Add Services** dialog, select **Users or Computers**.

      7. In the **Select Users or Computers** dialog, follow these steps based on your scenario:
         1. **Scenario 1**: If the SDK is running as a Local System, select the computer account of the SCOM management server (**SCOMMS1/SCOMMS2**) and select **OK**. 
         2.	**Scenario 2**: If the SDK is running as a Domain Account (**SDKSvc**), select the domain account that the SDK service is running under (**SDKSvc**) and select **OK**.

  
      8. In the **Add Services** dialog, select service type `MSOMSdkSvc`, and select **OK**.
  
      9. If you have multiple management servers, verify that MSOMSdkSvc SPNs for all management servers are listed.
  
     10. Select **Expanded**, and then verify that there are two entries for each management server (both NetBIOS name and FQDN).
  
     11. Select **OK** to close the **Properties** dialog.
  
4. Verify end-user account options.

     1. To verify that the user logging into the web console doesn't have the **Account is sensitive and cannot be delegated** checkbox selected, follow these steps:

         1.	Open **Active Directory Users and Computers**.
         2.	Right-click the UserAccount, and then select **Properties**. The UserAccount is the account used to connect to the web console. 
         3. Select **Account**.
         4.	In the **Account options** box, confirm that it is not selected.