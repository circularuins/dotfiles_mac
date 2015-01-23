;; 遅延ロードマクロ定義
;; (lazyload (triger-function　...) "filename" &rest body)
(defmacro lazyload (func lib &rest body)
  `(when (locate-library ,lib)
     ,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
     (eval-after-load ,lib
       '(progn
          ,@body)) t))

;; GUIでもGnuPGを読み込む
(add-to-list 'exec-path "/usr/local/Cellar/gnupg/1.4.18_1/bin")

(lazyload (twittering-mode)
          "twittering-mode"
          (require 'twittering-mode)
          (setq twittering-allow-insecure-server-cert t)
          (setq twittering-use-master-password t)
          (setq twittering-icon-mode t)
          (setq twittering-jojo-mode t)
          (defun twittering-mode-hook-func ()
            (set-face-bold-p 'twittering-username-face t)
            (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
            (set-face-foreground 'twittering-uri-face "gray35")
            (define-key twittering-mode-map (kbd "<") 'my-beginning-of-buffer)
            (define-key twittering-mode-map (kbd ">") 'my-end-of-buffer)
            (define-key twittering-mode-map (kbd "F") 'twittering-favorite)))
(add-hook 'twittering-mode-hook 'twittering-mode-hook-func)
