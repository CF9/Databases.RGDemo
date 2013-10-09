Databases.RGDemo
================

Red Gate Database for SQL in the City and [Bay Area Meetup](http://bit.ly/11QTbi3) presentations.
You can also find a copy of the PowerPoint presentation in the root folder.

I'm also experimenting with Prezi instead of PowerPoint.  Here's the Prezi deck:

http://bit.ly/10h72OE
 

* You can restore a copy of the RGDemo database in from the DatabaseBackup folder.
* You can also restore the same database as RGDemo_DEV, RGDemo_QA and RGDemo_PROD on your same machine
* If you install Jenkins, you can configure a new Job using the settings in the JenkinsConfig folder
* In order to use the Regular Expression replacement task for Versioning, you need to have MSBuild Community Tasks installed.


When creating this database locally, make sure you set the TRUSTWORTHY attribute to ON so that the CLR assembly can be created.

    ALTER DATABASE [RGDemo] SET TRUSTWORTHY ON
    GO

Setting up your Continuous Integration Server
---------------------------------------------

Here are the steps that I took when creating my build server via Windows Azure:

* Created a VM Running SQL 2012 Web
* Install the Git client
* Installed Jenkins with the following plug-ins:
    * MSBuild (need to configure this plug in to point to the MSBuild.exe binary)
    * Promoted Builds
    * Versioning
    * Copy Artifacts
    * GitHub (Need to configure this to point to the bin folder) 
* Changed the Jenkins service to run under the local admin account (since SQL is using trusted connections)
* Installed .NET Framework 4.0
* Install MSBuild community tasks (I just unzipped the binaries and threw them in a folder called MSBuildCommunityTasks in the C:\Windows\Microsoft.NET\Framework64\v4x folder)
* Open SSMS and create three empty databases:
    * RGDemo_Dev
    * RGDemo_QA
    * RGDemo_Prod
* Create the folder C:\JenkinsPromotions\ and put the DeployDb.bat file in it.


Create the Jenkins Build Job
----------------------------

Instead of writing out everything, below is a screenshot of the configuration for the Jenkins job.  I'll update the README.md file with the actual settings shortly.

![Jenkins Screenshot](http://i.imgur.com/XzMjaKv.png "Jenkins Job Configuration Screenshot")
