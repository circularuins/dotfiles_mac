;; Localeに合わせた環境の設定
(set-locale-environment nil)

;; 文字コードの指定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; Macの場合のファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Windowsの場合のファイル名の設定
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))

;;; MetaキーをAltからCmdへ変更(Macのみ)
; "Symbol's value as variable is void: warning-suppress-types" というエラーを出さないための設定
(setq warning-suppress-types nil)
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super)))
