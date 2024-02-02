---
title: HTTP 500 error when connecting to the OpsMgr web console remotely
description: Fixes an issue in which you receive HTTP 500 error when you remotely connect to a stand-alone Operations Manager web console.
ms.date: 02/16/2023
ms.prod-support-area-path: 
---
# HTTP 500 error when you connect to the Operations Manager web console remotely

This article provides a resolution to solve the HTTP 500 error that occurs when you connect to the Operations Manager web console remotely.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 4487099

## Symptoms

You install a stand-alone Operations Manager web console on a server. When you connect to the web console at `http://<web_host>/OperationsManager` from a remote computer, you receive the following error message:

> 500 - Internal server error.

This issue doesn't occur if you connect to the web console from the web console server.

## Resolution

To fix the issue, perform the following configurations and verifications, and then connect to the web console again:

1. [Register the SDK SPNs.](#register-the-sdk-spns)
1. [Verify the SDK SPNs.](#verify-the-sdk-spns)
1. [Register the HTTP SPNs.](#register-the-http-spns)
1. [Verify the HTTP SPNs.](#verify-the-http-spns)
1. [Configure constraint delegations.](#configure-constraint-delegations)
1. [Verify "Account is sensitive and cannot be delegated" isn't set.](#verify-account-is-sensitive-and-cannot-be-delegated-isnt-set)
1. [Disable Kernel-mode authentication in IIS.](#disable-kernel-mode-authentication-in-iis)

> [!NOTE]
> The following sample names are used in the configuration and verification steps. You have to replace them with the names in your environment.
>
> - *SCOMMS.Lab.Local* - The fully qualified domain name (FQDN) of the System Center Operations Manager (SCOM) management server
> - *SCOMWeb.Lab.Local* - The FQDN of the server that hosts the SCOM Web console
> - *Lab\SDKSvc* - SCOM Data Access Service account (Optional)
> - *Lab\SCOMAppPool* - SCOM Application Pool Identity account (Optional)
> - `https://mySCOM.Lab.Local/OperationsManager` - URL that's used to access the Operations Manager Web console (If there's no URL, substitute this with the Operations Manager Web console server name.)

---

### SDK SPNs

#### Register the SDK SPNs

To register the System Center Data Access (SDK) Service Principal Names (SPNs), run the following commands according to different scenarios:

- ##### Scenario 1

  The SDK service runs under a LocalSystem account

    ```console
    Setspn.exe -S MSOMSdkSvc/SCOMMS SCOMMS
    Setspn.exe -S MSOMSdkSvc/SCOMMS.Lab.Local SCOMMS
    ```

- ##### Scenario 2

  The SDK service runs under a domain account (SDKSvc)

    ```console
    Setspn.exe -S MSOMSdkSvc/SCOMMS SDKSvc
    Setspn.exe -S MSOMSdkSvc/SCOMMS.Lab.Local SDKSvc
    ```

#### Verify the SDK SPNs

To verify if the SDK service is registered, run the following command according to different scenarios:

- ##### Scenario 1

  The SDK service runs under a LocalSystem account

    ```console
    Setspn.exe -L SCOMMS
    ```

- ##### Scenario 2

  The SDK service runs under a domain account (SDKSvc)

    ```console
    Setspn.exe -L SDKSvc
    ```

---

### HTTP SPNs

#### Register the HTTP SPNs

To register the HTTP SPNs, run the following commands according to different scenarios:

- ##### Scenario 1

  The Web console application pool runs under the default identity (ApplicationPoolIdentity)

    ```console
    Setspn.exe -S HTTP/mySCOM SCOMWeb 
    Setspn.exe -S HTTP/mySCOM.Lab.Local SCOMWeb
    ```

- ##### Scenario 2

  The Web console application pool runs under a custom identity (Lab\SCOMAppPool)

    ```console
    Setspn.exe -S HTTP/mySCOM SCOMAppPool 
    Setspn.exe -S HTTP/mySCOM.Lab.Local SCOMAppPool
    ```

#### Verify the HTTP SPNs

To verify if the HTTP service is registered, run the following command according to different scenarios:

- ##### Scenario 1

  The Web console application pool runs under the default identity (ApplicationPoolIdentity)

    ```console
    Setspn.exe -L SCOMWeb
    ```

- ##### Scenario 2

  The Web console application pool runs under a custom identity (Lab\SCOMAppPool)

    ```console
    Setspn.exe -L SCOMAppPool
    ```

---

### Configure constraint delegations

To configure constraint delegations, follow these steps:

1. Start the Active Directory Users and Computers console.
2. In the console tree, select **Computers**.
3. Open the properties according to different scenarios:

    - Scenario 1: The Operations Manager web application pool runs under the default identity (ApplicationPoolIdentity)

        Right-click the computer where the web console is installed (SCOM Web) and select **Properties**.

    - Scenario 2: The Operations Manager web application pool runs under a custom identity (Lab\SCOMAppPool)

        Right-click the user that's configured on the custom identity (Lab\SCOMAppPool) and select **Properties**.

4. In the details pane, select **Delegation**.
5. On the **Delegation** tab, select **Trust this computer for delegation to specified services only**, and then select one of the following options accordingly:

    - Kernel-mode authentication is enabled: **Use any authentication protocol**

    - Kernel-mode authentication is disabled: **Use Kerberos only**

      For more information, see [Disable Kernel-mode authentication in IIS](#disable-kernel-mode-authentication-in-iis).
  
7. Select **Add**.
8. In the **Add Services** dialog box, select **Users or Computers**.
9. In the **Select Users or Computers** dialogue box, specify the account according to different scenarios:

    - Scenario 1: The SDK service runs under a LocalSystem account

         Select the computer account of the SCOM management server (SCOMMS) and select **OK**.

    - Scenario 2: The SDK service runs under a domain account (SDKSvc)

         Select the domain account that the SDK service runs under and select **OK**.

10. In the **Add Services** dialog box, select the service type **MSOMSdkSvc** and then select **OK**.
11. Select **OK** to close the **Properties** dialog box.

### Verify "Account is sensitive and cannot be delegated" isn't set

To verify that the user logging into the Web console doesn't have **Account is sensitive and cannot be delegated** set, follow these steps:

1. Start the Active Directory Users and Computers console.
2. Right-click the user account that's used to connect to the Web console, and then select **Properties**.
3. Select **Account**.
4. In the **Account options** dialogue box, confirm that the **Account is sensitive and cannot be delegated** checkbox isn't selected.

### Disable Kernel-mode authentication in IIS

To disable **Kernel-mode authentication** for both `MonitoringView` and `OperationsManager` in IIS, follow these steps:

1. In IIS Manager, navigate to *Default Web Site\MonitoringView*.
2. Double-click **Authentication**.
3. Select **Windows Authentication**.
4. In the **Actions** pane on the right, select **Advanced Settings**.
5. Clear the **Enable Kernel-mode authentication** checkbox.
6. Navigate to *Default Web Site\OperationsManager*, and repeat steps 2 through 5.
