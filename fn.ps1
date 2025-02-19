function arrayAnd {
    [CmdletBinding()]
    param( 
        $array1,
        $array2
    )
    $out = @()
    if ($array1 -and $array2 -and ($array1 -is [array]) -and ($array2 -is [array])) {
        foreach ($val1 in $array1) {
            foreach ($val2 in $array2) {
                if ($val2 -eq $val1) {
                    $out += $val2
                }
            }
        }
    }
    $out
}