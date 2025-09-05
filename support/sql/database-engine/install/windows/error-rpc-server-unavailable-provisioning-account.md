---
title: SQL Server Setup Fails With "The RPC server is unavailable" When Provisioning Service Accounts
description: This article provides troubleshooting guidance for "The RPC server is unavailable" errors when provisioning service accounts during SQL Server setup.
ms.date: 08/26/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.author: jopilov
ms.topic: troubleshooting-problem-resolution

#customer intent: As a developer or IT administrator, I want to resolve "The RPC server is unavailable" errors during SQL setup so that I can successfully setup SQL Server.
---

# "The RPC server is unavailable" error when provisioning service accounts during SQL Server setup

This article helps you troubleshoot "The RPC server is unavailable" errors when setting up SQL Server instances. This error can occur during the service account provisioning phase of the SQL Server setup.

## Symptoms

During the service account provisioning phase of the SQL Server install, installation fails with the error: `The RPC Server is unavailable`

The following example log indicates a failure during service account provisioning. In this example, the service account being provisioned is a domain account with the name `CONTOSO\SQLSvcAcct`:

```output
(05) 2024-01-19 15:00:42 Slp: Sco.User.LookupADEntry - Attempting to find user account CONTOSO\SQLSvcAcct
(05) 2024-01-19 15:00:42 Slp: Sco: Attempting to check if container 'WinNT://CONTOSO of user account exists
(05) 2024-01-19 15:01:03 Slp: Prompting user if they want to retry this action due to the following failure:
(05) 2024-01-19 15:01:03 Slp: ----------------------------------------
(05) 2024-01-19 15:01:03 Slp: The following is an exception stack listing the exceptions in outermost to innermost order
(05) 2024-01-19 15:01:03 Slp: Inner exceptions are being indented
(05) 2024-01-19 15:01:03 Slp:
(05) 2024-01-19 15:01:03 Slp: Exception type: Microsoft.SqlServer.Configuration.Sco.ScoException
(05) 2024-01-19 15:01:03 Slp:     Message:
(05) 2024-01-19 15:01:03 Slp:         The RPC server is unavailable.
(05) 2024-01-19 15:01:03 Slp:        
(05) 2024-01-19 15:01:03 Slp:     HResult : 0x84bb0001
(05) 2024-01-19 15:01:03 Slp:         FacilityCode : 1211 (4bb)
(05) 2024-01-19 15:01:03 Slp:         ErrorCode : 1 (0001)
(05) 2024-01-19 15:01:03 Slp:     Data:
(05) 2024-01-19 15:01:03 Slp:       WatsonData = Domain
(05) 2024-01-19 15:01:03 Slp:       DisableRetry = true
(05) 2024-01-19 15:01:03 Slp:     Inner exception type: System.Runtime.InteropServices.COMException
(05) 2024-01-19 15:01:03 Slp:         Message:
(05) 2024-01-19 15:01:03 Slp:                 The RPC server is unavailable.
(05) 2024-01-19 15:01:03 Slp:                
(05) 2024-01-19 15:01:03 Slp:         HResult : 0x800706ba
(05) 2024-01-19 15:01:03 Slp:         Stack:
(05) 2024-01-19 15:01:03 Slp:                 at System.DirectoryServices.DirectoryEntries.Find(String name, String schemaClassName)
(05) 2024-01-19 15:01:03 Slp:                 at Microsoft.SqlServer.Configuration.Sco.User.LookupADEntry()
(05) 2024-01-19 15:01:03 Slp: ----------------------------------------
```

The log shows that the [System.DirectoryServices.DirectoryEntries.Find()](/dotnet/api/system.directoryservices.directoryentries.find) method is failing with the error: `The RPC server is unavailable`.

You can look up the HResult error `0x800706ba` using the `certutil.exe` command line tool:

```cmd
certutil /error 0x800706ba
```

You should receive the following output:

```output
0x800706ba (WIN32: 1722 RPC_S_SERVER_UNAVAILABLE) -- 2147944122 (-2147023174)
Error message text: The RPC server is unavailable.
CertUtil: -error command completed successfully.
```

## Cause

An underlying Windows issue is typically the cause of this error, such as:

- The "Remote Registry" service isn't running.
- Incorrect DNS settings.
- Incorrect Time and Time zone settings.
- The "TCP/IP NetBIOS Helper" service isn't running.

For more information, see [The system can't log you on with the following error: The RPC server is unavailable](~/windows-server/user-profiles-and-logon/not-log-on-error-rpc-server-unavailable.md#cause).

### Verify that the SQL Server setup process isn't the issue

Using the following steps, you can build and run a test application to reproduce the `The RPC Server is unavailable` error and verify that the SQL Server setup process isn't the cause of failure:

#### Build the ADLookup application

1. Open a Command Prompt or PowerShell terminal.

1. Ensure the [.NET SDK](https://dotnet.microsoft.com/en-us/download) is installed on your machine:

   ```bash
   dotnet --version
   ```

   If the .NET SDK is correctly installed, this command should output the SDK's version number.

1. Create a project folder:

   ```bash
   md ADLookup
   cd ADLookup
   ```

1. Initialize a console project:

   ```bash
   dotnet new console -n ADLookup
   cd ADLookup
   ```

   This step creates a basic console app structure.

1. Using a text editor, replace the contents of `Program.cs` with:

   ```csharp
   using System;
   using System.Collections.Generic;
   using System.Linq;
   using System.Text;
   using System.DirectoryServices;
   using System.Runtime.InteropServices;
   
   namespace ADLookup 
   {
     public class Program 
     {
       static void Main(string[] args) 
       {
         if (args.Count() < 2) 
         {
           Console.WriteLine("Specify at least 2 parameters. Closing App");
           Console.ReadLine();
         } 
         else 
         {
           string param1 = args[0];
           string param2 = args[1];
           string myADPath = "WinNT://" + param1 + ", " + param2;
           
           // Examples
           // user "john" in the "contoso" domain
           // string myADPath = "WinNT://contoso/john, user";
           // Domain "contoso""
           // string myADPath = "WinNT://contoso, domain";
           bool adRes = false;
           
           Console.WriteLine("Checking {0} for type {1}", param1, param2);
           
           try 
           {
             Console.WriteLine("The string ADPath is : {0}", myADPath);
             adRes = DirectoryEntry.Exists(myADPath);
             System.Console.WriteLine(Marshal.GetLastWin32Error());
           } 
           catch (COMException e) 
           {
             Console.WriteLine("Error Encountered: {0}", e.ErrorCode);
           }
           
           if (!adRes) 
           {
             Console.WriteLine("The path is invalid");
             Console.WriteLine("Press any key to quit");
           } 
           else 
           {
             Console.WriteLine("The path is valid");
             Console.WriteLine("Press any key to quit");
           }
           Console.ReadLine();
         }
       }
     }
   }
   ```

1. Add required references to the project:

   ```bash
   dotnet add package System.DirectoryServices
   ```

1. Build the project:

   ```bash
   dotnet build --configuration Release
   ```

   This step compiles the code and generates an `ADLookup.exe` in the `bin\Release\net<VersionNumber>\` folder.

#### Run the ADLookup application

1. Navigate to the directory where the executable is built:

   ```bash
   cd bin\Release\net<VersionNumber>\
   ```

1. Run `ADLookup.exe` with the **domain** parameter to look up the domain name first:

   ```bash
   adlookup CONTOSO domain
   ```

   The output should be similar to the following example:

   ```output
   Checking CONTOSO for type domain
   The string ADPath is : WinNT://CONTOSO, domain
   1150
   The path is valid
   Press any key to quit
   ```

1. Look up the account name with the **user** parameter:

     ```bash
     adlookup CONTOSO/SQLSvcAcct user
     ```

     > [!NOTE]
     > You must use a forward slash to separate the domain and account name, not a backslash.

    For a service account experiencing issues, the output should be similar to the following example:

     ```output
     Checking CONTOSO/SQLSvcAcct for type user
     The string ADPath is : WinNT:// CONTOSO\SQLSvcAcct, user
     Error Encountered: -2147023174
     The path is invalid
     Press any key to quit
     ```

## Solution

To troubleshoot underlying Windows issues causing the SQL Server setup to fail, see [The system can't log you on with the following error: The RPC server is unavailable](~/windows-server/user-profiles-and-logon/not-log-on-error-rpc-server-unavailable.md#resolution).
