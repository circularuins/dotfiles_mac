;;; ircクライアントrieceの設定 ;;;
;; Server Alias
(setq riece-server-alist
      `(("2ch"      :host "irc.2ch.net"       :nickname "nwake" :coding utf-8)
        ("freenode" :host "chat.freenode.net" :nickname "nwake" :coding utf-8)))
;; Default Server
(setq riece-server "freenode")
