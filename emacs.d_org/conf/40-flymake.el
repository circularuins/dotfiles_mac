;; flymakeのハイライトをunderlineに変更
;; ハイライトだとCUIで文字が見えないので、、
(unless window-system
  (custom-set-faces
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))))
