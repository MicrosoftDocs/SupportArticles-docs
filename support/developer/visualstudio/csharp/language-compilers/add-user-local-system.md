---
title: Add a user to the local system
description: This article describes how to use the DirectoryServices namespace to add a user to the local system and a group in Visual C#.
ms.date: 10/12/2020
ms.custom: sap:Language or Compilers\C#
ms.topic: how-to
---
# Add a user to the local system by using directory services and Visual C sharp

This article describes how to use the `DirectoryServices` namespace to add a user to the local system and a group in Visual C#.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 306273

## Summary

This step-by-step article shows you how to use the `DirectoryServices` namespace to add a user to the local system and a group.

## Create the Sample

1. Start Visual Studio .NET 2003, Visual Studio 2005, or Visual Studio 2008, and then create a new Visual C# Console Application project.
2. In Solution Explorer, right-click **References**, and then click **Add Reference**.
3. Add a reference to the `System.DirectoryServices.dll` assembly.
4. Replace the code in the *Class1.cs* file with the following code.

   > [!NOTE]
   > In Visual C# 2005 or Visual C# 2008, the *Class1.cs* file is replaced by the *Program.cs* file.

    ```csharp
    using System;
    using System.DirectoryServices;

    class Class1
    {
        static void Main(string[] args)
        {
            try
            {
                DirectoryEntry AD = new DirectoryEntry("WinNT://" +
                Environment.MachineName + ",computer");
                DirectoryEntry NewUser = AD.Children.Add("TestUser1", "user");
                NewUser.Invoke("SetPassword", new object[] {"#12345Abc"});
                NewUser.Invoke("Put", new object[] {"Description", "Test User from .NET"});
                NewUser.CommitChanges();
                DirectoryEntry grp;
  
                grp = AD.Children.Find("Guests", "group");
                if (grp != null) {grp.Invoke("Add", new object[] {NewUser.Path.ToString()});}
                Console.WriteLine("Account Created Successfully");
                Console.ReadLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
            }
        }
    }
    ```

5. Compile and then run the project.
6. Follow these steps on a Windows 2000-based computer to verify that the account was created and added to the Guest group:

   1. From the **Start** menu, point to **Programs**, point to **Administrative Tools**, and then click **Computer Management**.
   1. Click to expand the **Local Users and Groups** node. The new account should appear under the Users node, as well as under the node for the Guest group.

   Follow these steps on a Windows XP-based computer to verify that the account was created and added to the Guest group:

   1. From the **Start** menu, click **Control Panel**.
   2. Double-click **User Accounts**. The new user account should appear in the **User Accounts** dialog box.

   > [!IMPORTANT]
   > Remove the newly created user account from the system after you finish testing.

## Create a New Directory Entry

When you create the directory entry in this sample, it is assumed that the system is running Windows NT, Windows 2000, or Windows XP.

> [!NOTE]
> The string that is passed to the `DirectoryEntry` constructor begins with `"WinNT://"`. You can also run Directory Services on other third-party operating systems.

```csharp
DirectoryEntry AD = new DirectoryEntry("WinNT://" + SystemInformation.ComputerName + ",computer");
```

## Add the Directory Entry to the Directory Tree

The following code adds a `DirectoryEntry` of type user with the value of `TestUser1` to the Active Directory tree.

```csharp
DirectoryEntry NewUser = AD.Children.Add("TestUser1", "user");
```

## Set the Password and Description for the New User Account

The following code calls the Invoke method to invoke the `SetPassword` and `Put` methods of the `DirectoryEntry` object. This sets the password and assigns a description to the user account. This code also calls the `CommitChanges` method to save the changes.

```csharp
NewUser.Invoke("SetPassword", new object[] {"#12345Abc"});
NewUser.Invoke("Put", new object[] {"Description", "Test User from .NET"});
NewUser.CommitChanges();
```

## Add the Account to a Group

To add the account to a group, follow these steps:

1. Define a variable of type `DirectoryEntry`.
2. Call the `Find` method of the `Children` member of the `ActiveDirectory` class to populate the variable. In this case, the Guest group is the target of the search. This code tests the value that the `Find` method returns to determine if the group has been found. If the group is found, the new user account is added to the group.

```csharp
DirectoryEntry grp;
grp = AD.Children.Find("Guests", "group");
if (grp != null) {grp.Invoke("Add", new object[] {NewUser.Path.ToString()});}
```

## Troubleshooting

The code in this article fails if you try to run the code without the sufficient privileges to create a user account. For the code to complete successfully, the currently logged on user must be a member of the Administrators group or have specific permissions that allow the user to create user accounts.
