(require 'swoop)

;; 検索の移行
;; isearch     > press [C-o] > swoop
;; evil-search > press [C-o] > swoop
;; swoop       > press [C-o] > swoop-multi
(define-key isearch-mode-map (kbd "C-o") 'swoop-from-isearch)
(define-key swoop-map (kbd "C-o") 'swoop-multi-from-swoop)
