;;; gist.github.comを利用する ;;;
; packageで入れたかったが、emacs24以上…
;(require 'gist)

;;; twitter ;;;
; packageでインストール
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
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite))
(add-hook 'twittering-mode-hook 'twittering-mode-hook-func)

;;; 2ch ;;;
; wget https://sourceforge.net/projects/navi2ch/files/navi2ch/navi2ch-1.8.4/navi2ch-1.8.4.tar.gz/download
(require 'navi2ch)
(setq navi-2ch-article-exist-message-range '(1 . 1000))
(setq navi-2ch-article-new-message-range '(1000. 1))
(setq navi-2ch-board-insert-subject-with-diff t)
(setq navi-2ch-board-insert-subject-with-unread t)
(setq navi-2ch-list-init-open-category t)
(setq navi-2ch-board-expire-date nil)
(setq navi-2ch-history-max-line nil)

;;; ircクライアントrieceの設定 ;;;
;; Server Alias
(setq riece-server-alist
      `(("2ch"      :host "irc.2ch.net"       :nickname "nwake" :coding utf-8)
        ("freenode" :host "chat.freenode.net" :nickname "nwake" :coding utf-8)))
;; Default Server
(setq riece-server "freenode")
