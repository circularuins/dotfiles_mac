;; asciiフォントをMenloに
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil
                      :family "Menlo"
                      :height 120))

;; Macのフォント設定
;; (when (eq system-type 'darwin)
;;   ; 日本語フォント
;;   (set-fontset-font
;;    nil 'japanese-jisx0208
;; ; 英語名の場合
;; ; (font-spec :family "Hiragino Mincho Pro"))
;;    (font-spec :family "ヒラギノ明朝 Pro"))

;;   ; 全／半角を1:2にする
;;   (setq face-font-rescale-alist
;;         '((".*Menlo.*" . 1.0)
;;           (".*Hiragino_Mincho_Pro.*" . 1.2)
;;           ("-cdac$" . 1.3))))
