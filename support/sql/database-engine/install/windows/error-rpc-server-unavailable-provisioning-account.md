---
title: SQL Server setup fails with "The RPC server is unavailable" when provisioning service accounts
description: This article helps you troubleshoot a problem where setting SQL Server instances fails when provisioning the service account.
ms.date: 08/26/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.author: jopilov
---
# SQL Server setup fails with "The RPC server is unavailable" when provisioning service accounts

This article helps you troubleshoot a problem where setting SQL Server instances fails when provisioning the service account.


## Symptoms
 
You try to install SQL Server and during the service account provisioning phase, installation fails with error:

`The RPC Server is unavailable.`

This error happens when SQL Server setup provisions service accounts for the SQL Server services. Here are the entries in the setup log indicating where the failure occurred. Let’s assume that the account chosen for the SQL Server services is a domain account with name CONTOSO\SQLSvcAcct:

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

You can see from the log that [System.DirectoryServices.DirectoryEntries.Find()](/dotnet/api/system.directoryservices.directoryentries.find) method is failing with the error: The RPC server is unavailable.

You can look up the HResult error `0x800706ba` by using CertUtil.exe command line tool.

```cmd
certutil /error 0x800706ba
```

Result:

```output
0x800706ba (WIN32: 1722 RPC_S_SERVER_UNAVAILABLE) -- 2147944122 (-2147023174)
Error message text: The RPC server is unavailable.
CertUtil: -error command completed successfully.
```


## Cause

This error is typically related to Windows issues. For more information, you can see [The system can't log you on with the following error: The RPC server is unavailable](../../../../windows-server/user-profiles-and-logon/not-log-on-error-rpc-server-unavailable.md). The article lists these reasons:

- The "Remote Registry" service isn't running.
- Incorrect DNS settings.
- Incorrect Time and Time zone settings.
- The "TCP/IP NetBIOS Helper" service isn't running.

## Resolution

Troubleshoot the Windows error by following [The system can't log you on with the following error: The RPC server is unavailable](../../../../windows-server/user-profiles-and-logon/not-log-on-error-rpc-server-unavailable.md).

## More information

Here's a sample C# (.NET Framework) application that you can build yourself. The goal is to test the account that is having issues. The application is likely to reproduce the same `The RPC Server is unavailable.` error and eliminate SQL Setup process as a possible cause.

### Build an `ADLookup` application with .NET CLI

These steps provide command line instructions on how to build the application. Alternatively, you can use Visual Studio to accomplish the same result. 
 
1. Ensure the .NET SDK is installed on your machine

   ```bash
   dotnet --version
   ```

1. Open a Command Prompt or PowerShell terminal

1. Create a Project Folder

   ```bash
   md ADLookup
   cd ADLookup
   ```

1. Initialize a Console project

   ```bash
   dotnet new console -n ADLookup
   cd ADLookup
   ```

   This step creates a basic console app structure.

1. Replace the `Program.cs` contents with this code

   You can copy-paste the code into the file using a text editor.

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

  

1. Add required References
   The code uses `System.DirectoryServices`, which might require adding a reference.

   ```bash
   dotnet add package System.DirectoryServices
   ```

1. Build the project

   ```bash
   dotnet build --configuration Release
   ```

   This compiles the code and generates an `.exe` in the `bin\Release\netX.X\` folder (depending on your .NET version).

### Run the application

1. Navigate to the directory where the executable is built:

   ```bash
   cd bin\Release\netX.X\
   ```

1. Run the `ADLookup.exe` with the **domain** parameter to look up the domain name first:

   ```bash
   adlookup CONTOSO domain
   ```

   Results might look like this:

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

     Note: the forward slash, not back slash

     Possible output for the service account you're having issues with:

     ```output
     Checking CONTOSO/SQLSvcAcct for type user
     The string ADPath is : WinNT:// CONTOSO\SQLSvcAcct, user
     Error Encountered: -2147023174
     The path is invalid
     Press any key to quit
     ```