;; js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-hook 'js2-mode-hook
;;           '(lambda ()
;;              (setq js2-basic-offs_et 4)))
;; ;js2-modeが持つインデントの不具合を解決する
;; (add-hook 'js2-mode-hook 'js-indent-hook)
