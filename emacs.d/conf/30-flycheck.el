(require 'flycheck)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
(add-hook 'js2-mode-hook 'flycheck-mode)
