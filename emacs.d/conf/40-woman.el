;; womanキャッシュを作成
;; C-u M-x woman RET で更新
(setq woman-cache-filename "~/.emacs.d/.wmncache.el")

;; womanにmanパスを設定
(setq woman-manpath '("/usr/share/man"
                      "/usr/local/share/man"
;                      "/usr/local/share/man/ja"))
                      "/usr/local/share/man/jp"))
