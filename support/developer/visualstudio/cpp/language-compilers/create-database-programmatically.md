---
title: Create a Database programmatically by using ADO.NET
description: This article describes how To Create a SQL Server Database programmatically by using ADO.NET and Visual C++ .NET.
ms.date: 09/24/2020
ms.custom: sap:Language or Compilers
ms.topic: how-to
---
# Create a SQL Server Database programmatically by using ADO.NET and Visual C++ .NET

This article shows how To Create a SQL Server Database programmatically by using ADO.NET and Visual C++ .NET.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 307402

## Introduce

- For a Microsoft Visual Basic .NET version of this article, see [How to create a SQL Server database programmatically by using ADO.NET and Visual Basic .NET](https://support.microsoft.com/help/305079).  

- For a Microsoft Visual C# .NET version of this article, see [How To Create a SQL Server Database Programmatically by Using ADO.NET and Visual C# .NET](https://support.microsoft.com/help/307283).  

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System`
- `System.Data`
- `System.Data.SqlClient`

## Summary

Programmers often need to create databases programmatically. This article describes how to use ADO.NET and Visual C++ .NET to programmatically create a Microsoft SQL Server database.

## Steps to Create the Sample

1. Start Microsoft Visual Studio .NET, and create a new Managed C++ Application project. `Form1` is added to the project by default.

1. Add the following code before your `Main` function definition:

    ```cpp
    #using <mscorlib.dll>
    using namespace System;
  
    #using <system.dll>
    using namespace System;
  
    #using <System.data.dll>
    using namespace System::Data;
    using namespace System::Data::SqlClient;
  
    #using <system.windows.forms.dll>
    using namespace System::Windows::Forms;
    ```

1. Add the following code in your `Main` function:

    ```cpp
    int main(void)
    {
         Console::WriteLine(S"Press 'C' and then ENTER to create a new database");
         Console::WriteLine(S"Press any other key and then ENTER to quit");
         char c = Console::Read();
         if (c == 'C' || c == 'c')
         {
             Console::WriteLine(S"Creating the database...");
             String* str;
             SqlConnection* myConn = new SqlConnection 
             ("Server=localhost;Integrated security=SSPI;database=master");
             str = "CREATE DATABASE MyDatabase ON PRIMARY " 
             "(NAME = MyDatabase_Data, " 
             "FILENAME = 'C:\\MyDatabaseData.mdf', " 
             "SIZE = 2MB, MAXSIZE = 10MB, FILEGROWTH = 10%)" 
             "LOG ON (NAME = MyDatabase_Log, " 
             "FILENAME = 'C:\\MyDatabaseLog.ldf', " 
             "SIZE = 1MB, " 
             "MAXSIZE = 5MB, " 
             "FILEGROWTH = 10%)";
  
            try
             {
                 SqlCommand* myCommand = new SqlCommand(str, myConn);
                 myConn->Open();
                 myCommand->ExecuteNonQuery();
                 MessageBox::Show("Database is created successfully", 
                 "MyProgram", MessageBoxButtons::OK, 
                 MessageBoxIcon::Information);
             }
             catch (System::Exception* ex)
             {
                 MessageBox::Show(ex->ToString(), "MyProgram", 
                 MessageBoxButtons::OK, 
                 MessageBoxIcon::Information);
             }
  
            if (myConn->State == ConnectionState::Open)
             {
                 myConn->Close();
             }
         }
  
        return 0;
    }
    ```

1. Change the connection string to point to your SQL Server, and make sure that the Database argument is set to **Master** or blank.
1. Press the **F5** key or the **CTRL+F5** key combination to run the project. Press *C* and then press ENTER to create the database.
1. Use the Server Explorer to verify that the database was created.

## Additional Notes

- This code creates a custom database with specific properties.
- The folder that will hold the created .mdf and .ldf files must already exist before you run the code or an exception will be generated.
- If you want to create a database that is similar to SQL Server's Model database and in the default location, then change the str variable in the code:

```cpp
str = "CREATE DATABASE MyDatabase"
```

## References

For more information on ADO.NET objects and syntax, see [Accessing Data with ADO.NET](/previous-versions/dotnet/netframework-1.1/e80y5yhx(v=vs.71)).
