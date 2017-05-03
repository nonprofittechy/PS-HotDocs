<#
.SYNOPSIS
    Generate a script to create a summary of a dialog's components for HotDocs, v. 11 or higher. 
    The summary will display the TITLE of each component in a list form, suitable for use in a component to be displayed with a dialog element.
.PARAMETER path
The Path to an XML Component file for HotDocs v. 11 or greater.
.PARAMETER dialog
The name of a dialog stored in the component file.
.EXAMPLE
get-dialogsummary.ps1 -path "c:\hotdocs\components.cmp" -dialog "Main Interview"
.NOTES
	Author: Quinten Steenhuis, 5/3/2017
#>
param([string]$path = "",
    [string]$dialog)

[xml]$xml = get-content $path


function get-dialogcontents($xml=$xml, $dialog=$dialog) {
    $xml.componentlibrary.components.dialog | where {$_.name -like $dialog} | foreach {$_.contents.item}
}

function get-component($xml=$xml, $component=$component, $type="truefalse") {
    $xml.componentlibrary.components.trueFalse | where {$_.name -like $component}
}

function get-dialogsummary($xml=$xml, $dialog=$dialog) {
    $items = get-dialogcontents -xml $xml -dialog $dialog
    write-host "«.p `"`"a, b, and c`"`"»`""
    foreach($item in $items) {
        $component = get-component -xml $xml -component $item.name 
        write-host "IF "($component.name)" RESULT + `""($component.title)"«.p»`" END IF"
    }
    write-host "RESULT + `"«.pe».`""
}

get-dialogsummary -xml $xml -dialog $dialog