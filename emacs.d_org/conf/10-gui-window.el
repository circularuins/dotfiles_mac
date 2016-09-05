;; 起動時のウィンドウサイズ
(when window-system
  (setq initial-frame-alist
        (append (list
                 '(width . 180)
                 '(height . 58)
                 '(top . 0)
                 '(left . 0)
                 )
                initial-frame-alist))
  (setq default-frame-alist initial-frame-alist))

;; 背景色と透明度
(if window-system (progn
  (set-background-color "Black")
  (set-foreground-color "LightGray")
  (set-cursor-color "Gray")
  (set-frame-parameter nil 'alpha 85)
  ))

;; バー設定(GUIのみ) ;;;
(when window-system
  ; タイトルバーにファイル名を表示
  (setq frame-title-format (format "%%f - emacs@%s" (system-name))))

;; 画像ファイルをバッファ内で表示する
(when window-system
  (auto-image-file-mode t))

;; バッファ内での画像ファイルの表示 ;;;
(turn-on-iimage-mode)
(iimage-mode-buffer t)
; iimage-modeでホームディレクトリを展開
(setq iimage-mode-image-filename-regex
     (concat "[-~+./_0-9a-zA-Z]+\\."
             (regexp-opt (nconc (mapcar #'upcase
                                        image-file-name-extensions)
                                image-file-name-extensions))))
; C-lC-lを再描画に設定
(setq iimage-mode-map (make-sparse-keymap))
(define-key iimage-mode-map "\C-l" nil)
(define-key iimage-mode-map "\C-l\C-l" 'iimage-recenter)
; 5秒何もしなければ再描画
(run-with-idle-timer 5 5 (lambda () (and iimage-mode (iimage-recenter))))
