---
title: Use ASP.NET forms-based authentication
description: This article demonstrates how to implement forms-based authentication in ASP.NET applications by using a database to store the users.
ms.date: 03/27/2020
ms.custom: sap:General Development
ms.reviewer: ARTHURYA
ms.topic: how-to
---
# Implement forms-based authentication in an ASP.NET application by using C#.NET

This article demonstrates how to implement forms-based authentication by using a database to store the users. It refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Data.SqlClient`
- `System.Web.Security`

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 301240

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you need:

- Visual Studio .NET
- Internet Information Services (IIS) version 5.0 or later
- SQL Server

## Create an ASP.NET application by using C# .NET

1. Open Visual Studio .NET.
2. Create a new ASP.NET Web application, and specify the name and location.

## Configure security settings in the Web.config File

This section demonstrates how to add and modify the `<authentication>` and `<authorization>` configuration sections to configure the ASP.NET application to use forms-based authentication.

1. In Solution Explorer, open the *Web.config* file.
2. Change the authentication mode to **Forms**.
3. Insert the `<Forms>` tag, and fill the appropriate attributes. Copy the following code, and then select **Paste as HTML** on the **Edit** menu to paste the code in the `<authentication>` section of the file:

    ```xml
    <authentication mode="Forms">
        <forms name=".ASPXFORMSDEMO" loginUrl="logon.aspx"
            protection="All" path="/" timeout="30" />
    </authentication>
    ```

4. Deny access to the anonymous user in the `<authorization>` section as follows:

    ```xml
    <authorization>
        <deny users ="?" />
        <allow users = "*" />
    </authorization>
    ```

## Create a sample database table to store users details

This section shows how to create a sample database to store the user name, password, and role for the users. You need the role column if you want to store user roles in the database and implement role-based security.

1. On the **Start** menu, select **Run**, and then type notepad to open Notepad.
2. Highlight the following SQL script code, right-click the code, and then select **Copy**. In Notepad, select **Paste** on the **Edit** menu to paste the following code:

    ```sql
    if exists (select * from sysobjects where id =
    object_id(N'[dbo].[Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
        drop table [dbo].[Users]
    GO
    CREATE TABLE [dbo].[Users] ([uname] [varchar] (15) NOT NULL,
        [Pwd] [varchar] (25) NOT NULL,
        [userRole] [varchar] (25) NOT NULL,
    ) ON [PRIMARY]
    GO
    ALTER TABLE [dbo].[Users] WITH NOCHECK ADD
        CONSTRAINT [PK_Users] PRIMARY KEY NONCLUSTERED
        ([uname]
        ) ON [PRIMARY]
    GO

    INSERT INTO Users values('user1','user1','Manager')
    INSERT INTO Users values('user2','user2','Admin')
    INSERT INTO Users values('user3','user3','User')
    GO
    ```

3. Save the file as *Users.sql*.
4. On the SQL Server computer, open *Users.sql* in Query Analyzer. From the list of databases, select **pubs**, and run the script. This operation creates a sample users table and populates the table in the Pubs database to be used with this sample application.

## Create a Logon.aspx page

1. Add a new Web Form to the project named *Logon.aspx*.
2. Open the Logon.aspx page in the editor, and switch to HTML view.
3. Copy the following code, and use the **Paste as HTML** option on the **Edit** menu to insert the code between the `<form>` tags:

    ```html
    <h3>
        <font face="Verdana">Logon Page</font>
    </h3>
    <table>
        <tr>
            <td>Email:</td>
            <td><input id="txtUserName" type="text" runat="server"></td>
            <td><ASP:RequiredFieldValidator ControlToValidate="txtUserName"
                Display="Static" ErrorMessage="*" runat="server" 
                ID="vUserName" /></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input id="txtUserPass" type="password" runat="server"></td>
            <td><ASP:RequiredFieldValidator ControlToValidate="txtUserPass"
            Display="Static" ErrorMessage="*" runat="server"
            ID="vUserPass" />
            </td>
        </tr>
        <tr>
            <td>Persistent Cookie:</td>
            <td><ASP:CheckBox id="chkPersistCookie" runat="server" autopostback="false" /></td>
            <td></td>
        </tr>
    </table>
    <input type="submit" Value="Logon" runat="server" ID="cmdLogin"><p></p>
    <asp:Label id="lblMsg" ForeColor="red" Font-Name="Verdana" Font-Size="10" runat="server" />
    ```

    This Web Form is used to present a logon form to users so that they can provide their user name and password to log on to the application.
4. Switch to Design view, and save the page.

## Code the event handler so that it validates the user credentials

This section presents the code that is placed in the code-behind page (Logon.aspx.cs).

1. Double-click **Logon** to open the *Logon.aspx.cs* file.
2. Import the required namespaces in the code-behind file:

    ```csharp
    using System.Data.SqlClient;
    using System.Web.Security;
    ```

3. Create a `ValidateUser` function to validate the user credentials by looking in the database. Make sure that you change the `Connection` string to point to your database.

    ```csharp
    private bool ValidateUser( string userName, string passWord )
    {
        SqlConnection conn;
        SqlCommand cmd;
        string lookupPassword = null;

        // Check for invalid userName.
        // userName must not be null and must be between 1 and 15 characters.
        if ( ( null == userName ) || ( 0 == userName.Length ) || ( userName.Length > 15 ))
        {
            System.Diagnostics.Trace.WriteLine( "[ValidateUser] Input validation of userName failed." );
            return false;
        }

        // Check for invalid passWord.
        // passWord must not be null and must be between 1 and 25 characters.
        if ( ( null == passWord ) || ( 0 == passWord.Length ) || ( passWord.Length > 25 ))
        {
            System.Diagnostics.Trace.WriteLine( "[ValidateUser] Input validation of passWord failed." );
            return false;
        }

        try
        {
            // Consult with your SQL Server administrator for an appropriate connection
            // string to use to connect to your local SQL Server.
            conn = new SqlConnection( "server=localhost;Integrated Security=SSPI;database=pubs" );
            conn.Open();

            // Create SqlCommand to select pwd field from users table given supplied userName.
            cmd = new SqlCommand( "Select pwd from users where uname=@userName", conn );
            cmd.Parameters.Add( "@userName", SqlDbType.VarChar, 25 );
            cmd.Parameters["@userName"].Value = userName;

            // Execute command and fetch pwd field into lookupPassword string.
            lookupPassword = (string) cmd.ExecuteScalar();

            // Cleanup command and connection objects.
            cmd.Dispose();
            conn.Dispose();
        }
        catch ( Exception ex )
        {
            // Add error handling here for debugging.
            // This error message should not be sent back to the caller.
            System.Diagnostics.Trace.WriteLine( "[ValidateUser] Exception " + ex.Message );
        }

        // If no password found, return false.
        if ( null == lookupPassword )
        {
            // You could write failed login attempts here to event log for additional security.
            return false;
        }

        // Compare lookupPassword and input passWord, using a case-sensitive comparison.
        return ( 0 == string.Compare( lookupPassword, passWord, false ));
    }
    ```

4. You can use one of two methods to generate the forms authentication cookie and redirect the user to an appropriate page in the `cmdLogin_ServerClick` event. Sample code is provided for both scenarios. Use either of them according to your requirement.

    - Call the `RedirectFromLoginPage` method to automatically generate the forms authentication cookie and redirect the user to an appropriate page in the `cmdLogin_ServerClick` event:

        ```csharp
        private void cmdLogin_ServerClick(object sender, System.EventArgs e)
        {
            if (ValidateUser(txtUserName.Value,txtUserPass.Value))
                FormsAuthentication.RedirectFromLoginPage(txtUserName.Value, chkPersistCookie.Checked);
            else
                Response.Redirect("logon.aspx", true);
        }
       ```

    - Generate the authentication ticket, encrypt it, create a cookie, add it to the response, and redirect the user. This operation gives you more control in how you create the cookie. You can also include custom data along with the `FormsAuthenticationTicket` in this case.

        ```csharp
        private void cmdLogin_ServerClick(object sender, System.EventArgs e)
        {
            if (ValidateUser(txtUserName.Value,txtUserPass.Value))
            {
                FormsAuthenticationTicket tkt;
                string cookiestr;
                HttpCookie ck;
                tkt = new FormsAuthenticationTicket(1, txtUserName.Value, DateTime.Now,
                DateTime.Now.AddMinutes(30), chkPersistCookie.Checked, "your custom data");
                cookiestr = FormsAuthentication.Encrypt(tkt);
                ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
                if (chkPersistCookie.Checked)
                    ck.Expires=tkt.Expiration;
                ck.Path = FormsAuthentication.FormsCookiePath;
                Response.Cookies.Add(ck);

                string strRedirect;
                strRedirect = Request["ReturnUrl"];
                if (strRedirect==null)
                    strRedirect = "default.aspx";
                Response.Redirect(strRedirect, true);
            }
            else
                Response.Redirect("logon.aspx", true);
        }
        ```

5. Make sure that the following code is added to the `InitializeComponent` method in the code that the Web Form Designer generates:

    ```csharp
    this.cmdLogin.ServerClick += new System.EventHandler(this.cmdLogin_ServerClick);
    ```

## Create a Default.aspx page

This section creates a test page to which users are redirected after they authenticate. If users browse to this page without first logging on to the application, they're redirected to the logon page.

1. Rename the existing *WebForm1.aspx* page as *Default.aspx*, and open it in the editor.
2. Switch to HTML view, and copy the following code between the `<form>` tags:

    ```html
    <input type="submit" Value="SignOut" runat="server" id="cmdSignOut">
    ```

    This button is used to log off from the forms authentication session.
3. Switch to Design view, and save the page.
4. Import the required namespaces in the code-behind file:

    ```csharp
    using System.Web.Security;
    ```

5. Double-click **SignOut** to open the code-behind page (Default.aspx.cs), and copy the following code in the `cmdSignOut_ServerClick` event handler:

    ```csharp
    private void cmdSignOut_ServerClick(object sender, System.EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("logon.aspx", true);
    }
    ```

6. Make sure that the following code is added to the `InitializeComponent` method in the code that the Web Form Designer generates:

    ```csharp
    this.cmdSignOut.ServerClick += new System.EventHandler(this.cmdSignOut_ServerClick);
    ```

7. Save and compile the project. You can now use the application.

## Additional notes

- You may want to store passwords securely in a database. You can use the `FormsAuthentication` class utility function named `HashPasswordForStoringInConfigFile` to encrypt the passwords before you store them in the database or configuration file.

- You may want to store the SQL connection information in the configuration file (*Web.config*) so that you can easily modify it if necessary.

- You may consider adding code to prevent hackers who try to use different combinations of passwords from logging on. For example, you can include logic that accepts only two or three logon attempts. If users can't log on in some attempts, you may want to set a flag in the database to not allow them to log on until the users re-enable their accounts by visiting a different page or by calling your support line. Also, you should add appropriate error handling wherever necessary.

- Because the user is identified based on the authentication cookie, you may want to use Secure Sockets Layer (SSL) on this application so that no one can deceive the authentication cookie and any other valuable information that is being transmitted.

- Forms-based authentication requires that your client accept or enable cookies on their browser.

- The timeout parameter of the `<authentication>` configuration section controls the interval at which the authentication cookie is regenerated. You can choose a value that provides better performance and security.

- Certain intermediary proxies and caches on the Internet may cache Web server responses that contain `Set-Cookie` headers, which are then returned to a different user. Because forms-based authentication uses a cookie to authenticate users, this behavior can cause users to accidentally (or intentionally) impersonate another user by receiving a cookie from an intermediary proxy or cache that wasn't originally intended for them.

## References

- [Forms Authentication Using An XML Users File](/previous-versions/dotnet/netframework-1.1/1b1y85bh(v=vs.71))

- [ASP.NET Web Application Security](/previous-versions/dotnet/netframework-1.1/330a99hc(v=vs.71))

- [System.Web.Security Namespace](/dotnet/api/system.web.security)

- [ASP.NET Configuration](/previous-versions/dotnet/netframework-1.1/aa719558(v=vs.71))

- [ASP.NET Configuration Sections](/previous-versions/dotnet/netframework-1.1/w7w4sb0w(v=vs.71))
