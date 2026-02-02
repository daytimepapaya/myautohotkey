#Requires AutoHotkey v2.0

; -------------------------
; SAVE WITH UTF-8 WITH BOM!
; -------------------------

; グローバル設定 ================================================================================
#Warn
SetWorkingDir A_ScriptDir ; 作業ディレクトリを現在のスクリプトが置かれているディレクトリへセット
SetNumLockState "AlwaysOn" ; always set numlock on.

; ホットストリング ================================================================================

; password
; '}'は'{}}'でエスケープ
:*:;p::Na{}}Ph9ae202210aaa

; ;dd 時刻
:*:;dd::
   {
      TimeString := FormatTime(, "yyyy/MM/dd HH:mm")
      SendInput TimeString
   }

; maven関係
:*:;mci::mvn clean -Dmaven.test.skip=true install
:*:;mcp::mvn clean -Dmaven.test.skip=true package -Plo
:*:;mcc::mvn clean compile -Dchanged.classes=jp/co/tico/preCompiled/C2132/C2132_Base.java,jp/co/tico/preCompiled/C3992/C3992_Base.java

:*:;kak::以下起票しました、確認お願いします。

:*:;rep::
(
＜タイトル＞
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

:*:;ryaku::・・・略・・・

; AGSのdocker用のコマンド
;
; DBの起動
:*:;dbu::docker compose up db -d

; 最新バックアップでDBリストア
:*:;dbr::docker exec db bash -c 'latest=$(ls -t /home/oracle/backup-restore-tools/bkup/*.tar.gz | head -1); echo $latest; sh /home/oracle/backup-restore-tools/oracledb_restore.sh KMSPDB $latest'

; オンラインの起動
:*:;dbu::docker compose up online-ap

; オンラインの電文送信
:*:;os::docker exec online-ap bash -c 'java -jar /opt/majalis/KyosaiOnlineAutoTester.jar /usr/local/ap/hh_backend_on/jsonl/'

; バッチの起動
:*:;dbu::docker compose up batch-ap

; バッチのジョブサブミット
:*:;bs::docker exec batch-ap bash -c 'sh sbodclt.sh submit --user=USER --password=PASSWD --batchEndPoints=http://localhost:8080/mapp-batch-kyosai --jobName=[ジョブ名] --jobParameter=timestamp=$(date {+}%Y%m%d%H%M%S) --wait'

; 改行形式変換PGM起動
; 右Ctrl + f
HotIfWinActive "ahk_class CabinetWClass"
>^f::
   {
      A_Clipboard := ""
      Send "^c"
      ClipWait 1
      setJavaEnvironmentalVariable()
      Try {
         Run "java -jar C:\Users\rui.kanamori\OneDrive - Accenture\EBCDICViewerV2.9\EBCDICViewer.jar" "%A_Clipboard%"
      }
      releaseEnvironmentalVariable()
      WinWaitActive "ahk_class SunAwtDialog"
      Send "@S"
   }
   HotIfWinActive

   ; sort(busybox)起動
   ; 出力ファイル名は [元のファイル名].sort
   ; 右Ctrl + s
   HotIfWinActive "ahk_class CabinetWClass"
>^s::
   {
      A_Clipboard := ""
      Send "^c"
      ClipWait 1
      outputfile := A_Clipboard ".sort"
      Run A_ComSpec ' /c ""busybox.exe" "sort" "%A_Clipboard%" "-o" "%outputfile%""',, "Hide"
   }
   HotIfWinActive

; Everythingで検索
; 右Ctrl + Alt + e
>^e::
   {
      clipboard := ""
      send "^c"
      clipwait 1
      Send "!{Esc}" ; chromeだとウィンドウを切り替えないとclipboardに反映されない
      Run "C:\Program Files\Everything\Everything.exe -nonewwindow -s %clipboard%"
   }

; IF用: 選択されたチケット番号からダウンロードリンクを生成、チケットのコメントに追記
; 右Ctrl + t
>^t::
   {
      A_Clipboard := ""
      send "^c"
      clipwait 1
      Send "!{Esc}" ; chromeだとウィンドウを切り替えないとclipboardに反映されない
      setJavaEnvironmentalVariable()
      Run 'java -jar "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\Redmine\redmine-api\target\redmine-api-1.0-SNAPSHOT.jar" %A_Clipboard%'
      releaseEnvironmentalVariable()
   }

; IF用: 選択されたチケット番号から解析用フォルダを用意する
; 右Ctrl + p
>^p::
   {
      A_Clipboard := ""
      send "^c"
      clipwait 1
      Send "!{Esc}" ; chromeだとウィンドウを切り替えないとclipboardに反映されない
      setJavaEnvironmentalVariable()
      Run 'java -cp "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\Redmine\redmine-api\target\redmine-api-1.0-SNAPSHOT.jar" "kanamori.Prepare" %A_Clipboard%'
      releaseEnvironmentalVariable()
   }

; みなし日取得 -> "*みなし時間.ttl"ファイルにセット
; （バッチの）エクセルテスト仕様書を選択しておくこと
; 右Ctrl + m
>^m::
   {
      A_Clipboard := ""
      send "^c"
      clipwait 1
      ; 他でファイルが開かれていないかチェック
      tempfile := FileOpen(A_Clipboard,"r-rwd")
      if !IsObject(tempfile)
      {
         MsgBox "Can't open %clipboard%"
         return
      } else {
         tempfile.Close()
      }
      setJavaEnvironmentalVariable()
      ; "%clipboard%"は空白を含むため、ダブルクォーテーションで囲むこと
      Run 'java -jar "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\Minashibi\minashibi\target\minashibi-1.0-SNAPSHOT.jar" "%A_Clipboard%"'
      releaseEnvironmentalVariable()
   }

   ; グローバル変数
   EnvBackupJAVAHOME := ""
   EnvBackupPATH := ""

   setJavaEnvironmentalVariable(){
      global EnvBackupJAVAHOME
      global EnvBackupPATH
      EnvBackupJAVAHOME := EnvGet("JAVA_HOME")
      EnvBackupPATH := EnvGet("PATH")
      EnvSet "JAVA_HOME" "C:\opt\openjdk-18.0.1.1_windows-x64_bin\jdk-18.0.1.1"
      EnvSet "PATH" "C:\opt\openjdk-18.0.1.1_windows-x64_bin\jdk-18.0.1.1\bin"
   }

   ; 変数はグローバルなので %EnvBackupJAVAHOME% は参照できる
   releaseEnvironmentalVariable(){
      global EnvBackupJAVAHOME
      global EnvBackupPATH
      EnvSet "JAVA_HOME" EnvBackupJAVAHOME
      EnvSet "PATH" EnvBackupPATH
   }

   ; untar log file.
   ; 右Ctrl + u
   HotIfWinActive "ahk_class CabinetWClass"
>^u::
   {
      A_Clipboard := ""
      send "^c"
      ClipWait 1
      searchKey := "tar.gz"
      If InStr(A_Clipboard, searchKey)
      {
         Run 'powershell.exe -File "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\ExtractLog\Extract-IFB.ps1" "%A_Clipboard%"'
         return
      }
      else
      {
         MsgBox "not tar.gz."
      }

   }
   HotIfWinActive

; open TresGrep
; 右Ctrl + g
>^g::
   {
      Run "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\TresGrep\TresGrep.exe"
   }

   ; grep "[err" with sakura editor.
   ; select the folder and then
   ; 右Ctrl + g
   HotIfWinActive "ahk_class CabinetWClass"
>^Numpad7::
   {
      A_Clipboard := ""
      send "^c"
      ClipWait 1
      Run 'sakura.exe -GREPMODE -GCODE=99 -GKEY="\[ERROR\]|WMJLSCBL0009|(?<!JMSProducer|WRAP_TAG_)Exception" -GFOLDER="%A_Clipboard%" -GOPT=SPR -GFILE="messages*.log;part.1.log"'
   }
   HotIfWinActive

   ; grep ""AbstractTran:\d+\] \[\w+\]" with sakura editor.
   ; select the folder and then
   ; 右Ctrl + numpad 9
   HotIfWinActive "ahk_class CabinetWClass"
>^Numpad9::
   {
      A_Clipboard := ""
      send "^c"
      ClipWait 1
      Run 'sakura.exe -GREPMODE -GCODE=99 -GKEY="AbstractTran:\d+\] \[\w+\]" -GFILE="messages*.log" -GFOLDER="%A_Clipboard%" -GOPT=SPR'
   }
   HotIfWinActive

   ; grep "Job Batch Status" with sakura editor.
   ; select the folder and then
   ; 右Ctrl + numpad 4
   HotIfWinActive "ahk_class CabinetWClass"
>^Numpad4::
   {
      A_Clipboard := ""
      send "^c"
      ClipWait 1
      Run 'sakura.exe -GREPMODE -GCODE=99 -GKEY="Job Batch Status" -GFILE="*part.1.log" -GFOLDER="%A_Clipboard%" -GOPT=SPR'
   }
   HotIfWinActive

   ; grep "cond" with sakura editor.
   ; select the folder and then
   ; 右Ctrl + numpad 5
   HotIfWinActive "ahk_class CabinetWClass"
>^Numpad5::
   {
      A_Clipboard := ""
      send "^c"
      ClipWait 1
      Run 'sakura.exe -GREPMODE -GCODE=99 -GKEY="cond" -GFILE="JOBLOG*" -GFOLDER="%A_Clipboard%" -GOPT=SPR'
   }
   HotIfWinActive

   ; grep "\[\S+\](?= MSG_I_JAX010700034)" with sakura editor.
   ; オンラインのどのearでプログラムが実行されているか調べるため
   ; select the folder and then
   ; 右Ctrl + numpad 6
   HotIfWinActive "ahk_class CabinetWClass"
>^Numpad6::
   {
      A_Clipboard := ""
      send "^c"
      ClipWait 1
      Run 'sakura.exe -GREPMODE -GCODE=99 -GKEY="\[\S+\](?= MSG_I_JAX010700034)" -GFILE="messages*.log" -GFOLDER="%A_Clipboard%" -GOPT=SR3H'
   }
   HotIfWinActive

; F1
; ファイル名に"*.taihi"付与をトグルon/off
f1::
   {
      hwnd := WinExist("A")
      Loop Parse Explorer_GetSelection(hwnd) , "`n"
      {
         SplitPath A_LoopField, &oldName, &folder
         Newfilename := ""
         if(checkTaihi(oldName)){
            NewName := rename_untaihi(oldName)
         } else {
            NewName := rename_taihi(oldName)
         }
         oldPath := folder "\" oldName
         newPath := folder "\" newName
         FileMove oldPath, newPath
      }
      Send "{F5}"
   }

; git pull all
; 右Ctrl + numpasd 3
>^Numpad3::
   {
      Run 'powershell.exe -File "C:\Users\rui.kanamori\Accenture\JFE-SI Migration(倉敷) - IF-B\kanamori\tools\etc\ags-pull-prune.ps1"'
   }

   ; copy (JCL|COBOL) with renamed
   ; 右Ctrl + v
   HotIfWinActive "ahk_class CabinetWClass"
>^v::
   {
      newpath:= renameExtension(A_Clipboard)
      FileCopy %A_Clipboard%, %newpath%
   }
   HotIfWinActive

   ; 関数 =============================================================================

   checkJCLorCOBOL(path){
      IF((InStr(path, "JCL") < 1) and (InStr(path, "COBOL") < 1) and (InStr(path, "COPY") < 1)){
         Exit
      }
   }

   renameExtension(path){
      SplitPath path, &filename

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
         for window in ComObject("Shell.Application").Windows
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

   ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=60403&start=20#p596121
   ; modified to work with MouseIsOver
   Explorer_GetSelection(hWnd := 0) {
      static IID_IShellBrowser := '{000214E2-0000-0000-C000-000000000046}'
         , SID_SShellBrowser := IID_IShellBrowser, VT_UI4 := 0x13, SWC_DESKTOP := 0x8
      MouseGetPos ,, &Win
    (!hWnd && hWnd := WinExist(Win))
    winClass := WinGetClass(hWnd)
    if !(winClass ~= '^(Progman|WorkerW|CabinetWClass)$') {
        return
    }
    shellFolderView := ''
    shellWindows := ComObject('Shell.Application').Windows
    if (winClass ~= 'Progman|WorkerW') {
        shellFolderView := shellWindows.Item(ComValue(VT_UI4, SWC_DESKTOP)).Document
    } else {
        Loop shellWindows.Count() {
            try window := shellWindows.Item(A_Index - 1)
            catch {
                continue
            }
            if hWnd != window.HWND {
                continue
            }
            IShellBrowser := ComObjQuery(window, SID_SShellBrowser, IID_IShellBrowser)
            ComCall(GetWindow := 3, IShellBrowser, 'PtrP', &hTab := 0)
            if hTab != ControlGetHwnd('ShellTabWindowClass1', hWnd) {
                continue
            }
            shellFolderView := window.Document
        } until shellFolderView
    }
    selected := ''
    for item in shellFolderView.SelectedItems {
        selected .= (selected = '' ? '' : '`n') . item.Path
    }
    return selected
}
