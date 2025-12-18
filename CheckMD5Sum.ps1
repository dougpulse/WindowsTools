param([string]$file)

# $file = "C:\Users\pulsed\Downloads\mysql-connector-odbc-9.2.0-winx64.msi"
# $hash = "4f6cc481d3df4d8fbf50e8000466530a"
$hash = Get-Clipboard -Raw
((Get-FileHash -Path $file -Algorithm MD5).Hash) -eq $hash
