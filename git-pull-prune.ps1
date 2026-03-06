# 指定ディレクトリ以下のgitレポジトリを一括でgit pull

function gitpull($dir) {
    Get-ChildItem $dir -Directory |
    ForEach-Object {
        if (-not (Test-Path (join-path -Path $_.FullName -ChildPath .git))) {
            # .gitフォルダが存在しない場合は処理しない
            return;
        }
        Write-Host "================================================="
        Write-Host $_.FullName
        cd $_.FullName
        git pull --prune
        cd ..
    }
}

# gitレポジトリの親ディレクトリを指定
$dirs = @(
    "c:\repos1", 
    "c:\repos2"
)

# main
foreach ($d in $dirs) {
    gitpull($d)
}
