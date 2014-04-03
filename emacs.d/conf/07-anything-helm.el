;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; anything関連の設定 ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

; packageでインストール
;; 基本設定
(require 'anything)
;(require 'anything-startup)
; 動作チューニング
(setq
 ; 候補を表示するまでの時間。初期値は0.5
 anything-idle-delay 0.3
 ; タイプして再描写するまでの時間。初期値は0.1
 anything-input-idle-delay 0.2
 ; 候補の最大表示数。初期値は50
 anything-candidate-number-limit 100
 ; 候補が多い時に体感速度を速くする
 anything-quick-update t)
(require 'anything-config)
; root権限でアクションを実行するときのコマンド
; デフォルトは"su"
(setq anything-su-or-sudo "sudo")
; 履歴にデフォルト表示させるコマンド
(setq extended-command-history
     '( "anything-for-files" "perltidy-region" "eval-region" "eval-buffer"))
(require 'anything-match-plugin nil t)
(require 'anything-complete)
; Lispシンボルの補完候補の再検索時間
(anything-lisp-complete-symbol-set-timer 150)
(require 'anything-show-completion nil t)
(require 'anything-auto-install nil t)

;; describe-bindingsをAnythingに置き換える
(when (require 'descbinds-anything nil t)
  (descbinds-anything-install))

;; anythingフレームワークでフォントを確認する
(require 'cl)  ; loop, delete-duplicates
(defun anything-font-families ()
  "Preconfigured `anything' for font family."
  (interactive)
  (flet ((anything-mp-highlight-match () nil))
    (anything-other-buffer
     '(anything-c-source-font-families)
     "*anything font families*")))
(defun anything-font-families-create-buffer ()
  (with-current-buffer
      (get-buffer-create "*Fonts*")
    (loop for family in (sort (delete-duplicates (font-family-list)) 'string<)
          do (insert
              (propertize (concat family "\n")
                          'font-lock-face
                          (list :family family :height 2.0 :weight 'bold))))
    (font-lock-mode 1)))
(defvar anything-c-source-font-families
  '((name . "Fonts")
    (init lambda ()
          (unless (anything-candidate-buffer)
            (save-window-excursion
              (anything-font-families-create-buffer))
            (anything-candidate-bufferx
             (get-buffer "*Fonts*"))))
    (candidates-in-buffer)
    (get-line . buffer-substring)
    (action
     ("Copy Name" lambda
      (candidate)
      (kill-new candidate))
     ("Insert Name" lambda
      (candidate)
      (with-current-buffer anything-current-buffer
        (insert candidate))))))





;;;;;;;;;;;;;;;;;;;;;;
;;; helm関連の設定 ;;;
;;;;;;;;;;;;;;;;;;;;;;

(require 'helm-config)
