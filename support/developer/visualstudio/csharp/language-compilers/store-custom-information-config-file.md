---
title: Store custom information from a configuration file
description: This article describes how to store and retrieve custom information from an application configuration file by using Visual C#.
ms.date: 04/28/2020
ms.topic: how-to
---
# Use Visual C# to store and retrieve custom information from an application configuration file

This article introduces how to store custom information from a configuration file that you can retrieve later during run time by its associated application. It's helpful when you must define data that's associated with an application.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 815786

## Requirements

The following list outlines the recommended hardware and software that you need:

- Microsoft Windows
- Visual C#

This article assumes that you're familiar with the following topics:

- Extensible Markup Language (XML)
- .NET configuration files

## Create a console application that reads a configuration file

You can store application settings in the configuration file that is associated with the application. Configuration files are saved in XML format.

The `System.Configuration` and the `System.Collections.Specialized` namespaces in the .NET Framework include the necessary classes to retrieve information from a .NET application configuration file during run time.

To create a console application that reads the contents of an associated configuration file during run time, follow these steps:

1. Start Visual Studio .NET or Visual Studio.
2. On the **File** menu, point to **New**, and then select **Project**.
3. select **Visual C#** under **Project Types**, and then select **Console Application** under **Templates**. Name the project *ConConfig*. By default, Visual C# creates a class that is named *Program*.

    > [!NOTE]
    > In Visual Studio .NET, select **Visual C# Projects** under
     **Project Types**, and then select **Console Application** under **Templates**. Name the project *ConConfig*. By default, Visual C# creates a class that is named *Class1*.

4. Make sure that the **Solution Explorer** window is visible. If it isn't visible, press the CTRL+ALT+L key combination.
5. In **Solution Explorer**, right-click the project name, select **Add**, and then select **New Item**.
6. In the **Add New Item** list, select **XML File**.
7. In the **Name** text box, type *App.config*, and then select **Add**.
8. You can use an application configuration file to collect custom application settings that you save in key/value format. You can include `<add>` elements in the `<appSettings>` section of an associated configuration file. Each key/value pair has one `<add>` element. An `<add>` element has the following format:

    ```xml
    <add key="Key0" value="0" />
    ```

    Add an `<appSettings>` section with `<add>` elements to the configuration file between the `<configuration>` and `</configuration>` tags.

    For example, the following configuration file includes an `<appSettings>` section that specifies three key/value pairs:

    ```xml
    <?xml version="1.0" encoding="utf-8" ?>
    <configuration>
        <appSettings>
            <add key="Key0" value="0" />
            <add key="Key1" value="1" />
            <add key="Key2" value="2" />
        </appSettings>
    </configuration>
    ```

9. In **Solution Explorer**, double-click *Program.cs* to display the code window. Add the following statements to your code module.

    > [!NOTE]
    > These statements must appear before any other statements in the file.

    ```csharp
    using System.Configuration;
    using System.Collections.Specialized;
    ```

10. Add a reference to *System.Configuration.dll* by following these steps:
    1. On the **Project** menu, select **Add Reference**.
    2. In the **Add Reference** dialog box, select the **.NET** tab.
    3. Find and select the Component Name of `System.Configuration`.
    4. select **OK**.
11. To hold the value from a configuration file key in the
 `<appSettings>` section of the configuration file, declare a string variable in the `Main` section as follows:

    ```csharp
    string sAttr;
    ```

12. To retrieve a value for a specified key from the `<appSettings>` section of the configuration file, use the `Get` method of the `AppSettings` property of the `ConfigurationManager` class. The `ConfigurationManager` class is in the `System.Configuration` namespace. When the `AppSettings.Get` method receives a string input parameter that contains a key, the application retrieves the value that is associated with the key.

    The following code retrieves the value for the `Key0` attribute from the associated configuration file. The code then places this value in the `sAttr` string variable. If a key doesn't exist for this value, nothing is stored in `sAttr`.

    ```csharp
    sAttr = ConfigurationManager.AppSettings.Get("Key0");
    ```

13. To display the value that the application retrieves in the Console window, use `Console.WriteLine` as follows:

    ```csharp
    Console.WriteLine("The value of Key0 is "+sAttr);
    ```

14. You can use one reference to the `AppSettings` property to retrieve all the key/value pairs in the `<appSettings>` section. When you use the `AppSettings` property, the application returns all associated key/value pairs. These pairs are stored in a `NameValueCollection` type. The `NameValueCollection` contains key/value entries for each key that the application retrieves. The `NameValueCollection` class is in the `System.Collections.Specialized` namespace.

    ```csharp
    NameValueCollection sAll ;
    sAll = ConfigurationManager.AppSettings;
    ```

15. The `AllKeys` property of `NameValueCollection` references a string array that has an entry for each key that the application retrieves. Use a foreach construction to iterate through the `AllKeys` array to access each key that the application retrieves. Each key entry in `AllKeys` is a string data type.

    Inside the `foreach` construction, use `Console.WriteLine` to display the key and its associated value in the Console window. The current key that the application processes is in `s`. Use it as an index in the `sAllNameValueCollection` to obtain its associated value.

    ```csharp
     foreach (string s in sAll.AllKeys)
         Console.WriteLine("Key: "+ s + " Value: " + sAll.Get(s));
    
     Console.ReadLine();
    ```

## Complete code listing

```csharp
using System;
using System.Configuration;
using System.Collections.Specialized;

namespace ConConfig
{
    class Program
    {
        static void Main(string[] args)
        {
            string sAttr;

            // Read a particular key from the config file 
            sAttr = ConfigurationManager.AppSettings.Get("Key0");
            Console.WriteLine("The value of Key0: " + sAttr);

            // Read all the keys from the config file
            NameValueCollection sAll;
            sAll = ConfigurationManager.AppSettings;

            foreach (string s in sAll.AllKeys)
                Console.WriteLine("Key: " + s + " Value: " + sAll.Get(s));

            Console.ReadLine();
        }
    }
}
```

> [!NOTE]
> This code is targeting the .NET Framework 2.0. If you are using the .NET Framework 1.0 or the .NET Framework 1.1, change all instances of the `ConfigurationManager` class to `ConfigurationSettings`.

## Complete configuration file listing (ConConfig.exe.config)

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <appSettings>
        <add key="Key0" value="0" />
        <add key="Key1" value="1" />
        <add key="Key2" value="2" />
    </appSettings>
</configuration>
```

## Verify that it works

Press F5 to run the code. The Console window should display the key/value pairs from the `<appSettings>` section of the associated configuration file as follows:

```console
The value of Key0: 0
Key: Key0 Value:0
Key: Key1 Value:1
Key: Key2 Value:2
```

## Troubleshoot

- The configuration file is saved in XML format. Make sure that you follow all XML syntax rules. Remember that XML is case-sensitive. If the XML isn't well formed, or if an element is misspelled, you receive a `System.Configuration.Configuration` exception.

    For example, if you add the key attribute of an `<add>` element with an uppercase K instead of a lowercase k, or if the `<appSettings>` section appears as `<AppSettings>` (with an uppercase A instead of a lowercase a), you receive an error message.

- The configuration file must be saved in the same folder as its associated application.
- You must use the following syntax for the configuration file name:  
    \<ApplicationName>.\<ApplicationType>.config

    Where \<ApplicationName> is the name of the application. \<ApplicationType> is the type of application, such as `.exe`. And `.config` is the required suffix.

## References

- [ConfigurationSettings.AppSettings Property](/dotnet/api/system.configuration.configurationsettings.appsettings?&view=dotnet-plat-ext-3.1&preserve-view=true)

- [System.Configuration Namespace](/dotnet/api/system.configuration?&view=dotnet-plat-ext-3.1&preserve-view=true)
