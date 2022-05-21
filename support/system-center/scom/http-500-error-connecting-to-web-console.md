---
title: HTTP 500 error connecting to the OpsMgr web console
description: Fixes an issue in which you receive HTTP 500 error when you remotely connect to a stand-alone Operations Manager web console.
ms.date: 06/30/2020
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
