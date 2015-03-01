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
(add-to-list 'ac-modes 'yaml-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'eshell-mode)
;; ac-mode
;(autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)
