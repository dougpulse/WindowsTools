param (
	#[Parameter(Mandatory=$true)][string]$filename
	[string]$filename
)

$server = $env:computername
$database = "MyStuff"

if ($filename.SubString($filename.length - 4, 4) -eq ".csv") {
  Import-DbaCsv -Path $filename -SqlInstance $server -Database $database -AutoCreateTable
	write-output "If there were no errors, $filename is now in your database."
}
else {
	write-output "$filename is NOT a CSV file."
}
