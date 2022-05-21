---
title: Configure Windows authentication
description: Describes how to configure Windows authentication on a BlueStripe management server.
ms.date: 08/13/2020
---
# How to configure Windows authentication on a BlueStripe management server

This article describes how to configure Windows authentication on a BlueStripe management server.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134885

## Windows authentication/Active Directory

Users can be authenticated against your existing Windows system accounts by configuring the jaas.config file to use Windows authentication.

To configure the management server to use Windows authentication, follow these steps:

- Copy the default **jaas.config** file to **jaas.config.bak** so that you have your original configuration if needed.
- Copy the **jaas.windowsSSPI.config** file to the **jaas.config** file.
- Alter the `adminFilter` and `userFilter` to reflect a regular expression for the groups that are intended to indicate admin or user access.
- Restart the management server and sign in to the management server with a FactFinder console.

> [!NOTE]
> Windows authentication will only work with Windows-based components, so Linux-based management servers or Linux-based database loaders aren't supported.

## Windows authentication configuration example

```Java
FactFinder {
    /* Windows SSPI Authentication with Group Privileges */
    /* Note: to use this file, rename to jaas.config */
    com.bluestripe.ms.auth.WindowsAuthLoginModule required

    /* This variable indicates which Security Support Provider (SSP) to use */
    /* http://msdn.microsoft.com/en-us/library/windows/desktop/aa380502(v=vs.85).aspx */
    /* bluestripe.securityPackage="Negotiate" */

    /* If the SSP is Negotiate, Kerberos, or NTLM, then targetName may be set to the */
    /* Service Principal Name (SPN) or the security context of the destination server. */
    /* Run the command "setspn.exe -L <target>" to list the SPNs for a target FactFinder Management Server. */
    /* bluestripe.targetName="ExampleServicePrincipalName" */

    /* These filters are Java Regular Expressions matched against the user's group membership list */
    /* Note: the 4 '\' characters separating domain and group are to escape both the Java string and the regex */
    bluestripe.adminFilter="DOMAIN\\\\FFAdmin"
    bluestripe.userFilter="DOMAIN\\\\FFUser"

    /* Uncomment the line below to enable additional logging */
    /* debug=true */
    ;
};
```

## Windows authentication JAAS options

JAAS options are available for using with Windows authentication:

- `bluestripe.securityPackage`

    Determines which Security Support Provider (SSP) to use. The default is **Negotiate** which first attempts to use Kerberos, but if unsuccessful falls back to **NTLM**.

- `bluestripe.targetName`

    Determines which service principal name (SPN) to use to uniquely identify the management server to which the user is connecting. It's optional for **Negotiate** or **NTLM**, but configuration is required for Kerberos.

- `bluestripe.adminFilter`

    Specifies a regular expression value to examine the user's group list for appropriate matches and grant administrative access to FactFinder. In the examples above, the group, *DOMAIN\FFAdmin*, is used.

- `bluestripe.userFilter`

    Specifies a regular expression value to examine the user's group list for appropriate matches and grant user access to FactFinder. In the examples above, the Group, *DOMAIN\FFGuest*, is used.

> [!NOTE]
> The *DOMAIN\Group* is specified with 4 **\\** characters. This is necessary to escape both the Java string and the regular expression.

> [!TIP]
> If you have any issues with your Windows authentication configuration, the `debug=true` option can be added to provide additional logging to the FactFinderMS.log file.
