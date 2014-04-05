(when window-system
  (require 'nyan-mode)
  (nyan-mode t)
  (nyan-start-animation)
  (add-hook 'eshell-load-hook 'nyan-prompt-enable))
