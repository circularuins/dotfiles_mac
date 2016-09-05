;; 遅延ロードマクロ定義
;; (lazyload (triger-function　...) "filename" &rest body)
(defmacro lazyload (func lib &rest body)
  `(when (locate-library ,lib)
     ,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
     (eval-after-load ,lib
       '(progn
          ,@body)) t))

;; 共通のパス変数はlazyloadの外で宣言しておく
;; Dropboxのパス変数
(defvar dropbox-directory
  (cond
   ((equal system-type 'windows-nt) (concat "c:/Users/" user-login-name "/Dropbox"))
   (t "~/Dropbox")))

;; 拡張子の登録
(add-to-list 'auto-mode-alist '(".org$" . org-mode))

;; キーバインドの設定
(global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; C-c r でorg-remember起動
(define-key global-map (kbd "C-c r") 'org-remember)

;; lazyloadの設定
;; (lazyload (function ...) "filename" ...)
(lazyload (org-mode org-install org-store-link org-agenda org-iswitchb org-remember)
           "org-install"
    (require 'org-install)

    (if (boundp 'dropbox-directory)
        (setq org-directory (concat dropbox-directory "/Documents/org/")))
    (setq org-default-notes-file (concat org-directory "agenda.org"))
    (setq org-mobile-directory (concat dropbox-directory "/MobileOrg"))
    (setq org-mobile-inbox-for-pull (concat dropbox-directory "/flagged.org"))
    (setq org-agenda-files
          (mapcar #'(lambda (x) (concat org-directory x))
                  '("work.org" "school.org" "home.org")))

    (defvar org-foo)
    (defun org-bar () ...)

    (define-key org-mode-map "\M-n" 'org-next-visible-link)
    (define-key org-mode-map "\M-p" 'org-previous-visible-link)
    ...)

;; フックの設定
(add-hook 'org-mode-hook 'foo-function)
