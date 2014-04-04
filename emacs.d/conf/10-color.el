;; color-themeの設定
; wget https://gnuemacscolorthemetest.googlecode.com/files/color-theme-6.6.0-mav.zip
; unzipしたフォルダごと、elisp/に置く
; GUIでは、自作テーマを仕様
(cond ((window-system)
       (setq custom-theme-directory "~/.emacs.d/themes/")
       (load-theme 'molokai t))
      (t
       (require 'color-theme)
       (color-theme-initialize)
       (color-theme-arjen)
;       (color-theme-euphoria)
;       (color-theme-clarity)
       ))
