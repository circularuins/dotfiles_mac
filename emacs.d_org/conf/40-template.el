;; auto-insert
(require 'autoinsert)
; テンプレ格納用ディレクトリ
(setq auto-insert-directory "~/.emacs.d/template/")
; ファイル拡張子とテンプレートの対応
(setq auto-insert-alist
      (append '(
                ("\\.pl$" . ["Template.pl"])
                ("\\.psgi$" . ["Template.psgi"])
                ("\\.pm$" . ["Template.pm"])
                ("\\.t$" . ["Template.t"])
                ) auto-insert-alist))
(add-hook 'find-file-hooks 'auto-insert)
