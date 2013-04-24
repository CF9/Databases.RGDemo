Databases.RGDemo
================

Red Gate Database for SQL in the City and [Bay Area Meetup](http://bit.ly/11QTbi3) presentations.
You can also find a copy of the PowerPoint presentation in the root folder.


* You can restore a copy of the RGDemo database in from the DatabaseBackup folder.
* You can also restore the same database as RGDemo_DEV, RGDemo_QA and RGDemo_PROD on your same machine
* If you install Jenkins, you can configure a new Job using the settings in the JenkinsConfig folder
* In order to use the Regular Expression replacement task for Versioning, you need to have MSBuild Community Tasks installed.


When creating this database locally, make sure you set the TRUSTWORTHY attribute to ON so that the CLR assembly can be created.

    ALTER DATABASE [RGDemo] SET TRUSTWORTHY ON
    GO

