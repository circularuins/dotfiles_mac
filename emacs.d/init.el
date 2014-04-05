;; 遅延ロードマクロ定義
;; (lazyload (triger-function　...) "filename" &rest body)
(defmacro lazyload (func lib &rest body)
  `(when (locate-library ,lib)
     ,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
     (eval-after-load ,lib
       '(progn
          ,@body)) t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; パフォーマンスチェック ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 総起動時間の計測
(add-hook 'after-init-hook
  (lambda ()
    (message "@@@@@@@@@@ init time: %.3f sec @@@@@@@@@@"
             (float-time (time-subtract after-init-time before-init-time)))))

;; requireにかかる時間の計測
(defadvice require (around require-benchmark activate)
  (let* ((before (current-time))
         (result ad-do-it)
         (after  (current-time))
         (time (+ (* (- (nth 1 after) (nth 1 before)) 1000)
                  (/ (- (nth 2 after) (nth 2 before)) 1000))))
    (when (> time 50)
      (message "********** %s: %d msec **********" (ad-get-arg 0) time))))


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
;; (require 'auto-install)
;; (setq auto-install-directory "~/.emacs.d/elisp/")
;; (ignore-errors (auto-install-update-emacswiki-package-name t))
;; ; install-elisp との互換のため
;; (auto-install-compatibility-setup)
;; ; ediff関連のバッファを1つのフレームにまとめる
;; (setq ediff-window-setup-function 'ediff-setup-windows-plain)
(lazyload (auto-install auto-install-from-url auto-install-from-emacswiki)
          "auto-install"
          (require 'auto-install)
          (setq auto-install-directory "~/.emacs.d/elisp/")
          (ignore-errors (auto-install-update-emacswiki-package-name t))
          ; install-elisp との互換のため
          (auto-install-compatibility-setup)
          ; ediff関連のバッファを1つのフレームにまとめる
          (setq ediff-window-setup-function 'ediff-setup-windows-plain))

;;; package.el ;;;

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
