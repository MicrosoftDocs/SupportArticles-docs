---
title: SQL Server Setup Fails With The RPC server is unavailable When Provisioning Service Accounts
description: This article provides troubleshooting guidance for the "RPC server is unavailable" error when provisioning service accounts during SQL Server Setup.
ms.date: 08/26/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.author: jopilov
ms.topic: troubleshooting-problem-resolution

#customer intent: As a developer or IT administrator, I want to resolve the "RPC server is unavailable" error so that I can successfully set up SQL Server.
---

# "RPC server is unavailable" error when provisioning service accounts during SQL Server Setup

This article helps you troubleshoot an "RPC server is unavailable" error when you set up Microsoft SQL Server instances. This error can occur during the service account provisioning phase of SQL Server Setup.

## Symptoms

During the service account provisioning phase of a SQL Server installation, the installation fails and generates an "RPC Server is unavailable" error message.

The following example log entry shows a failure that occurs during a service account provisioning. In this example, the service account is a domain account that's named `CONTOSO\SQLSvcAcct`.

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

This log entry shows that the [System.DirectoryServices.DirectoryEntries.Find()](/dotnet/api/system.directoryservices.directoryentries.find) method fails and returns the error message, `The RPC server is unavailable`.

You can look up the "HResult" error, `0x800706ba`, by using the Certutil.exe command line tool:

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

The cause of this error is typically an underlying Windows issue, such as:

- The Remote Registry service isn't running.
- DNS settings are incorrect.
- Time and Time zone settings are incorrect.
- The TCP/IP NetBIOS Helper service isn't running.

For more information, see [The system can't log you on with the following error: The RPC server is unavailable](~/windows-server/user-profiles-and-logon/not-log-on-error-rpc-server-unavailable.md#cause).

### Eliminate the SQL Server setup process as the issue

To determine whether the SQL Server setup process itself is the cause of failure, use the following steps to build and run a test application that reproduces the `RPC Server is unavailable` error.

#### Step 1: Build the ADLookup application

1. Open a Command Prompt window or a PowerShell terminal.

1. Make sure that the [.NET SDK](https://dotnet.microsoft.com/en-us/download) is installed on your computer:

   ```bash
   dotnet --version
   ```

   If the .NET SDK is installed correctly, this command should output the SDK's version number.

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

   > [!NOTE]
   > This step creates a basic console app structure.

1. Use a text editor to replace the contents of `Program.cs` with the following code:

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

   > [!NOTE]
   > This step compiles the code and generates an `ADLookup.exe` in the `bin\Release\net<VersionNumber>\` folder.

#### Step 2: Run the ADLookup application

1. Navigate to the directory in which the executable is built:

   ```bash
   cd bin\Release\net<VersionNumber>\
   ```

1. Run `ADLookup.exe` by using the **domain** parameter to look up the domain name first:

   ```bash
   adlookup CONTOSO domain
   ```

   The output should resemble the following example:

   ```output
   Checking CONTOSO for type domain
   The string ADPath is : WinNT://CONTOSO, domain
   1150
   The path is valid
   Press any key to quit
   ```

1. Look up the account name using the the **user** parameter:

     ```bash
     adlookup CONTOSO/SQLSvcAcct user
     ```

    You must use a forward slash, not a backslash, to separate the domain and account name.

    For a service account that's experiencing RPC server issues, the output should resemble the following example:

     ```output
     Checking CONTOSO/SQLSvcAcct for type user
     The string ADPath is : WinNT:// CONTOSO\SQLSvcAcct, user
     Error Encountered: -2147023174
     The path is invalid
     Press any key to quit
     ```

## More information

To troubleshoot underlying Windows issues that cause SQL Server Setup to fail, see [The system can't log you on with the following error: The RPC server is unavailable](~/windows-server/user-profiles-and-logon/not-log-on-error-rpc-server-unavailable.md#resolution).
