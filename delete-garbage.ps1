$day_limit = (Get-Date).AddDays(-3) # 直近3日
$size_limit = "1mb" # サイズ。指定より大きいファイルを削除
$exclude_files = "*.xlsx,*.bat,*.txt" # 削除対象除外ファイル

function delete_garbage($dir) {
    Get-ChildItem -Path $dir -Recurse -File -Exclude $exclude_files | 
    Where-Object { $_.Length -gt $size_limit } | 
    Where-Object { $_.CreationTime -lt $day_limit } |
    Remove-Item
}

$dirs = @(
    "C:\dir1", 
    "C:\dir2"
)

# main
foreach ($d in $dirs) {
    delete_garbage($d)
}
