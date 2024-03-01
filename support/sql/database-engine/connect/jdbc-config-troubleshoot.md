---
title: JDBC Configuring and Troubleshooting
description: 
ms.date: 02/28/2024
ms.reviewer: mastewa, prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
# JDBC configuring and troubleshooting

This article explains Java database connectivity (JDBC) and troubleshooting steps that occur during configuration.

This is a reference guide to JDBC, where to find the driver and supporting documentation and how to install on various operating systems with troubleshooting SQL connections.

> [!NOTE]
> Microsoft will not troubleshoot JDBC connections where there is a 3rd party connection pool manager in place. Troubleshooting with a 3rd party connection pool manager has the potential to expose intellectual property information.

- [Download Microsoft JDBC Driver for SQL Server](/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server)
- [Setting the connection properties](/sql/connect/jdbc/setting-the-connection-properties)

## JDBC driver version changes

- [10.2](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-10-2-for-sql-server-released/ba-p/3100754)
- [11.2](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-11-2-for-sql-server-released/ba-p/3595479)
- [12.2](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-12-2-for-sql-server-released/ba-p/3731398)
- [12.4](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-12-4-for-sql-server-released/ba-p/3889965)

## JDBC requirements

The [JRE](/sql/connect/jdbc/system-requirements-for-the-jdbc-driver) version must match the driver with the JRE version specified in the name. For example, *mssql-jdbc-9.4.1.jre8.jar* requires JRE1.8 and *mssql-jdbc-9.4.1.jre11.jar* requires JRE11.

[CLASSPATH](/sql/connect/jdbc/using-the-jdbc-driver) is a Java environment variable that contains the directory path and binary jar files. Java needs it to execute the desired application. This is a requirement to specify what driver and dependencies binary jar files Java will need to run. The minimum CLASSPATH includes current working directory `.;` and the location of the JDBC driver jar file.

CLASSPATHs can be defined in the operating system environment variable or in the application environment itself, like Tomcat. If the CLASSPATH is defined in the application environment, the application vendor or developer will have to be engaged to ensure proper CLASSPATH configurations are in place.

## JDBC configuration

This document is based on the latest driver ([12.4](https://techcommunity.microsoft.com/t5/sql-server-blog/jdbc-driver-12-4-for-sql-server-released/ba-p/3889965)) installed in the root of C drive.

## Set the CLASSPATH

To set CLASSPATH, use one of the following methods:

> [!NOTE]
> Command prompt setting is a temporary setting and will be removed when you close the command prompt window. GUI is a permanent setting and will require a reboot.

### Command prompt

```cmd
Set CLASSPATH=.;C:\sqljdbc_12.4\enu\mssql-jdbc-12.4.0.jre8.jar
```

### GUI

To set the CLASSPATH using GUI, follow these steps:

1. Open the **Control Panel** and select **System and Security**.

1. Select **System** > **Advanced system settings**.

1. Select **Environment Variables** > **New**, and enter *CLASSPATH* as the variable name.

1. Select **Edit** and enter *.;C:\sqljdbc_12.4\enu\mssql-jdbc-12.4.0.jre8.jar* as the variable value.

1. Select **OK**.

## Connection strings with passed in credentials

Connection strings with passed in credentials refers to a connection string that includes authentication credentials (such as username and password) as parameters or values within the string. When a program connects to a database or another service, it needs to provide authentication information to establish a secure connection.

The following connection string shows an example of how to connect to a SQL Server database based on the authentication mode you want to use:

### SQL Server Authentication

Connection string = `jdbc:sqlserver://<ServerName>:<PortNum>;user=<MySQLAuthAccount>;password=<MyPassword>;trustServerCertificate=true;`

### Windows AD Authentication without integrated security

Connection string = `jdbc:sqlserver://ServerName:Port;user=<MyADAuthAccount>;password=<MyPassword>;Domain=<MyDomain>;trustServerCertificate=true;javaAuthentication=NTLM`

### Windows AD Authentication with Kerberos and without integrated security

Connection string = `jdbc:sqlserver://ServerName:Port;user=<MyADAuthAccount>;password=<MyPassword>;Domain=<MyDomain>;trustServerCertificate=true;javaAuthentication=JavaKerberos`

### Integrated NTLM connection

In this kind of connection, client machine must be on a windows domain.

The *mssql-jdbc_auth-\<version\>-\<arch\>.dll* file must be in the following paths:

- **64-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x64\mssql-jdbc_auth-12.4.1.x64.dll`

- **32-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x86\mssql-jdbc_auth-12.4.1.x86.dll`

You can either modify and add the path or copy the file into an already established path. For more information, see [Connecting with integrated authentication On Windows](/sql/connect/jdbc/building-the-connection-url#Connectingintegrated).

Connection string = `jdbc:sqlserver://ServerName:Port;integratedSecurity=true;Domain=mydomain;trustServerCertificate=true;javaAuthentication=NTLM`

### Integrated Kerberos connections

Prerequisites for this type of connection are:

- Must be a part of a domain
- Must have SSSD installed and configured (Linux OS)
- Must have KLIST installed and configured (Linux OS)

The *mssql-jdbc_auth-\<version\>-\<arch\>.dll* file must be in the following paths. You can either modify and add the path or copy the file into an already established path.

- **64-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x64\mssql-jdbc_auth-12.4.1.x64.dll`

- **32-bit DLL**

  `%Path%;C:\sqljdbc_12.4.1.0_enu\sqljdbc_12.4\enu\auth\x86\mssql-jdbc_auth-12.4.1.x86.dll`

You also have to create a *Jaas.conf* file. This file doesn't come with the driver by default and doesn't get installed with Java. You'll also need to tell the environment where to find this file. You can do this by either modifying the *Java.Security* file or adding the file via parameter when you load your environment or application.

The *Jaas.conf* files will allow java to use the current context of the logged in user. It will also tell java to use current cached Kerberos tickets.

- In the *Java.Security* file, you need to modify the following line:

  ```output
  # Default login configuration file
    
  login.config.url.1=C:=\<Path to the File>\jaas.conf
  ```

- Alternative via parameter to modify or add the *Java.Security* file. You should also use the same parameter when you compile the java file.

  - ```cmd
    javac -Djava.security.auth.login.config=c:\myDirectory\Jaas.conf myapp.java
    ```

  - ```cmd
    java -Djava.security.auth.login.config=c:\myDirectory\Jaas.conf myapp
    ```

  Jaas.conf file

  ```java
  SQLJDBCDriver {
  com.sun.security.auth.module.Krb5LoginModule required 
   =true;
  };
  ```

Connection string = `jdbc:sqlserver://ServerName:Port;integratedSecurity=true;Domain=mydomain;trustServerCertificate=true;javaAuthentication=JavaKerberos;`

## Sample code

All JDBC drivers come with sample code in the *\sqljdbc_12.4\enu\samples* directory. The one most commonly used will be in *\sqljdbc_12.4\enu\samples\connections\ConnectURR.java*. Create a file called *ConnectURL.java* or use the *ConnectURL.java* from the sampled supplied with the driver.

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

## JDBC driver tracing

[Tracing driver operation](/sql/connect/jdbc/tracing-driver-operation).

Generally, we always want to set tracing to `FINEST` for the more detail. There are two methods of driver tracing, programmatically and enabling it by using the *logging.properties* file.

If you choose to use the *logging.properties* file, you must find the correct environment for the *logging.properties* file. *$JAVA_HOME\conf\\* and *$JAVA_HOME\jre\lib* are two possible locations. Modify the *logging.properties* files to look like the following Global Properties:

```output
# "handlers" specifies a comma-separated list of log Handler
# classes. These handlers will be installed during VM startup.
# Note that these classes must be on the system classpath.
# By default we only configure a ConsoleHandler, which will only
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

Handlers tell java where to export the output. There are two locations FileHandler writes to a file and ConsoleHandler writes to a console window. There's going to be a lot of data coming from the output, so we really want to just write the output to a file.

Comment line

`#handlers= java.util.logging.ConsoleHandler`

Uncomment line

`handlers= java.util.logging.FileHandler`

We also want to set `.level` to `OFF` so we don't see messages on the console window.

`.level=OFF`

Specific FileHander logging settings:

```output
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

Modify this portion so it looks like or contains the following:

```output
java.util.logging.FileHandler.pattern = /Path/java%u.log
java.util.logging.FileHandler.limit = 5000000
java.util.logging.FileHandler.count = 20
java.util.logging.FileHandler.formatter = java.util.logging.SimpleFormatter
java.util.logging.FileHandler.level = FINEST
```

I would modify `java.util.logging.FileHandler.pattern = %h/java%u.log` line and replace `%h/` with a path you want to the file to be stored.

`java.util.logging.FileHandler.pattern = c:/Temp/java%u.log`

Lastly, in this file, we want to set the driver logging level:

```output
############################################################
# Facility-specific properties.
# Provides extra control for each logger.
############################################################

# For example, set the com.xyz.foo logger to only log SEVERE
# messages:
# com.xyz.foo.level = SEVERE
```

At the bottom of this section, add the following line:

`com.microsoft.sqlserver.jdbc.level=FINEST`

Save the changes made.

The file should look like the following:

```output
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

After you have reproduced the error, you'll want to revert the changes to stop the logger from creating files.
