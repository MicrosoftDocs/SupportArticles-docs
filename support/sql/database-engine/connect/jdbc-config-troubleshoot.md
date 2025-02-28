---
title: JDBC configuration and troubleshooting
description: Describes Java database connectivity (JDBC) and the troubleshooting steps that occur during configuration.
ms.date: 03/25/2024
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Database Connectivity and Authentication
---
# JDBC configuration and troubleshooting

This article describes Java database connectivity (JDBC) and the troubleshooting steps that occur during configuration. The focus is on JDBC for SQL Server.

> [!NOTE]
>
> - This article is based on the latest JDBC driver ([version 12.4](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-12-4-for-sql-server-released/ba-p/3889965)) installed in the root of the *C* drive.
> - Microsoft doesn't troubleshoot JDBC connections where a third-party connection pool manager exists. Troubleshooting with a third-party connection pool manager has the potential to expose intellectual property information.

## Microsoft JDBC Driver for SQL Server

This article provides reference guide to JDBC, including the driver and supporting documentation, installation instructions for different operating systems (OS), and troubleshooting SQL Server connection issues.

- [Download Microsoft JDBC Driver for SQL Server](/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server)
- [Setting the connection properties](/sql/connect/jdbc/setting-the-connection-properties)

## JDBC driver version changes

- [10.2](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-10-2-for-sql-server-released/ba-p/3100754)
- [11.2](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-11-2-for-sql-server-released/ba-p/3595479)
- [12.2](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-12-2-for-sql-server-released/ba-p/3731398)
- [12.4](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-12-4-for-sql-server-released/ba-p/3889965)

## JDBC requirements

- The [Java Runtime Environment (JRE)](/sql/connect/jdbc/system-requirements-for-the-jdbc-driver) version must match the driver with the JRE version specified in the name. For example, *mssql-jdbc-9.4.1.jre8.jar* requires JRE 1.8, and *mssql-jdbc-9.4.1.jre11.jar* requires JRE 11.0.

- [CLASSPATH](/sql/connect/jdbc/using-the-jdbc-driver) is a Java environment variable that contains the directory path and binary jar files. Java needs it to execute the desired application. It's a requirement to specify which driver and dependency binary jar files Java needs to run. The minimum `CLASSPATH` includes the current working directory `.;` and the location of the JDBC driver jar file.

## JDBC configuration and troubleshooting steps

### Set the CLASSPATH variable

CLASSPATHs can be defined in the OS environment variable or in the application environment itself, like Tomcat. If `CLASSPATH` is defined in the application environment, the application vendor or developer has to be engaged to ensure proper `CLASSPATH` configurations are in place.

To set `CLASSPATH`, use one of the following methods:

> [!NOTE]
> The command prompt setting is temporary and will be removed when you close the command prompt window. The graphical user interface (GUI) is a permanent setting and requires a reboot.

#### Command prompt example

```cmd
Set CLASSPATH=.;C:\sqljdbc_12.4\enu\mssql-jdbc-12.4.0.jre8.jar
```

#### GUI example

To set `CLASSPATH` using the GUI, follow these steps:

1. Open **Control Panel** and select **System and Security**.

1. Select **System** > **Advanced system settings**.

1. Select **Environment Variables** > **New**, and then enter *CLASSPATH* as the variable name.

1. Select **Edit** and enter *.;C:\sqljdbc_12.4\enu\mssql-jdbc-12.4.0.jre8.jar* as the variable value.

1. Select **OK**.

### Connection strings with passed-in credentials

A connection string with passed-in credentials refers to a connection string that includes authentication credentials (such as username and password) as parameters or values within the string. When a program connects to a database or other service, it needs to provide authentication information to establish a secure connection.

The following connection string shows an example of how to connect to a SQL Server database based on the authentication mode you want to use:

#### SQL Server authentication

Connection string is `String connectionUrl = "jdbc:sqlserver://<ServerName>:<PortNum>;user=<MySQLAuthAccount>;password=<MyPassword>;trustServerCertificate=true;"`

#### Windows AD authentication without integrated security

Connection string is `String connectionUrl = "jdbc:sqlserver://<ServerName>:<PortNum>;user=<MyADAuthAccount>;password=<MyPassword>;Domain=<MyDomain>;trustServerCertificate=true;javaAuthentication=NTLM"`

#### Windows AD authentication with Kerberos and without integrated security

Connection string is `String connectionUrl = "jdbc:sqlserver://<ServerName>:<PortNum>;user=<MyADAuthAccount>;password=<MyPassword>;Domain=<MyDomain>;trustServerCertificate=true;javaAuthentication=JavaKerberos"`

#### Integrated NTLM connection

In this kind of connection, the client machine must be in a Windows domain.

The *mssql-jdbc_auth-\<version\>-\<arch\>.dll* file must be in the following paths:

- **64-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x64\mssql-jdbc_auth-12.4.1.x64.dll`

- **32-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x86\mssql-jdbc_auth-12.4.1.x86.dll`

You can either modify and add the path or copy the file into an already established path. For more information, see [Connecting with integrated authentication on Windows](/sql/connect/jdbc/building-the-connection-url#Connectingintegrated).

Connection string is `String connectionUrl = "jdbc:sqlserver://<ServerName>:<PortNum>;integratedSecurity=true;Domain=<MyDomain>;trustServerCertificate=true;javaAuthentication=NTLM"`

#### Integrated Kerberos connections

The prerequisites for this type of connection are:

- Must be a part of a domain.
- Must have SSSD installed and configured on Linux OS.
- Must have Klist installed and configured on Linux OS.

The *mssql-jdbc_auth-\<version\>-\<arch\>.dll* file must be in the following paths. You can either modify and add the path or copy the file into an already established path.

- **64-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x64\mssql-jdbc_auth-12.4.1.x64.dll`

- **32-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x86\mssql-jdbc_auth-12.4.1.x86.dll`

You also have to create a *Jaas.conf* file. By default, this file doesn't come with the driver and doesn't get installed with Java. To help the environment to locate this file, use one of the following methods:

> [!NOTE]
> The *Jaas.conf* file will allow Java to use the current context of the logged-in user. It will also tell Java to use the currently cached Kerberos tickets.

- Modify the following line in the *Java.Security* file:

  ```java
  # Default login configuration file
    
  login.config.url.1=C:=\<Path to the File>\jaas.conf
  ```

- Alternatively, add the *Jaas.conf* file via a parameter when you load your environment or application. Ensure you use the same parameter when you compile the Java file:

  ```cmd
  javac -Djava.security.auth.login.config=c:\myDirectory\Jaas.conf myapp.java
  java -Djava.security.auth.login.config=c:\myDirectory\Jaas.conf myapp
  ```

To establish a connection to a SQL Server using Kerberos integrated authentication, configure the *Jaas.conf* file:

```java
SQLJDBCDriver {
com.sun.security.auth.module.Krb5LoginModule required 
useTicketCache=true; 
};
```

Connection string is `String connectionUrl = "jdbc:sqlserver://<ServerName>:<PortNum>;integratedSecurity=true;Domain=<MyyDomain>;trustServerCertificate=true;javaAuthentication=JavaKerberos;"`

#### Sample code

All JDBC drivers come with sample code in the *\sqljdbc_12.4\enu\samples* directory. The most commonly used one is in *\sqljdbc_12.4\enu\samples\connections\ConnectURR.java*. Create a file called *ConnectURL.java*, or use *ConnectURL.java* from the sample supplied with the driver.

```java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectURL {
    public static void main(String[] args) {

        // Create a variable for the connection string. Base the connection string on the previous examples supplied in the above documentation.
        String connectionUrl = "jdbc:sqlserver://ServerName:Port;user=SQLAuthAccount;password=SomePassword;trustServerCertificate=true;";

        try (Connection con = DriverManager.getConnection(connectionUrl); Statement stmt = con.createStatement();) 
	{
                String SQL = "SELECT @@version";
	        ResultSet rs = stmt.executeQuery(SQL);
                // Iterate through the data in the result set and display it.
                while (rs.next()) 
		{
                     System.out.println(rs.getString(1));
            	}
        }
        // Handle any errors that may have occurred.
        catch (SQLException e) 
        {e.printStackTrace();    }
  }
}
```

### JDBC driver tracing

Generally, we always want to set tracing to `FINEST` for more details. There are two methods for driver tracing: [enabling tracing programmatically](/sql/connect/jdbc/tracing-driver-operation#enabling-tracing-programmatically) and [enabling tracing by using the logging.properties file](/sql/connect/jdbc/tracing-driver-operation#enabling-tracing-by-using-the-loggingproperties-file).

If you choose to use the *logging.properties* file, you must find the correct environment for the *logging.properties* file. *$JAVA_HOME\conf\\* and *$JAVA_HOME\jre\lib* are two possible locations.

Follow these steps to configure this file:

1. Modify the *logging.properties* file to ensure it resembles the following global properties:

    ```java
    ############################################################
    #  Global properties
    ############################################################
    # "handlers" specifies a comma-separated list of log Handler
    # classes. These handlers will be installed during VM startup.
    # Note that these classes must be on the system classpath.
    # By default, we only configure a ConsoleHandler, which will only
    # show messages at the INFO and above levels.
    
    handlers= java.util.logging.ConsoleHandler
    
    # To also add the FileHandler, use the following line instead.
    #handlers= java.util.logging.FileHandler
    
    # Default global logging level.
    # This specifies which kinds of events are logged across
    # all loggers.  For any given facility this global level
    # can be overridden by a facility-specific level
    # Note that the ConsoleHandler also has a separate level
    # setting to limit messages printed to the console.
    
    .level= INFO
    ```

    Handlers tell Java where to export the output. There are two locations where FileHandler writes to a file and ConsoleHandler writes to a console window. The output will produce lots of data, so it needs to be written to a file.

    - **Comment line**

      ```java
      #handlers= java.util.logging.ConsoleHandler
      ```

    - **Uncomment line**

      ```java
      handlers= java.util.logging.FileHandler
      ```

    > [!NOTE]
    > Set `.level` to `OFF` and you won't see messages on the console window.
    >
    > ```java
    >  .level=OFF
    >  ```

1. Set the specific FileHandler logging:

    ```java
    ############################################################
    # Handler specific properties.
    # Describes specific configuration info for Handlers.
    ############################################################
    
    # default file output is in user's home directory.
    java.util.logging.FileHandler.pattern = %h/java%u.log
    java.util.logging.FileHandler.limit = 50000
    java.util.logging.FileHandler.count = 1
    # Default number of locks FileHandler can obtain synchronously.
    # This specifies maximum number of attempts to obtain lock file by FileHandler
    # implemented by incrementing the unique field %u as per FileHandler API documentation.
    java.util.logging.FileHandler.maxLocks = 100
    java.util.logging.FileHandler.formatter = java.util.logging.XMLFormatter
    
    # Limit the messages that are printed on the console to INFO and above.
    java.util.logging.ConsoleHandler.level = INFO
    java.util.logging.ConsoleHandler.formatter = java.util.logging.SimpleFormatter
    
    # Example to customize the SimpleFormatter output format
    # to print one-line log message like this:
    #     <level>: <log message> [<date/time>]
    #
    # java.util.logging.SimpleFormatter.format=%4$s: %5$s [%1$tc]%n
    ```

1. Modify this portion to ensure it resembles or contains the following lines:

    ```java
    java.util.logging.FileHandler.pattern = /Path/java%u.log
    java.util.logging.FileHandler.limit = 5000000
    java.util.logging.FileHandler.count = 20
    java.util.logging.FileHandler.formatter = java.util.logging.SimpleFormatter
    java.util.logging.FileHandler.level = FINEST
    ```

1. Modify the `java.util.logging.FileHandler.pattern = %h/java%u.log` line and replace `%h/` with a path you want the file to be stored. For example:

   `java.util.logging.FileHandler.pattern = c:/Temp/java%u.log`

1. Set the driver logging level:

   Add `com.microsoft.sqlserver.jdbc.level=FINEST` at the bottom of the following section:

    ```java
    ############################################################
    # Facility-specific properties.
    # Provides extra control for each logger.
    ############################################################
    
    # For example, set the com.xyz.foo logger to only log SEVERE
    # messages:
    # com.xyz.foo.level = SEVERE
    ```

1. Save the changes.

   The file should look like the following one:

    ```java
    ############################################################
    #  Default Logging Configuration File
    #
    # You can use a different file by specifying a filename
    # with the java.util.logging.config.file system property.
    # For example, java -Djava.util.logging.config.file=myfile
    ############################################################
    
    ############################################################
    #  Global properties
    ############################################################
    
    # "handlers" specifies a comma-separated list of log Handler
    # classes.  These handlers will be installed during VM startup.
    # Note that these classes must be on the system classpath.
    # By default we only configure a ConsoleHandler, which will only
    # show messages at the INFO and above levels.
    #handlers= java.util.logging.ConsoleHandler
    
    # To also add the FileHandler, use the following line instead.
    handlers= java.util.logging.FileHandler
    
    # Default global logging level.
    # This specifies which kinds of events are logged across
    # all loggers.  For any given facility this global level
    # can be overridden by a facility-specific level
    # Note that the ConsoleHandler also has a separate level
    # setting to limit messages printed to the console.
    .level= OFF
    
    ############################################################
    # Handler specific properties.
    # Describes specific configuration info for Handlers.
    ############################################################
    
    # default file output is in user's home directory.
    java.util.logging.FileHandler.pattern = c:/Temp/java%u.log
    java.util.logging.FileHandler.limit = 50000
    java.util.logging.FileHandler.count = 1
    # Default number of locks FileHandler can obtain synchronously.
    # This specifies maximum number of attempts to obtain lock file by FileHandler
    # implemented by incrementing the unique field %u as per FileHandler API documentation.
    java.util.logging.FileHandler.maxLocks = 100
    java.util.logging.FileHandler.formatter = java.util.logging.SimpleFormatter
    
    # Limit the messages that are printed on the console to INFO and above.
    #java.util.logging.ConsoleHandler.level = INFO
    #java.util.logging.ConsoleHandler.formatter = java.util.logging.SimpleFormatter
    
    # Example to customize the SimpleFormatter output format
    # to print one-line log message like this:
    #     <level>: <log message> [<date/time>]
    #
    # java.util.logging.SimpleFormatter.format=%4$s: %5$s [%1$tc]%n
    
    ############################################################
    # Facility-specific properties.
    # Provides extra control for each logger.
    ############################################################
    
    # For example, set the com.xyz.foo logger to only log SEVERE
    # messages:
    # com.xyz.foo.level = SEVERE
    com.microsoft.sqlserver.jdbc.level=FINEST
    ```

After reproducing the error, revert the changes to stop the logger from creating files.

Alternatively, you can create or copy the text above, save it to a file, and add the file to the startup command when loading the application.

```cmd
java -Djava.util.logging.config.file=c:\<Path to the file>\logging.properties myapp
```

This would allow you to identify a *logging.properties* file that's not specified in the default directories `$JAVA_HOME\conf\` and `$JAVA_HOME\jre\lib` via a command line.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
