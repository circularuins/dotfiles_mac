;; MacのEmacs.app用の環境変数
(when (eq system-type 'darwin)
  (setenv "PATH" (concat (expand-file-name "/usr/local/bin/:") (getenv "PATH")))
  (setenv "PATH" (concat (expand-file-name "~/.plenv/versions/5.18.1/bin/:") (getenv "PATH")))
  (setq eshell-path-env (getenv "PATH")))
