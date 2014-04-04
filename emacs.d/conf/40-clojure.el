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
