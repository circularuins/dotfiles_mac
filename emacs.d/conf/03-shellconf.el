;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ミニバッファでshellコマンド ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; "M-!"でカレントバッファの存在するディレクトリでコマンドを実行し、*Shell Command Output*バッファに出力する。
;; "C-u M-! コマンド"で、カレントバッファに出力する。

;; バッファ上のテキストをコマンドの標準入力に利用する
;; リージョン選択後、"C-u M-| コマンド"で、リージョンが出力で置換される
;; 例：C-u M-| grep "hoge" RET





;;;;;;;;;;;;;;
;;; Eshell ;;;
;;;;;;;;;;;;;;

;; Emacs 起動時に Eshell を起動
;;(add-hook 'after-init-hook (lambda () (eshell) ))

;; 起動時のウェルカムメッセージ
(setq eshell-banner-message "\n\nHello Eshell, Goodbye\n\n\n")

;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)

;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))

;; 補完時にサイクルする
;(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-completions nil)

;;補完候補がこの数値以下だとサイクルせずに候補表示
;(setq eshell-cmpl-cycle-cutoff-length 5)

;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)

;; prompt 文字列の変更
(setq eshell-prompt-function
      (lambda ()
        (concat "[wake "
                (eshell/pwd)
                (if (= (user-uid) 0) "]\n# " "]\n$ ")
                )))
;; 変更した prompt 文字列に合う形で prompt の初まりを指定 (C-a で"$ "の次にカーソルがくるようにする)
;; これの設定を上手くしとかないとタブ補完も効かなくなるっぽい
(setq eshell-prompt-regexp "^[^#$]*[$#] ")

;; キーバインドの変更
(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map "\C-a" 'eshell-bol)
;               (yas/minor-mode -1)      ; yasnippet マイナーモードだと eshell-cmpl-cycle-completions がバグるのでオフ。 C-u - M-x yas/minor-mode と等価。
               (define-key eshell-mode-map [up] 'previous-line)
               (define-key eshell-mode-map [down] 'next-line)
               ;(define-key eshell-mode-map [(meta return)] 'ns-toggle-fullscreen)
;               (define-key eshell-mode-map [(meta return)] (select-toggle-fullscreen))
               )
             ))

;; エスケープシーケンスを処理
;; http://d.hatena.ne.jp/hiboma/20061031/1162277851
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)
;; http://www.emacswiki.org/emacs-ja/EshellColor
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

;; sudoのあとも補完可能に
(defun pcomplete/sudo ()
  "Completion rules for the `sudo' command."
  (let ((pcomplete-help "complete after sudo"))
    (pcomplete-here (pcomplete-here (eshell-complete-commands-list)))))

;; ;; eshell での補完に auto-complete.el を使う
;; (require 'pcomplete)
;; (require 'auto-complete)
;; (add-to-list 'ac-modes 'eshell-mode)
;; (ac-define-source pcomplete
;;   '((candidates . pcomplete-completions)))
;; (defun my-ac-eshell-mode ()
;;   (setq ac-sources
;;         '(ac-source-pcomplete
;;           ac-source-words-in-buffer
;;           ac-source-dictionary)))
;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (my-ac-eshell-mode)
;;             (define-key eshell-mode-map (kbd "C-i") 'auto-complete)))

;; Unixコマンドエミュレーションを無効にする
(progn
 (defmacro eval-after-load* (name &rest body)
   (declare (indent 1))
   `(eval-after-load ,name '(progn ,@body)))
 (defun eshell-disable-unix-command-emulation ()
   ;; (eval-after-load* "em-ls"
   ;;   (fmakunbound 'eshell/ls))
   (eval-after-load* "em-unix"
     (mapc 'fmakunbound '(eshell/agrep
                          eshell/basename
                          eshell/cat
                          eshell/cp
                          eshell/date
                          eshell/diff
                          eshell/dirname
                          eshell/du
                          eshell/egrep
                          eshell/fgrep
                          eshell/glimpse
                          eshell/grep
                          eshell/info
                          eshell/ln
                          eshell/locate
                          eshell/make
                          eshell/man
                          eshell/mkdir
                          eshell/mv
                          eshell/occur
                          eshell/rm
                          eshell/rmdir
                          eshell/su
                          eshell/sudo
                          eshell/time))))
 (eshell-disable-unix-command-emulation))

;; シェルらしい挙動にする
(progn
 (defun eshell-in-command-line-p ()
   (<= eshell-last-output-end (point)))
 (defmacro defun-eshell-cmdline (key &rest body)
   (let ((cmd (intern (format "eshell-cmdline/%s" key))))
     `(progn
        (add-hook 'eshell-mode-hook
                  (lambda () (define-key eshell-mode-map (read-kbd-macro ,key) ',cmd)))
        (defun ,cmd ()
          (interactive)
          (if (not (eshell-in-command-line-p))
              (call-interactively (lookup-key (current-global-map) (read-kbd-macro ,key)))
            ,@body)))))
 (defun eshell-history-and-bol (func)
   (delete-region eshell-last-output-end (point-max))
   (funcall func 1)
   (goto-char eshell-last-output-end)))
; C-w
(defun-eshell-cmdline "C-w"
 (if (eq (point-max) (point))
     (backward-kill-word 1)
   (kill-region (region-beginning) (region-end))))
; C-p
(defun-eshell-cmdline "C-p"
 (let ((last-command 'eshell-previous-matching-input-from-input))
   (eshell-history-and-bol 'eshell-previous-matching-input-from-input)))
; C-n
(defun-eshell-cmdline "C-n"
 (let ((last-command 'eshell-previous-matching-input-from-input))
   (eshell-history-and-bol 'eshell-next-input)))
; 直前の履歴を取り出すようにする
(defadvice eshell-send-input (after history-position activate)
 (setq eshell-history-index -1))

;; 新しいeshellを立ち上げるショートカット
(progn
 (defun eshell-new ()
   (interactive)
   (eshell t))
 (defun eshell-mode-hook0 ()
   (define-key eshell-mode-map "\C-c\C-z" 'eshell-new))
 (add-hook 'eshell-mode-hook 'eshell-mode-hook0))

;;; コマンド解釈の乗っ取り
; M-x install-elisp-from-emacswiki esh-myparser.el
(require 'esh-myparser)
;; zshの乗っ取り
(defun eshell-parser/z (str) (eshell-parser/b str "zsh"))





;;;;;;;;;;;;;;;;;;;
;;; Shell Utils ;;;
;;;;;;;;;;;;;;;;;;;

;; 選択範囲に対してPerlコマンドを実行する関数
(defun perl-eval (beg end)
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "perl" 0)))
