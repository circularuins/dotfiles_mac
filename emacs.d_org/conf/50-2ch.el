;; 遅延ロードマクロ定義
;; (lazyload (triger-function　...) "filename" &rest body)
(defmacro lazyload (func lib &rest body)
  `(when (locate-library ,lib)
     ,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
     (eval-after-load ,lib
       '(progn
          ,@body)) t))

; wget https://sourceforge.net/projects/navi2ch/files/navi2ch/navi2ch-1.8.4/navi2ch-1.8.4.tar.gz/download
(lazyload (navi2ch)
          "navi2ch"
          (require 'navi2ch)
          (setq navi-2ch-article-exist-message-range '(1 . 1000))
          (setq navi-2ch-article-new-message-range '(1000. 1))
          (setq navi-2ch-board-insert-subject-with-diff t)
          (setq navi-2ch-board-insert-subject-with-unread t)
          (setq navi-2ch-list-init-open-category t)
          (setq navi-2ch-board-expire-date nil)
          (setq navi-2ch-history-max-line nil))
