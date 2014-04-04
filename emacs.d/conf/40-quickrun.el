(require 'quickrun)
;; popwinに追加
(push '("*quickrun*" :position right) popwin:special-display-config)
;; 実行結果がうまく表示されない対処療法
(defadvice quickrun/apply-outputter (after quickrun/fix-scroll-buffer activate)
  (recenter))
;; region選択されていたらquickrun-region、されていなかったらquickrunを実行
(defun quickrun-sc (start end)
  (interactive "r")
  (if mark-active
      (quickrun :start start :end end)
    (quickrun)))
