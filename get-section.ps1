$csv = import-csv "C:\Users\QSteenhuis\Documents\gitlab\Eviction Defense System\Discovery Requests.csv"

function get-section ($category) {
    $open = "<hd:item name=`""
    $close = "`"/>"
    "<hd:item name=`"DISC Interrogatories DE`"/>"
    $csv | where "interrogatory group" -like "*$category*" | foreach {$x = $open + $_.interrogatories + $close; $x} ; 
    "<hd:item name=`"DISC Document requests DE`"/>"
    $csv | where "document group" -like "*$category*" | foreach {$x = $open + $_.'document requests' + $close; $x } 
    "<hd:item name=`"DISC Admissions DE`"/>"
    $csv | where "admissions group" -like "*$category*" | foreach {$x = $open + $_.'admissions' + $close; $x} ; 
}

function set-default ($category) {
    $open = "SET "
    $close = " TO TRUE"

    $csv | where "interrogatory group" -like "*$category*" | foreach {$x = $open + $_.interrogatories + $close; $x} ; 
    $csv | where "document group" -like "*$category*" | foreach {$x = $open + $_.'document requests' + $close; $x } 
    $csv | where "admissions group" -like "*$category*" | foreach {$x = $open + $_.'admissions' + $close; $x} ; 

}