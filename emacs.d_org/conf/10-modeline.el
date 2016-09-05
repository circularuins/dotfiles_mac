;; カーソル位置の列番号を表示
(column-number-mode t)

;; ファイルサイズ表示
(size-indication-mode t)

;; 年月日時刻の表示
;; 以下の書式に従ってモードラインに日付・時刻を表示する 
(setq display-time-string-forms 
'((format "%s/%s/%s(%s) %s:%s" 
year month day 
dayname 
24-hours minutes) 
load 
(if mail " Mail" ""))) 
(display-time) ; 時間を表示
(setq display-time-kawakami-form t) ; 時刻表示の左隣に日付を追加
(setq display-time-24hr-format t) ; 24 時間制

;; リージョン内の行数と文字数をモードラインに表示する(範囲指定時のみ)
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines, %d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ""))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))
