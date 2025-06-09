---
title: Troubleshooting Kerberos constrained delegation issues
description: Provides guidance to troubleshoot Kerberos constrained delegation issues.
ms.date: 06/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
ms.reviewer: kaushika, raviks,
---

# Troubleshooting Kerberos constrained delegation issues

> [IMPORTANT!]  
> Before you use the procedures in this article, follow the steps in the Kerberos [Troubleshooting checklist](kerberos-authentication-troubleshooting-guidance.md#troubleshooting-checklist). The most common causes of Kerberos problems are infrastructure issues or service principal name (SPN) issues. The checklist helps you identify such issues.

When your target service has separate front-end and back-end components, Kerberos can delegate client credentials (including access permissions) to a service account. In simple terms, the client accesses the front-end service, and then the front-end service accesses the back-end service on the client's behalf. In the case of constrained delegation, the front-end service maintains a list of services that it can access on behalf of a client.

The configuration details differ depending on the type of account that the front-end service uses. This article provides separate procedures for different types of service accounts:

- [Troubleshooting Kerberos constrained delegation when using a built-in service account](#troubleshooting-kerberos-constrained-delegation-when-using-a-built-in-service-account).
- [Troubleshooting Kerberos constrained delegation when using a custom service account](#troubleshooting-kerberos-constrained-delegation-when-using-a-custom-service-account).

## Troubleshooting Kerberos constrained delegation when using a built-in service account

Follow these steps when your front-end service runs under the security context of a built-in account such as the computer account of the local computer (or one of the security contexts that's related to the computer account, such as Local System or Network Service).

### 1. Check your topology type

To use constrained delegation, the front-end services and back-end services must belong to the same domain. If these services are in different domains or different trusted forest, you have to use resource-based constrained delegation (RBCD) instead. For more information, see [Kerberos authentication troubleshooting guidance: Supported topology types](kerberos-authentication-troubleshooting-guidance.md#supported-topology-types).

### 2. Check the delegation settings of the computer account

Use Active Directory Users and Computers (available on the Server Manager **Tools** menu) for these steps.

1. In Active Directory Users and computers, select **Computers**. Right-click the account of the front-end computer, and then select **Properties** > **Delegation**.
2. Make sure that **Trust this user for delegation to specified services only** is selected.
3. Make sure that the authentication option that's selected is appropriate for the users that access the web service.
4. Make sure that the service list includes the back-end service (or a common service class such as HOST for the back-end server). If needed, select **Add** to add the service to the list.
5. Select **OK**.

### 2. In IIS, check the application pool configuration

Use the Internet Information Services (IIS) tool (available on the Server Manager **Tools** menu) to review application pool settings.

1. In the IIS console, expand the IIS server and select **Application Pools**. In the right pane, right-click **DefaultAppPool**, and then select **Advanced Settings**.
2. Select **Process Model** > **Identity**. Make sure that **Built-in account** is selected, and that an appropriate built-in account (such as **NetworkService**) is selected. Select **OK** to return to the properties list. 
3. Make sure that **Load User Profile** is set to **True**. Select **OK** to close the properties list.
4. If you changed any settings, restart the IIS service.
5. When you are sure that all settings are correct, try to authenticate again.

## Troubleshooting Kerberos constrained delegation when using a custom service account

Follow these steps when your front-end service runs under the security context of a custom account.

### 1. Check your topology type

To use constrained delegation, the front-end services and back-end services must belong to the same domain. If these services are in different domains or different trusted forest, you have to use resource-based constrained delegation (RBCD) instead. For more information, see [Kerberos authentication troubleshooting guidance: Supported topology types](kerberos-authentication-troubleshooting-guidance.md#supported-topology-types).

### 1. Check the service account permissions

Make sure that the service account is part of either the local Administrators or IIS_Users group on the web server.

### 2. Check the delegation settings of the service account

Use Active Directory Users and Computers (available on the Server Manager **Tools** menu) for these steps.

1. In Active Directory Users and Computers, right-click the service account (typically in the **Users** container), and then select **Properties** > **Delegation**.
2. Make sure that **Trust this user for delegation to specified services only** is selected.
3. Make sure that the authentication option that's selected is appropriate for the users that access the web service.
4. Make sure that the service list includes the back-end service (or a common service class such as HOST for the back-end server). If needed, select **Add** to add the service to the list.
5. Select **Account**, and then review the **Account options** settings. Make sure that **Account is sensitive and cannot be delegated** is not selected.
6. Select **OK**.

### 3. Check the delegation configuration of the computer account of the front-end server

In addition to the custom service account, the computer account of the front-end server also has to be configured for delegation.

1. In Active Directory Users and computers, select **Computers**, right-click the account of the front-end computer, and then select **Properties** > **Delegation**.
2. Make sure that **Trust this user for delegation to specified services only** is selected, and that the subordinate option **Use any authentication protocol** is also selected.
3. Make sure that the service list includes the back-end service (or a common service class such as HOST for the back-end server). If needed, select **Add** to add the service to the list.
4. Select **OK**.

### 4. In IIS, check the application pool configuration

Use the Internet Information Services (IIS) tool (available on the Server Manager **Tools** menu) to review application pool settings.

1. In the IIS console, expand the IIS server and select **Application Pools**. In the right pane, right-click **DefaultAppPool**, and then select **Advanced Settings**.
2. Select **Process Model** > **Identity**. Make sure that **Custom account** is selected, and that the service account is selected. Select **OK** to return to the properties list.
3. Make sure that **Load User Profile** is set to **True**. Select **OK** to close the properties list.
4. Restart the IIS service.
5. When you are sure that all settings are correct, try to authenticate again.
