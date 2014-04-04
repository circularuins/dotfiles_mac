;; 設定したバッファをポップアップ表示する
;; "C-g"または、他のウィンドウを選択すると閉じる
(if (require 'popwin nil t)
    (progn
      (setq display-buffer-function 'popwin:display-buffer)
      (setq popwin:popup-window-height 0.4)
      (setq anything-samewindow nil)
      (push '("*anything*" :height 14) popwin:special-display-config)
      (push '(dired-mode :position top) popwin:special-display-config)
      (push '("\\*[Vv][Cc]" :regexp t :position top) popwin:special-display-config)
      (push '("\\*git-" :regexp t :position top) popwin:special-display-config)
      (push '(" *auto-async-byte-compile*" :height 10 :position bottom :noselect t) popwin:special-display-config)
      (push '("*Compile-Log*" :height 10 :position bottom :noselect t) popwin:special-display-config)
      (push '("*VC-log*" :height 10 :position bottom) popwin:special-display-config)
      (push '("*anything kill-ring*" :height 14) popwin:special-display-config)
;      (push '("*ruby*" :height 14) popwin:special-display-config)
      ))
