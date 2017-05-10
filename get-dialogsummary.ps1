<#
.SYNOPSIS
    Generate a HotDocs script to create a summary of a dialog's components for HotDocs, v. 11 or higher. It filters for true/false variables.
    The summary will display the TITLE of each component in a list form, suitable for use in a component to be displayed with a dialog element. If TITLE is empty, it falls back
	to displaying the PROMPT.
.PARAMETER path
The Path to an XML Component file for HotDocs v. 11 or greater.
.PARAMETER dialog
The name of a dialog stored in the component file.
.EXAMPLE
get-dialogsummary.ps1 -path "c:\hotdocs\components.cmp" -dialog "Main Interview"
.NOTES
	Author: Quinten Steenhuis, 5/3/2017
#>
param( [Parameter(Mandatory = $True,valueFromPipeline=$true,HelpMessage="Path to HotDocs Component File")][string]$path,
     [Parameter(Mandatory = $True,valueFromPipeline=$true,HelpMessage="Name of dialog containing true/false variables")][string]$dialog)

if ($path) {
    [xml]$xml = get-content $path
}

function get-dialogcontents($xml=$xml, $dialog=$dialog) {
    $xml.componentlibrary.components.dialog | where {$_.name -like $dialog} | foreach {$_.contents.item}
}

function get-component($xml=$xml, $component=$component, $type="truefalse") {
    $xml.componentlibrary.components.trueFalse | where {$_.name -like $component}
}

function get-dialogsummary($xml=$xml, $dialog=$dialog) {
    $items = get-dialogcontents -xml $xml -dialog $dialog
    write-host "`"«.p `"`"a, b, and c`"`"»`""
    foreach($item in $items) {
        $component = get-component -xml $xml -component $item.name
         #description = (if ($component.title -like "") {($component.title)} else {($component.prompt)})
        if ($component) {
            if ($component.title) {$description = ($component.title).trim()} else {$description = ($component.prompt).trim()}
            
            $concat = "IF " + $component.name + " RESULT + `"" + $description + "«.p»`" END IF"
            write-host $concat
            # write-host "IF"($component.name)" RESULT + `""($description)"«.p»`" END IF"
        }
    }
    write-host "RESULT + `"«.pe»`""
}
if ($xml) {
	get-dialogsummary -xml $xml -dialog $dialog
}