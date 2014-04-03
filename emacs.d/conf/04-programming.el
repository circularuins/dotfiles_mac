;;;;;;;;;;;;
;;; 全般 ;;;
;;;;;;;;;;;;

;; yasnippetの設定
(require 'yasnippet)
(yas-global-mode 1)

;; 実行権限の自動付与
;; ファイルが #! から始まる場合、+X を付けて保存する
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;; ヘルプを綺麗に表示する
; packageでインストール
(require 'pos-tip)
(defun my-describe-function (function)
   "Display the full documentation of FUNCTION (a symbol) in tooltip."
   (interactive (list (function-called-at-point)))
   (if (null function)
       (pos-tip-show
        "** You didn't specify a function! **" '("red"))
     (pos-tip-show
      (with-temp-buffer
        (let ((standard-output (current-buffer))
              (help-xref-following t))
          (prin1 function)
          (princ " is ")
          (describe-function-1 function)
          (buffer-string)))
      nil nil nil 0)))
 (define-key emacs-lisp-mode-map (kbd "C-;") 'my-describe-function)

;;; マニュアルビューアの設定 ;;;

;; womanキャッシュを作成
;; C-u M-x woman RET で更新
(setq woman-cache-filename "~/.emacs.d/.wmncache.el")

;; womanにmanパスを設定
(setq woman-manpath '("/usr/share/man"
                      "/usr/local/share/man"
;                      "/usr/local/share/man/ja"))
                      "/usr/local/share/man/jp"))

;; ;; anything-for-document用のソースを定義
;; ;; M-x anything-for-documentでドキュメントを串刺し検索
;; (require 'anything)
;; (setq anything-for-document-sources
;;       (list anything-c-source-man-pages
;;             anything-c-source-info-cl
;;             anything-c-source-info-pages
;;             anything-c-source-info-elisp
;; ;            anything-c-source-info-emacs
;; ;            anything-c-source-emacs-commands
;;             anything-c-source-emacs-functions
;;             anything-c-source-emacs-variables))

;; ;; anything-for-documentコマンドを作成
;; (defun anything-for-document ()
;;   "Preconfigured `anything' for anything-for-document."
;;   (interactive)
;;   (anything anything-for-document-sources
;;  ;           (thing-at-point 'symbol) nil nil nil
;;             nil nil nil nil
;;             "*anything for document*"))

;;; ソースコード上でのプログラムの実行

;; quickrunの設定
; packageでインストール
(require 'quickrun)
;; popwinに追加
(push '("*quickrun*" :position right) popwin:special-display-config)
;; 実行結果がうまく表示されない対処療法
(defadvice quickrun/apply-outputter (after quickrun/fix-scroll-buffer activate)
  (recenter))
;; region選択されていたらquickrun-region、されていなかったらquickrunを実行
(defun quickrun-sc (start end)
  (interactive "r")
  (if mark-active
      (quickrun :start start :end end)
    (quickrun)))





;;;;;;;;;;;;;;;
;;; flymake ;;;
;;;;;;;;;;;;;;;

;; flymakeのハイライトをunderlineに変更
;; ハイライトだとCUIで文字が見えないので、、
(unless window-system
  (custom-set-faces
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))))

;; flycheck(flymakeの簡易版)
;; Ruby
(add-hook 'ruby-mode-hook 'flycheck-mode)





;;;;;;;;;;;;
;;; Perl ;;;
;;;;;;;;;;;;

;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.psgi$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t\\'"  . cperl-mode))
(eval-after-load "cperl-mode"
  '(progn
     (cperl-set-style "PerlStyle")
     (define-key cperl-mode-map (kbd "C-m") 'newline-and-indent)
     (define-key cperl-mode-map (kbd "(") nil)
     (define-key cperl-mode-map (kbd "{") nil)
     (define-key cperl-mode-map (kbd "[") nil)
     (define-key cperl-mode-map (kbd "M-n") 'flymake-goto-next-error)
     (define-key cperl-mode-map (kbd "M-p") 'flymake-goto-prev-error)))
(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset     -4))

;; perl-completion
;; (auto-install-from-emacswiki "perl-completion.el")
(autoload 'perl-completion-mode "perl-completion" nil t)
(eval-after-load "perl-completion"
  '(progn
     (defadvice flymake-start-syntax-check-process (around flymake-start-syntax-check-lib-path activate) (plcmp-with-set-perl5-lib ad-do-it))
     (define-key plcmp-mode-map (kbd "M-TAB") nil)
     (define-key plcmp-mode-map (kbd "M-C-o") 'plcmp-cmd-smart-complete)))

;; hook
(defun my-cperl-mode-hook ()
  (perl-completion-mode t)
  (flymake-mode t)
  (when (boundp 'auto-complete-mode)
    (defvar ac-source-my-perl-completion
      '((candidates . plcmp-ac-make-cands)))
    (add-to-list 'ac-sources 'ac-source-my-perl-completion)))
(add-hook 'cperl-mode-hook 'my-cperl-mode-hook)
 
;; perl tidy
;; sudo aptitude install perltidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))





;;;;;;;;;;;;
;;; Ruby ;;;
;;;;;;;;;;;;

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

;; ruby-insert-endがないよっっていうエラーへの対応
(defun ruby-insert-end ()
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

;; 括弧の自動挿入
(require 'ruby-electric nil t)
;; endに対応する行のハイライト
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))
;; ruby-mode-hook用の関数
(defun ruby-mode-hooks ()
  (ruby-electric-mode t)
  (ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)

;; インタラクティブRubyを利用する
;; (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
;; (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)





;;;;;;;;;;;;;;;;;;
;;; javascript ;;;
;;;;;;;;;;;;;;;;;;

;; js2-mode
; packageでインストールしたいのだが、emacs24以上が必要…
; なので
; git clone git://github.com/mooz/js2-mode.git
; cd js2-mode
; git checkout emacs23
; emacs --batch -f batch-byte-compile js2-mode.el
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-hook 'js2-mode-hook
;;           '(lambda ()
;;              (setq js2-basic-offs_et 4)))
;; ;js2-modeが持つインデントの不具合を解決する
;; (add-hook 'js2-mode-hook 'js-indent-hook)





;;;;;;;;;;;;;;;;;;
;;; emacs-lisp ;;;
;;;;;;;;;;;;;;;;;;

;; emacs-lisp-modeのフック
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
    (setq eldoc-idle-delay 0.2)
    (setq eldoc-echo-area-use-multiline-p t)
    (turn-on-eldoc-mode)))
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;;; 式の評価結果を注釈するための設定
; packageでインストール
(require 'lispxmp)
;; emacs-lisp-modeでC-c C-dを押すと注釈される
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)
(add-to-list 'ac-modes 'emacs-lisp-mode)

;;; 括弧の対応を保持して編集する設定
; http://www.daregada.sakuraweb.com/paredit_tutorial_ja.html (日本語チュートリアル)
; packageでインストール
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(add-hook 'inferior-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'inferior-scheme-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'nrepl-mode-hook 'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook 'enable-paredit-mode)
(add-hook 'js2-mode-hook 'enable-paredit-mode)
; カーソルの要素だけを残すのは"M-r"
; カーソル直後のS式の選択は"C-M-SPC"

;;; eldocの設定
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(add-hook 'scheme-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")





;;;;;;;;;;;;;
;;; slime ;;;
;;;;;;;;;;;;;

;;; slime(lisp-mode)の設定

(setq inferior-lisp-program "clisp")    ; clisp用
;;(setq inferior-lisp-program "sbcl")     ; sbcl用

; packageでインストール
; slime-fancy等のエラーが出たので、package内の全ての.elcを消した
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))
(setq slime-net-coding-system 'utf-8-unix)

;;lispの補完(auto-completeの拡張版)
; packageでインストール
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; HyperSpecを読み込む.
; wget ftp://ftp.lispworks.com/pub/software_tools/reference/HyperSpec-7-0.tar.gz
; ~/.emacs.d/doc/hyperspec/に解凍したフォルダとファイルを設置
; http://d.hatena.ne.jp/khiker/20061231/1167567844
(setq common-lisp-hyperspec-root
      (concat "file://" (expand-file-name "~/.emacs.d/doc/hyperspec/HyperSpec/"))
      common-lisp-hyperspec-symbol-table
      (expand-file-name "~/.emacs.d/doc/hyperspec/HyperSpec/Data/Map_Sym.txt"))
;; カーソル付近にある単語の情報を表示
(slime-autodoc-mode)

;; slime時のポップアップを追加
;; Apropos
(push '("*slime-apropos*") popwin:special-display-config)
;; Macroexpand
(push '("*slime-macroexpansion*") popwin:special-display-config)
;; Help
(push '("*slime-description*") popwin:special-display-config)
;; Compilation
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
;; Cross-reference
(push '("*slime-xref*") popwin:special-display-config)
;; Debugger
(push '(sldb-mode :stick t) popwin:special-display-config)
;; REPL
(push '(slime-repl-mode) popwin:special-display-config)
;; Connections
(push '(slime-connection-list-mode) popwin:special-display-config)




;;;;;;;;;;;;;;;;;;;;;;
;;; scheme(gauche) ;;;
;;;;;;;;;;;;;;;;;;;;;;

;; C-c C-lでバッファを評価
;; 行末C-c C-e でS式を評価
;; M-x run-scheme REPLを起動
(setq quack-default-program "gosh")
(require 'quack)
(require 'scheme-complete)
;;(autoload 'scheme-smart-complete "scheme-complete" nil t)
;; auto-completeを使っているので不要
;; (eval-after-load 'scheme
;;   '(define-key scheme-mode-map "\e\t" 'scheme-smart-complete))
(add-hook 'scheme-mode-hook
  (lambda ()
    (make-local-variable 'eldoc-documentation-function)
    (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
    (eldoc-mode)))
(setq lisp-indent-function 'scheme-smart-indent-function)





;;;;;;;;;;;;;;;
;;; Clojure ;;;
;;;;;;;;;;;;;;;

;; nrepl.el後継のCIDER
(require 'cider)
(add-hook 'clojure-mode-hook 'cider-mode)

;; ミニバッファに関数の引数を表示
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; 'C-x b' した時に *nrepl-connection* と *nrepl-server* のbufferを一覧に表示しない
(setq nrepl-hide-special-buffers t)

;; RELPのbuffer名を 'project名:nREPLのport番号' と表示する
;; project名は project.clj で defproject した名前
(setq nrepl-buffer-name-show-port t)

;; ciderのreplでauto-completeが使えるようにする
(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
 
;; clojure用のyasnippet
(require 'clojure-snippets)
(clojure-snippets-initialize)





;;;;;;;;;;;;
;;; yaml ;;;
;;;;;;;;;;;;

;; yaml-mode
; packgeでインストール
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))





;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; コードテンプレート ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto-insert
(require 'autoinsert)
; テンプレ格納用ディレクトリ
(setq auto-insert-directory "~/.emacs.d/template/")
; ファイル拡張子とテンプレートの対応
(setq auto-insert-alist
      (append '(
                ("\\.pl$" . ["Template.pl"])
                ("\\.psgi$" . ["Template.psgi"])
                ("\\.pm$" . ["Template.pm"])
                ("\\.t$" . ["Template.t"])
                ) auto-insert-alist))
(add-hook 'find-file-hooks 'auto-insert)



;;;;;;;;;;;;
;;; TAGS ;;;
;;;;;;;;;;;;

;;; etags ;;;

;; 目的のライブラリのディレクトリに行き、
;; $ etags *.pm *.pl
;; で、TAGSファイルを作成
;; "M-." クラス名や関数名を入力する（デフォルトでカーソル下を取る）
;; "C-u M-." 複数ヒットする場合、次の候補へ
;; "M-*" 前の場所に戻る

;;; ctags ;;;

;;; gtags ;;;
