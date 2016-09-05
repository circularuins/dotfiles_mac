;; 遅延ロードマクロ定義
;; (lazyload (triger-function　...) "filename" &rest body)
(defmacro lazyload (func lib &rest body)
  `(when (locate-library ,lib)
     ,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
     (eval-after-load ,lib
       '(progn
          ,@body)) t))

;; commonlispライブラリの選択
(setq inferior-lisp-program "clisp")
;;(setq inferior-lisp-program "sbcl")

; packageでインストール
; slime-fancy等のエラーが出たので、package内の全ての.elcを消した
(lazyload (slime ac-slime)
          "slime"
          (require 'slime)
          (require 'ac-slime)
          (slime-setup '(slime-repl slime-fancy slime-banner))
          (setq slime-net-coding-system 'utf-8-unix)
          (slime-autodoc-mode))
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
