;;;;;;;;;;;;;;;;;;;;;;
;;; 環境変数の設定 ;;;
;;;;;;;;;;;;;;;;;;;;;;

;; MacのEmacs.app用の設定
(when (eq system-type 'darwin)
  (setenv "PATH" (concat (expand-file-name "/usr/local/bin/:") (getenv "PATH")))
  (setenv "PATH" (concat (expand-file-name "/Users/wake/.plenv/versions/5.18.1/bin/:") (getenv "PATH")))
  (setq eshell-path-env (getenv "PATH")))





;;;;;;;;;;;;;;;;
;;; 基本設定 ;;;
;;;;;;;;;;;;;;;;

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





;;;;;;;;;;;;;;;;;;;;;;;;
;;; ロードパスの設定 ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; load-pathを追加する関数（Emacs実践入門より）
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "package")





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 拡張インストールのための設定 ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; auto-install.el ;;;

; wget http://www.emacswiki.org/emacs/download/auto-install.el
; emacs --batch -Q -f batch-byte-compile auto-install.el
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(ignore-errors (auto-install-update-emacswiki-package-name t))
; install-elisp との互換のため
(auto-install-compatibility-setup)
; ediff関連のバッファを1つのフレームにまとめる
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; package.el ;;;

; Emacs23の場合（24からは標準でin）
; (auto-install-from-url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el")
(require 'package)
; リポジトリにMarmaladeと開発者個人のELPAを追加
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("MELPA" . "http://melpa.milkbox.net/packages/"))
; インストールするディレクトリを指定
(setq package-user-dir (concat user-emacs-directory "package"))
; インストールしたパッケージにロードパスを通してロードする
(package-initialize)

;;; 自動バイトコンパイル ;;;

; M-x install-elisp-from-emacswiki auto-async-byte-compile.el
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 分割設定ファイルの読み込み ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 分割した設定ファイルを読み込む
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf") ; 設定ファイルのディレクトリを指定
