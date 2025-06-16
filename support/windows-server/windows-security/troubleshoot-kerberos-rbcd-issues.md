---
title: Troubleshooting Kerberos RBCD issues
description: Provides guidance to troubleshoot Kerberos resource-based constrained delegation (RBCD) issues.
ms.date: 06/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
ms.reviewer: kaushika, raviks,
---

# Troubleshooting Kerberos RBCD issues

> [!IMPORTANT]  
> Before you use the procedures in this article, follow the steps in the Kerberos [Troubleshooting checklist](kerberos-authentication-troubleshooting-guidance.md#troubleshooting-checklist). The most common causes of Kerberos problems are infrastructure issues and service principal name (SPN) issues. The checklist helps you identify such issues.

If your target service has separate front-end and back-end components, Kerberos can delegate client credentials (including access permissions) to a service account. In simple terms, first the client accesses the front-end service, and then the front-end service accesses the back-end service on the client's behalf. In the case of resource-based constrained delegation (RBCD), the back-end service maintains a list of services that can access it on behalf of a client. This list is associated with the account that the back-end service uses. You have to use Windows PowerShell to configure this setting.

> [!NOTE]  
> You must use the `ActiveDirectory` PowerShell module for these procedures. To make sure that your environment has the correct PowerShell module, open a PowerShell window, and then run the following commands, in the given order:
>
> ```powershell
> Add-WindowsFeature RSAT-AD-PowerShell
> Import-Module ActiveDirectory
> ```

The configuration details differ depending on the type of account that the front-end service uses. This article provides separate procedures for different kinds of service accounts:

- [Troubleshooting Kerberos RBCD if using a built-in service account](#troubleshooting-kerberos-rbcd-if-using-a-built-in-service-account)
- [Troubleshooting Kerberos RBCD if using a custom service account](#troubleshooting-kerberos-rbcd-if-using-a-custom-service-account)

## Troubleshooting Kerberos RBCD if using a built-in service account

1. To check the back-end (resource) server delegation configuration, open a Windows PowerShell command prompt window, and then run the following cmdlet:

   ```powershell
   Get-ADComputer -Identity <BackEndSvcAcct> -PrincipalsAllowedToDelegateToAccount
   ```

   > [!NOTE]  
   > In this command, \<BackEndSvcAcct> represents the back-end service account (in this case, the name of the back-end computer).

   This cmdlet retrieves the list of principals that can delegate to the back-end service. Do one of the following actions:
   - If this list includes the service account that the front-end service is using, then RBCD is correctly configured. Skip to step 3.
   - If this list doesn't include the service account that the front-end service is using, go to the next step.

2. To configure RBCD on the back-end service account, run the following cmdlet:

   ```powershell
   Set-ADComputer -AuthType Negotiate -Identity <BackEndSvcAcct> -PrincipalsAllowedToDelegateToAccount <FrontEndSvcAcct>
   ```

   > [!NOTE]  
   > In this command, \<BackEndSvcAcct> represents the back-end service account, and \<FrontEndSvcAcct> represents the front-end service account.

3. Check the front-end service account options. Use **Active Directory Users and Computers** (available on the Server Manager **Tools** menu) for these steps.

   1. In **Active Directory Users and Computers**, right-click the service account (typically in the **Computers** container), and then select **Properties** > **Account**.
   2. Review the **Account options** settings. Make sure that **Account is sensitive and cannot be delegated** isn't selected.
   3. Select **OK**.

## Troubleshooting Kerberos RBCD if using a custom service account

1. To check the back-end (resource) server delegation configuration, open a PowerShell command prompt window, and then run the following cmdlet:

   ```powershell
   Get-ADUser -Identity <BackEndSvcAcct> -PrincipalsAllowedToDelegateToAccount
   ```

   > [!IMPORTANT]  
   > If the back-end service uses a managed service account, use `Get-ADServiceAccount` instead of `Get-ADUser`.

   > [!NOTE]  
   > In this command, \<BackEndSvcAcct> represents the back-end service account.

   This cmdlet retrieves the list of principals that can delegate to the back-end service. Do one of the following actions:
   - If this list includes the service account that the front-end service is using, then RBCD is correctly configured. Skip to step 3.
   - If this list doesn't include the service account that the front-end service is using, go to the next step.

2. To configure RBCD on the back-end service account, run the following cmdlet:

   ```powershell
   Set-ADUser -Identity <BackEndSvcAcct> -PrincipalsAllowedToDelegateToAccount <FrontEndSvcAcct>
   ```

   > [!IMPORTANT]  
   > If the services use a managed service account, use **Get-ADServiceAccount** instead of **Get-ADUser**.

   > [!NOTE]  
   > In these commands, \<BackEndSvcAcct> represents the back-end service account, and \<FrontEndSvcAcct> represents the front-end service account.

3. Check the front-end service account options. Use **Active Directory Users and Computers** (available on the Server Manager **Tools** menu) for these steps.

   1. In **Active Directory Users and Computers**, right-click the service account (typically in the **Users** container), and then select **Properties** > **Account**.
   2. Review the **Account options** settings. Make sure that **Account is sensitive and cannot be delegated** isn't selected.
   3. Select **OK**.
