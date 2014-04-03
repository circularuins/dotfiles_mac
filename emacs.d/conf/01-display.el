;;;;;;;;;;;;;;;;
;;; 基本設定 ;;;
;;;;;;;;;;;;;;;;

;; 起動画面の非表示
(setq inhibit-startup-message t)

;;; 警告音なし
(setq ring-bell-function 'ignore)

;;; キーワードのカラー表示を有効化
(global-font-lock-mode t)

;;; 選択範囲（リージョン）をハイライト
(transient-mark-mode 1)

;;; 対応する括弧をハイライト
(setq show-paren-delay 0)
(show-paren-mode 1)
(setq show-paren-style 'mixed)

;;; コードの階層に対応してカッコに色を付ける
; packageからインストール
(global-rainbow-delimiters-mode t)

;;; 1行ずつスクロール
(setq scroll-step 1)

;;; タブの代わりにスペースを使う
(setq-default tab-width 4 indent-tabs-mode nil)

;;; "yes or no"の代わりに"y or n"を使用
(fset 'yes-or-no-p 'y-or-n-p)

;;; evalした結果を全部表示
(setq eval-expression-print-length nil)

;;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)

;;; バッファ自動再読み込み
(global-auto-revert-mode 1)





;;;;;;;;;;;;;;;;;;;;
;;; フォント設定 ;;;
;;;;;;;;;;;;;;;;;;;;

;; asciiフォントをMenloに
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil
                      :family "Menlo"
                      :height 120))

;; Macのフォント設定
;; (when (eq system-type 'darwin)
;;   ; 日本語フォント
;;   (set-fontset-font
;;    nil 'japanese-jisx0208
;; ; 英語名の場合
;; ; (font-spec :family "Hiragino Mincho Pro"))
;;    (font-spec :family "ヒラギノ明朝 Pro"))

;;   ; 全／半角を1:2にする
;;   (setq face-font-rescale-alist
;;         '((".*Menlo.*" . 1.0)
;;           (".*Hiragino_Mincho_Pro.*" . 1.2)
;;           ("-cdac$" . 1.3))))





;;;;;;;;;;;;;;;;;;;;;;
;;; ウィンドウ関連 ;;;
;;;;;;;;;;;;;;;;;;;;;;

;;; #サイズと背景色(GUIのみ) ;;;

;; 起動時のウィンドウサイズ
(when window-system
  (setq initial-frame-alist
        (append (list
                 '(width . 180)
                 '(height . 58)
                 '(top . 0)
                 '(left . 0)
                 )
                initial-frame-alist))
  (setq default-frame-alist initial-frame-alist))

;; 背景色と透明度
(if window-system (progn
  (set-background-color "Black")
  (set-foreground-color "LightGray")
  (set-cursor-color "Gray")
  (set-frame-parameter nil 'alpha 85)
  ))

;;; #各種バー設定(GUIのみ) ;;;

(when window-system
  ; タイトルバーにファイル名を表示(GUIのみ)
  (setq frame-title-format (format "%%f - emacs@%s" (system-name))))
; ツールバーを非表示
(tool-bar-mode -1)
; スクロールバーを非表示
;(scroll-bar-mode -1)
; メニューバーを非表示
(cond
 (window-system (tool-bar-mode -1))
 (t             (menu-bar-mode -1)))

;;; #文字やツールバーの色 ;;;

;; color-themeの設定
; wget https://gnuemacscolorthemetest.googlecode.com/files/color-theme-6.6.0-mav.zip
; unzipしたフォルダごと、elisp/に置く
; GUIでは、自作テーマを仕様
(cond ((window-system)
       (setq custom-theme-directory "~/.emacs.d/themes/")
       (load-theme 'molokai t))
      (t
       (require 'color-theme)
       (color-theme-initialize)
       (color-theme-arjen)
;       (color-theme-euphoria)
;       (color-theme-clarity)
       ))

;;; 開いているウィンドウ一覧をポップアップ表示する
;;; C-n/C-pや英字キーで選択する

;; ; M-x install-elisp-from-emacswiki popup-select-window.el
;; (require 'popup-select-window)
;; ;; ウィンドウが3つ以上存在する際にポップアップ表示する
;; (setq popup-select-window-popup-windows 3)
;; ;; 選択中のウィンドウは、背景をオレンジにして目立たせる
;; (setq popup-select-window-window-highlight-face '(:foreground "white" :background "yellow"))

;;; 分割したウィンドウの大きさをインタラクティブに変更する
;; http://d.hatena.ne.jp/khiker/20100119/window_resize
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))






;;;;;;;;;;;;;;;;;;;;
;;; モードライン ;;;
;;;;;;;;;;;;;;;;;;;;

;; カーソル位置の列番号を表示
(column-number-mode t)

;; ファイルサイズ表示
(size-indication-mode t)

;; 年月日時刻の表示
;; 以下の書式に従ってモードラインに日付・時刻を表示する 
(setq display-time-string-forms 
'((format "%s/%s/%s(%s) %s:%s" 
year month day 
dayname 
24-hours minutes) 
load 
(if mail " Mail" ""))) 
(display-time) ; 時間を表示
(setq display-time-kawakami-form t) ; 時刻表示の左隣に日付を追加
(setq display-time-24hr-format t) ; 24 時間制

;; リージョン内の行数と文字数をモードラインに表示する(範囲指定時のみ)
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines, %d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ""))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))





;;;;;;;;;;;;;;;;
;;; 補完機能 ;;;
;;;;;;;;;;;;;;;;

;;; auto-complete-mode ;;;
; packageでインストール
;; (require 'auto-complete)
;; (global-auto-complete-mode 1)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(ac-config-default)
(setq ac-use-menu-map t) ;; C-n / C-p で選択
(setq ac-auto-show-menu 0.3) ;; 候補が出るまでの時間 default 0.8
;; ac-modeに各モードを追加する
(add-to-list 'ac-modes 'lisp-mode)
(add-to-list 'ac-modes 'slime-repl-mode)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'js2-mode)
(add-to-list 'ac-modes 'scheme-mode)
(add-to-list 'ac-modes 'inferior-scheme-mode)
(add-to-list 'ac-modes 'inferior-lisp-mode)
(add-to-list 'ac-modes 'clojure-mode)
;; ac-mode
;(autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ウィンドウのポップアップ ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; packageでインストール
;; 設定したバッファをポップアップ表示する
;; "C-g"または、他のウィンドウを選択すると閉じる
(if (require 'popwin nil t)
    (progn
      (setq display-buffer-function 'popwin:display-buffer)
      (setq popwin:popup-window-height 0.4)
      (setq anything-samewindow nil)
      (push '("*anything*" :height 14) popwin:special-display-config)
      (push '(dired-mode :position top) popwin:special-display-config)
      (push '("\\*[Vv][Cc]" :regexp t :position top) popwin:special-display-config)
      (push '("\\*git-" :regexp t :position top) popwin:special-display-config)
      (push '(" *auto-async-byte-compile*" :height 10 :position bottom :noselect t) popwin:special-display-config)
      (push '("*Compile-Log*" :height 10 :position bottom :noselect t) popwin:special-display-config)
      (push '("*VC-log*" :height 10 :position bottom) popwin:special-display-config)
      (push '("*anything kill-ring*" :height 14) popwin:special-display-config)
;      (push '("*ruby*" :height 14) popwin:special-display-config)
      ))





;;;;;;;;;;;;;;;;;;;;
;;; バッファ関連 ;;;
;;;;;;;;;;;;;;;;;;;;

;;; #整理 ;;;

;; ;;; 使わないバッファを自動的に消す
;; (require 'tempbuf)
;; (add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
;; (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)

;; *Completions*バッファを使用後に消す
; M-x install-elisp-from-emacswiki lcomp.el
(require 'lcomp)
(lcomp-mode 1)
(lcomp-keys-mode 1)

;;; #選択 ;;;

;; iswitchb(バッファ切り替え時のインクリメンタル補完)
(iswitchb-mode 1)
(add-hook 'iswitchb-define-mode-map-hook
          (lambda ()
            (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
            (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;; minibufでisearchを使えるようにする
(require 'minibuf-isearch nil t)

;;; #履歴 ;;;

;; 閉じたバッファもundo
(when (require 'undohist nil t)
  (undohist-initialize))

;; 前回終了時のバッファ状態を復元
; install-elisp http://www.gentei.org/~yuuji/software/euc/revive.el
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(define-key ctl-x-map "S" 'save-current-configuration)    ; C-x S で状態保存
(define-key ctl-x-map "F" 'resume)                        ; C-x F で復元
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に状態保存





;;;;;;;;;;;;;;
;;; その他 ;;;
;;;;;;;;;;;;;;

;; jaspace.el を使った全角空白、タブ、改行表示モード
;; 切り替えは M-x jaspace-mode-on or -off
; ネットからインストールすると文字コードが変なので、手動でコピった
; http://homepage3.nifty.com/satomii/software/jaspace.elayout.el
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
;(setq jaspace-alternate-eol-string "↓\n")
(setq jaspace-highlight-tabs t)  ; highlight tabs
;(setq jaspace-highlight-tabs ?&gt;) ; use ^ as a tab marker

;;; 画像ファイルをバッファ内で表示する
(when window-system
  (auto-image-file-mode t))

;; バッファ内での画像ファイルの表示 ;;;
; iimage-modeでホームディレクトリを展開
(setq iimage-mode-image-filename-regex
     (concat "[-~+./_0-9a-zA-Z]+\\."
             (regexp-opt (nconc (mapcar #'upcase
                                        image-file-name-extensions)
                                image-file-name-extensions))))
; C-lC-lを再描画に設定
(setq iimage-mode-map (make-sparse-keymap))
(define-key iimage-mode-map "\C-l" nil)
(define-key iimage-mode-map "\C-l\C-l" 'iimage-recenter)
; 5秒何もしなければ再描画
(run-with-idle-timer 5 5 (lambda () (and iimage-mode (iimage-recenter))))
; テキストモードでiimage-modeをon(GUIのみ)
(when window-system
  (add-hook 'text-mode-hook 'turn-on-iimage-mode))

;; e2wmモード（IDE風のウィンドウ分割）
;; (auto-install-from-url "http://github.com/kiwanami/emacs-window-layout/raw/master/window-layout.el")
;; (auto-install-from-url "http://github.com/kiwanami/emacs-window-manager/raw/master/e2wm.el")
;; 作者のページ：http://d.hatena.ne.jp/kiwanami/20100528/1275038929
;; "M-+"で開始、"C-c ; Q"で終了
(require 'e2wm)
(e2wm:add-keymap 
 e2wm:pst-minor-mode-keymap
 '(("<M-left>" . e2wm:dp-code ) ; codeへ変更
   ("<M-right>"  . e2wm:dp-two) ; twoへ変更
   ("<M-up>"    . e2wm:dp-doc)  ; docへ変更
   ("<M-down>"  . e2wm:dp-dashboard) ; dashboardへ変更
   ("C-."       . e2wm:pst-history-forward-command) ; 履歴進む
   ("C-,"       . e2wm:pst-history-back-command) ; 履歴戻る
   ("C-M-s"     . e2wm:my-toggle-sub) ; subの表示をトグルする
   ("prefix L"  . ielm) ; ielm を起動する（subで起動する）
   ("M-m"       . e2wm:pst-window-select-main-command) ; メインウインドウを選択する
   ) e2wm:prefix-key)
(e2wm:add-keymap 
 e2wm:dp-doc-minor-mode-map 
 '(("prefix I" . info)) ; infoを起動する
 e2wm:prefix-key)
(defun e2wm:my-toggle-sub () ; Subをトグルする関数
  (interactive)
  (e2wm:pst-window-toggle 'sub t 'main))
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))
