;;;;;;;;;;;;;;;;;;;;;;;;
;;; ユーザー定義関数 ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;;; タイマーで遊ぶ ;;;

;; http://d.hatena.ne.jp/sanryuu/20131203/1385996455
;; バッファを激しく点滅させる

(defvar pokemon-flag nil)

(defun pokemon-shock ()
 (interactive)
 (cond
  (pokemon-flag
   (custom-set-faces
    '(default ((t (:background "red" :foreground "white")))))
   (setq pokemon-flag nil))
  (t
   (custom-set-faces
    '(default ((t (:background "blue" :foreground "white")))))
   (setq pokemon-flag t))))

(defun pokemon-shock-start ()
 (interactive)
 (setq pokemon-process (run-with-timer t 0.1 'pokemon-shock))
 (setq pokemon-shock-mode t)
 (global-set-key "\C-g" 'pokemon-shock-stop))

(defun pokemon-shock-stop ()
 (interactive)
 (cancel-timer pokemon-process)
 (setq pokemon-shock-mode nil)
 (global-set-key "\C-g" 'keyboard-quit)
 (custom-set-faces
  '(default ((t (:background "black" :foreground "white"))))))

;(run-at-time "12:00" nil 'pokemon-shock-start)

;; http://d.hatena.ne.jp/ozawanay/20110124/p1
;; 指定した時間にメッセージをアニメーション

(defun timer-message (time msg &rest moremsg)
  (interactive
   (list (read-string "いつ？") ; 例："2:30pm" "18:45" "10 sec" "3 min"
         (read-string "メッセージ：")))
  (run-at-time
   time nil
   #'(lambda (arg)
       (message "＼時間です／")
       (ding)
       (sleep-for 1)
       (animate-sequence arg 0)
       (goto-char (point-min))
       (insert (format-time-string "%H:%M "))
       (insert-button "［閉じる］" 'action #'(lambda (arg) (kill-buffer))))
   (cons msg moremsg))
  (message "タイマー開始しました"))

;; http://d.hatena.ne.jp/kitokitoki/20100322/p3
;; カーソルをcuteに点滅

(require 'cl)

(lexical-let ((interval 0.05)
              (colors '("red" "green" "blue" "yellow" "purple" "magenta" "cyan"))
              (cursor-nth 0)
              (timer nil))
  (defun cute-cursor (flag)
    "Start toggling cursor color when flag is true."
    (cond
     ((and flag timer) (cute-cursor nil))
     (flag (setq timer (run-with-timer interval interval
                                       (lambda ()
                                         (set-cursor-color (nth cursor-nth colors))
                                         (incf cursor-nth)
                                         (if (>= cursor-nth (length colors))
                                           (setq cursor-nth 0)))))
           (blink-cursor-mode 0))
     (timer (cancel-timer timer)
            (setq timer nil)))))

;(cute-cursor t)

