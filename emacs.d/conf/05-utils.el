;;; 汽車ぽっぽ
; M-x install-elisp-from-emacswiki sl.el
(require 'sl)

;;; 英和・和英
; M-x install-elisp-from-emacswiki text-translator.el
(require 'text-translator)
(setq text-translator-auto-selection-func
     'text-translator-translate-by-auto-selection-enja)

;; Nyanmode (*^o^*)
; packageでインストール
(when window-system
  (require 'nyan-mode)
  (nyan-mode t)
  (nyan-start-animation)
  (add-hook 'eshell-load-hook 'nyan-prompt-enable))

;;; zo～～ne
(require 'zone)
;(zone-when-idle 300)

(defun zone-choose (pgm)
    "Choose a PGM to run for `zone'."
    (interactive
     (list
      (completing-read
       "Program: "
       (mapcar 'symbol-name zone-programs))))
    (let ((zone-programs (list (intern pgm))))
      (zone)))
;; zoneのサンプル
(eval-after-load "zone"
    '(unless (memq 'zone-pgm-md5 (append zone-programs nil))
       (setq zone-programs
             (vconcat zone-programs [zone-pgm-md5]))))
(defun zone-pgm-md5 ()
    "MD5 the buffer, then recursively checksum each hash."
    (let ((prev-md5 (buffer-substring-no-properties ;; Initialize.
                     (point-min) (point-max))))
      ;; Whitespace-fill the window.
      (zone-fill-out-screen (window-width) (window-height))
      (random t)
      (goto-char (point-min))
      (while (not (input-pending-p))
        (when (eobp)
          (goto-char (point-min)))
        (while (not (eobp))
          (delete-region (point) (line-end-position))
          (let ((next-md5 (md5 prev-md5)))
            (insert next-md5)
            (setq prev-md5 next-md5))
          (forward-line 1)
          (zone-park/sit-for (point-min) 0.1)))))
