---
title: Fail to connect to SQL Server instance
description: This article provides a resolution for the problem that occurs when you use a protocol other than TCP/IP to connect to SQL Server on a port other than 1433.
ms.date: 10/12/2020
ms.custom: sap:Language or Compilers\C#
---
# You cannot connect to SQL Server on any port other than 1433 if you use a protocol other than TCP/IP

This article helps you resolve the problem that occurs when you use a protocol other than TCP/IP to connect to SQL Server on a port other than 1433.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 307645

## Symptoms

When you use a protocol other than Transmission Control Protocol/Internet Protocol (TCP/IP), `SqlConnection.Open` fails if you specify a port number other than 1433 to connect to an instance of SQL Server.

## Resolution

To resolve this problem, use TCP/IP protocol, and include `Server=ComputerName, PortNumber` in the connection string.

## Steps to reproduce the behavior

1. Start Visual Studio .NET.
2. Create a new Visual C# .NET Console Application project.
3. Make sure that your project contains a reference to the `System.Data` namespace, and add a reference to this namespace if it does not.
4. Use the using statement on the `System`, `System.Data`, `System.Data.SqlClient` namespaces so that you are not required to qualify declarations in those namespaces later in your code.

    ```csharp
    using System;
    using System.Data;
    using System.Data.SqlClient;
    ```

5. Visual Studio creates a static class and an empty `Main` procedure by default. Copy the following code, and paste it in the Code window:

   > [!NOTE]
   > You must change the `User ID` `<username>` value and the password `<strong password>` value to the correct values before you run this code. Make sure that `User ID` has the appropriate permissions to perform this operation on the database.

    ```csharp
    class Class1
    {
        static void Main(string[] args)
        {
            string sConnectionString;
            sConnectionString = "User ID=<username>;Password =<strong password>;Initial Catalog=pubs;Data Source=myServer,1200";
            SqlConnection objConn = new SqlConnection(sConnectionString);
            objConn.Open();
            SqlDataAdapter daAuthors = new SqlDataAdapter("Select * From Authors", objConn);

            DataSet dsPubs = new DataSet("Pubs");
            daAuthors.FillSchema(dsPubs, SchemaType.Source, "Authors");
            daAuthors.Fill(dsPubs, "Authors");
            daAuthors.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            daAuthors.Fill(dsPubs, "Authors");

            DataTable tblAuthors;
            tblAuthors = dsPubs.Tables["Authors"];
            foreach (DataRow drCurrent in tblAuthors.Rows)
            {
                Console.WriteLine("{0} {1}",
                drCurrent["au_fname"].ToString(),
                drCurrent["au_lname"].ToString());
            }
            Console.ReadLine();
        }
    }
    ```

6. Modify the `sConnectionString` string as appropriate for your environment.
7. Save your project.
8. On the **Debug** menu, click **Start**, and run your project to connect to the database.
