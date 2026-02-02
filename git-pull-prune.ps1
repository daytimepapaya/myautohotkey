$base_dir = "c:\dev_ags"

Get-ChildItem $base_dir -Directory |
ForEach-Object{
    if(-not (Test-Path (join-path -Path $_.FullName -ChildPath .git))){
        # .gitƒtƒHƒ‹ƒ_‚ª‘¶İ‚µ‚È‚¢ê‡‚Íˆ—‚µ‚È‚¢
        return;
    }
    Write-Host "================================================="
    Write-Host $_.FullName
    cd $_.FullName
    git pull --prune
    cd ..
}