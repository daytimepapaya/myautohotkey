$base_dir = ""
$limit = (Get-Date).AddDays(-7)

Get-ChildItem -Path $base_dir -Recurse -File -Exclude *.xlsx | 
    Where-Object { $_.Length -gt 1mb } | 
    Where-Object { $_.CreationTime -lt $limit } |
    Remove-Item
