---
title: Kerberos generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE error
description: 
ms.date: 06/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
ms.reviewer: kaushika, raviks, v-lianna, jobesanc
keywords: KDC_ERR_S_PRINCIPAL_UNKNOWN, KDC_ERR_PRINCIPAL_NOT_UNIQUE
---

# Kerberos generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE error

These errors indicate that the client is requesting access to a service that Kerberos can't identify. This type of error indicates one or more of the following issues:

- The service account is not configured correctly.
- The service is not using the service account that is configured for it.
- More than one account has been configured for the service.
- The client didn't correctly request the service.

Each service has a service principal name (SPN), which identifies it to clients and other services. The SPN is an attribute of the Active Directory Domain Services (AD DS) account that the service uses. A service can run in the context of a custom service account or in the context of a built-in account such as the computer account of the local computer (or one of the security contexts that's related to the computer account, such as Local System or Network Service).

The way you configure SPNs differs depending on the type of account that your service uses:

- A custom service account has to have an explicit SPN for each service that uses the account.
- The computer account might have explicit SPNs that are configured for the services that use it. However, common service classes map automatically to the HOST/ SPN, which is in turn automatically generated for each computer account. In such cases, some services might not have their own SPN configured on the computer account.

> [IMPORTANT!]  
>
> - Unless a service uses the computer account and the HOST SPN, SPNs must be unique in the AD DS forest. In a multi-forest environment, the SPN must be unique across all of the associated forests.
> - One SPN can only be associated with one account. A common cause of SPN issues is when a service is configured to use a custom account but the SPN is associated with both the custom account and the computer account.

## Collect trace data and identify the problem SPN

If you haven't yet collected trace data for the issue, do so now. [Kerberos authentication troubleshooting guidance: 3. Collect trace and ticket data](kerberos-authentication-troubleshooting-guidance.md#3-collect-trace-and-ticket-data) describes how to do this. Check the trace data to find the SPN that the client requested.

## Check the SPN that the service account uses

These procedures differ slightly depending on whether the service uses a custom account or the computer account. The following table summarizes the difference.

| Service uses a custom account | Service uses the computer account |
| - | - |
| The requested SPN has to match the account SPN.<br/>The SPN must be unique in the forest. | The requested SPN might match one of account SPNs. However, common services (such as the web service) typically use the automatic HOST SPN instead of a unique SPN.<br/>If the account does have an SPN that's specific to the service, that SPN must be unique in the forest. |

1. Get a list of SPNs that are assigned to the service account. To do this, in an administrative Command Prompt window on a domain controller, run the following command:

   ```console
   setspn -L <Name>
   ```

   > [NOTE!]  
   >
   > - In this command, \<Name> represents the name of either the computer that runs the service, or a custom account that the service uses.
   > - In a multi-domain environment, use the format \<Domain\\Name> to specify the account's domain.

1. Search for any accounts that use the requested SPN. This search identifies any duplicate SPNs or SPNs that are assigned to the incorrect account.

   > [NOTE!]  
   > To perform this procedure, you have to have at least Enterprise Administrator permissions.

   To identify the account or accounts that are associated with the SPN, open an administrative Command Prompt window, and then run one of the following commands:

   | Single forest | Multiple trusted forests |
   | - | - |
   | `setspn -Q <SPN>` | `setspn -X <SPN>` |

   > [NOTE!]  
   > - In this command, \<SPN> represents the SPN that you're searching for.
   > - Searching for duplicates, especially forest-wide, can take a long period of time and a large amount of memory.

For more information about the `setspn` command and the available options, see [setspn](https://learn.microsoft.com/windows-server/administration/windows-commands/setspn).

## Reconfigure the SPN as needed

The next steps depend on the result of the trace data, the `setspn` queries, and the type of account that your service uses.

You might see any (or more than one) of the following issues:

| Custom account | Computer account |
| - | - |
| One or more accounts other than the service account has the SPN. | One or more accounts other than the computer account has the SPN. |
| The custom account doesn't have the SPN. | The computer account should have the SPN, but it doesn't.<sup>1</sup> |
| The custom account has an incorrect SPN, or an SPN that doesn't match the SPN that the client requested.<sup>2</sup> | The computer account has an incorrect SPN, or an SPN that doesn't match the SPN that the client requested.<sup>2</sup> |

<sup>1</sup> For a list of the services that can use the HOST SPN of the computer account, see [setspn](https://learn.microsoft.com/windows-server/administration/windows-commands/setspn). If your service is not one of these common services, you have to configure an SPN for the service on the computer account.  

<sup>2</sup> For the client request information, see the network trace data.

Use the following procedures to fix the SPN configuration:

- If the service account is configured correctly but the client requested an incorrect SPN, see [Fix an inconsistent SPN](#fix-an-inconsistent-spn).

- If the correct service account has the SPN but the SPN is not correct, remove the incorrect SPN and then add the correct SPN. For details, see [Remove an SPN from an account](#remove-an-spn-from-an-account) and [Add an SPN to a service account](#add-an-spn-to-a-service-account).

- If the SPN has been assigned to any account other than the correct service account (custom account or computer account), remove the SPN from those accounts. See [Remove an SPN from an account](#remove-an-spn-from-an-account).

- If your service uses a custom account but the custom account doesn't have an assigned SPN, add the SPN. For details, see [Add an SPN to a service account](#add-an-spn-to-a-service-account).

- If your service uses the computer account but isn't one of the common services that were described earlier, [add the SPN](#add-an-spn-to-a-service-account) to the computer account.

### Remove an SPN from an account

To remove the SPN from an account, run the following command at the administrative command prompt:

```console
setspn -D <SPN> <AccountName>
```

> [NOTE!]  
> In this command, \<SPN> represents the SPN that you want to remove. \<AccountName> represents the account (or one of the accounts) that you want to remove the SPN from.

### Add an SPN to a service account

To add the SPN to an account, run the following command at the administrative command prompt:

```console
setspn -S \<SPN> \<AccountName>
```

> [NOTE!]  
> In this command, \<SPN> represents the SPN that you want to add. \<AccountName> represents the account (or one of the accounts) that you want to add the SPN to.

### Fix an inconsistent SPN

Determine which version of the SPN is correct, the one that the client requested or the one that's configured on the service account.

If the client is requesting an incorrect SPN, verify what information your client uses to build an SPN for a request, and make sure that the source information is correct. One source of this information is DNS Beyond DNS, clients might use other sources for this information (especially non-browser or custom clients).

If the service account uses the incorrect SPN, [remove the SPN from the service account](#remove-an-spn-from-an-account), and then [add the correct SPN](#add-an-spn-to-a-service-account).

## More information

An SPN uses the format \<ServiceClass>/\<Host>:\<Port>/,\<ServiceName> and includes the following components:

- \<ServiceClass> (required) represents the service class of the service.
- \<Host> (required) represents the name of the computer that runs the service.
- \<Port> (optional) represents the port number that the service uses.
- \<ServiceName> (optional) represents the name of the service.

For more information about the format to use for SPNs and when to use optional parameters, see [Name Formats for Unique SPNs](/windows/win32/ad/name-formats-for-unique-spns).
