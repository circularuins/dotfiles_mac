;; jaspace.el を使った全角空白、タブ、改行表示モード
;; 切り替えは M-x jaspace-mode-on or -off
; ネットからインストールすると文字コードが変なので、手動でコピった
; http://homepage3.nifty.com/satomii/software/jaspace.elayout.el
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
;(setq jaspace-alternate-eol-string "↓\n")
(setq jaspace-highlight-tabs t)  ; highlight tabs
;(setq jaspace-highlight-tabs ?&gt;) ; use ^ as a tab marker
