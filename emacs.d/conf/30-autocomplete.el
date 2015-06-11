; packageでインストール
;; (require 'auto-complete)
;; (global-auto-complete-mode 1)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(ac-config-default)
(setq ac-use-menu-map t) ;; C-n / C-p で選択
(setq ac-use-fuzzy t) ;; 曖昧マッチ
(setq ac-use-comphist t) ;; 補完推測機能有効
;(setq ac-auto-show-menu 0.3) ;; 候補が出るまでの時間 default 0.8

;; ac-modeに各モードを追加する
(add-to-list 'ac-modes 'lisp-mode)
;(add-to-list 'ac-modes 'slime-repl-mode)
(add-to-list 'ac-modes 'js2-mode)
(add-to-list 'ac-modes 'scheme-mode)
;(add-to-list 'ac-modes 'inferior-scheme-mode)
;(add-to-list 'ac-modes 'inferior-lisp-mode)
(add-to-list 'ac-modes 'clojure-mode)
(add-to-list 'ac-modes 'yaml-mode)
;(add-to-list 'ac-modes 'eshell-mode)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(add-to-list 'ac-modes 'org-mode)

;; ac-mode
;(autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)

;; ac-html
(setq web-mode-ac-sources-alist
  '(("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
    ("css" . (ac-source-css-property ac-source-emmet-css-snippets))))
(add-hook 'web-mode-before-auto-complete-hooks
          '(lambda ()
             (let ((web-mode-cur-language
                    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "css")
                   (setq emmet-use-css-transform t)
                 (setq emmet-use-css-transform nil)))))
(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-attribute-value
                         ac-source-html-tag
                         ac-source-html-attribute)))
(add-hook 'haml-mode-hook 'ac-haml-enable)
