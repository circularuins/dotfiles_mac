;; color-themeの設定
;; GUIでは自作テーマを仕様
;; CUIではデフォルトテーマを使用
(cond ((window-system)
       (setq custom-theme-directory "~/.emacs.d/themes/")
       (load-theme 'molokai t))
      (t
       (load-theme 'deeper-blue t)
       (load-theme 'manoj-dark t)
       (load-theme 'wheatgrass t)
       ))
