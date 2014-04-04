;; *Completions*バッファを使用後に消す
; M-x install-elisp-from-emacswiki lcomp.el
(require 'lcomp)
(lcomp-mode 1)
(lcomp-keys-mode 1)

;; iswitchb(バッファ切り替え時のインクリメンタル補完)
(iswitchb-mode 1)
(add-hook 'iswitchb-define-mode-map-hook
          (lambda ()
            (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
            (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;; minibufでisearchを使えるようにする
(require 'minibuf-isearch nil t)

;; 閉じたバッファもundo
(when (require 'undohist nil t)
  (undohist-initialize))

;; 前回終了時のバッファ状態を復元
; install-elisp http://www.gentei.org/~yuuji/software/euc/revive.el
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(define-key ctl-x-map "S" 'save-current-configuration)    ; C-x S で状態保存
(define-key ctl-x-map "F" 'resume)                        ; C-x F で復元
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に状態保存
