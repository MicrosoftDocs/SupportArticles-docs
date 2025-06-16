---
title: Kerberos Generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE Error
description: Guidance for troubleshooting missing, incorrect, or duplicate SPNs that cause Kerberos authentication issues.
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

The KDC_ERR_S_PRINCIPAL_UNKNOWN and KDC_ERR_PRINCIPAL_NOT_UNIQUE errors indicate that the client is requesting access to a service that Kerberos can't identify. This kind of error indicates one or more of the following issues:

- The service account isn't configured correctly.
- The service isn't using the service account that's configured for it.
- More than one account is configured for the service.
- The client didn't correctly request the service.

Each service has a service principal name (SPN) that identifies it to clients and other services. The SPN is an attribute of the Active Directory Domain Services (AD DS) account that the service uses. A service can run in the context of a custom service account or in the context of a built-in account, such as the computer account of the local computer. The service can also run in a security context that's related to the computer account, such as Local System or Network Service.

The manner is which you configure SPNs differs depending on the type of account that your service uses:

- A custom service account must have an explicit SPN for each service that uses the account.
- The computer account might have explicit SPNs that are configured for the services that use it. However, common service classes map automatically to the HOST SPN. The HOST SPN is automatically generated for each computer account. In such cases, some services might not have their own SPN that's configured on the computer account.

> [!IMPORTANT]  
>
> - Unless a service uses the computer account and the HOST SPN, SPNs must be unique in the AD DS forest. In a multi-forest environment, the SPN must be unique across all the associated forests.
> - One SPN can be associated with only one account. A common cause of SPN issues is configuring a service to use a custom account even though the SPN is associated with both the custom account and the computer account.

## Collect trace data and identify the problem SPN

If you haven't yet collected trace data for the issue, do that now. For more information, see [Kerberos authentication troubleshooting guidance: 3. Collect trace and ticket data](kerberos-authentication-troubleshooting-guidance.md#3-collect-trace-and-ticket-data). Check the trace data to find the SPN that the client requested.

## Check the SPN that the service account uses

These procedures differ slightly depending on whether the service uses a custom account or the computer account. The following table summarizes the difference.

| Service uses a custom account | Service uses the computer account |
| - | - |
| The requested SPN has to match the account SPN.<br/><br/>The SPN must be unique in the forest. | The requested SPN might match one of account SPNs. However, common services (such as the web service) typically use the automatic HOST SPN instead of a unique SPN.<br/><br/>If the account does have an SPN that's specific to the service, that SPN must be unique in the forest. |

1. Get a list of SPNs that are assigned to the service account. To do this, open an administrative Command Prompt window on a domain controller, and then run the following command:

   ```console
   setspn -L <Name>
   ```

   > [!NOTE]  
   >
   > - In this command, \<Name> represents the name of either the computer that runs the service or a custom account that the service uses.
   > - In a multi-domain environment, use the \<Domain\\Name> format to specify the account's domain.

1. Search for any accounts that use the requested SPN. This search identifies any duplicate SPNs or SPNs that are assigned to the incorrect account.

   > [!NOTE]  
   > To perform this procedure, you have to have at least Enterprise Administrator permissions.

   To determine the account or accounts that are associated with the SPN, open an administrative Command Prompt window, and then run one of the following commands.

   | Single forest | Multiple trusted forests |
   | - | - |
   | `setspn -Q <SPN>` | `setspn -X <SPN>` |

   > [!NOTE]  
   > - In this command, \<SPN> represents the SPN that you're searching for.
   > - Searching for duplicates, especially forest-wide, can take a long time and lots of memory.

For more information about the `setspn` command and the available options, see [setspn](/windows-server/administration/windows-commands/setspn).

## Reconfigure the SPN as necessary

The next steps depend on the result of the trace data, the `setspn` queries, and the type of account that your service uses.

You might see any of the following issues.

| Custom account | Computer account |
| - | - |
| One or more accounts other than the service account has the SPN. | One or more accounts other than the computer account has the SPN. |
| The custom account doesn't have the SPN. | The computer account should have the SPN, but it doesn't.<sup>1</sup> |
| The custom account has an incorrect SPN or an SPN that doesn't match the SPN that the client requested.<sup>2</sup> | The computer account has an incorrect SPN or an SPN that doesn't match the SPN that the client requested.<sup>2</sup> |

<sup>1</sup> For a list of the services that can use the HOST SPN of the computer account, see [setspn](/windows-server/administration/windows-commands/setspn). If your service isn't one of these common services, you have to configure an SPN for the service on the computer account.  

<sup>2</sup> For the client request information, see the network trace data.

Use the following methods to fix the SPN configuration:

- If the service account is configured correctly but the client requested an incorrect SPN, see [Fix an inconsistent SPN](#fix-an-inconsistent-spn).

- If the correct service account has the SPN but the SPN isn't correct, remove the incorrect SPN, and then add the correct SPN. For details, see [Remove an SPN from an account](#remove-an-spn-from-an-account) and [Add an SPN to a service account](#add-an-spn-to-a-service-account).

- If the SPN is assigned to any account other than the correct service account (custom account or computer account), remove the SPN from those accounts. See [Remove an SPN from an account](#remove-an-spn-from-an-account).

- If your service uses a custom account but the custom account doesn't have an assigned SPN, add the SPN. For details, see [Add an SPN to a service account](#add-an-spn-to-a-service-account).

- If your service uses the computer account but isn't one of the common services that are described in this article, [add the SPN](#add-an-spn-to-a-service-account) to the computer account.

### Remove an SPN from an account

To remove the SPN from an account, run the following command at an administrative command prompt:

```console
setspn -D <SPN> <AccountName>
```

> [!NOTE]  
> In this command, \<SPN> represents the SPN that you want to remove. \<AccountName> represents the account (or one of the accounts) that you want to remove the SPN from.

### Add an SPN to a service account

To add the SPN to an account, run the following command at an administrative command prompt:

```console
setspn -S \<SPN> \<AccountName>
```

> [!NOTE]  
> In this command, \<SPN> represents the SPN that you want to add. \<AccountName> represents the account (or one of the accounts) that you want to add the SPN to.

### Fix an inconsistent SPN

Determine which version of the SPN is correct: Either the one that the client requested or the one that's configured on the service account.

If the client is requesting an incorrect SPN, verify the information that your client uses to build an SPN for a request, and make sure that the source information is correct. DNS is a common source of this information. Other clients (especially non-browser or custom clients) might use other sources in addition to DNS.

If the service account uses the incorrect SPN, [remove the SPN from the service account](#remove-an-spn-from-an-account), and then [add the correct SPN](#add-an-spn-to-a-service-account).

## More information

An SPN uses the \<ServiceClass>/\<Host>:\<Port>/,\<ServiceName> format and includes the following components:

- \<ServiceClass> (required) represents the service class of the service.
- \<Host> (required) represents the name of the computer that runs the service.
- \<Port> (optional) represents the port number that the service uses.
- \<ServiceName> (optional) represents the name of the service.

For more information about how to format SPNs and when to use optional parameters, see [Name Formats for Unique SPNs](/windows/win32/ad/name-formats-for-unique-spns).
