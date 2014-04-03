;;;;;;;;;;;;;;;;;;;;;;;;
;;;キーバインドの設定;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;; 連続して操作する際のprefixキー入力をキャンセルさせる
;; http://sheephead.homelinux.org/2011/12/19/6930/
(require 'smartrep)

;; 同じコマンドを連続実行した時の振る舞いを変更する
;; C-a連続：行頭→ファイル頭→元 C-e連続：行末→ファイル末→元
;; M-u(upcase),M-l(downcase),M-c(capitalize)が、カーソル直前の単語に効くようになる。連打すると、前方の単語を順次変換
(require 'sequential-command-config)
(sequential-command-setup-keys)


;;;;;;;;;;;;;;
;;;基本操作;;;
;;;;;;;;;;;;;;
;;; キーボード
(keyboard-translate ?\C-h ?\C-?) ;C-hで直前の文字を消去
(global-set-key (kbd "C-x C-h") 'help)
(global-set-key (kbd "C-M-k") 'backward-kill-line) ;カーソル位置から行頭まで削除
(global-set-key "\M-d" 'kill-word-at-point) ;カーソル位置の単語を削除
(global-set-key "\M-n" (kbd "C-u 5 C-n"))
(global-set-key "\M-p" (kbd "C-u 5 C-p"))

;;; バッファ
(global-set-key "\C-x\C-b" 'bs-show)

;;; ファイル
(define-key global-map (kbd "C-x C-m") 'recentf-open-files)

;;; cua-mode
;; C-RETで開始、C-gで終了
;; #連番入力の手順
;; 矩形選択後、M-oでスペース1文字挿入
;; M-n 後、初期値、加算値、フォーマットの順に入力
(define-key global-map (kbd "C-x C-x") 'cua-set-rectangle-mark) ; ターミナルでデフォルトの"C-RET"が使えないので変更する

;;; シェル
(define-key global-map (kbd "C-z") 'eshell)


;;;;;;;;;;;;;;;;;;;;;
;;; プログラミング;;;
;;;;;;;;;;;;;;;;;;;;;
;;; Perl
(global-set-key "\C-ct" 'perltidy-region)
(global-set-key "\C-c\C-t" 'perltidy-defun)

;;; lisp
(global-set-key (kbd "C-c f") 'paredit-forward-slurp-sexp) ; 右のS式を飲み込む
(global-set-key (kbd "C-c b") 'paredit-forward-barf-sexp) ; S式を右に吐き出す
(global-set-key (kbd "C-c u") 'paredit-splice-sexp-killing-backward) ; カーソル前の要素と外側の()を消す


;;;;;;;;;;;;;;;;;;;
;;;anything/helm;;;
;;;;;;;;;;;;;;;;;;;
;;; anything
(define-key global-map (kbd "M-x")
  (lambda ()
    (interactive)
    (anything-other-buffer
     '(anything-c-source-extended-command-history anything-c-source-emacs-commands)
     "*anything emacs commands*")))
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;;; helm


;;;;;;;;;;;;;;
;;;外部依存;;;
;;;;;;;;;;;;;;
;;; ウィンドウ
;(global-set-key "\C-xo" 'popup-select-window)
(global-set-key "\C-c\C-r" 'my-window-resizer) ;hjklでウィンドウサイズ変更

;;; e2wm
(global-set-key (kbd "M-+") 'e2wm:start-management)
(global-set-key (kbd "C-c <left>")  'windmove-left)
    (global-set-key (kbd "C-c <right>") 'windmove-right)
    (global-set-key (kbd "C-c <up>")    'windmove-up)
    (global-set-key (kbd "C-c <down>")  'windmove-down)

;;; direx
(global-set-key (kbd "C-x C-j") 'my/dired-jump) ;C-u C-x C-j で、通常のdiredを実行

;;; undo-tree
;; C-x uで起動
;; "p","n"で履歴を移動、"f","b"でブランチの切り替え、"q"で終了
(global-set-key (kbd "M-/") 'undo-tree-redo)

;;; open-junk-file
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;; 最後の変更箇所にジャンプ
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)

;;; カーソル位置を戻す
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)
