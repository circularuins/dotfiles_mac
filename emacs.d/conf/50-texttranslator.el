;; 遅延ロードマクロ定義
;; (lazyload (triger-function　...) "filename" &rest body)
(defmacro lazyload (func lib &rest body)
  `(when (locate-library ,lib)
     ,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
     (eval-after-load ,lib
       '(progn
          ,@body)) t))

;;; 英和・和英
; M-x install-elisp-from-emacswiki text-translator.el
(lazyload (text-translator)
          "text-translator"
          (require 'text-translator)
          (setq text-translator-auto-selection-func
                'text-translator-translate-by-auto-selection-enja))
