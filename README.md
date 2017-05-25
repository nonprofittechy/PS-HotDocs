# PS-HotDocs
Two PowerShell scripts to help manage a large HotDocs library:
1. get-dialogcontents: lists all of the variables in a dialog, with optional text before/after the variable name.
1. get-dialogsummary: creates a computation script that lists all of the true/false variables in a dialog, to be used in a dialog element. The text of the dialog element will display the TITLE only of the "checked" (or YES) variables. (If title isn't specified, the PROMPT will be used instead).

The purpose of these PowerShell scripts is to speed up creation of HotDocs scripts and computations that involve a lot of repetive information: for example, manipulating a long list of related variables that might be spread out over a few different dialogs.

Read more on my blog, [here](http://nonprofittechy.com/2017/05/03/using-powershell-to-manage-large-hotdocs-interviews/).

## Using the scripts
You'll need just a few things to get started:

1. Download the files in this repository. Click the green "Clone or Download" button, and select "Download ZIP" if you aren't familiar with using the Git commandline or desktop tools.
1. PowerShell (built in to Windows after Vista).
1. A HotDocs component file.
1. The name of a dialog in the component file.

## Set up your PowerShell environment
By default, PowerShell will only run "signed" scripts. The scripts in this repository are not signed. You need to turn off the signed execution policy to allow running these scripts.

1. Open a PowerShell window (Start | Windows PowerShell)
1. Type the text below:
```powershell
set-executionpolicy bypass
```

## Run the Dialog scripts
You'll run each of these scripts from the PowerShell prompt. A quirk of PowerShell is that when you run a script in PowerShell, you need to type in a ampersand "&" before the path to the script. This tells PowerShell that you want to run the text in quotes as a script instead of interpreting it literally.

Open the PowerShell window. Type in an "&". Then, just drag and drop the script itself to the PowerShell commandline to add its path to the prompt.

PowerShell scripts have options, with tab completion. You can hit the TAB key to cycle through the available options. If you type "help" and then the path to the script, you'll see some help information that explains how to use the script.

### Get-DialogContents.ps1
```powershell
get-dialogcontents.ps1 -path "c:\hotdocs\components.cmp" -dialog "Main Interview"
```
Will output something like:
```
 DOC Cover letter to clerk TF
 DOC Answers and counterclaims TF
 DOC Interrogatories TF
 DOC Requests for production of documents TF
 DOC Request for admissions TF
 DRQ Foreclosure document requests TF
 DOC Demand for jury trial TF
 ```
If you'd like to HIDE or SHOW all of the contents of the dialog, add the -before option and the text you want to add in front of the variable, surrounded by quotes:
```powershell
get-dialogsummary.ps1 -path "c:\hotdocs\components.cmp" -dialog "Main Interview" -before "HIDE"
```
Will output something like this:
```
HIDE DOC Cover letter to clerk TF
HIDE DOC Answers and counterclaims TF
HIDE DOC Interrogatories TF
HIDE DOC Requests for production of documents TF
HIDE DOC Request for admissions TF
HIDE DRQ Foreclosure document requests TF
HIDE DOC Demand for jury trial TF
HIDE DOC Motion to file answer and discovery TF
HIDE DOC Request for docs at trial TF
```

There's a symmetrical -after option that allows you to place text that will appear after the variable's name.

### Get-DialogSummary.ps1
```powershell
get-dialogsummary.ps1 -path "c:\hotdocs\components.cmp" -dialog "Main Interview"
```
Will output something like this:
```
"«.p ""a, b, and c""»"
IF DEF Failure to state a claim G TF RESULT + "Failure to state a claim«.p»" END IF
IF DEF Tenancy not properly terminated G TF RESULT + "Tenancy not properly terminated«.p»" END IF
IF DEF Lease G TF RESULT + "Tenancy not terminated by terms of Lease«.p»" END IF
IF DEF Action improperly commenced G TF RESULT + "Action improperly commenced«.p»" END IF
IF DEF No tenancy G TF RESULT + "No tenancy«.p»" END IF
IF DEF No standing G TF RESULT + "No standing«.p»" END IF
IF DEF Another action pending G TF RESULT + "Another action pending«.p»" END IF
IF DEF Creation of new tenancy G TF RESULT + "Creation of new tenancy by action or waiver«.p»" END IF
IF DEF Equitable estoppel and/or waiver G TF RESULT + "Equitable estoppel and/or waiver«.p»" END IF
IF DEF Failure to bring action by atty G TF RESULT + "Failure to bring action by atty (Varney claim)«.p»" END IF
IF DEF No assignment of rights G TF RESULT + "«DEF No assignment of rights CO»No assignment of rights«.p»" END IF
IF DEF No superior possessory G TF RESULT + "No superior possessory rights«.p»" END IF
RESULT + "«.pe»"
```
This uses HotDocs paragraph "dot codes" to create a nice list of all of the options that were marked YES from the list, separated by an Oxford comma. Check HotDocs documentation if you'd like to alter the formatting of the list.
