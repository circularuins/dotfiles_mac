;; 拡張子の追加
(add-to-list 'auto-mode-alist '("\\.clj_$" . clojure-mode))

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

;; clojure用のyasnippet
(require 'clojure-snippets)
(clojure-snippets-initialize)
