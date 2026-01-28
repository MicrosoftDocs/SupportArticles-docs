The initially released version of this cumulative update (KB5074819) contained an issue that caused Database Mail to stop working. You might have also seen the following error message:

> Could not load file or assembly 'Microsoft.SqlServer.DatabaseMail.XEvents, Version=17.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' or one of its dependencies. The system cannot find the file specified.

This issue is _resolved_ in the currently available version of this cumulative update (KB5078297).

The following recommendations and considerations apply:

- If you downloaded the initially released version of this update, don't install it. Download and install the currently available version of the update.
- If you already installed the initially released update, you can [uninstall](/sql/sql-server/install/uninstall-a-cumulative-update-from-sql-server) it, or install the currently available version of the update to restore Database Mail functionality.
- Future cumulative updates will also contain the fix for this issue, and can be installed regardless of the currently installed version of this cumulative update.
- Any email messages queued via Database Mail while the initially released version of this update was installed aren't sent. These messages aren't automatically resent when the initially released update is uninstalled, or when a cumulative update with the fix for this issue is installed.
