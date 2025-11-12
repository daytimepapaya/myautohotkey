#Requires AutoHotkey v1.1.33+

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

SetNumLockState, AlwaysOn ; always set numlock on.

; make sure to save with UTF-8 with BOM

; authokey version is 1.1.34.04
; msgbox % "my ahk version: " A_AhkVersion

; ;dd to insert date and time
; デフォルト遅延(10ms)だと、速すぎる。200msを設定(効いてない、そのうち調べる)。
:*:;dd::
   SetKeyDelay, 200
   FormatTime,TimeString,,yyyy/MM/dd HH:mm
   SendInput,%TimeString%
Return

:*:;mci::mvn clean -Dmaven.test.skip=true install
Return

:*:;mcp::mvn clean -Dmaven.test.skip=true package -Plo
Return

:*:;mcc::mvn clean compile -Dchanged.classes=jp/co/tico/preCompiled/C2132/C2132_Base.java,jp/co/tico/preCompiled/C3992/C3992_Base.java
Return

:*:;kak::以下起票しました、確認お願いします。
Return

:*:;rep::
(＜タイトル＞
【バッチ障害共有】 分析証跡作成で作成したEXCELのタイトル

＜宛先＞
原因障害対応チーム + CC @バッチ障害分析

＜障害内容＞
障害のログともに発生事象を記載する

＜障害原因＞
障害分析の結果を記載

＜JIRA障害チケット＞
１で作成した障害チケットのリンクを添付
)
Return
; password
; '}'は'{}}'でエスケープ
:*:;p::Na{}}Ph9ae202210aaa
Return

:*:;ryaku::・・・略・・・
Return

; AGSのdocker用のコマンド
;
; DBの起動
:*:;dbu::docker compose db up -d
Return

; 最新バックアップでDBリストア
:*:;dbr::docker exec db bash -c 'latest=$(ls -t /home/oracle/backup-restore-tools/bkup/*.tar.gz | head -1); echo $latest; sh /home/oracle/backup-restore-tools/oracledb_restore.sh ORCLPDB1 $latest'
Return

; オンラインの電文送信
:*:;os::docker exec online-ap bash -c 'java -jar /opt/majalis/KyosaiOnlineAutoTester.jar /usr/local/ap/hh_backend_on/jsonl/'
Return

; バッチのジョブサブミット
:*:;bs::docker exec batch-ap bash -c 'sh sbodclt.sh submit --user=USER --password=PASSWD --batchEndPoints=http://localhost:8082/mapp-batch-kyosai --jobName=[ジョブ名] --jobParameter=timestamp=`date +%Y%m%d%H%M%S` --wait'
Return


; tico テスト実行ツールログイン
; ユーザー名、パスワード同じ
:*:;t::testuser16
Return


; run fold program with selected file
; RightControl + f
#IfWinActive ahk_class CabinetWClass
   >^f::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      setJavaEnvironmentalVariable()
      Run, java -jar "C:\Users\rui.kanamori\OneDrive - Accenture\EBCDICViewerV2.9\EBCDICViewer.jar" "%clipboard%"
      releaseEnvironmentalVariable()
      WinWaitActive ahk_class SunAwtDialog
      If ErrorLevel <> 0
      {
         MsgBox, WinWait timed out.
         Return
      }
      Else
         Send @S
   Return
#IfWinActive

; sort selected file.
; outputfile name is [original file name].sort
; RightControl + s
#IfWinActive ahk_class CabinetWClass
   >^s::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      outputfile := clipboard ".sort"
      Run %ComSpec% /c ""busybox.exe" "sort" "%clipboard%" -o "%outputfile%"", ,Hide
   Return
#IfWinActive

; search selected text with Everything
; right Control + Alt + e
>^e::
   clipboard := ""
   send ^c
   clipwait, 1
   Send, !{Esc} ; chromeだとウィンドウを切り替えないとclipboardに反映されない
   Run, "C:\Program Files\Everything\Everything.exe" -nonewwindow -s "%clipboard%"
Return

; IF用: 選択されたチケット番号からダウンロードリンクを生成、チケットのコメントに追記
; right Control + t
>^t::
   clipboard := ""
   send ^c
   clipwait, 1
   Send, !{Esc} ; chromeだとウィンドウを切り替えないとclipboardに反映されない
   setJavaEnvironmentalVariable()
   Run, java -jar "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\Redmine\redmine-api\target\redmine-api-1.0-SNAPSHOT.jar" %clipboard%
   releaseEnvironmentalVariable()
Return

; IF用: 選択されたチケット番号から解析用フォルダを用意する
; right Control + p
>^p::
   clipboard := ""
   send ^c
   clipwait, 1
   Send, !{Esc} ; chromeだとウィンドウを切り替えないとclipboardに反映されない
   setJavaEnvironmentalVariable()
   Run, java -cp "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\Redmine\redmine-api\target\redmine-api-1.0-SNAPSHOT.jar" "kanamori.Prepare" %clipboard%
   releaseEnvironmentalVariable()
Return

; みなし日取得 -> "*みなし時間.ttl"ファイルにセット
; （バッチの）エクセルテスト仕様書を選択しておくこと
; right Control + m
>^m::
   clipboard := ""
   send ^c
   clipwait, 1
   ; 他でファイルが開かれていないかチェック
   file := FileOpen(clipboard,"r-rwd")
   if !IsObject(file)
   {
      MsgBox Can't open "%clipboard%" .
      return
   } else {
      file.Close()
   }
   setJavaEnvironmentalVariable()
   ; "%clipboard%"は空白を含むため、ダブルクォーテーションで囲むこと
   Run, java -jar "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\Minashibi\minashibi\target\minashibi-1.0-SNAPSHOT.jar" "%clipboard%"
   releaseEnvironmentalVariable()
Return

; グローバル変数
EnvBackupJAVAHOME := ""
EnvBackupPATH := ""

setJavaEnvironmentalVariable(){
   global EnvBackupJAVAHOME
   global EnvBackupPATH
   EnvGet, EnvBackupJAVAHOME, JAVA_HOME
   EnvGet, EnvBackupPATH, PATH
   EnvSet, JAVA_HOME, C:\opt\openjdk-18.0.1.1_windows-x64_bin\jdk-18.0.1.1
   EnvSet, PATH, C:\opt\openjdk-18.0.1.1_windows-x64_bin\jdk-18.0.1.1\bin
}

; 変数はグローバルなので %EnvBackupJAVAHOME% は参照できる
releaseEnvironmentalVariable(){
   global EnvBackupJAVAHOME
   global EnvBackupPATH
   EnvSet, JAVA_HOME, %EnvBackupJAVAHOME%
   EnvSet, PATH, %EnvBackupPATH%
}

; untar log file.
; RightControl + u
#IfWinActive ahk_class CabinetWClass
   >^u::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      searchKey=tar.gz
      IfInString, clipboard, %searchKey%
      {
         Run, powershell.exe -File "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\ExtractLog\Extract-IFB.ps1" "%clipboard%"
         return
      }
      else
      {
         MsgBox, not tar.gz.
      }

   Return
#IfWinActive

; open TresGrep
; RightControl + g
>^g::
   Run, "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\TresGrep\TresGrep.exe"
Return

; grep "[err" with sakura editor.
; select the folder and then
; RightControl + g
#IfWinActive ahk_class CabinetWClass
   >^Numpad7::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      Run, sakura.exe -GREPMODE -GCODE=99 -GKEY="\[ERROR\]|WMJLSCBL0009|(?<!JMSProducer|WRAP_TAG_)Exception" -GFOLDER="%clipboard%" -GOPT=SPR -GFILE="messages*.log;part.1.log"
   Return
#IfWinActive

; grep ""AbstractTran:\d+\] \[\w+\]" with sakura editor.
; select the folder and then
; RightControl + numpad 9
#IfWinActive ahk_class CabinetWClass
   >^Numpad9::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      Run, sakura.exe -GREPMODE -GCODE=99 -GKEY="AbstractTran:\d+\] \[\w+\]" -GFILE="messages*.log" -GFOLDER="%clipboard%" -GOPT=SPR
   Return
#IfWinActive

; grep "Job Batch Status" with sakura editor.
; select the folder and then
; RightControl + numpad 4
#IfWinActive ahk_class CabinetWClass
   >^Numpad4::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      Run, sakura.exe -GREPMODE -GCODE=99 -GKEY="Job Batch Status" -GFILE="*part.1.log" -GFOLDER="%clipboard%" -GOPT=SPR
   Return
#IfWinActive

; grep "cond" with sakura editor.
; select the folder and then
; RightControl + numpad 5
#IfWinActive ahk_class CabinetWClass
   >^Numpad5::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      Run, sakura.exe -GREPMODE -GCODE=99 -GKEY="cond" -GFILE="JOBLOG*" -GFOLDER="%clipboard%" -GOPT=SPR
   Return
#IfWinActive

; grep "\[\S+\](?= MSG_I_JAX010700034)" with sakura editor.
; オンラインのどのearでプログラムが実行されているか調べるため
; select the folder and then
; RightControl + numpad 6
#IfWinActive ahk_class CabinetWClass
   >^Numpad6::
      clipboard := ""
      Send, ^c
      ClipWait, 1
      Run, sakura.exe -GREPMODE -GCODE=99 -GKEY="\[\S+\](?= MSG_I_JAX010700034)" -GFILE="messages*.log" -GFOLDER="%clipboard%" -GOPT=SR3H
   Return
#IfWinActive


; F1
; ファイル名に"*.taihi"付与をトグルon/off
f1::
   Loop, Parse, % Explorer_GetSelection() , `n
   {
      SplitPath, % A_LoopField, filename, filepath
      Newfilename := ""
      if(checkTaihi(filename)){
         Newfilename := rename_untaihi(filename)
      } else {
         Newfilename := rename_taihi(filename)
      }
      FileMove, % filePath "\" filename, % filePath "\" Newfilename
   }
   Send {F5}
return


; git pull all
; RightControl + numpasd 3
>^Numpad3::
   Run, powershell.exe -File "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\etc\ags-pull-prune.ps1"
Return

; copy (JCL|COBOL) with renamed
; RightControl + v
#IfWinActive ahk_class CabinetWClass
   >^v::
      newpath:= renameExtension(clipboard)
      FileCopy, %clipboard%, %newpath%
   Return
#IfWinActive

checkJCLorCOBOL(path){
   IF((InStr(path, "JCL") < 1) and (InStr(path, "COBOL") < 1) and (InStr(path, "COPY") < 1)){
      Exit
   }
}

renameExtension(path){
   SplitPath, path, filename

   IF(InStr(path, "JCL")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".JCL")
      addtype := RegExReplace(replacefileextention, "^", "[JCL]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }
   IF(InStr(path, "COPY")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".CPY")
      addtype := RegExReplace(replacefileextention, "^", "[COPY]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }
   IF(InStr(path, "COBOL")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".COB")
      addtype := RegExReplace(replacefileextention, "^", "[COBOL]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }
   IF(InStr(path, "EASY")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".easyc")
      addtype := RegExReplace(replacefileextention, "^", "[EASY]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }
   IF(InStr(path, "PED")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".ped")
      addtype := RegExReplace(replacefileextention, "^", "[PED]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }
   IF(InStr(path, "DBスキーマ定義")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".adl")
      addtype := RegExReplace(replacefileextention, "^", "[DBスキーマ定義]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }
   IF(InStr(path, "DBサブスキーマ定義")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".adl")
      addtype := RegExReplace(replacefileextention, "^", "[DBサブスキーマ定義]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }
   IF(InStr(path, "DAMスキーマ定義")){
      nopercent := removePercent(filename)
      replacefileextention := StrReplace(nopercent, ".txt", ".adl")
      addtype := RegExReplace(replacefileextention, "^", "[DAMスキーマ定義]")
      dir:= GetActiveExplorerPath()
      newpath := dir "\" addtype
      return newpath
   }

}

removePercent(filename){
   return RegExReplace(filename, ".*%")
}

; return currently opened folder
GetActiveExplorerPath()
{
   explorerHwnd := WinActive("ahk_class CabinetWClass")
   if (explorerHwnd)
   {
      for window in ComObjCreate("Shell.Application").Windows
      {
         if (window.hwnd==explorerHwnd)
         {
            return window.Document.Folder.Self.Path
         }
      }
   }
}

checkTaihi(path){
   return SubStr(path, -5) == ".taihi"
}

rename_taihi(path){
   return path . ".taihi"
}

rename_untaihi(path){
   return RegExReplace(path, "\.taihi$")
}

Explorer_GetSelection() { ; by teadrinker
   WinGetClass, winClass, % "ahk_id" . hWnd := WinExist("A")
   if !(winClass ~="Progman|WorkerW|(Cabinet|Explore)WClass")
      Return
   shellWindows := ComObjCreate("Shell.Application").Windows
   if (winClass ~= "Progman|WorkerW")
      shellFolderView := shellWindows.FindWindowSW(0, 0, SWC_DESKTOP := 8, 0, SWFO_NEEDDISPATCH := 1).Document
   else {
      for window in shellWindows
         if (hWnd = window.HWND) && (shellFolderView := window.Document)
            break
   }
   for item in shellFolderView.SelectedItems
      result .= (result = "" ? "" : "`n") . item.Path
   if !result
      result := shellFolderView.Folder.Self.Path
   Return result
}
